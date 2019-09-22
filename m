Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C641FBA2F5
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Sep 2019 17:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbfIVPJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Sep 2019 11:09:57 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.227]:51754 "EHLO
        cdptpa-cmomta01.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728211AbfIVPJ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Sep 2019 11:09:57 -0400
Received: from static.bllue.org ([66.65.51.108])
        by cmsmtp with ESMTP
        id C3UmiJiYHwchrC3UpiTyRY; Sun, 22 Sep 2019 15:09:55 +0000
Received: from bllue.org (localhost.localdomain [127.0.0.1])
        by static.bllue.org (Postfix) with ESMTP id 64B5AC4839;
        Sun, 22 Sep 2019 11:09:51 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 22 Sep 2019 11:09:51 -0400
From:   Kenneth Topp <toppk@bllue.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs filesystem not mountable after unclear shutdown
In-Reply-To: <aa88fe5f-51f9-cfca-6193-cc2cf0d3ead5@gmx.com>
References: <e9073c1dc608dc8d50ee8d131bc86887@bllue.org>
 <aa88fe5f-51f9-cfca-6193-cc2cf0d3ead5@gmx.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <cae0f117bd93af5df07f5f1604eab32b@bllue.org>
X-Sender: toppk@bllue.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on static.bllue.org
X-CMAE-Envelope: MS4wfCcS7Xqqtnx/sNKX8RrGcOzN0Uz8ibsjzJfppttBOya8+xmaC7A0G/nWthpVZpxLDStSsO2xraMiPd93q0xMlGVjTmXJm00L9JJ9DpT2gBdRmp0Eo2r8
 92RZF76fBSMZYsH+rJZffqh8HIDFFhohx5TFU9xIqBq8OZUNxwwAQK0TtDtT/DMPM/WiXcIHqTy7RaIBbcp1nBUrYJ2OYFxopBJ+hKwcTu/AKghvH4MSE2Mc
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-22 06:02, Qu Wenruo wrote:
> On 2019/9/22 上午9:12, Kenneth Topp wrote:
>> after a couple unclean reboots, this filesystem became un-mountable. 
>> btrfs check didn't help either.  This should be a raid 1 metadata/raid 
>> 0
>> data volume.  I've had this filesystem for several years, but I think 
>> it
>> was after any major on disk options.
>> 
>> I tend to run a current kernel.   I got to 5.2.15 quickly after the
>> btrfs bug report, and just was switching to 5.2.17 when things died.  
>> I
>> still have these disks as they are, but will wipe them out tomorrow 
>> and
>> restore from backups unless someone has any further diagnostics they'd
>> like me to run.
>> 
>> On a related subject, are there any tips for creating a new 
>> filesystem,
>> I think I used to specify "-l 16K -n 16K" during mkfs.  I'll be
>> switching to 4kn soon, and but currently using 512e, any notes 
>> regarding
>> using 4kn disks?
>> 
>> 
>> here are some diagnostics:
>> 
>> [toppk@static ~]$ cat btrfs-failure.txt
>> # btrfs filesystem show /dev/mapper/cprt-47
>> Label: 'tm'  uuid: 2f8c681b-1973-4fe6-a6b6-0be182944528
>>         Total devices 2 FS bytes used 17.16TiB
>>         devid    1 size 9.09TiB used 8.65TiB path /dev/mapper/cprt-46
>>         devid    2 size 9.09TiB used 8.65TiB path /dev/mapper/cprt-47
>> # btrfs check /dev/mapper/cprt-46
>> Opening filesystem to check...
>> parent transid verify failed on 6751397658624 wanted 2012643 found 
>> 2012295
>> parent transid verify failed on 6751397658624 wanted 2012643 found 
>> 2012295
>> parent transid verify failed on 6751397658624 wanted 2012643 found 
>> 2012295
> 
> Well, this transid mismatch looks exactly the bug introduced in 
> v5.2-rc.
> 
> Kernel mount dmesg please, it would help us to determine which tree is
> causing the problem.


here it is.

[ 2470.719919] BTRFS info (device dm-9): disabling log replay at mount 
time
[ 2470.719921] BTRFS info (device dm-9): disk space caching is enabled
[ 2470.719923] BTRFS info (device dm-9): has skinny extents
[ 2482.112442] BTRFS error (device dm-9): parent transid verify failed 
on 6751397658624 wanted 2012643 found 2012295
[ 2482.124103] BTRFS error (device dm-9): parent transid verify failed 
on 6751397658624 wanted 2012643 found 2012295
[ 2482.124112] BTRFS error (device dm-9): failed to read block groups: 
-5
[ 2482.163205] BTRFS error (device dm-9): open_ctree failed


> 
> But please keep in mind, we can only salvage data from the fs, not
> really fix it to RW mountable status.

I have good backups when the filesystem was mounted.  If it is that bug, 
should I expect my backups to contain corrupt data?

Thanks,

Ken


> 
> Thanks,
> Qu
> 
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=7267733438464 item=33 parent
>> level=2 child level=0
>> [root@static ~]# btrfs check -b /dev/mapper/cprt-46
>> Opening filesystem to check...
>> parent transid verify failed on 6751304908800 wanted 2012643 found 
>> 2012294
>> parent transid verify failed on 6751305105408 wanted 2012643 found 
>> 2012295
>> parent transid verify failed on 6751381258240 wanted 2012643 found 
>> 2012295
>> parent transid verify failed on 6751397658624 wanted 2012643 found 
>> 2012295
>> parent transid verify failed on 6751397658624 wanted 2012643 found 
>> 2012295
>> parent transid verify failed on 6751397658624 wanted 2012643 found 
>> 2012295
>> Ignoring transid failure
>> ERROR: child eb corrupted: parent bytenr=6751265570816 item=33 parent
>> level=2 child level=0
>> ERROR: cannot open file system
>> [root@static ~]#   uname -a
>> Linux static.bllue.org 5.2.17-200.fc30.x86_64 #1 SMP Sat Sep 21 
>> 16:13:27
>> EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
>> [root@static ~]#   btrfs --version
>> btrfs-progs v5.2.1
>> 
>> 
>> Thanks,
>> 
>> Ken
