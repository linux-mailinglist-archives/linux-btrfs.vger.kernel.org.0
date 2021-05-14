Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41028380597
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhENIzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 04:55:31 -0400
Received: from mail.knebb.de ([188.68.42.176]:54698 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhENIzb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 04:55:31 -0400
Received: by mail.knebb.de (Postfix, from userid 121)
        id 7451BE18E6; Fri, 14 May 2021 10:54:19 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=1.7 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p508bf12b.dip0.t-ipconnect.de [80.139.241.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id B88FCE18DA
        for <linux-btrfs@vger.kernel.org>; Fri, 14 May 2021 10:54:18 +0200 (CEST)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Subject: Removal of Device and Free Space
Message-ID: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
Date:   Fri, 14 May 2021 10:54:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

I am running a three device DRBD setup (non-RAID!).
When I do "df -h" I see loads of free space:

root@backuppc:~# df -h
[...]
/dev/mapper/crypt_drbd2          2,8T    1,7T  1,1T   63% /var/lib/backuppc

As written, the fs consists of three devices:

root@backuppc:~# btrfs fi sh /var/lib/backuppc/
Label: 'backuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
         Total devices 3 FS bytes used 1.70TiB
         devid    3 size 799.96GiB used 799.96GiB path dm-5
         devid    4 size 1.07TiB used 1.07TiB path dm-4
         devid    7 size 899.96GiB used 327.00GiB path dm-6

root@backuppc:~# btrfs fi usage /var/lib/backuppc/
Overall:
     Device size:                   2.73TiB
     Device allocated:              2.61TiB
     Device unallocated:          128.00GiB
     Device missing:                  0.00B
     Used:                          1.70TiB
     Free (estimated):              1.03TiB      (min: 1.03TiB)
     Free (statfs, df):             1.03TiB
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:2.60TiB, Used:1.69TiB (65.17%)
    /dev/mapper/crypt_drbd2       790.93GiB
    /dev/mapper/crypt_drbd1         1.07TiB
    /dev/mapper/crypt_drbd3       774.96GiB

Metadata,single: Size:9.00GiB, Used:3.95GiB (43.91%)
    /dev/mapper/crypt_drbd2         6.00GiB
    /dev/mapper/crypt_drbd1         3.00GiB

System,single: Size:32.00MiB, Used:320.00KiB (0.98%)
    /dev/mapper/crypt_drbd2        32.00MiB

Unallocated:
    /dev/mapper/crypt_drbd2         3.00GiB
    /dev/mapper/crypt_drbd1         1.03MiB
    /dev/mapper/crypt_drbd3       125.00GiB

So it tells me there is an estimated of ~1TB free. As the crypt_drbd3 
device has a size of 899G I wanted to remove the device. I expected no 
issue as "Free" shows 1.03TiB. There should still be 200GB of free space 
afterwards.
But the removal failed after two hours:

root@backuppc:~# btrfs dev remove /dev/mapper/crypt_drbd3 /var/lib/backuppc/
ERROR: error removing device '/dev/mapper/crypt_drbd3': No space left on 
device

Now it looks like this:
root@backuppc:~# btrfs fi usage /var/lib/backuppc/
Overall:
     Device size:                   2.73TiB
     Device allocated:              2.17TiB
     Device unallocated:          572.96GiB
     Device missing:                  0.00B
     Used:                          1.70TiB
     Free (estimated):              1.03TiB      (min: 1.03TiB)
     Free (statfs, df):             1.03TiB
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:2.17TiB, Used:1.69TiB (78.24%)
    /dev/mapper/crypt_drbd2       793.93GiB
    /dev/mapper/crypt_drbd1         1.07TiB
    /dev/mapper/crypt_drbd3       327.00GiB

Metadata,single: Size:9.00GiB, Used:3.89GiB (43.23%)
    /dev/mapper/crypt_drbd2         6.00GiB
    /dev/mapper/crypt_drbd1         3.00GiB

System,single: Size:32.00MiB, Used:288.00KiB (0.88%)
    /dev/mapper/crypt_drbd2        32.00MiB

Unallocated:
    /dev/mapper/crypt_drbd2         1.03MiB
    /dev/mapper/crypt_drbd1         1.03MiB
    /dev/mapper/crypt_drbd3       572.96GiB


So some questions arise:

     Why can btrfs device remove not check in advance if there is enough 
free space available? Instead of working for hours and then failing...

     Do I have to balance my fs after the failed removal now?

     Why is it not possible to remove the device when all information 
tell me there is enough free space available?

     What is occupying so much disk space as the data only has 1.7TB 
which should fit in 1.8TB (two) devices? (no snapshot, nothing special 
configured on btrfs). Looks like there are ~400GB allocated which are 
not from data.

Just for completeness:

Debian Buster

root@backuppc:~# btrfs --version
btrfs-progs v5.10.1

Thanks for letting me know.


Greetings

/CV



