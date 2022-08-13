Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972B3591840
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 03:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiHMBub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 21:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbiHMBua (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 21:50:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D78FFA
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 18:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660355413;
        bh=BTUThIwNSCkrLLSywWNRdlH4IWdtElk43ElXv+jgV5A=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=ZghP31Z/TtWu9EJGROpvsM24gg2fre0g/+H7jVkpFCis5VbCg2HUDROCDHXw/+MGR
         w9bAFy6cPjrd07gl1Vw3APd8SC4lwuLXzcE06l0Q/GXO0Vzr/7c98iLoBhBNUlFWPa
         UqhA5udWfU1qisJfVB5Ev0gCRS9BRwTRGdPr/d4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1nnLTJ2Ww5-00ZfJw; Sat, 13
 Aug 2022 03:50:13 +0200
Message-ID: <9dfb0b60-9178-7bbe-6ba1-10d056a7e84c@gmx.com>
Date:   Sat, 13 Aug 2022 09:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <YvHVJ8t5vzxH9fS9@hungrycats.org> <YvIbB5l4gtG4f/S9@infradead.org>
 <YvK0WPtEVzXwv3p1@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
In-Reply-To: <YvK0WPtEVzXwv3p1@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NazXHP9uH4x4Bw7oK1xhkRirpIWGcUwg0Nsjs6EARrvJiJ2SngW
 v1CW2RhUUpxLb3pRpVgKtDXMIvBysQ2TjMjZyJnKwgi/Nq04KPUzyh5izwuWPKJldwCmReP
 MDx7DKSCmDCXQTxwLH5P9ks5TDIPQRB7AkAwAbZ3/J/YHkOTGc4OgBH/XZEc8gcFVzRHtWT
 pXar7L1mOhvidJKdR3Y5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:du7Eyv23Nvw=:khJH3wv0Zx/O/jXvWilF9S
 4+dY7z9wrEGKdtoEmi4jD+kGDueVB7GWE+EKyWF4ABEMP2VQWn6SaBpe4XWCBDZuzSlDzFxmB
 hfj3CMB3zkOk5yUn3cPOahuiTvsxHtWTBF1E9S61vbiEi9FFCscjtPpsxuD/SqiKIDMMoTZcM
 4uqHB8iNlTMQZ+JuMRtEWOWkXDoFAC0UX5LN6UxmpQXKX/ZjKZa3DR1a39qtOT7uxmXOnw7zk
 PinnBYPb0pyet/4jplrCTN30le4R8xHpox0vW/BMo8h+sbFDdvafrr53AXw139W4xqLva5gMt
 xfSiG1+QsmG0IsR39tvLp9a7CUJdjv4I9ez/HORTSI4eha7XAKqAyNoyyqskLAT0mO7DPdFj2
 hrhugxNIaDdMehWcKcIQRxWCNtCRKGWa81nZL1jJ/o9RG1JDNEM9H9VHvaLdcj8NTrg74SYtt
 BKM5US43OTuDOz+5t4dFDkVSmqFuPegITa9XwfMS1ns4z1Q7XILOfQv5d+B5vSz4Y46t1sYL2
 1H5hUyIK5djWljqhaLSQ9OBAZWRiOp3jP1amcwEtFJkqWJ3i8lJH1fMmbKDdoQHlA5qfFg6e3
 Awdj+fBlt2jCV6p3D+at0OPlzLCoAc8cwf5+MqG/srRUuBkvgMB/PQUdN6VVlQk1GUEOktRhE
 6pDUkx3svJwruXdbqYnKnYYK0d9+aPNEZfgH21NeVWGvaLRX9YZojnkyElQDcV/80bqBrj6gV
 JuZniyILgHXl/tfVV2pShR1L18MIb/ZGzOQ8A3bULzyLXI8RAenK1HK/VI0HkxMjZ+ElDWVUh
 YpLIqm5lfEat0aRKp/LzFaGzjZiU2miqcgiEBWzq5tdOQeRW4bNFzV0ko/U9UeuSgFuwpzEZi
 XMKXNja6H/4jUPGSTeRfNqR7mrqJyY+N7HHIkVrn0i7tV8me8JddZbRLgC+2pEGErADeDhuUq
 3mOr9tiBnrxIs9r01RDRFcoa6HjX9/ihRfewxPs5SesAuQl96SWysj2zpKPutsUG37txKfG44
 O/vkSmPOtH+xmZpBB79iq81/4+AMXSmBU2t4aTf9nEeYuTvMdZw0AeAHHKmufVv4YEcX8i5ef
 Z4wM7CaJdNsvolGKtu1VOCQ1ec9aJyp3OezG8bYtBJHw7zltwl5q70Irg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 03:24, Zygo Blaxell wrote:
> On Tue, Aug 09, 2022 at 01:29:59AM -0700, Christoph Hellwig wrote:
>> On Mon, Aug 08, 2022 at 11:31:51PM -0400, Zygo Blaxell wrote:
>>> There is now a BUG_ON arising from this test case:
>>>
>>> 	[  241.051326][   T45] btrfs_print_data_csum_error: 156 callbacks sup=
pressed
>>> 	[  241.100910][   T45] ------------[ cut here ]------------
>>> 	[  241.102531][   T45] kernel BUG at fs/btrfs/extent_io.c:2350!
>>
>> This
>>
>>          BUG_ON(!mirror_num);
>>
>> so repair_io_failure gets called with a mirror_num of 0..
>>
>>> 	[  241.128354][   T45]  clean_io_failure+0x21a/0x260
>>
>> .. from clean_io_failure.  Which starts from failrec->this_mirror and
>> tries to go back to failrec->failed_mirror using the prev_mirror
>> helper.  prev_mirror looks like:
>>
>> static int prev_mirror(const struct io_failure_record *failrec, int cur=
_mirror)
>> {
>>          if (cur_mirror =3D=3D 1)
>> 		return failrec->num_copies;
>> 	return cur_mirror - 1;
>> }
>>
>> So the only way we could end up with a mirror =3D 0 is if
>> failrec->num_copies is 0.  -failrec->num_copies is initialized
>> in btrfs_get_io_failure_record by doing:
>>
>>          failrec->num_copies =3D btrfs_num_copies(fs_info, failrec->log=
ical, sectorsize);
>>
>> just adter allocating the failrec.  I can't see any obvious way how
>> btrfs_num_copies would return 0, though, as for raid5 it just copies
>> from btrfs_raid_array.
>
> Judging from prior raid5 testing behavior, it looks like there's a race
> condition specific to btrfs raid5 IO.  Previous kernel versions have had
> assorted UAF bugs from time to time that KASAN tripped over, and btrfs
> replace almost never works on the first try on a real raid5 array.
> These issues were reported years ago, but nobody seems to have been
> working on them until recently.
>
> A similar test setup previously produced data corruption during raid5
> recovery, even on an otherwise idle filesystem, at a low rate (~1
> error per 100 GB).  I expect whatever bug was leading to that hasn't
> been entirely fixed yet.
>
>> Any chance you could share a script for your reproducer?
>
> The simplest reproducer is some variant of:
>
> 	mkfs.btrfs -draid5 -mraid1 /dev/vdb /dev/vdc /dev/vdd
> 	mount /dev/vdb /mnt -ocompress=3Dzstd,noatime
> 	cd /mnt
> 	cp -a /40gb-test-data .
> 	sync
> 	while true; do
> 		find -type f -exec cat {} + > /dev/null
> 	done &
> 	while true; do
> 		cat /dev/zero > /dev/vdb
> 	done &
> 	while true; do
> 		btrfs scrub start -Bd /mnt
> 	done &
> 	wait
>
> but it can take a long time to hit a failure with something that gentle.
> I throw on some extra test workload (e.g. lots of rsyncs) to keep the
> page cache full and under memory pressure, which seems to speed up the
> failure rate to once every few hours.

I got it reproduced, although it's a different crash it has the minimal
workload so far, and it doesn't even need the race of corrupting the
disk on-the-fly:

         mkfs.btrfs -f -d raid5 -m raid5 $dev1 $dev2 $dev3 -b 1G > /dev/nu=
ll
         mount $dev1 $mnt
         $fsstress -w -d $mnt -n 100 -s 1660337237
         sync
         $fssum -A -f -w /tmp/fssum.saved $mnt
         umount $mnt

         xfs_io -c "pwrite -S 0x0 1m 1023m" $dev1
         mount $dev1 $mnt
         $fssum -r /tmp/fssum.saved $mnt > /dev/null # <<< CRASH here
         umount $mnt

The point here is, before another BUG_ON() triggered, we can got the
following "unable to find logical" triggered:

[  173.089275] BTRFS critical (device dm-1): unable to find logical
18446744073709551613 length 4096
[  173.089825] BTRFS critical (device dm-1): unable to find logical 4093
length 4096
[  173.090224] BTRFS critical (device dm-1): unable to find logical
18446744073709551613 length 4096
[  173.090657] BTRFS critical (device dm-1): unable to find logical 4093
length 4096
[  173.091451] assertion failed: failrec->this_mirror =3D=3D
bbio->mirror_num, in fs/btrfs/extent_io.c:2566

I have even pinned down the offending commit: "btrfs: pass a btrfs_bio
to btrfs_repair_one_sector". (not RAID56 though)

The "unable to find logical" is caused by the fact that, we're repairing
HOLE extent, which should not happen at all.

Unfortunately I can not find out why that seemingly harmless refactor is
causing the problem.
My initial guess is the bbio->file_offset is incorrect, I need to do
more debugging using above minimal script to find out why.

Thanks,
Qu
