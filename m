Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01323D8C8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhG1LSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 07:18:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57150 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhG1LSI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 07:18:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A08AE1FF79;
        Wed, 28 Jul 2021 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627471086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=toaF6IVxBSwD99/DVVqopX3IM3a8iMw9453BKtnwTvY=;
        b=WAyYhnBX1i2zwatSMGzcEq0jcQNjCvWKDRmu+FqZWHYrKTbXD2irn7ngY5z1+v9c0N1Qlz
        oOQEZd3JE2FoycQrlkVp9AHmjofr/hrKpPJdkyWhFEIxRSURFqQLY4hNto1BmFrAZGoACg
        OWjGXJimxRl4Jh0OkttIjd6NxsodE4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627471086;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=toaF6IVxBSwD99/DVVqopX3IM3a8iMw9453BKtnwTvY=;
        b=GLyXgbfbWJ3zc95AjqnsjISmPI2b1Q5HVjIOJAiIgar+zPGuEjo6ryH3xMVitrD0oGAFYv
        itYC4/DUs9SsX1Bw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 96520A3B83;
        Wed, 28 Jul 2021 11:18:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C9F32DA8A7; Wed, 28 Jul 2021 13:15:21 +0200 (CEST)
Date:   Wed, 28 Jul 2021 13:15:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] libbtrfsutil: fix race between subvolume iterator and
 deletion
Message-ID: <20210728111521.GA5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <1b0ba76b40a8fc22f8a97124ddcc83d3164f1836.1627429989.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0ba76b40a8fc22f8a97124ddcc83d3164f1836.1627429989.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 04:53:28PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Subvolume iteration has a window between when we get a root ref (with
> BTRFS_IOC_TREE_SEARCH or BTRFS_IOC_GET_SUBVOL_ROOTREF) and when we look
> up the path of the parent directory (with BTRFS_IOC_INO_LOOKUP{,_USER}).
> If the subvolume is moved or deleted and its old parent directory is
> deleted during that window, then BTRFS_IOC_INO_LOOKUP{,_USER} will fail
> with ENOENT. The iteration will then fail with ENOENT as well.
> 
> We originally encountered this bug with an application that called
> `btrfs subvolume show` (which iterates subvolumes to find snapshots) in
> parallel with other threads creating and deleting subvolumes. It can be
> reproduced almost instantly with the following script:
> 
>   import multiprocessing
>   import os
> 
>   import btrfsutil
> 
>   def create_and_delete_subvolume(i):
>       dir_name = f"subvol_iter_race{i}"
>       subvol_name = dir_name + "/subvol"
>       while True:
>           os.mkdir(dir_name)
>           btrfsutil.create_subvolume(subvol_name)
>           btrfsutil.delete_subvolume(subvol_name)
>           os.rmdir(dir_name)
> 
>   def iterate_subvolumes():
>       fd = os.open(".", os.O_RDONLY | os.O_DIRECTORY)
>       while True:
>           with btrfsutil.SubvolumeIterator(fd, 5) as it:
>               for _ in it:
>                   pass
> 
>   if __name__ == "__main__":
>       for i in range(10):
>           multiprocessing.Process(target=create_and_delete_subvolume, args=(i,), daemon=True).start()
>       iterate_subvolumes()

Can you please turn this into a test case?

> Subvolume iteration should be robust against concurrent modifications to
> subvolumes. So, if a subvolume's parent directory no longer exists, just
> skip the subvolume, as it must have been deleted or moved elsewhere.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Added to devel, thanks.
