Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390BC40F648
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbhIQKxd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 06:53:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbhIQKxb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 06:53:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 726991FE6D;
        Fri, 17 Sep 2021 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631875928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZisgputP4C/8Tu2NQDW9HtV+dYA5mpixdKAfYYMdzY=;
        b=Y+4HjXZtWbXT0gY2a/YTPDkMpCAeKFI5P+OIEQ9XpeLG+e0Ce+dMyoQTceD+arWTPfyJhk
        u/wTSnoFbcxnUss4zc34aKiu7UDmzpLDpnPlHdY8pTVq4bGpJd/sltK9mdNL0E2/Rv+6gF
        RvHtb2CmDKCMNXb7aSc5O2bEmLadz/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631875928;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZZisgputP4C/8Tu2NQDW9HtV+dYA5mpixdKAfYYMdzY=;
        b=CnXM3BqYYGw53qaX2sF9DcjgLglxYgJ1z5Aulut1qXaR1medBRjDI13mR6kMyxhShCKhU/
        gXGqsTM3MEbr/+Cg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6C682A3B8F;
        Fri, 17 Sep 2021 10:52:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D787FDA781; Fri, 17 Sep 2021 12:51:58 +0200 (CEST)
Date:   Fri, 17 Sep 2021 12:51:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: remove root argument from btrfs_log_inode()
 and its callees
Message-ID: <20210917105158.GL9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1631787796.git.fdmanana@suse.com>
 <03c99e78af748d21af7ff0bb6e915230cf0e3310.1631787796.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c99e78af748d21af7ff0bb6e915230cf0e3310.1631787796.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 16, 2021 at 11:32:10AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The root argument passed to btrfs_log_inode() is unncessary, as it is
> always the root of the inode we are going to log. This root also gets
> unnecessarily propagated to several functions called by btrfs_log_inode(),
> and all of them take the inode as an argument as well. So just remove
> the root argument from these functions and have them get the root from
> the inode where needed.
> 
> This patch is part of a patchset comprised of the following 5 patches:
> 
>   btrfs: remove root argument from btrfs_log_inode() and its callees
>   btrfs: remove redundant log root assignment from log_dir_items()
>   btrfs: factor out the copying loop of dir items from log_dir_items()
>   btrfs: insert items in batches when logging a directory when possible
>   btrfs: keep track of the last logged keys when logging a directory

This is a nice description, in all the patches, though I think you could
make it less tedious for yourself to just reference the patch with
results or a significant change. Up to you.
