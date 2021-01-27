Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0557305CBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbhA0NOz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 08:14:55 -0500
Received: from smtp102.iad3b.emailsrvr.com ([146.20.161.102]:58520 "EHLO
        smtp102.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343780AbhA0NMb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 08:12:31 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 08:12:30 EST
X-Auth-ID: a.isaev@rqc.ru
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: a.isaev-AT-rqc.ru) with ESMTPSA id 6F4606017D;
        Wed, 27 Jan 2021 08:05:15 -0500 (EST)
Subject: Re: btrfs becomes read-only
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cf9189c0-614c-26e8-9d3e-8e18555c064f@rqc.ru>
 <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
From:   Alexey Isaev <a.isaev@rqc.ru>
Message-ID: <688790d4-4412-4570-8490-4f8f70e3b5a1@rqc.ru>
Date:   Wed, 27 Jan 2021 16:05:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQFniOd53+3FFoOo4UM8CzY_vranrrHiWH86HugNvaOpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: ru
X-Classification-ID: 1b5eb2d3-0eef-4fc8-80fc-e42d748a1fbe-1-1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I managed to run btrs check, but it didn't solve the problem:

aleksey@host:~$ sudo btrfs check --repair /dev/sdg
[sudo] password for aleksey:
enabling repair mode
Checking filesystem on /dev/sdg
UUID: 070ce9af-6511-4b89-a501-0823514320c1
checking extents
parent transid verify failed on 52180048330752 wanted 132477 found 132432
parent transid verify failed on 52180048330752 wanted 132477 found 132432
parent transid verify failed on 52180048330752 wanted 132477 found 132432
parent transid verify failed on 52180048330752 wanted 132477 found 132432
Ignoring transid failure
leaf parent key incorrect 52180048330752
bad block 52180048330752
Errors found in extent allocation tree or chunk allocation
parent transid verify failed on 52180048330752 wanted 132477 found 132432
Ignoring transid failure
Fixed 0 roots.
checking free space cache
parent transid verify failed on 52180048330752 wanted 132477 found 132432
Ignoring transid failure
There is no free space entry for 5100308647936-5101376765952
cache appears valid but isnt 5100303024128
block group 5143252697088 has wrong amount of free space
failed to load free space cache for block group 5143252697088
block group 10289697259520 has wrong amount of free space
failed to load free space cache for block group 10289697259520
block group 10447537307648 has wrong amount of free space
failed to load free space cache for block group 10447537307648
block group 10856632942592 has wrong amount of free space
failed to load free space cache for block group 10856632942592
block group 10877034037248 has wrong amount of free space
failed to load free space cache for block group 10877034037248
block group 10901730099200 has wrong amount of free space
failed to load free space cache for block group 10901730099200
block group 37427448119296 has wrong amount of free space
failed to load free space cache for block group 37427448119296
block group 40151531126784 has wrong amount of free space
failed to load free space cache for block group 40151531126784
block group 40155826094080 has wrong amount of free space
failed to load free space cache for block group 40155826094080
block group 45729619902464 has wrong amount of free space
failed to load free space cache for block group 45729619902464
block group 45751094738944 has wrong amount of free space
failed to load free space cache for block group 45751094738944
block group 45775790800896 has wrong amount of free space
failed to load free space cache for block group 45775790800896
block group 45797265637376 has wrong amount of free space
failed to load free space cache for block group 45797265637376
block group 45839141568512 has wrong amount of free space
failed to load free space cache for block group 45839141568512
found 31266648615205 bytes used err is -22
total csum bytes: 0
total tree bytes: 2949169152
total fs tree bytes: 0
total extent tree bytes: 2927755264
btree space waste bytes: 813795673
file data blocks allocated: 9188147200
  referenced 9188147200

С уважением,
Алексей Исаев,
RQC

27.01.2021 10:38, Chris Murphy пишет:
> On Wed, Jan 27, 2021 at 12:22 AM Alexey Isaev <a.isaev@rqc.ru> wrote:
>> Hello!
>>
>> BTRFS volume becomes read-only with this messages in dmesg.
>> What can i do to repair btrfs partition?
>>
>> [Jan25 08:18] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.007587] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.000132] BTRFS error (device sdg): qgroup scan failed with -5
>>
>> [Jan25 19:52] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.009783] BTRFS error (device sdg): parent transid verify failed on
>> 52180048330752 wanted 132477 found 132432
>> [  +0.000132] BTRFS: error (device sdg) in __btrfs_cow_block:1176:
>> errno=-5 IO failure
>> [  +0.000060] BTRFS info (device sdg): forced readonly
>> [  +0.000004] BTRFS info (device sdg): failed to delete reference to
>> ftrace.h, inode 2986197 parent 2989315
>> [  +0.000002] BTRFS: error (device sdg) in __btrfs_unlink_inode:4220:
>> errno=-5 IO failure
>> [  +0.006071] BTRFS error (device sdg): pending csums is 430080
> What kernel version? What drive make/model?
>
> wanted 132477 found 132432 indicates the drive has lost ~45
> transactions, that's not good and also weird. There's no crash or any
> other errors? A complete dmesg might be more revealing. And also
>
> smartctl -x /dev/sdg
> btrfs check --readonly /dev/sdg
>
> After that I suggest
> https://btrfs.wiki.kernel.org/index.php/Restore
>
> And try to get any important data out if it's not backed up. You can
> try btrfs-find-root to get a listing of roots, most recent to oldest.
> Start at the top, and plug that address in as 'btrfs restore -t' and
> see if it'll pull anything out. You likely need -i and -v options as
> well.
>
