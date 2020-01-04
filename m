Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2C1301C9
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2020 11:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgADKqK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jan 2020 05:46:10 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:57254 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgADKqJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jan 2020 05:46:09 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id E828E9BB2C; Sat,  4 Jan 2020 10:46:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578134766;
        bh=IC4KB/VYcd0VDlrhuLfwIZr1Tq9tmOw5jvJt8zMj3Hg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NTo5Z0FA33idx1i9+FaP5X3VHuz0ppBWQskAB5gWj1g6OY6TrJ7D44drJlgzO1tRj
         jCv6rit768YBrepEX4GNrILb2Bm5quy++EhECB4NDEm+wvY0iDVML9TowveA0wUNf4
         pnh13aUtSId0N1EO1fD3Q3Bz17aDLoHXGvFptvym4Rz4VdpxD015dXkPZsJkOLFqdO
         da/NFpw5pUpcAHtKSSnRV+KP16M2CpXPA+1S1GmZDcwWL1guc461m/4NpJdN4yt/3n
         67Lb1rU3DHJn/P2UB3BKwE+X8zSjXZMIro6XmIC/Hxig+bQ0w0IF6sHdiBjKooWRHr
         KMAGlXKgCE3rQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 11A859B9D5;
        Sat,  4 Jan 2020 10:46:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1578134762;
        bh=IC4KB/VYcd0VDlrhuLfwIZr1Tq9tmOw5jvJt8zMj3Hg=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=BX3NwGM/b+gIRuLEBpenxIM2I9UHjtoK1S+lfUm8Vo+4iXF+NAWjYHGXlFxfsJ7T/
         hpkMJpNMcPQqYNvB9u9SPHwPiUwZqrieBhC0QftZ3vP5ZauUK7t8PbcoFiy7rJue3z
         cwv9keNOIg5uY6sOC0OETz5DYQg3I0Nb4jCy6+v84XubRdFqF5jMD+iI95Xj187d9J
         37snK4YcGI9AUmVngFcA1IT2OA2vv4eUDg141BL+wTUq1k/IkQZKnbsUutt9p+vUyt
         nFw2saskxCtJk3aETgsbfPisL+8k46U8KQxSSKvcKgh5GpB9HrbI9QRVa/JHEJ8jGY
         Bw1w/L6dKd9SA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id A5A4696D5B;
        Sat,  4 Jan 2020 10:46:01 +0000 (GMT)
Subject: Re: Interrupted and resumed scrubs seem to have caused filesystem to
 go readonly (EFBIG error)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <f15c0d2f-df61-17fc-667c-2b0eb5674be2@cobb.uk.net>
 <7798d1f5-d54d-e756-973c-f2ebfa456315@gmx.com>
 <09556f2c-be43-1363-ccbe-065c88f8d5c5@cobb.uk.net>
 <e481748b-d31a-e9a5-8532-e3e77188cbe3@gmx.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <20b897b7-8420-0360-63a9-ae9d754dd87a@cobb.uk.net>
Date:   Sat, 4 Jan 2020 10:46:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e481748b-d31a-e9a5-8532-e3e77188cbe3@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/01/2020 12:34, Qu Wenruo wrote:
> 
> 
> On 2020/1/2 下午8:07, Graham Cobb wrote:
>> On 02/01/2020 01:26, Qu Wenruo wrote:
>>>
>>>
>>> On 2020/1/2 上午7:35, Graham Cobb wrote:
>>>> I have a problem on one BTRFS filesystem. It is not a critical
>>>> filesystem (it is used for backups) and I have not yet tried even
>>>> unmounting and remounting, let alone a "btrfs check".
>>>>
>>>> The problem seems to be that after several iterations of running 'btrfs
>>>> scrub' for 30 minutes, then pausing for a while, then resuming the
>>>> scrub, I got a transaction aborted with an EFBIG error and a warning in
>>>> the kernel log. The fs went readonly, and transid verify errors are now
>>>> reported. The original log extract is available at
>>>> http://www.cobb.uk.net/kern.log.bug-010120 but I have pasted the key
>>>> part below.
>>>
>>> EFBIG in btrfs is very rare, and can only be caused by too many system
>>> chunks.
>>>
>>> The most common reason is the chunk pre-alllocation for scrub, which
>>> also matches your situation.
>>>
>>> There is already a fix for it, and will land in v5.5 kernel.
>>> It looks like we should backport it.
>>
>> Thanks Qu. I will wait for that kernel, and maybe stop my monthly scrubs
>> (although my several other btrfs filesystems did not have a problem this
>> month fortunately).
> 
> And the problem will normally not impact the fs, as newly created empty
> system chunks will be soon cleaned up.
> 
>>
>> I am getting transid errors:
> 
> This is not a good news. And in fact it's normally a deadly problem.

In fact, this was not a real problem: the errors were because the
filesystem was still mounted from the original error and had gone ro so
I guess the in-memory state was different from the on-disk state.  Doh!

A simple umount and mount worked fine, although I then did a btrfs check
which also worked fine:

black:~# btrfs check --readonly -p /dev/sdc3
Opening filesystem to check...
Checking filesystem on /dev/sdc3
UUID: 4d1ba5af-8b89-4cb5-96c6-55d1f028a202
[1/7] checking root items                      (0:06:27 elapsed,
25179174 items checked)
[2/7] checking extents                         (6:34:26 elapsed, 2419791
items checked)
cache and super generation don't match, space cache will be invalidated
[3/7] checking free space tree                 (0:00:00 elapsed)
[4/7] checking fs roots                        (25:44:17 elapsed,
1497725 items checked)
[5/7] checking csums (without verifying data)  (0:54:36 elapsed, 4812627
items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 1067
items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 11946687545430 bytes used, no error found
total csum bytes: 11626743024
total tree bytes: 39628275712
total fs tree bytes: 24636817408
total extent tree bytes: 2363850752
btree space waste bytes: 5422658757
file data blocks allocated: 29159815589888
 referenced 16100593688576

Thanks again for the help, and for the design which prevented fs
corruption in this case.

I would encourage you to consider backporting the fix for the original
EFBIG problem, as you suggested above.

Graham

> 
>>
>>>> Jan  1 06:51:56 black kernel: [1931271.801468] BTRFS error (device
>>>> sdc3): parent transid verify failed on 16216583520256 wanted 301800
>>>> found 301756
>>
>> I presume 301800 is the transaction which failed and caused the fs to go
>> readonly. I don't suppose it is likely I could revert the whole fs to
>> the state of the last successful transaction is there?
> 
> This means some tree blocks doesn't reach disk.
> It can be deadly, or just a side effect caused by the transaction abort.
> 
>>
>> It is not a big problem: the fs only contains backup snapshots (not my
>> only backups!) although it would be nice to recover the historical
>> snapshots if I could (I used them to research a bug I reported to debian
>> just the other day!).
> 
> I'm afraid this depends on where the corruption is.
> 
> If it's just caused by that EFBIG error, and btrfs check reports no
> error, then it's just temporary problem caused by transaction abort.
> 
> 
> If it's in extent tree, it only affects mount or certain write
> operations, but if you can mount the fs, it should be OK to read out the
> whole fs.
> 
> If it's in csum tree, it will affect certain data read, other than
> mostly OK.
> 
> If it's in subvolume trees, some directories/files can't be accessed.
> 
> So, please run a btrfs check on the unmounted fs to verify what's the case.
> 
> Thanks,
> Qu
> 
>>
>> Regards
>> Graham
>>
> 

