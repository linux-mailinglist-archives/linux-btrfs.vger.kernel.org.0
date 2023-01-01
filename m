Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE3E65A97D
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjAAJ14 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Jan 2023 04:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjAAJ1z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Jan 2023 04:27:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB932645
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Jan 2023 01:27:51 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1McpNy-1odOtM3RTe-00Zte1; Sun, 01
 Jan 2023 10:27:47 +0100
Message-ID: <bea8afad-b3dc-82e5-f5ed-d3ef73391ff4@gmx.com>
Date:   Sun, 1 Jan 2023 17:27:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Buggy behaviour after replacing failed disk in RAID1
Content-Language: en-US
To:     =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>, linux-btrfs@vger.kernel.org
References: <CACsxjPaFgBMRkeEgbHcGwM7czSrjtakX9hSKXQq7RL2wJZYYCA@mail.gmail.com>
 <CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com>
 <d13c2454-b642-2db7-371e-b669fdf24279@gmx.com>
 <63b1143d.170a0220.9d74e.f651@mx.google.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <63b1143d.170a0220.9d74e.f651@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aOo6DKcRoRsJSjzyzK2O8ovWpiUrqUznAAqbhgG33VOISOzZTCJ
 Tu0rK4H52y09Pgew3Hh8SehqTbEu2wjFwwUy67jNyM4DMakq9McwK/W3861AiDTHr2NuTfl
 pO8vEMCgNh+5+GjzP4CgYXVr1mblLTxfvVjc+fYzk+X6gCsVkfT8dZuW30EzPGiwPwgfVIe
 wJalDH3TAdnGPATbcmLNg==
UI-OutboundReport: notjunk:1;M01:P0:Jx2OPyu7Bps=;UyPeo19roBbDa1+OLz34semwaMF
 5RKnmUcY0uADKBWQrM8OOM6z0sp5MkElScjhp1UZGTH0mU8Bu3XwbRNQiS4RhYWtgKJobHqkb
 1QlAAYsfX2iOmE7ZvO0eNitUfI2nOhPlkebFbA+sKqHE6wSUGc8AlToI8Radh3VOSsqKtkd39
 XcMf7I05mmm+MNxYUwGCzVGOhyjmwW7aBopu9cBKaIAtCVnNO2HGd6A6ud1Ro6miXVxkd1Nvc
 3FONa0tQw8dF7Hr7aBQfJnZMLxIsyYlVr+8+fQ2sC+SZfKRZV+gmHHP6dVqMGYGLQLhRqa05v
 G6ATsIZu3ugEfU48M1Wa0KJ4BMuAfxnnRkHJXSgtKHl40aZr7oXB31KCMN7g93RuK/54b2NWd
 /lsa+oC/5abShcfq/pnXbsXEcyC62ntFKbYDXqddD6vrOvplty+jOYqzk68gZExVY20kiEDs+
 pz8WrrBIrdVIq6ms2HymVdwnU5XP9r3oe9X3ZXB0CVb14ktv155Y9Gih2GqqO5qbs4t9Z3JK2
 96lhc0RXraVXPJ24h7E+NCuXatQfDnGkWEDcrNV06fDq++diWPMLZWg2jb7fMwSaAA7OCyT+/
 sY1kojtMq8n3OW9s6Lyj0VhQIjrkG4I2swntY/h6FMQO6HgL9eNiz1rAfIj4Oxb9ku3Rw5G3F
 XWNI4H1rwucWw7KRKO9zp/TX9sB9/B8o4viSw0oj4aS7v0tLUMM2+AVNINxKrlGdJQ7pG25O5
 mcj3bAHa04AWzvNFGNONKaDxAXlWLihpSuNdsgOnG3uBTA4yd/YTHmiMhkZ1MvIS5k5/cB5Kb
 otqzC9b/t7iMzGZFy6GJEwdI7qSBU19I4lV0AUbDCr1IeX/Oyhpa7Vy9CgZayZ0+5X44M/iS6
 QGG5fYyh7mCKGB83Z63bxaeoO+4o3729hjCOYUsNqWDUYCdyqBmg4wdGg/qanFl+U0uAcos7t
 M2Cim0zjW84CGFCGfwZdvIY9MFs=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/1 13:03, 小太 wrote:
>> Weirdly, the dmesg is not showing devid 1 missing, in fact, it still
>> shows the devices is there, just tons of IO errors (ata4, sd 3:0:0:0)
> 
>> If you initially removed the hard disk completely, btrfs then can handle
>> it well.
>> (Sure, this is a bug in btrfs and we should be able to fix it).
> 
> I did completely remove the drive. In fact, I used the very same SATA port for
> the replacement drive. See my dmesg lines:
> 
>> [1744757.386462] ata4: SATA link down (SStatus 0 SControl 300)
>> [1744762.810285] ata4: SATA link down (SStatus 0 SControl 300)
>> [1744768.190059] ata4: SATA link down (SStatus 0 SControl 300)
>> [1744768.190072] ata4.00: disable device
>> [1744768.190097] ata4.00: detaching (SCSI 3:0:0:0)
>> [1744768.295895] sd 3:0:0:0: [sda] Stopping disk
>> [1744768.295913] sd 3:0:0:0: [sda] Start/Stop Unit failed: Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
>> ...
>> [1745523.320657] ata4: found unknown device (class 0)
>> [1745527.965324] ata4: softreset failed (1st FIS failed)
>> [1745533.288241] ata4: found unknown device (class 0)
>> [1745533.452246] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [1745533.453025] ata4.00: ATA-9: MB2000ECWCR, HPG4, max UDMA/133
>> [1745533.453306] ata4.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 32), AA
>> [1745533.454136] ata4.00: configured for UDMA/133
>> [1745533.464339] scsi 3:0:0:0: Direct-Access     ATA      MB2000ECWCR      HPG4 PQ: 0 ANSI: 5
>> [1745533.464556] sd 3:0:0:0: Attached scsi generic sg3 type 0
>> [1745533.464652] sd 3:0:0:0: [sdd] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
>> [1745533.464667] sd 3:0:0:0: [sdd] Write Protect is off
>> [1745533.464671] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>> [1745533.464684] sd 3:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>> [1745533.464700] sd 3:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
>> [1745533.492586] sd 3:0:0:0: [sdd] Attached SCSI disk
> 
> I also verified that the device file /dev/sda was also gone at the time (despite
> "btrfs fi show" thinking it still exists).

OK, I guess there is really no way to let btrfs to release that faulty 
device until it got replaced.

And since the root cause is not the hanging sda, but a bug in btrfs 
repair code (patch already sent), it's unrelated to the bug.

Thanks,
Qu
> Maybe there's some other bug where the kernel still thinks the drive exists, even
> though it was disconnected?
