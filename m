Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0D204C0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jun 2020 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgFWIRF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jun 2020 04:17:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731158AbgFWIRE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jun 2020 04:17:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1D3D4ADC1;
        Tue, 23 Jun 2020 08:17:01 +0000 (UTC)
Subject: Re: btrfs dev sta not updating
To:     Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
References: <4857863.FCrPRfMyHP@liv>
 <08121825-9c05-87c4-4015-f6f508193fa8@suse.com> <5752066.y3qnG1rHMR@liv>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d4c28f49-f6fc-0fc7-0c4d-4fe8b3ce32a9@suse.com>
Date:   Tue, 23 Jun 2020 11:17:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5752066.y3qnG1rHMR@liv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 23.06.20 г. 11:00 ч., Russell Coker wrote:
> On Tuesday, 23 June 2020 4:03:37 PM AEST Nikolay Borisov wrote:
>>> I have a USB stick that's corrupted, I get the above kernel messages when
>>> I
>>> try to copy files from it.  But according to btrfs dev sta it has had 0
>>> read and 0 corruption errors.
>>>
>>> root@xev:/mnt/tmp# btrfs dev sta .
>>> [/dev/sdc1].write_io_errs    0
>>> [/dev/sdc1].read_io_errs     0
>>> [/dev/sdc1].flush_io_errs    0
>>> [/dev/sdc1].corruption_errs  0
>>> [/dev/sdc1].generation_errs  0
>>> root@xev:/mnt/tmp# uname -a
>>> Linux xev 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64
>>> GNU/Linux
>> The read/write io err counters are updated when even repair bio have
>> failed. So in your case you had some checksum errors, but btrfs managed
>> to repair them by reading from a different mirror. In this case those
>> aren't really counted as io errs since in the end you did get the
>> correct data.
> 
> In this case I'm getting application IO errors and lost data, so if the error 
> count is designed to not count recovered errors then it's still not doing the 
> right thing.

In this case yes, however this was utterly not clear from your initial
email. In fact it seems you have omitted quite a lot of information. So
let's step back and start afresh. So first give information about your
current btrfs setup by giving the output of:

btrfs fi usage /path/to/btrfs

From the output provided it seems the affected mirror is '1', which to
me implies you have at least another disk containing the same data. So
unless you have errors in mirror 0 as well those errors should be
recovered from by simply reading from that mirror.

> 
> # md5sum *
> md5sum: 'Rise of the Machines S1 Ep6 - Mega Digger-qcOpMtIWsrgN.mp4': Input/
> output error
> md5sum: 'Rise of the Machines S1 Ep7 - Ultimate Dragster-Ke9hMplfQAWF.mp4': 
> Input/output error
> md5sum: 'Rise of the Machines S1 Ep8 - Aircraft Carrier-Qxht6qMEwMKr.mp4': 
> Input/output error
> ^C

You are trying to md5sum 3 distinct files....

> # btrfs dev sta .
> [/dev/sdc1].write_io_errs    0
> [/dev/sdc1].read_io_errs     0
> [/dev/sdc1].flush_io_errs    0
> [/dev/sdc1].corruption_errs  0
> [/dev/sdc1].generation_errs  0
> # tail /var/log/kern.log
> Jun 23 17:48:40 xev kernel: [417603.547748] BTRFS warning (device sdc1): csum 
> failed root 5 ino 275 off 59580416 csum 0x8941f998 expected csum 0xb5b581fc 
> mirror 1
> Jun 23 17:48:40 xev kernel: [417603.609861] BTRFS warning (device sdc1): csum 
> failed root 5 ino 275 off 60628992 csum 0x8941f998 expected csum 0x4b6c9883 
> mirror 1
> Jun 23 17:48:40 xev kernel: [417603.672251] BTRFS warning (device sdc1): csum 
> failed root 5 ino 275 off 61677568 csum 0x8941f998 expected csum 0x89f5fb68 
> mirror 1

Yet here all the errors happen in one inode, namely 275. So the md5sum
commands do not correspond to those errors specifically. Also provide
the name of inode 275. And for good measure also provide the output of
"btrfs check /dev/sdc1" - this is a read only command so if there is
some metadata corruption it will at least not make it any worse.


> # uname -a
> Linux xev 5.6.0-2-amd64 #1 SMP Debian 5.6.14-1 (2020-05-23) x86_64 GNU/Linux
> 
> On Tuesday, 23 June 2020 4:17:55 PM AEST waxhead wrote:
>> I don't think this is what most people expect.
>> A simple way to solve this could be to put the non-fatal errors in
>> parentheses if this can be done easily.
> 
> I think that most people would expect a "device stats" command to just give 
> stats of the device and not refer to what happens at the higher level.  If a 
> device is giving corruption or read errors then "device stats" should tell 
> that.

That's a fair point.

> 
> On Tuesday, 23 June 2020 5:11:05 PM AEST Nikolay Borisov wrote:
>> read_io_errs. But this leads to a different can of worms - if a user
>> sees read_io_errs should they be worried because potentially some data
>> is stale or not (give we won't be distinguishing between unrepairable vs
>> transient ones).
> 
> If a user sees errors reported their degree of worry should be based on the 
> degree to which they use RAID and have decent backups.  If you have RAID-1 and 
> only 1 device has errors then you are OK.  If you have 2 devices with errors 
> then you have a problem.
> 
> Below is an example of a zpool having errors that were corrected.  The DEVICE 
> had an unrecoverable error, but the RAID-Z pool recovered it from other 
> devices.  It states that "Applications are unaffected" so the user knows the 
> degree of worry that should be involved.

BTRFS' internal structure is very different from ZFS' so we don't have
this notion of vdev, consisting of multiple child devices. And so each
physical + vdev can be considered a separate device. So again, without
extending the on-disk format i.e introducing new items or changing the
format of existing ones we can't accommodate the exact same reports. And
while the on-disk format can be changed (which of course comes with
added complexity) there should be a very good reason to do so. Clearly
something is amiss in your case, but I would like to first properly root
cause it before jumping to conclusions.

> 
> # zpool status
>   pool: pet630
>  state: ONLINE
> status: One or more devices has experienced an unrecoverable error.  An
>         attempt was made to correct the error.  Applications are unaffected.
> action: Determine if the device needs to be replaced, and clear the errors
>         using 'zpool clear' or replace the device with 'zpool replace'.
>    see: http://zfsonlinux.org/msg/ZFS-8000-9P
>   scan: scrub repaired 380K in 156h39m with 0 errors on Sat Jun 20 13:03:26 
> 2020
> config:
> 
>         NAME           STATE     READ WRITE CKSUM
>         pet630         ONLINE       0     0     0
>           raidz1-0     ONLINE       0     0     0
>             sdf        ONLINE       0     0     0
>             sdq        ONLINE       0     0     0
>             sdd        ONLINE       0     0     0
>             sdh        ONLINE       0     0     0
>             sdi        ONLINE      41     0     1
> 
> 
