Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9060F568830
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 14:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiGFMSx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 08:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiGFMSv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 08:18:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC68237EE
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 05:18:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8176822641;
        Wed,  6 Jul 2022 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657109928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A17kg5BCVClZkxKShwvOB5h3c3BRCAQlbBOzI/gw+x0=;
        b=WPxrpEW31NY9TDfYTLPm/pQPyhU0VE89LAeMx+rG/r/ZffDw/VAvlM3hoLt5pMyj2wsZvH
        +hAgiRsMcMAOugta6noA5H8cNNo9a5XmccQhniAFBCFGyfwFF48+CsXq4ugwhtlyUkpQ8/
        qMri8ColE+4wsgaDMENVZgHkfpItR/Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53157134CF;
        Wed,  6 Jul 2022 12:18:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +chFEah9xWJTDAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 06 Jul 2022 12:18:48 +0000
Message-ID: <add2b9ba-831b-9cc6-7858-3938c33de78b@suse.com>
Date:   Wed, 6 Jul 2022 15:18:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: lost page write due to IO error on [...]
Content-Language: en-US
To:     Nicolas Averesch <naveresch@xsec.at>, linux-btrfs@vger.kernel.org
References: <36ad3a51-3629-06b0-2a04-a106bf571a91@xsec.at>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <36ad3a51-3629-06b0-2a04-a106bf571a91@xsec.at>
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



On 6.07.22 г. 14:59 ч., Nicolas Averesch wrote:
> Hi *,
> 
> we are seeing BTRFS-Errors on two of our (new) harddrives.
> 
> Our current setup for these harddrives is BTRFS on top of LUKS on top of 
> LVM.
> 
> The error:
> 
> [ 4027.385538] blk_update_request: I/O error, dev sdc, sector 36992 op 
> 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
> [ 4027.385620] BTRFS warning (device dm-6): lost page write due to IO 
> error on /dev/mapper/vg3-lv3_crypt (-5)
> [ 4027.385630] BTRFS error (device dm-6): bdev /dev/mapper/vg3-lv3_crypt 
> errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
> [ 4027.385698] BTRFS error (device dm-6): error writing primary super 
> block to device 1
> [ 4027.385829] BTRFS: error (device dm-6) in write_all_supers:4255: 
> errno=-5 IO failure (1 errors while writing supers)
> [ 4027.385873] BTRFS info (device dm-6): forced readonly

You are getting errors from the storage layer:

[ 4027.385505] sd 7:0:3:0: [sdc] tag#51 FAILED Result: 
hostbyte=DID_SOFT_ERROR driverbyte=DRIVER_OK cmd_age=0s
[ 4027.385524] sd 7:0:3:0: [sdc] tag#51 Sense Key : Aborted Command 
[current] [descriptor]
[ 4027.385527] sd 7:0:3:0: [sdc] tag#51 Add. Sense: No additional sense 
information
[ 4027.385533] sd 7:0:3:0: [sdc] tag#51 CDB: Write(16) 8a 08 00 00 00 00 
00 00 90 80 00 00 00 08 00 00
[ 4027.385538] blk_update_request: I/O error, dev sdc, sector 36992 op 
0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0

[ 4234.250238] sd 7:0:4:0: [sdd] tag#364 FAILED Result: 
hostbyte=DID_SOFT_ERROR driverbyte=DRIVER_OK cmd_age=0s
[ 4234.250269] sd 7:0:4:0: [sdd] tag#364 Sense Key : Aborted Command 
[current] [descriptor]
[ 4234.250273] sd 7:0:4:0: [sdd] tag#364 Add. Sense: No additional sense 
information
[ 4234.250277] sd 7:0:4:0: [sdd] tag#364 CDB: Write(16) 8a 08 00 00 00 
00 00 00 90 80 00 00 00 08 00 00
[ 4234.250280] blk_update_request: I/O error, dev sdd, sector 36992 op
0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0

This is causing btrfs to not be able to write its superlbock when doing 
transaction commit. So in this case the problem is in the lower layers.

> 
> Is there any way to figure out what exactly is going wrong? Could this 
> error be due to misconfiguration of btrfs? (Or just a simple hardware 
> issue?)
> 
> We have already set /sys/block/sdc/device/timeout and 
> /sys/block/sdd/device/timeout to 180.
> 
> For more details please find dmesg here: 
> https://bin.0xfc.de/?f66f5337238b06bc#3kgTBVYt1okReYAvyawEWy7LiUquuZ1jZL6bGxzHdYVX 
> 
> 
> # uname -a
> Linux hostname 5.15.39-1-pve #1 SMP PVE 5.15.39-1 (Wed, 22 Jun 2022 
> 17:22:00 +0200) x86_64 GNU/Linux
> #  btrfs --version
> btrfs-progs v5.16.2
> # btrfs fi show
> Label: none  uuid: f8c37b45-dcaf-4553-ad4f-379b472868f4
>      Total devices 2 FS bytes used 35.05GiB
> 
>      <those devices (vg1-lv1_crypt and vg2-lv2_crypt) are OS drives and 
> not affected by aforementioned issues>
> 
>      devid    1 size 930.56GiB used 37.03GiB path /dev/mapper/vg1-lv1_crypt
>      devid    2 size 930.56GiB used 37.03GiB path /dev/mapper/vg2-lv2_crypt
> 
> Label: none  uuid: e641c14b-a09c-4e6a-83b8-7176728d8f01
>      Total devices 1 FS bytes used 176.00KiB
>      devid    1 size 3.64TiB used 2.02GiB path /dev/mapper/vg4-lv4_crypt
> 
> Label: none  uuid: b50ebf38-bcbd-438d-9f04-22b4946cd65c
>      Total devices 1 FS bytes used 192.00KiB
>      devid    1 size 3.64TiB used 2.02GiB path /dev/mapper/vg3-lv3_crypt
> 
> # btrfs fi df /hdds
> Data, single: total=8.00MiB, used=0.00B
> System, DUP: total=8.00MiB, used=16.00KiB
> Metadata, DUP: total=1.00GiB, used=128.00KiB
> GlobalReserve, single: total=3.25MiB, used=32.00KiB
> 
> We'd appreciate any help we can get.
> 
> Best regards,
> 
> Nico
> 
