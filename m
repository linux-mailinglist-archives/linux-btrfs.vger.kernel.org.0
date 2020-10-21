Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A514C2953F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 23:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505922AbgJUVPG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Oct 2020 17:15:06 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37011 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411408AbgJUVPG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 17:15:06 -0400
Received: from [192.168.177.174] ([91.63.161.114]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MOAr1-1kl78s1myP-00OUwE; Wed, 21 Oct 2020 23:14:59 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Subject: Re[2]: parent transid verify failed: Fixed but re-appearing
Cc:     "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Date:   Wed, 21 Oct 2020 21:15:06 +0000
Message-Id: <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
In-Reply-To: <20201021193246.GE21815@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.38682.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:DVOy4p1GQl75OMxctk3fONI9A4Yf10eKbidCnkFjUIa2x4KFyeh
 SIpdu33amoe8hVE3U02jVX5TuMHwgrODvSl2bMMfMQlJdZavyOp4IzYJK3Uz85SOIu1SUBN
 rLhlW143HRO7MJx9hVtnlHnjv6hfX3eKIouplOfO1HtEA1TUs+XFnvDnmk8G3sezAi/5QFQ
 Shdh5fzbxFn7ts7st+g7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pFeCuedE9BQ=:lDiiCDfyQn7btfbUYsSIHX
 WDCodYwakTwTgySSp86B9Zfn+FRTVhHZZ5JLC3hAiVU6jgxl2Wsj47xCVzML2J4MQU+KTdZyc
 EhcNa8kZASXgJWuvQi2ykiPwm8gag6agoUDqjuY44yP/XLYIUld1ygL1bm3VqjwM/8EvLU7lw
 1CXV95f5wcUhFjPoHbX/nXbhycKtKC1wmJOt/bIi7RRrdZfBmk7WWlGn3FbIZyM7Io7MT8xx9
 s9np3eXfAENvtKyl3lwWXt20yCM6sDgChUQth+6WB7Idec7FIsK17zzuNWJOy5E+88QXrOwDP
 ubjh5DHkGyy+O1DFNZyzKRBqi0kvrQ/gKDRy+OgxaM3EZB5ESIKivP6tdMVMDOAtPU7T/JoPv
 h5JlL23W1Y+DPmxcUtcwNe6qFm5zPXCrwjGntZuyob7a3P2rVOMgWmg7vAxjZpczNk05CjvKC
 nYVXNuinmA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Zygo,

thanks for your reply.
>To be clear, scrub is the first thing to try, it will try to walk all
>the trees on the filesystem and read all the blocks.
>
Understood. Also thanks for explaining the other two options.
I think, it would be really advisable to add some recipies in the btrfs 
wiki - especially because btrfs check --repair is often not the right 
option opposed to the equivalent on other file systems.

>>  > Scrub iterates over all metadata pages and should hit ptvf if it's
>>  > on disk.
>>
>>  But apparently it did not?!
>
>...which indicates the problem is probably in memory, not on disk.

Which is good. On the other hand, that leaves the question why I have 
re-occuring failures of this kind (apparently) in memory.
What are possible reasons?

>>  So it looks like it is raid1 metadata
>
>That would mean either that recovery already happened (if the corruption
>was on disk and has been removed), or the problem never reached a disk
>(if it is only in memory).
Ok.
Good news.

But it's still there:
dduper --device /dev/sda1 --dir 
/srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
parent transid verify failed on 8333716668416 wanted 357026 found 357028
parent transid verify failed on 8333716668416 wanted 357026 found 357028
parent transid verify failed on 8333716668416 wanted 357026 found 357028


>
>>  > only one of your disks is silently dropping writes.  In that case
>>  > btrfs will recover from ptvf by replacing the missing block from the
>>  > other drive.  But there are no scrub errors or kernel messages related
>>  > to this, so there aren't any symptoms of that happening, so it seems
>>  > these ptvf are not coming from the disk.
>>  And can this be confirmed somehow? Would be good to replace that disk
>>  then...
>
>These normally appear in 'btrfs dev stats', although there are various
>coverage gaps with raid5/6 and (until recently) compressed data blocks.
I do not use raid5/6 and I think I do not use compressed data.

btrfs dev stats /dev/sda1
[/dev/sda1].write_io_errs    0
[/dev/sda1].read_io_errs     0
[/dev/sda1].flush_io_errs    0
[/dev/sda1].corruption_errs  0
[/dev/sda1].generation_errs  1

So, what does the generation_errs tell us?

>'btrfs scrub status -d' will give a per-drive error breakdown.

btrfs scrub status -d /dev/sda1
scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
scrub device /dev/sda1 (id 1) history
         scrub started at Mon Oct 19 21:07:13 2020 and finished after 
15:11:10
         total bytes scrubbed: 6.56TiB with 0 errors

btrfs scrub status -d /dev/sdj1
scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
scrub device /dev/sdj1 (id 2) history
         scrub started at Mon Oct 19 21:07:13 2020 and finished after 
17:06:15
         total bytes scrubbed: 6.56TiB with 0 errors


>I haven't seen spurious ptvf errors on my test machines since the 5.4.30s,
>but 5.4 has a lot of fixes that between-LTS kernels like 5.6 do not
>always get.

Ok, I am compiling 5.9.1 now.

Apart from switching to the latest Kernel - what next step do you 
recommend?
I tend to run a scrub again. Is it possible/useful to make it more 
verbose?
What else?

Greetings,
Hendrik

