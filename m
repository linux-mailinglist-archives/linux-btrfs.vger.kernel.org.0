Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD84EAAD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 11:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiC2J4l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiC2J4k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 05:56:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918AB326D6
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 02:54:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C995218F4;
        Tue, 29 Mar 2022 09:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648547696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mOYj+qtwxY4Z8W0a5Y4iAlX6VwkCQNztpBQEjrD4KWs=;
        b=VehEn+uG6JnmbhiiIETKHEcG/sD1rsykjbG6bkMCMxTDXVoM2ZKjQ7U7MYn1fiBK51F2J+
        q3b7rnW4fh6Z/j1G50LN1lwt6FRkufpyyjwULDkvzuWi5I4R7EImS7HZpD8WG7iEJyAoNI
        7jckWmypuoO671xwQPcuzuTXVBbAgUo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BC5613A7E;
        Tue, 29 Mar 2022 09:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4InLA3DXQmKoVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 29 Mar 2022 09:54:56 +0000
Message-ID: <069a1ea8-566d-8bae-31df-6cb5f3709f89@suse.com>
Date:   Tue, 29 Mar 2022 12:54:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: btrfs: raid1C3 and raid1C4 fails to go ro when all but 1 drive
 removed.
Content-Language: en-US
To:     peter brown <brown@freenet.carleton.ca>,
        linux-btrfs@vger.kernel.org
References: <29f7e1cb-7882-ee15-2c19-01d5c43ce363@freenet.carleton.ca>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <29f7e1cb-7882-ee15-2c19-01d5c43ce363@freenet.carleton.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.03.22 г. 6:44 ч., peter brown wrote:
> Hi,
> 
>   If I set up raid1C3 or raid1C4 and pull drives to simulate a drive 
> failure the fs does not go readonly.
> 
>   If I perform the same test on a raid1 setup the fs goes readonly when 
> the second last drive is removed. Ie when the fs can no longer maintain 
> a two copy mirror.
> 
> 
> 
> kernel 5.16.17-gentoo
> btrfs-progs v5.16.2
> 
> short version of the logs...
> 
> test1 ~ # mkfs.btrfs -f -L test -d raid1C3 -m raid1C3  /dev/sdb /dev/sdc 
> /dev/sde /dev/sdf
> test1 ~ # mount -t btrfs -o noatime /dev/sdb /mnt/btrfs/
> 
> 
> 
> RAID1C3
> pull drive 1 (3 left)
> pull drive 2 (2 left)

For raid1c3 we tolerate 2 failures, since you've removed 2 device you 
are within the boundaries so no failure is expected.

<snip>

> 
> 
> 
> pulling drive 3  we no longer can support 2 copies.. just 1

Here you've pulled 3 drives so when we try to writeback stuff to disk 
(like during transaction commit) the writes should fail and the 
filesystem switch to RO.

<snip>

> 
> read from fs
> find .
> no errors and no logs
> 
> The fs should go ro when we write the the drive in this state.

Yes it should, however this likely won't happen the same instant as you 
remove the drive. Instead it will wait until a write has to hit disk and 
the bio mapping routines figures out that the number of missing devices 
is above the threshold.

> 
> write to fs
> touch 3
> no errors ---  dmesg logs.
> [Thu Mar 24 23:31:34 2022] btrfs_dev_stat_print_on_error: 2 callbacks 
> suppressed
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: 
> wr 8, rd 0, flush 1, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: 
> wr 1, rd 0, flush 0, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: 
> wr 9, rd 0, flush 1, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: 
> wr 2, rd 0, flush 0, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: 
> wr 10, rd 0, flush 1, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: 
> wr 3, rd 0, flush 0, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdb errs: 
> wr 6, rd 0, flush 3, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sde errs: 
> wr 10, rd 0, flush 2, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdf errs: 
> wr 3, rd 0, flush 1, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sdb (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): bdev /dev/sdb errs: 
> wr 7, rd 0, flush 3, corrupt 0, gen 0
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sdb (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sdb (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sde (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sde (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sde (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sdf (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sdf (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS warning (device sdb): lost page write 
> due to IO error on /dev/sdf (-5)
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): error writing 
> primary super block to device 1
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): error writing 
> primary super block to device 3
> [Thu Mar 24 23:31:34 2022] BTRFS error (device sdb): error writing 
> primary super block to device 4
> 
> There is no going ro log and the write should fail.
> 
> raid1C4 is the same thing. As 4 copies are required it should do ro when
> the first drive is pulled.

No, it shouldn't , raid1c4 tolerates up to 3 missing devices.

> 
> 
> If I configure as raid1

<snip>

>   Am I missing something here?

Raid1 tolerates 1 drive failure.

> 
> 
> 
> 
> 
> 
> 
> 
