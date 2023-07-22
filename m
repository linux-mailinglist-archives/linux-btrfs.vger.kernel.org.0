Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEB75D9B1
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 06:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVEed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 00:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVEeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 00:34:31 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184C130D7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 21:34:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb87828386so734275e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 21:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690000468; x=1690605268;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAOcLe+JF+bhpNau5vW1y+YoqSWEhPUDuErUxHDTtSs=;
        b=aVGwnb8hu73lbW112m1vA/fMaXmOA/rNAT3bgc8u4Twq//jqWnwQnyV44xCoDDkwMj
         EqA2CNwsib2SbgOyaUu3ai7y8MUcUUxkj5RS98UUXLX0zOtMqtK84BnHxWzPbSR2KLOy
         cYn/Wtu/5MAyJXOoTsJ4slifkLRZ/nC8Iq7wJcnNA0toQfCK3Y6qCMFRUm1DaYg/QQF/
         dWmF3ZzySNubBIBKDlQGvFo69c5g2XrmMLi/SFn2U19UNbfdXQ5wY6TSpJciBWBCg8Qt
         etUcfYBjPHD7Z4l6i4K/oFTsp1hktLC8Y1tNizdvbDvjd2wnVbz7lxRGVHCVkk0P3hZc
         Beyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690000468; x=1690605268;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAOcLe+JF+bhpNau5vW1y+YoqSWEhPUDuErUxHDTtSs=;
        b=XFIO+4buvxuybHqYGEH693Ku/cIb5dlYVaJs0pZRgoKoEiOUfFCtD30a+Re0bI1xfw
         O10UKeStxlD4lqjkZgbOKwAy4/Y5K4l96QEumsmzm08FhPpSyAOkatm4LTjdPth6SFGq
         aay+RgIJu+xu/HLqh+CMkcM3j8mNrk0e+2AKoErzAdrhzlTJcFMNia1yKXyVYzJ3sVa2
         XgzpInX+LtYUegWxCj0sg5JXcwbbce7Po+XDDrefZCEY2B/6nbtZ4tRk4tEnSL5Tdnp9
         6XG4uAFvafq7RLT6X+0GKvIcthDkf45wqBwBx/C8HMuO6NXjtB5yYWw/GH3JvuyGgLpJ
         Wrqg==
X-Gm-Message-State: ABy/qLYrWABYAq2l4RrhKDmmuxsRQYUdlKz/BzMwE3jbvYoUHO+LlQpp
        m/3t82MggDT4Cnf4KssM18BaC0/kWio=
X-Google-Smtp-Source: APBJJlEu/zQD57rq/OBInyo6fN4XpZCA8cHBBNAQrlNlWFG7YO+yJhw+pZzmvjXuHpql2t0pNg58rg==
X-Received: by 2002:ac2:4891:0:b0:4fd:d47b:cff8 with SMTP id x17-20020ac24891000000b004fdd47bcff8mr1677072lfc.6.1690000467454;
        Fri, 21 Jul 2023 21:34:27 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:2474:2a7e:740:5ff2:c783? ([2a00:1370:8180:2474:2a7e:740:5ff2:c783])
        by smtp.gmail.com with ESMTPSA id d12-20020ac244cc000000b004fddb0eb960sm1016805lfm.165.2023.07.21.21.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 21:34:27 -0700 (PDT)
Message-ID: <9904a32c-76d7-903d-78b3-7df62c60141a@gmail.com>
Date:   Sat, 22 Jul 2023 07:34:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: race condition mounting multi-device iscsi volume, not resolved
 in newer kernels
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>, linux-btrfs@vger.kernel.org
References: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <c7aec65c5a94c32d9a2325ad3ad5c15ee94e5463.camel@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22.07.2023 03:40, Eric Levy wrote:
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

Log with timestamps could be more useful.

> Note that attachment of device `sdc` follows the mount attempt, as well
> as the announcement of scan completion.
> 
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

Something tries to mount this filesystem before all its devices are 
present. You need to find out what does it. btrfs is just a messenger here.

> systemd[1]: srv-store.mount: Failed with result 'exit-code'.
> systemd[1]: Failed to mount SAN Storage.
> systemd[1]: Dependency failed for Remote File Systems.
> systemd[1]: remote-fs.target: Job remote-fs.target/start failed with result 'dependency'.
> 
> kernel: sd 4:0:0:6: [sdc] Attached SCSI disk
> kernel: BTRFS: device fsid c6f83d24-1ac3-4417-bdd9-6249c899604d devid 12 transid 309446 /dev/sdc scanned by systemd-udevd (372)

