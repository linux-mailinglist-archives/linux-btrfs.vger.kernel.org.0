Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006CC65AC96
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 01:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjABAP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Jan 2023 19:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjABAP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Jan 2023 19:15:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC147BE0
        for <linux-btrfs@vger.kernel.org>; Sun,  1 Jan 2023 16:15:56 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE27-1pVjhy3WBv-00Kh10 for
 <linux-btrfs@vger.kernel.org>; Mon, 02 Jan 2023 01:15:54 +0100
Message-ID: <2c4c19fd-6426-8b6c-5661-1be607b82522@gmx.com>
Date:   Mon, 2 Jan 2023 08:15:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Buggy behaviour after replacing failed disk in RAID1
Content-Language: en-US
Cc:     linux-btrfs@vger.kernel.org
References: <CACsxjPaFgBMRkeEgbHcGwM7czSrjtakX9hSKXQq7RL2wJZYYCA@mail.gmail.com>
 <CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com>
 <d13c2454-b642-2db7-371e-b669fdf24279@gmx.com>
 <63b1143d.170a0220.9d74e.f651@mx.google.com>
 <bea8afad-b3dc-82e5-f5ed-d3ef73391ff4@gmx.com>
 <CACsxjPbo7DYJCHs1rg3agtX=G9hgGBvs3iTMgNX=JUGFmGkg-w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CACsxjPbo7DYJCHs1rg3agtX=G9hgGBvs3iTMgNX=JUGFmGkg-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l+381RMpeUAPyLtjkHV4/OZkr20t+4/krL/QqZGqOhZ7wC10Tq/
 OxoHbAO1jQvx0zJUdWnGbHenUnyuwWYiH2Ghi3KF1giAXOEUlPKOkVIHODGj1d8kU4sCBeF
 YFSXdSa+MNjq/utsyRMs6yy8bouG0tMFW47kANIajyxhVJyUAXEkGjMpBaiMgNdfAfp5KvI
 WyaEo+XHGUxDW5QImEeIQ==
UI-OutboundReport: notjunk:1;M01:P0:fuOAKp5awag=;Pr68aXRIGqBNYKDpF5OpdzzoFF8
 aCgI5jk8gBRsmbmjKx6d7Q59ZjAeQh0YhqtbzzXYCHLSxeVdQKds0dOXwFHD3qswswDA8jZ17
 Et8QT86cEW6R9fdiO5nPWxje6VUj1c++YxtjWdODo9WLuEMXTrF/m9o9c4wO7NfVm214F/SZ/
 4lGTh1BC/M5lZ4BrVwO8vuu/0jTwG7QZusb4lfsEkOZsMDZBmNZwq/AHbHquUBnCT1TKTF1yt
 d+am+/XmZfr0ZuquhsLSK2neXu79Bk+IsUWvK1a60NX2DYkrUjypAP1jGSV/XeIB+6763aDLX
 gtffR/31d2ZsvK8aVIWGTJhWK50GsqC0u4ri48bZaDPAlQVWKFdzUxYNK+BZJdjoB2n+MDn0g
 hbVzwmNuaS1DHLKx0IuJ/BohhSi9mVEEZJEY8+ezrWgryMOIAb3NvIaYxgLTio46hd0j7ln1j
 LwgCR1GmA8XJwHxywNiLrFUcee1Hsphu3gOqWF1qBf0NMblL+3arU0Biu+/e1WUPrPoqrh3WK
 qfsp8N4n8xqL9Lvng6QrsqvOjw2PC46Gu4BWQlEqip32ufD3WkeRjJ1AFvJl6sfANUJx/fKH1
 qvXRT8a4cyd37nx+/8fcQxIdeJNaogc6ImnpycbRHTMhHhJImHVgPQtaU1bfOFeKprvXpzOze
 OzMU0qSgBuA5Y5NHVFSI+WUVzQDuFJz8UZRe0P0srOYfEF4D+28kYGDE3cMjwQTaQN9SDRjKy
 /c+VRktSB+rnvFKhuSZ5Vf25CUkB1eNlKz7+aBdPeotFyd8EY4weZKI3ZBJaWRcyQBxFw50+U
 zLcsTkj4DqJOrEtGWXyauiJaDvWo931xkoN6oJezvGCRZr4UzmbQjJdZU+y1qoYBpx02TLrIU
 frX543eQ3zbTV/DO0/rondBXQlr7F7H3Garw56TN1d1bSMbBP8+M1s7gdh8U4sSqVhWIA432e
 4mUmWeT2lCMIL8J9aoIuh4FCUok=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        MISSING_HEADERS,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/2 07:31, 小太 wrote:
> For posterity, I will record what happened after I restarted my system
> in case anyone else encounters my problem.
> 
> On Sun, 1 Jan 2023 at 11:38, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> Since btrfs module crashed, you have to reset the system.
>>
>> And if you're going to reset the system, please remove the offending
>> disk (sda) completely.
>>
>> Then at next bootup, the fs can not be mounted without "-o degraded".
>>
>> And at next mount, btrfs may or may not resume the replace.
>> If btrfs didn't resume the replace, it means the previous replace finished.
>> If btrfs did resume the replace, let it finish first.
>>
>> Then run a scrub to fix any corrupted sectors which didn't properly get
>> repaired during replace.
> 
> I restarted my system today (which ended up requiring the magic sysrq
> sequence to get around the processes stuck in uninterruptible sleep).
> Indeed afterwards the file system needed to be mounted with -o
> degraded, but it finished the replace immediately afterwards:
> 
>> kota@home:~$ sudo btrfs fi show
>> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>>      Total devices 3 FS bytes used 1.47TiB
>>      devid    0 size 1.36TiB used 925.03GiB path /dev/sdb1
>>      devid    2 size 1.82TiB used 956.03GiB path /dev/sda1
>>      devid    3 size 1.82TiB used 1.35TiB path /dev/sdc1
>> kota@home:~$ sudo mount /media/Data -o degraded
>> kota@home:~$ sudo dmesg
>> ...
>> [  261.442582] BTRFS info (device sdb1): using crc32c (crc32c-intel) checksum algorithm
>> [  261.442590] BTRFS info (device sdb1): allowing degraded mounts
>> [  261.442592] BTRFS info (device sdb1): disk space caching is enabled
>> [  261.442917] BTRFS warning (device sdb1): devid 1 uuid 1f6d045d-ff05-43ee-99b6-0517b0240656 is missing
>> [  261.460749] BTRFS warning (device sdb1): devid 1 uuid 1f6d045d-ff05-43ee-99b6-0517b0240656 is missing
>> [  261.729290] BTRFS info (device sdb1): bdev (efault) errs: wr 4147, rd 220094697, flush 0, corrupt 0, gen 0
>> [  261.729294] BTRFS info (device sdb1): bdev /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 521, gen 0
>> [  268.369240] BTRFS info (device sdb1): continuing dev_replace from <missing disk> (devid 1) to target /dev/sdb1 @93%
>> [  269.123140] BTRFS info (device sdb1): dev_replace from <missing disk> (devid 1) to /dev/sdb1 finished
>> kota@home:~$ sudo btrfs fi show
>> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>>      Total devices 3 FS bytes used 1.47TiB
>>      devid    1 size 1.36TiB used 925.03GiB path /dev/sdb1
>>      devid    2 size 1.82TiB used 956.03GiB path /dev/sda1
>>      devid    3 size 1.82TiB used 1.35TiB path /dev/sdc1
> 
> Performing the scrub afterwards showed there were no errors, despite
> "btrfs device stats" claiming there were corruptions

That's fine, I believe now the sdb1 is the old sdd1, which during 
replace shows some false errors (the ones with mirror 3 during replace).

You can use "btrfs device status -z <device>" to clear the false errors.

Thanks,
Qu
> 
>> kota@home:~$ sudo btrfs device stats /media/Data/
>> [/dev/sdb1].write_io_errs    0
>> [/dev/sdb1].read_io_errs     0
>> [/dev/sdb1].flush_io_errs    0
>> [/dev/sdb1].corruption_errs  521
>> [/dev/sdb1].generation_errs  0
>> [/dev/sda1].write_io_errs    0
>> [/dev/sda1].read_io_errs     0
>> [/dev/sda1].flush_io_errs    0
>> [/dev/sda1].corruption_errs  0
>> [/dev/sda1].generation_errs  0
>> [/dev/sdc1].write_io_errs    0
>> [/dev/sdc1].read_io_errs     0
>> [/dev/sdc1].flush_io_errs    0
>> [/dev/sdc1].corruption_errs  0
>> [/dev/sdc1].generation_errs  0
>> kota@home:~$ sudo btrfs scrub start /media/Data
>> scrub started on /media/Data, fsid b7e4da98-b885-4e70-b0a4-510fb77fa744 (pid=5993)
>> kota@home:~$ sudo btrfs scrub status /media/Data
>> UUID:             b7e4da98-b885-4e70-b0a4-510fb77fa744
>> Scrub started:    Sun Jan  1 22:00:57 2023
>> Status:           finished
>> Duration:         3:13:29
>> Total to scrub:   2.94TiB
>> Rate:             265.23MiB/s
>> Error summary:    no errors found
>> kota@home:~$ sudo dmesg
>> ...
>> [  320.159758] BTRFS info (device sdb1): scrub: started on devid 1
>> [  320.180088] BTRFS info (device sdb1): scrub: started on devid 2
>> [  320.180491] BTRFS info (device sdb1): scrub: started on devid 3
>> [11864.015290] BTRFS info (device sdb1): scrub: finished on devid 1 with status: 0
>> [11920.924076] BTRFS info (device sdb1): scrub: finished on devid 2 with status: 0
>> [11928.142109] BTRFS info (device sdb1): scrub: finished on devid 3 with status: 0
