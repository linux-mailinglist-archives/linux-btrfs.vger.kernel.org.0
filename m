Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127C112BE1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 18:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL1RML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 12:12:11 -0500
Received: from naboo.endor.pl ([91.194.229.149]:54164 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfL1RML (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 12:12:11 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Dec 2019 12:12:09 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 304931A0E83;
        Sat, 28 Dec 2019 18:04:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I_DwZZdQKeiv; Sat, 28 Dec 2019 18:04:27 +0100 (CET)
Received: from [192.168.1.16] (aahg142.neoplus.adsl.tpnet.pl [83.4.188.142])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id C29471A0E8F;
        Sat, 28 Dec 2019 18:04:25 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
From:   Leszek Dubiel <leszek@dubiel.pl>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Remi Gauvin <remi@georgianit.com>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
Message-ID: <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
Date:   Sat, 28 Dec 2019 18:04:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


PROBLEM SOLVED --- btrfs was busy cleaing after snaphot deletion few 
days ago, so it dodn't have time to "dev delete", that's why it was slow

=======================


I restarted server, so job "btrfs delete" was not existent any more.
But disks were still working (!!!). I wondered why? What is BTRFS doing 
all the time?

I realized that afew days before starting "btrfs dev delete" I have 
removed many snapshots -- there were about 400 snapshots and I left 20 
only. I did that because I have read that many snapshot could slowdown 
btrfs operations severely.



I made an experiment on another testing serwer:

1. started command "watch -n1 'btrfs fi df /"
2. started "iostat -x -m"

Disks were not working at all.


3. Then I removed many shapshots on that testing server

and I was watching:

Data, single: total=6.56TiB, used=5.13TiB
System, RAID1: total=32.00MiB, used=992.00KiB
Metadata, RAID1: total=92.00GiB, used=70.56GiB
GlobalReserve, single: total=512.00MiB, used=1.39MiB

Disks started to work hard. So btrfs was probably cleaining after 
snapshot deletion.

At the beginning in "Metadata" line there was "used=70.00GiB".

            Metadata, RAID1: total=92.00GiB, used=70.00GiB

It was changing all the time... getting lower and lower. During that 
process in line

            GlobalReserve, single: total=512.00MiB, used=1.39MiB

"used=" was going up until it reached about 100MiB, then it was flushed 
to zero, and started again to fill, flush, fill, flush... some 
loop/buffer/cache (?).
It convinced me, that after snapshot deletion btrfs is really working 
hard on cleanup.
After some time "Metadata...used=" stopped changing, disks stopped 
working, server got lazy again.



I got back to main server. Started to watch "Metadata...used=". It was 
going down and down...
I waited. When "Metadata...used=" stopped changing, then "iostat -m" 
stopped showing any disk activity.

I started "btrfs dev delete" again and now speed is 50Mb/sek. Hurrray! 
Problem solved.


Sorry for not beeing clever enough to connect all this facts at the 
beginning.
Anyway -- maybe in the future someone has the same problem, then btrfs 
experts could ask him if he let btrfs do some other hard work in the 
same time (eg cleaning up after massive snapsot deletion).

Maybe it would be usful to have a tool to ask btrfs "what are you doing? 
are you busy?".
It would respond "I am cleaing up after snapshot deletion... I am 
balancing... I am scrubbing... I am resizing... I am deleting ...".




