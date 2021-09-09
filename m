Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66019405A53
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Sep 2021 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhIIPos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Sep 2021 11:44:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhIIPor (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Sep 2021 11:44:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8FE461FE25;
        Thu,  9 Sep 2021 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631202217;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNgQc2FkrFrngb2fnW7lBDvXUcocqBnQwKVJFCBeAqQ=;
        b=SPwPSfY4eWGT83OiMBP4xvDQg/J9GShkYAfdnQLE5fPg9jUei0YjgBrj7VglmkNRVdd7Wx
        dptMmVXv5eFReMuFq8Bgo1vz7HoQXC6YtqTVn69gN+hY0t9FyvzoRKf0PfBbnLe8B/i8TL
        Xz3X/y9qy8A3ch9Ld3rNnKV1o4tgsLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631202217;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNgQc2FkrFrngb2fnW7lBDvXUcocqBnQwKVJFCBeAqQ=;
        b=GrxSH+tNuGAhad0+2D1kDaVaCydXTyxkok0WmYHDVc+DKaKaXOB3Y/F1PzCRT++NJbw6lw
        UoGOo83SJj0dzCCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 82002A3B8E;
        Thu,  9 Sep 2021 15:43:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 560B5DA7A9; Thu,  9 Sep 2021 17:43:32 +0200 (CEST)
Date:   Thu, 9 Sep 2021 17:43:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: fix mount failure due to past and transient
 device flush error
Message-ID: <20210909154331.GA15306@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <dcf9de78faa6ec5cef443d031a987c87301805b1.1631026981.git.fdmanana@suse.com>
 <893dad4768973411df7867e4436fe728d989fe1a.1631122173.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893dad4768973411df7867e4436fe728d989fe1a.1631122173.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 08, 2021 at 07:05:44PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we get an error flushing one device, during a super block commit, we
> record the error in the device structure, in the field 'last_flush_error'.
> This is used to later check if we should error out the super block commit,
> depending on whether the number of flush errors is greater than or equals
> to the maximum tolerated device failures for a raid profile.
> 
> However if we get a transient device flush error, unmount the filesystem
> and later try to mount it, we can fail the mount because we treat that
> past error as critical and consider the device is missing. Even if it's
> very likely that the error will happen again, as it's probably due to a
> hardware related problem, there may be cases where the error might not
> happen again. One example is during testing, and a test case like the
> new generic/648 from fstests always triggers this. The test cases
> generic/019 and generic/475 also trigger this scenario, but very
> sporadically.
> 
> When this happens we get an error like this:
> 
>   $ mount /dev/sdc /mnt
>   mount: /mnt wrong fs type, bad option, bad superblock on /dev/sdc, missing codepage or helper program, or other error.
> 
>   $ dmesg
>   (...)
>   [12918.886926] BTRFS warning (device sdc): chunk 13631488 missing 1 devices, max tolerance is 0 for writable mount
>   [12918.888293] BTRFS warning (device sdc): writable mount is not allowed due to too many missing devices
>   [12918.890853] BTRFS error (device sdc): open_ctree failed
> 
> The failure happens because when btrfs_check_rw_degradable() is called at
> mount time, or at remount from RO to RW time, is sees a non zero value in
> a device's ->last_flush_error attribute, and therefore considers that the
> device is 'missing'.
> 
> Fix this by setting a device's ->last_flush_error to zero when we close a
> device, making sure the error is not seen on the next mount attempt. We
> only need to track flush errors during the current mount, so that we never
> commit a super block if such errors happened.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V3: Use a different and cleaner approach, by reseting the flush error
>     from a device when we close it, so that it's not seen on the next
>     mount attempt.

Added to misc-next, thanks.
