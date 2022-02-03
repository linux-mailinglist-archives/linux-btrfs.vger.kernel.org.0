Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C441D4A88BB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 17:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352289AbiBCQk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 11:40:58 -0500
Received: from mail.xsoli.com ([170.39.196.115]:48976 "EHLO xweb105.xsoli.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352290AbiBCQkw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 11:40:52 -0500
Received: from [10.72.103.152] (bras-base-blolpq2201w-grc-22-76-68-192-161.dsl.bell.ca [76.68.192.161])
        (Authenticated sender: sylvainf.xsoli)
        by xweb105.xsoli.com (Postfix) with ESMTPSA id 9E669C01C5
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Feb 2022 11:40:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xsoli.com; s=2017;
        t=1643906451; bh=MnT87NDcY1ft6zOf1XoS8HvTYneLOPJ1adCeIZGF45k=;
        h=Date:From:Subject:To:From;
        b=jnuk0UgJVbmx0hbxv4Jwyz2UgaeRBU0uh8m3GjIXd9+K/b5noZIvB5DP1koU3gbnz
         NMPRwUMUm5PnMiUi3SSgm8zjwFVQjWzl9XNeF3Li4Ui3z/GKydhReTJ3JoJlFhpcX9
         1yhlWk1wJyHDqFdqBvHH7+skA6tkeE+I54BMhbLuK/Qb778Tkm3HMHP29MNR9siXJ4
         ii9J7K5Gnrghd0aNn+Xr2PpA3KFCSLU1wA/fAgnOQ6oFk5OImLC25RvkR7/Ep3SyYH
         Dd4Ijkn04uYFw2NRyMku5NEXqrjJmPUkCe2JywwavtYuMJOlTD/hatt4uJkONvR96r
         imWSdgUB2x0Cg==
Message-ID: <abc613d0-b71b-6e16-34ca-f5f8adb4b6ce@xsoli.com>
Date:   Thu, 3 Feb 2022 11:40:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Sylvain Falardeau <sylvainf@xsoli.com>
Subject: ENOSPC during balance with filesystem switching read-only (system
 info)
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again,

I just realized I did not add the system information:

Ubuntu 20.04

uname -a

Linux jbak100 5.13.0-28-generic #31~20.04.1-Ubuntu SMP Wed Jan 19 
14:08:10 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

(It was booted in version 5.4 from Ubuntu when I got the error and I 
tried using linux-image-generic-hwe-20.04 which correspond to 5.13.0-28 
above to see if it fixed the issue).

btrfs --version
btrfs-progs v5.4.1


Label: none  uuid: c56123f0-7b5f-46b2-b53a-60f2657e9bf1
         Total devices 6 FS bytes used 17.70TiB
         devid    2 size 7.28TiB used 7.23TiB path /dev/sdd1
         devid    3 size 7.28TiB used 7.28TiB path /dev/sde1
         devid    4 size 7.28TiB used 7.28TiB path /dev/sdf1
         devid    5 size 7.26TiB used 7.26TiB path /dev/sdb3
         devid    6 size 7.24TiB used 5.62TiB path /dev/sda4
         devid    7 size 14.55TiB used 793.51GiB path /dev/sdc1

btrfs fi df /srv/backups/
Data, RAID10: total=1.04TiB, used=1.04TiB
Data, RAID1: total=16.49TiB, used=16.49TiB
System, RAID1: total=32.00MiB, used=3.59MiB
Metadata, RAID10: total=80.00MiB, used=57.50MiB
Metadata, RAID1: total=195.00GiB, used=182.21GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

The dmesg portion was included in my original message.

One interesting detail is devid 5 with `btrfs fi show` indicate a size 
of 7.26TiB but in `btrfs fi usage` is shows 7.26TiB unallocated. Is it 
normal?

Thank you.

-- 
Sylvain Falardeau
