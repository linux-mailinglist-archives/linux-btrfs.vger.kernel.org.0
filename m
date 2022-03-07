Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D173E4D01F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiCGOw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 09:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiCGOwI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 09:52:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642D88F9BE
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 06:51:05 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A2F81F37C;
        Mon,  7 Mar 2022 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646664664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qq/cLnW78WiQ2q6AYwIXyEbeNb0w7flk4/SDi5+NBg=;
        b=O7RMXYDdUfsZDpbbz/c+ohaDngDCUEw71U0QT54kV8V+lcRtKefdNJkgNbkSBlKF/oKmLY
        mLOm1RkKPebTz5TUIc3hj1Zt1RwrOE0ZfVefUJOO7mk3xOI6Xj1wm4E8OusNvoRUHkSOm+
        Qy+vX21cQsUbM/VWbWdd3N5wjCSmMic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646664664;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qq/cLnW78WiQ2q6AYwIXyEbeNb0w7flk4/SDi5+NBg=;
        b=kYt5tBnvrjQKto6gM0R+rBjQiKD3uQEeX4P38znO/zYkQ5lGVYcE3Mi3N9LFQNO2InUZ9L
        t8GSMfhDN/SFU4Dw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 12061A3B84;
        Mon,  7 Mar 2022 14:51:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8F7F1DA7F7; Mon,  7 Mar 2022 15:47:09 +0100 (CET)
Date:   Mon, 7 Mar 2022 15:47:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     ethanlien <ethanlien@synology.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix qgroup reserve overflow break the qgroup limit
Message-ID: <20220307144709.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, ethanlien <ethanlien@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20220307100004.24759-1-ethanlien@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307100004.24759-1-ethanlien@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 07, 2022 at 06:00:04PM +0800, ethanlien wrote:
> We use extent_changeset->bytes_changed in qgroup_reserve_data() to record
> how many bytes we set for EXTENT_QGROUP_RESERVED state. Currently the
> bytes_changed is set as "unsigned int", and it will overflow if we try to
> fallocate a range larger than 4GiB. The result is we reserve less bytes
> and eventually break the qgroup limit.
> 
> The following example test script reproduces the problem:
> 
>   $ cat qgroup-overflow.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdj
>   MNT=/mnt/sdj
> 
>   mkfs.btrfs -f $DEV
>   mount $DEV $MNT
> 
>   # Set qgroup limit to 2GiB.
>   btrfs quota enable $MNT
>   btrfs qgroup limit 2G $MNT
> 
>   # Try to fallocate a 3GiB file. This should fail.
>   echo
>   echo "Try to fallocate a 3GiB file..."
>   fallocate -l 3G $MNT/3G.file
> 
>   # Try to fallocate a 5GiB file.
>   echo
>   echo "Try to fallocate a 5GiB file..."
>   fallocate -l 5G $MNT/5G.file
> 
>   # See we break the qgroup limit.
>   echo
>   sync
>   btrfs qgroup show -r $MNT
> 
>   umount $MNT
> 
> When running the test:
> 
>   $ ./qgroup-overflow.sh
>   (...)
> 
>   Try to fallocate a 3GiB file...
>   fallocate: fallocate failed: Disk quota exceeded
> 
>   Try to fallocate a 5GiB file...
> 
>   qgroupid         rfer         excl     max_rfer
>   --------         ----         ----     --------
>   0/5           5.00GiB      5.00GiB      2.00GiB
> 
> Since we have no control of how bytes_changed is used, it's better to
> set it to u64.
> 
> Signed-off-by: ethanlien <ethanlien@synology.com>

Added to misc-next, thanks.
