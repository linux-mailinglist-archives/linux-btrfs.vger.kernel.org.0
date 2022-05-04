Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60E519F11
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbiEDMSY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbiEDMSX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:18:23 -0400
X-Greylist: delayed 494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 05:14:47 PDT
Received: from syrinx.knorrie.org (syrinx.knorrie.org [82.94.188.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8B18359
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:14:47 -0700 (PDT)
Received: from [IPV6:2a02:a213:2b80:4c00::12] (unknown [IPv6:2a02:a213:2b80:4c00::12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id B32B0611DD35A;
        Wed,  4 May 2022 14:06:31 +0200 (CEST)
Message-ID: <83b2f5df-fc16-627d-85b4-af07bac9a73b@knorrie.org>
Date:   Wed, 4 May 2022 14:06:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org,
        richard lucassen <mailinglists@lucassen.org>
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
From:   Hans van Kranenburg <hans@knorrie.org>
Subject: Re: Debian Bullseye install btrfs raid1
In-Reply-To: <20220504112315.71b41977e071f43db945687c@lucassen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Richard,

On 5/4/22 11:23, richard lucassen wrote:
> Hello list,
> 
> Still new to btrfs, I try to set up a system that is capable of
> booting even if one of the two disks is removed or broken. The BIOS
> supports this.
> 
> As the Debian installer is not capable of installing btrfs raid1, I 
> installed Bullseye using /dev/md0 for /boot (ext2) and a / btrfs on
> /dev/sda3. This works of course. After install I added /dev/sdb3 to
> the / fs: OK.

Did you 'just' add the disk to the filesystem, or did you also do a next
step of converting the existing data to the raid1 profile?

If you start out with 1 disk and simply add another, it tells btrfs
that it can continue writing just 1 (!) copy of your data wherever it 
likes. And, in this case, the filesystem *always* wants (needs!) all 
disks to be present to mount, of course.

disk 1  disk 2
A       C
B       E
D

If you want everything duplicated on both disks, you need to convert the 
existing data that you already had on the first disk to the raid1 
profile, and from then on, it will keep writing 2 copies of the data on 
any two disks in the filesystem (but you have exactly 2, so it's always 
on both of those two in that case).

disk 1  disk 2
A       D
B       B
D       C
C       A

If the previous installed system still works well when you add back the 
second disk again, you can still do this. (so, when you did not force 
any destructive operations, and just had it fail like seen below)

Can you share output of the following commands:

btrfs fi usage <mountpoint>

With the following command you let it convert all (d)ata and (m)etadata 
to the raid1 profile:

btrfs balance start -dconvert=raid1 -mconvert=raid1 /

Afterwards, you can check the result with the usage command. The data, 
metadata, and system lines in the output of the usage command should all 
say RAID1, and you should see that on both disks, a similar amount of 
data is present.

Hans

> Reboot: works. Proof/pudding/eating: I stopped the system, removed
> one of the disks and started again. It boots, but it refuses to mount
> the / fs, either without sda or sdb.
> 
> Question: is this newbie trying to set up an impossible config or
> have I missed something crucial somewhere?
> 
> R.
> 
> Begin: Running /scripts/init-premount ... done. Begin: Mounting root
> file system ... Begin: Running /scripts/local-top ... done. Begin:
> Running /scripts/local-premount ... [    6.809309] Btrfs loaded,
> crc32c=crc32c-generic Scanning for Btrfs filesystems [    6.849966]
> random: fast init done [    6.884290] BTRFS: device label data devid
> 1 transid 50 /dev/sda6 scanned by btrfs (171) [    6.892822] BTRFS:
> device fsid 1739f989-05e0-48d8-b99a-67f91c18c892 devid 1 transid 23
> /dev/sda5 scanned by btrfs (171) [    6.903959] BTRFS: device fsid
> f9cf579f-d3d9-49b2-ab0d-ba258e9df3d8 devid 1 transid 3971 /dev/sda3
> scanned by btrfs (171) Begin: Waiting for suspend/resume device ...
> Begin: Running /scripts/local-block ... done. Begin: Running
> /scripts/local-block ... done. Begin: Running /scripts/local-block
> ... done. Begin: Running /scripts/local-block ... done. Begin:
> Running /scripts/local-block ... done. Begin: Running
> /scripts/local-block ... done. Begin: Running /scripts/local-block
> ... done. Begin: Running /scripts/local-block ... done. Begin:
> Running /scripts/local-block ... done. Begin: Running
> /scripts/local-block ... done. Begin: Running /scripts/local-block
> ... done. Begin: Running /scripts/local-block ... done. Begin:
> Running /scripts/local-block ... done. Begin: Running
> /scripts/local-block ... done. Begin: Running /scripts/local-block
> ... done. Begin: Running /scripts/local-block ... done. Begin:
> Running /scripts/local-block ... done. Begin: Running
> /scripts/local-block ... [   27.015660] md/raid1:md0: active with 1
> out of 2 mirrors [   27.021181] md0: detected capacity change from 0
> to 262078464 [   27.036555] md/raid1:md1: active with 1 out of 2
> mirrors [   27.042062] md1: detected capacity change from 0 to
> 4294901760 done. done. done. Warning: fsck not present, so skipping
> root file system [   27.235880] BTRFS info (device sda3): flagging fs
> with big metadata feature [   27.242984] BTRFS info (device sda3):
> disk space caching is enabled [   27.249314] BTRFS info (device
> sda3): has skinny extents [   27.258259] BTRFS error (device sda3):
> devid 2 uuid 5b50e238-ae76-426f-bae3-deee5999adbc is missing [
> 27.267448] BTRFS error (device sda3): failed to read the system
> array: -2 [   27.275696] BTRFS error (device sda3): open_ctree
> failed mount: mounting /dev/sda3 on /root failed: Invalid argument 
> Failed to mount /dev/sda3 as root file system.
> 
> 
> BusyBox v1.30.1 (Debian 1:1.30.1-6+b3) built-in shell (ash) Enter
> 'help' for a list of built-in commands.
> 
> (initramfs)
> 
> 


