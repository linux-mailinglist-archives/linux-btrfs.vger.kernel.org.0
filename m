Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732CC44AF43
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 15:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbhKIORc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 09:17:32 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57048 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhKIORc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 09:17:32 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1EEC72195F;
        Tue,  9 Nov 2021 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636467285;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EWWEWw3cQ4dnUTkDbD8K6wBSp9GYErd1OFDcPnmMbQ=;
        b=BzENprVpCfRw8XLqPNlqehbtxDFmaNHZOhDJDhR0v0dB0xRNu0P+0HX4PUvLKe+1/ZHM0L
        vOvtXsRTIwwoLfzgP1yc/bV4ErPg0rRN72XKxR6LCQa+9QRLfrKR3JQRgslazYCNNbh4CX
        MB2D4UJirqcD/XNC9gCwsH+bBqz2giA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636467285;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+EWWEWw3cQ4dnUTkDbD8K6wBSp9GYErd1OFDcPnmMbQ=;
        b=e3wjVrm/IuT6FD0WkOjJhoyGYg/DsQaOsqCMQMteWnt7lKWFmrui1kpS7YLsXWC/bbSXOP
        vnEDMWN0YlbBkUBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 10C94A3B83;
        Tue,  9 Nov 2021 14:14:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0ADFBDA799; Tue,  9 Nov 2021 15:14:05 +0100 (CET)
Date:   Tue, 9 Nov 2021 15:14:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Message-ID: <20211109141405.GR28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>
References: <31950264637728c53f794571354ef91842c6ea59.1636443598.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31950264637728c53f794571354ef91842c6ea59.1636443598.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 09, 2021 at 05:51:58PM +0800, Anand Jain wrote:
> btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
> so that its parent function btrfs_init_new_device() can add the new sprout
> device to fs_info->fs_devices.
> 
> Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
> device_list_mutex. But they are holding it sequentially, thus creates a
> small window to an opportunity to race. Close this opportunity and hold
> device_list_mutex common to both btrfs_init_new_device() and
> btrfs_prepare_sprout().
> 
> This patch splits btrfs_prepare_sprout() into btrfs_init_sprout() and
> btrfs_setup_sprout(). This split is essential because device_list_mutex
> shouldn't be held for allocs in btrfs_init_sprout() but must be held for
> btrfs_setup_sprout(). So now a common device_list_mutex can be used
> between btrfs_init_new_device() and btrfs_setup_sprout().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v10:
>  %ret should carry the error code from the init sprout, thx David.
> 
> v9:
>  Moved back the lockdep_assert_held(&uuid_mutex) to the top of the func
>    per Josef comment.
>  Add Josef RB.

Added to misc-next, thanks.
