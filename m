Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CC88C1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfHJQB2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 12:01:28 -0400
Received: from know-smtprelay-omd-7.server.virginmedia.net ([81.104.62.39]:40830
        "EHLO know-smtprelay-omd-7.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfHJQB2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 12:01:28 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2019 12:01:27 EDT
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id wTiihDtHywGUPwTiihaZfp; Sat, 10 Aug 2019 16:55:52 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=Kc78TzQD c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=IkcTkHD0fZMA:10 a=wlwkM76NG8ceImqrYBoA:9
 a=QEXdDO2ut3YA:10
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Peter Chant <pete@petezilla.co.uk>
Subject: Mount failure with 5.2.7 but mounts with 5.1.4
Message-ID: <13654030-d9c5-ad3f-283e-16e6ef6c7bcf@petezilla.co.uk>
Date:   Sat, 10 Aug 2019 16:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCI9l/Cb61asoM3MqA0T0aTWaYW4RFgTZMxu44u1bHJdbTfSsaWnbugHsLpLAuz4Y6nxF88hpaUWmfhnuaaAfQInzZT3O/oKLkR/aXmjigD0XHeBmvt/
 H9p7lXlSyNy6OObfdhaTHx/wnMSCkmiEQtobmi0b2BRPgSyORF/8nwAv/hjS6//scyFPtw83zhjsuQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I attempted update an i5 machine today with kernel 5.2.7.  Unfortunately
I could not mount the file system.  However, reverting the kernel back
to 5.1.4 allowed it to mount with no issue.

This issue is not critical to me, machine boots with older kernel, I
have a backup and the machine is only lightly used anyway.  However, I
wonder whether this info is useful to anyone?

I have a spare ext4 root partition on the hard drive of the affected
machine, so I booted to that, with 5.2.7, and got the following behaviour.

dmesg:

[   55.139154] BTRFS: device fsid 5128caf4-b518-4b65-ae46-b5505281e500
devid 1 transid 66785 /dev/sda4
[   55.139623] BTRFS info (device sda4): disk space caching is enabled
[   55.813959] BTRFS critical (device sda4): corrupt leaf: root=5
block=38884884480 slot=1 ino=45745394, invalid inode generation: has
18446744073709551492 expect [0, 66786]
[   55.817296] BTRFS error (device sda4): block=38884884480 read time
tree block corruption detected
[   55.817342] BTRFS warning (device sda4): failed to read fs tree: -5
[   55.834802] BTRFS error (device sda4): open_ctree failed

/var/log/messages:
Aug 10 11:59:05 retreat dbus[903]: [system] Activating service
name='org.freedesktop.PolicyKit1' (using servicehelper)
Aug 10 11:59:05 retreat polkitd[975]: started daemon version 0.105 using
authority implementation `local' version `0.105'
Aug 10 11:59:05 retreat dbus[903]: [system] Successfully activated
service 'org.freedesktop.PolicyKit1'
Aug 10 11:59:31 retreat kernel: [   55.139154] BTRFS: device fsid
5128caf4-b518-4b65-ae46-b5505281e500 devid 1 transid 66785 /dev/sda4
Aug 10 11:59:31 retreat kernel: [   55.139623] BTRFS info (device sda4):
disk space caching is enabled

uname -a:
Linux retreat 5.2.7 #1 SMP Wed Aug 7 23:53:42 BST 2019 x86_64 Intel(R)
Core(TM) i5-4430 CPU @ 3.00GHz GenuineIntel GNU/Linux

Rebooting with 5.1.4 showed no problems.


A very similar kernel, with AMD rather than Intel processor options, is
running on the Ryzen machine I am typing this on.  I did have my hdd
file system seem to hang, but not sure if that is related.

I have not tried the intel kernel on my laptop, but the laptop is a lot
older, as it is a core2duo.

Seems a bit odd to me that 5.2.7 should show such an issue but 5.1.4 be
OK with it.

Pete

