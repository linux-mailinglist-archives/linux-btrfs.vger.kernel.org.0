Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E021382078
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 May 2021 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEPSnP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 May 2021 14:43:15 -0400
Received: from mail.knebb.de ([188.68.42.176]:53254 "EHLO mail.knebb.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhEPSnP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 May 2021 14:43:15 -0400
Received: by mail.knebb.de (Postfix, from userid 121)
        id BB961E18E8; Sun, 16 May 2021 20:41:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on netcup.knebb.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=1.7 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=unavailable autolearn_force=no version=3.4.2
Received: from [192.168.9.194] (p508bf12b.dip0.t-ipconnect.de [80.139.241.43])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cvoelker)
        by mail.knebb.de (Postfix) with ESMTPSA id 95F02E18DA;
        Sun, 16 May 2021 20:41:56 +0200 (CEST)
Subject: Re: Removal of Device and Free Space
To:     Roman Mamedov <rm@romanrm.net>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <850c35a8-0322-c60e-b179-b07eb0e1de8c@knebb.de>
 <20210515013903.GE32440@hungrycats.org> <20210515124803.41f88f70@natsu>
From:   =?UTF-8?Q?Christian_V=c3=b6lker?= <cvoelker@knebb.de>
Message-ID: <27e96a85-be12-c830-c916-b8fbcac8a535@knebb.de>
Date:   Sun, 16 May 2021 20:41:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515124803.41f88f70@natsu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

thanks for your suggestions. Even though I do not understand every 
implication.

However, your suggestions in total allowed me to remove the device.

root@backuppc42:/var/lib/backuppc# btrfs fi sh /var/lib/backuppc/
Label: 'backuppc'  uuid: 73b98c7b-832a-437a-a15b-6cb00734e5db
         Total devices 3 FS bytes used 1.68TiB
         devid    3 size 799.96GiB used 798.96GiB path dm-5
         devid    4 size 1.07TiB used 1.07TiB path dm-4
         devid    7 size 899.96GiB used 327.00GiB path dm-6


root@backuppc42:/var/lib/backuppc# btrfs balance start -ddevid=3 
/var/lib/backuppc/;btrfs balance start -ddevid=4 /var/lib/backuppc/


Done, had to relocate 793 out of 2224 chunks
Done, had to relocate 1094 out of 1726 chunks

root@backuppc42:/var/lib/backuppc# btrfs fi df /var/lib/backuppc/
Data, single: total=1.68TiB, used=1.67TiB
System, single: total=32.00MiB, used=208.00KiB
Metadata, single: total=9.00GiB, used=3.49GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

root@backuppc42:/var/lib/backuppc# btrfs fi us /var/lib/backuppc/
Overall:
     Device size:                   2.73TiB
     Device allocated:              1.68TiB
     Device unallocated:            1.05TiB
     Device missing:                  0.00B
     Used:                          1.68TiB
     Free (estimated):              1.05TiB      (min: 1.05TiB)
     Free (statfs, df):             1.05TiB
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:1.68TiB, Used:1.67TiB (99.96%)
    /dev/mapper/crypt_drbd2       436.00GiB
    /dev/mapper/crypt_drbd1       737.00GiB
    /dev/mapper/crypt_drbd3       543.00GiB

Metadata,single: Size:9.00GiB, Used:3.49GiB (38.79%)
    /dev/mapper/crypt_drbd2         6.00GiB
    /dev/mapper/crypt_drbd1         3.00GiB

System,single: Size:32.00MiB, Used:208.00KiB (0.63%)
    /dev/mapper/crypt_drbd2        32.00MiB

Unallocated:
    /dev/mapper/crypt_drbd2       357.93GiB
    /dev/mapper/crypt_drbd1       359.95GiB
    /dev/mapper/crypt_drbd3       356.96GiB

root@backuppc42:/var/lib/backuppc# btrfs dev remove 
/dev/mapper/crypt_drbd3 /var/lib/backuppc/

root@backuppc42:/var/lib/backuppc# btrfs fi us /var/lib/backuppc/
Overall:
     Device size:                   1.85TiB
     Device allocated:              1.68TiB
     Device unallocated:          174.88GiB
     Device missing:                  0.00B
     Used:                          1.68TiB
     Free (estimated):            175.62GiB      (min: 175.62GiB)
     Free (statfs, df):           175.62GiB
     Data ratio:                       1.00
     Metadata ratio:                   1.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,single: Size:1.68TiB, Used:1.67TiB (99.96%)
    /dev/mapper/crypt_drbd2       706.00GiB
    /dev/mapper/crypt_drbd1      1010.00GiB

Metadata,single: Size:9.00GiB, Used:3.48GiB (38.62%)
    /dev/mapper/crypt_drbd2         6.00GiB
    /dev/mapper/crypt_drbd1         3.00GiB

System,single: Size:32.00MiB, Used:224.00KiB (0.68%)
    /dev/mapper/crypt_drbd2        32.00MiB

Unallocated:
    /dev/mapper/crypt_drbd2        87.93GiB
    /dev/mapper/crypt_drbd1        86.95GiB

root@backuppc42:/var/lib/backuppc# btrfs fi df /var/lib/backuppc/
Data, single: total=1.68TiB, used=1.67TiB
System, single: total=32.00MiB, used=224.00KiB
Metadata, single: total=9.00GiB, used=3.48GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


I am still unsure why this did not work initially- I expect a fs doing 
everything (ie reallocate, balance, whatever) to get the job (remove a 
device) done.


However, device is removed now.

Thanks @all!

Greetings

/CV
