Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BAC3DA1D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 13:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhG2LOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 07:14:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhG2LOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 07:14:24 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA739223FE;
        Thu, 29 Jul 2021 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627557260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjpgMnn4AQmhK3ynxLFE+A42f3XpaQX4xTe0FZ1o1ic=;
        b=tNLZHNvQ4Su38tzdCPSoYrCWSmB3AOv371dGgGpWkC3o9mg2dgRkFxmMbcsQ4hHLxDCMd4
        j5VYotdg2giGA4ZhW7RiArMKiBhykVjscBPKNMrNIZWorMO9HmaRGhg6dOehgawHvdUaxP
        9Q+Q/BADPf7h4kIW1qmu+WGY68QBqHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627557260;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjpgMnn4AQmhK3ynxLFE+A42f3XpaQX4xTe0FZ1o1ic=;
        b=i7O/RXbAFFJbc9JrmqferD8pRF55ME4+hTEpEK5V4DeODUm7p6Xu+RcOrYraLcfRuqNFkB
        E+9GXI1GHEtzeTAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AEF2BA3B87;
        Thu, 29 Jul 2021 11:14:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5DA29DA7AF; Thu, 29 Jul 2021 13:11:35 +0200 (CEST)
Date:   Thu, 29 Jul 2021 13:11:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] libbtrfsutil: fix race between subvolume iterator and
 deletion
Message-ID: <20210729111135.GV5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0f344e692b14ffbec90cb9f32e0d177c30326c37.1627498953.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f344e692b14ffbec90cb9f32e0d177c30326c37.1627498953.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 12:04:45PM -0700, Omar Sandoval wrote:
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
> reproduced almost instantly with the included test cases.
> 
> Subvolume iteration should be robust against concurrent modifications to
> subvolumes. So, if a subvolume's parent directory no longer exists, just
> skip the subvolume, as it must have been deleted or moved elsewhere.
> 
> Reviewed-by: Neal Gompa <ngompa13@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Changes from v1 -> v2:
> 
> - Added Neal's reviewed-by.
> - Added test cases.

Replaced in devel, thanks.
