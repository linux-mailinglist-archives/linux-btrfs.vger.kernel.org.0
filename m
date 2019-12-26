Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C969112AF67
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Dec 2019 23:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLZWtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Dec 2019 17:49:04 -0500
Received: from naboo.endor.pl ([91.194.229.149]:35807 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfLZWtE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Dec 2019 17:49:04 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id E5FA31A10BA;
        Thu, 26 Dec 2019 23:48:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id crl156SHTZ86; Thu, 26 Dec 2019 23:48:58 +0100 (CET)
Received: from [192.168.1.16] (aaee101.neoplus.adsl.tpnet.pl [83.4.108.101])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id B1BD01A04C9;
        Thu, 26 Dec 2019 23:48:58 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Chris Murphy <lists@colorremedies.com>, linux-btrfs@vger.kernel.org
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <CAJCQCtQR+rFoS7kaLm0eh35x5iYw0UO9Ybi3gxANTxJLU-YEFg@mail.gmail.com>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <cd8f4789-62c1-8e4a-c67e-f6dd5ae4cfc3@dubiel.pl>
Date:   Thu, 26 Dec 2019 23:48:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQR+rFoS7kaLm0eh35x5iYw0UO9Ybi3gxANTxJLU-YEFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



W dniu 26.12.2019 o 23:15, Chris Murphy pisze:
 >
 > What is the SCT ERC for each drive?

Failing drive is /dev/sda.

    root@wawel:~# smartctl -l scterc /dev/sda
    smartctl 6.6 2017-11-05 r4594 [x86_64-linux-4.19.0-6-amd64] (local
    build)
    Copyright (C) 2002-17, Bruce Allen, Christian Franke,
    www.smartmontools.org

    SCT Error Recovery Control command not supported

    root@wawel:~# smartctl -l scterc /dev/sdb
    SCT Error Recovery Control:
                Read:     70 (7.0 seconds)
               Write:     70 (7.0 seconds)

    root@wawel:~# smartctl -l scterc /dev/sdc
    SCT Error Recovery Control:
                Read:    100 (10.0 seconds)
               Write:    100 (10.0 seconds)


I have changed timeout to higher:


        echo 180 >  /sys/block/sda/device/timeout



 > And when was the last time a scrub was done on the volume?

It was done few months ago unfortunatelly...




 > Were there
 > any errors reported by either user space tools or kernel? And what
 > were they?

There were NO errors from any user space tools.
Only smartctl reported uncorrectable sectors and failed smart self-tests.




Thank you for suggestions below. Data is not critical (this is backup 
server...).
I will see tommorow how is the progress.
Actually there are no errors but this is slow only...


 > My suggestion for single profile multiple device is to leave the per
 > drive SCT ERC disabled (or a high value, e.g. 1200 deciseconds) and
 > also change the per block device command timer (this is a kernel timer
 > set per device) to be at least 120 seconds.
 > This will allow the drive
 > to do deep recovery, which will make it dog slow, but if necessary
 > it'll improve the chances of getting data off the drives. If you don't
 > care about getting data off the drives, i.e. you have a backup, then
 > you can set the SCT ERC value to 70 deciseconds. Any bad sector errors
 > will quickly result in a read error, Btrfs will report the affected
 > file. IF it's metadata that's affected, it'll get a good copy from the
 > mirror, and fix up the bad copy, automatically.
 >
 >
 >


