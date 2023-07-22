Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A675DA3C
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 07:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGVFfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 01:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGVFfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 01:35:54 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 22:35:50 PDT
Received: from ts201-relay01.ddc.teliasonera.net (ts201-relay01.ddc.teliasonera.net [81.236.60.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEFA1986
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 22:35:50 -0700 (PDT)
Received: from gammdatan.home.lan (78-73-44-111-no600.tbcn.telia.com [78.73.44.111])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by ts201-relay01.ddc.teliasonera.net (Postfix) with ESMTPS id A0EE58075D2;
        Sat, 22 Jul 2023 07:27:52 +0200 (CEST)
Received: from [IPV6:2001:2002:4e49:2c6f:5444:da6f:3ab9:f14b] ([IPv6:2001:2002:4e49:2c6f:5444:da6f:3ab9:f14b])
        by gammdatan.home.lan (8.17.1/8.17.1) with ESMTP id 36M5RpvA072730;
        Sat, 22 Jul 2023 07:27:52 +0200
Message-ID: <4d3142d5-cf0e-5c26-9a8d-80f040d7e557@jansson.tech>
Date:   Sat, 22 Jul 2023 07:27:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
Content-Language: en-US
From:   =?UTF-8?Q?Torbj=c3=b6rn_Jansson?= <torbjorn@jansson.tech>
In-Reply-To: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-07-22 02:40, Eric Levy wrote:
> I mount a volume that spans multiple devices, all provided as logical
> units from an iSCSI target.
> 
> Mounting is inconsistently successful at boot.
> 
> The problem had presented with both kernel versions 5.19.0 and 6.2.0.
> 
> After learning that a patch for similarly reported problems had been
> submitted in commit 50d281fc434c, I further tested with kernels 6.3.0
> and 6.5.0-rc2.
> 
> The general problem has persisted even with the newer kernels.
> 
> The system is Linux Mint and all kernels are Ubuntu mainline.
> 
> Mounting is possible manually after boot, though the mount status of
> the volume appears to be left in an inconsistent state at such time.
> 
> The below system log, with redaction for unrelated messages, is taken
> from a boot sequence for which mounting has failed, with kernel version
> 6.3.0.
> 
> Note that attachment of device `sdc` follows the mount attempt, as well
> as the announcement of scan completion.
> 

i assume you mount your filesystem via fstab.
i had issues once in the past with a network filesystem and getting the timing 
right, i then discovered that you can add a few extra options in fstab to tell 
systemd how to behave.

from memory i think it was x-systemd.requires= i had to use in fstab.

see:
https://www.freedesktop.org/software/systemd/man/systemd.mount.html

perhaps you can make your fstab entry depend on your iscsi service and control 
the order that way.


> ---
> 
> kernel: Linux version 6.3.0-060300-generic (kernel@sita) (x86_64-linux-gnu-gcc-12 (Ubuntu 12.2.0-9ubuntu1) 12.2.0, GNU ld (GNU Binutils for Ubuntu) 2.39) #202304232030 SMP PREEMPT_DYNAMIC Sun Apr 23 20:37:49 UTC 2023
> 
> systemd[1]: Starting Login to default iSCSI targets...
> 
> systemd[1]: Starting iSCSI initiator daemon (iscsid)...
> iscsid[749]: iSCSI logger with pid=754 started!
> systemd[1]: iscsid.service: Failed to parse PID from file /run/iscsid.pid: Invalid argument
> iscsid[754]: iSCSI daemon with pid=755 started!
> systemd[1]: Started iSCSI initiator daemon (iscsid).
> 
> kernel: Loading iSCSI transport class v2.0-870.
> 
> kernel: iscsi: registered transport (tcp)
> kernel: scsi host4: iSCSI Initiator over TCP/IP
> 
> kernel: scsi 4:0:0:6: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:6: [sdc] 2097152000 512-byte logical blocks: (1.07 TB/1000 GiB)
> kernel: sd 4:0:0:6: [sdc] Write Protect is off
> kernel: sd 4:0:0:6: [sdc] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:6: [sdc] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:6: [sdc] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:6: [sdc] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:6: Attached scsi generic sg4 type 0
> kernel: scsi 4:0:0:7: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:7: Attached scsi generic sg5 type 0
> kernel: sd 4:0:0:7: [sdd] 2097152000 512-byte logical blocks: (1.07 TB/1000 GiB)
> kernel: scsi 4:0:0:3: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:7: [sdd] Write Protect is off
> kernel: sd 4:0:0:7: [sdd] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:7: [sdd] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:7: [sdd] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:7: [sdd] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:3: [sde] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:3: [sde] Write Protect is off
> kernel: sd 4:0:0:3: [sde] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:3: Attached scsi generic sg6 type 0
> kernel: sd 4:0:0:3: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: scsi 4:0:0:4: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:3: [sde] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:3: [sde] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:4: [sdf] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:4: [sdf] Write Protect is off
> kernel: sd 4:0:0:4: [sdf] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:4: [sdf] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:4: [sdf] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:4: [sdf] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: sd 4:0:0:7: [sdd] Attached SCSI disk
> kernel: sd 4:0:0:3: [sde] Attached SCSI disk
> kernel: sd 4:0:0:4: [sdf] Attached SCSI disk
> kernel: sd 4:0:0:4: Attached scsi generic sg7 type 0
> kernel: scsi 4:0:0:2: Direct-Access     SYNOLOGY Storage          4.0  PQ: 0 ANSI: 5
> kernel: sd 4:0:0:2: Attached scsi generic sg8 type 0
> kernel: sd 4:0:0:2: [sdg] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:2: [sdg] Write Protect is off
> kernel: sd 4:0:0:2: [sdg] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:2: [sdg] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:2: [sdg] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:2: [sdg] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> kernel: scsi 4:0:0:1: Direct-Access     SYNOLOGY iSCSI Storage    4.0  PQ: 0 ANSI: 5
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 11 transid 309446 /dev/sdd scanned by systemd-udevd (371)
> kernel: sd 4:0:0:1: Attached scsi generic sg9 type 0
> kernel: sd 4:0:0:1: [sdh] 524288000 512-byte logical blocks: (268 GB/250 GiB)
> kernel: sd 4:0:0:1: [sdh] Write Protect is off
> kernel: sd 4:0:0:1: [sdh] Mode Sense: 43 00 10 08
> kernel: sd 4:0:0:1: [sdh] Write cache: enabled, read cache: enabled, supports DPO and FUA
> kernel: sd 4:0:0:1: [sdh] Preferred minimum I/O size 512 bytes
> kernel: sd 4:0:0:1: [sdh] Optimal transfer size 16384 logical blocks > dev_max (8192 logical blocks)
> iscsiadm[721]: Logging in to [iface: default, target: iqn.2000-01.com.synology:diskstation.default-target.b890048b949, portal: 10.4.1.2,3260]
> iscsiadm[721]: Login to [iface: default, target: iqn.2000-01.com.synology:diskstation.default-target.b890048b949, portal: 10.4.1.2,3260] successful.
> kernel: sd 4:0:0:2: [sdg] Attached SCSI disk
> kernel: sd 4:0:0:1: [sdh] Attached SCSI disk
> 
> systemd[1]: Finished Login to default iSCSI targets.
> systemd[1]: Reached target Preparation for Remote File Systems.
> systemd[1]: Mounting SAN Storage...
> systemd[1]: Finished Availability of block devices.
> kernel: BTRFS info (device sdd): using crc32c (crc32c-intel) checksum algorithm
> kernel: BTRFS info (device sdd): turning on async discard
> kernel: BTRFS info (device sdd): disk space caching is enabled
> kernel: BTRFS error (device sdd): devid 8 uuid 3d66ced8-24c1-45dc-9d70-8a921764dc88 is missing
> kernel: BTRFS error (device sdd): failed to read the system array: -2
> kernel: BTRFS error: device /dev/sdf belongs to fsid c6f83d24-1ac3-4417-bdd9-6249c899604d, and the fs is already mounted
> nm-dispatcher[919]: /etc/network/if-up.d/resolved: 12: mystatedir: not found
> kernel: BTRFS error (device sdd): open_ctree failed
> mount[921]: mount: /srv/store: wrong fs type, bad option, bad superblock on /dev/sdd, missing codepage or helper program, or other error.
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 8 transid 309446 /dev/sde scanned by systemd-udevd (376)
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 6 transid 309446 /dev/sdg scanned by systemd-udevd (365)
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 7 transid 309446 /dev/sdh scanned by systemd-udevd (363)
> systemd[1]: srv-store.mount: Mount process exited, code=exited, status=32/n/a
> 
> systemd[1]: srv-store.mount: Failed with result 'exit-code'.
> systemd[1]: Failed to mount SAN Storage.
> systemd[1]: Dependency failed for Remote File Systems.
> systemd[1]: remote-fs.target: Job remote-fs.target/start failed with result 'dependency'.
> 
> kernel: sd 4:0:0:6: [sdc] Attached SCSI disk
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 12 transid 309446 /dev/sdc scanned by systemd-udevd (372)
> 


