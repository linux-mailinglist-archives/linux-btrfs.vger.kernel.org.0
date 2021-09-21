Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60C413A57
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 20:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhIUSxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 14:53:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50646 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbhIUSxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 14:53:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED39622148;
        Tue, 21 Sep 2021 18:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632250296;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JDM4MAT7/fjgS+DMd3f4gB8yKKeMGUkqLSseciFGHg=;
        b=sNAary97/TlUZ2wsPHIQGPqKfwYU7PPvEToFMhNx+fjoXb5RZC4JT0VSAoK954kE7OsPTL
        VGaONT5BKCytfAN3bRBef0wN6VcK/8PTexYtxxedWO34/CwkkrpCAay6c+v6DqH073eUHE
        dNTkdRByD2IRWb7yZ//iPBVTNWKxCys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632250296;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JDM4MAT7/fjgS+DMd3f4gB8yKKeMGUkqLSseciFGHg=;
        b=MaxvpmE9dSF7I4Iescz4hXEopZ1k2qSVaZwE0IC58i/V+edMkBy8MXhj82OZY9UawRvwzR
        Xdx2WkTZeVoRX0Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E6AA7A3B88;
        Tue, 21 Sep 2021 18:51:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EAE3FDA72B; Tue, 21 Sep 2021 20:51:24 +0200 (CEST)
Date:   Tue, 21 Sep 2021 20:51:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Implement progs support for removing received
 uuid on RW vols
Message-ID: <20210921185124.GQ9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914090558.79411-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 12:05:50PM +0300, Nikolay Borisov wrote:
> Here's V2 which takes into account Qu's suggestions, namely:
> 
> - Add a helper which contains the common code to clear receive-related data
> - Now there is a single patch which impements the check/clear for both orig and
> lowmem modes
> - Added Reviewed-by from Qu.
> 
> 
> Nikolay Borisov (8):
>   btrfs-progs: Add btrfs_is_empty_uuid
>   btrfs-progs: Remove root argument from btrfs_fixup_low_keys
>   btrfs-progs: Remove fs_info argument from leaf_data_end
>   btrfs-progs: Remove root argument from btrfs_truncate_item
>   btrfs-progs: Add btrfs_uuid_tree_remove
>   btrfs-progs: Implement helper to remove received information of RW
>     subvol
>   btrfs-progs: check: Implement removing received data for RW subvols
>   btrfs-progs: tests: Add test for received information removal

Patches 2-5 added to devel as they're preparatory and otherwise OK as
independent cleanups.

Regarding the rw and received_uuid, it's choosing between these options:

1) ro->rw resets received_uuid unconditionally

Pros:
- safe as it does not lead to unexpected results after incremental send

Cons:
- unconditional, so it's too easy to break the incremental send usecase,
  which is the main usecase, if that' for backups breaking the
  continuity is IMNSHO serious usability problem -- and main reason why
  I'm personally looking for other options

Issuing a warning when the ro status is changed by btrfs-progs is only
partially fixing that as the raw ioctl or it's wrapper in libbtrfsutil
will happily destroy the received_uuid. There's no log or other
information that would make it possible to restore it.

Note that received_uuid can be set to any value using the
BTRFS_IOC_SET_RECEIVED_SUBVOL ioctl, as long as the subvolume is
writable.

2) don't allow ro->rw if received_uuid is set, it must be cleared first

As mentioned above, the received_uuid can be changed or reset (setting
all zeros), but there's still the condition that the subvolume must be
writable.

After 'receive' the subvolume is snapshotted, updated from stream, set
received_uuid and set rw->ro.

Reusing the SET_RECEIVED_SUBVOL can't be used as-is, the subvol would
have to be rw first. Which is a chicken-egg problem.

The safe steps would be:

- (after receive, subvolume is RO)
- set it to RW
- clear received_uuid
- either keep it RW or set RO again

This would be the single "clear received_uuid manually" and it would be
up to the user to knowingly destroy the continuity of the incremental
send.

The fix here is that the above steps would have to be atomic from user
perspective, inside SET_RECEIVED_SUBVOL, eg. based on flag. And we'd
have to add a btrfs-progs command somewhere.
