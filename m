Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E9965FC40
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 08:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAFHrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 02:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjAFHrI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 02:47:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EE213D2E
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 23:47:06 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1p9qcT0zD4-008N1Z; Fri, 06
 Jan 2023 08:47:03 +0100
Message-ID: <3a220ba2-67a6-c3b8-6b07-cf70c1c80fc2@gmx.com>
Date:   Fri, 6 Jan 2023 15:47:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Robert LeBlanc <robert@leblancnet.us>
Cc:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com>
 <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it>
 <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
 <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: File system can't mount
In-Reply-To: <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:W2rxcpys0LfL7zAc/OGncj7YFFrvgVv9Y6irnHyXnfU5gd5RQwU
 ChSDRDrMXzRcv8kVZ8Mu+gZv8s6Yw6/bKtCpUe8v4J/HvZCMJfqvnFUly1JMafwZBnqg2zj
 AOGw8U+waNJ87/TXzDbvjDjRRHaIgz/E7e3qNKm7OyVEd1AxLKH3C26+jj9BO5GqWf8c8SJ
 1LQ8hDxeKSFUp+UhJS1xg==
UI-OutboundReport: notjunk:1;M01:P0:L2BSfZvQ+Ps=;44BI7pVlZX4NSMbpo1OzTDoRszu
 1Ugoi1C/ADZCTgcGKspUUCG+rK6AdYpJV1EDvBfOE1dR2bW8ugO0RuA/0Z3BRS/kBxrWt3EoD
 gMh4DDN+ETF/23Oif+G7C4UbbetVNHWF7YA6RRkuvFD7YEl1ooB/lpunEuXSLPcSpoTD3qoYB
 RJjGVSJeF+0PecMUKM73n6M4HKHtGpOm8gnR+2hanWtEjiidQzof00ttNWchogD8jfwOTbfXs
 fllGmyQYvRtSeepnBY22A2QJGt6STpqk3qOjfTEapn+k8DFzRi+1zbzkTxHHXAA/sa1CkSLvX
 wLYfb90N68/Qn7UT+dpoOZGijRC7aiU/KLPk/UT7YBwalE2rSQMhn1/VkHU2wTSpMwot2UYTi
 HiDsfX6DYBDB7z5jxavaMzattH02WT3zv3dCSaQy7p8RgNaHzi0mUovb4J2VdlJr95zAqndrQ
 aKhAAp7lHHFMiYEl8Q0qzEGS0CnX2V7LdDLskjK2NQexfwwzDaOAgvRQz7QY0S4cCxnQbyw/N
 IR6NlLetA15pJ0NM55xOVfh9yrdYs2myV3ayDHLjn2q1lUeXjeZyI/3Qpov7ahAAZkmE8aaYU
 A/KO4JUI2OdtjXwasaGpKUKsTHHoF12RK6TfnYbpEs+6sHENPSq9K8QtjWeLxVqJdGsx41rbO
 ScB3h3JeFbo8Ybwf3ZwMlWsYNu2w0VWWGPgLGUy6YxySpsajBkuAXJAycCwJJJIE7wIntM2TA
 GtOrBp3PXmSv4w8xP7GenH/GOB6rtIV7MUhXTVGGF7Z6QfIXe0DBySa8vVWaKW5XRh39ycdQy
 GLbV2FJIXbw2QHyyWFotHjZhtwhJREjtMB43PD5YiIQumHxJ2o4Q9ojo6ydS+NY4Se7tkyWr2
 /E73T2FR/SdgZno/pbctAbKomvBjJHwYeGwgOW+w0Jhff4ru4aVEZtBSDolwfH7OGdAHRS9R1
 WixhRMDIFpUf0RTMqxnrZ6fibs0=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/6 14:17, Robert LeBlanc wrote:
> On Thu, Jan 5, 2023 at 5:20 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> There are several hidden assumptions.
>>
>> - For recently created/balanced btrfs, there should be no tree blocks
>>     crossing stripe/64K page boundary
>>     Thus a single backref crossing the boundary is not some common thing.
>>
>>     We should either get tons of such metadata, or none.
>>
>> - Dmesg itself only contains the obviously bad info
>>     In your case, it's "btrfs check" result showing the details.
>>     As kernel rejects the mount directly, without giving any chance
>>     to look into the situation.
>>
>> - One backref is missing, one backref should not exist
>>     This is already a hint to let us link those two backrefs.
>>
>>     And if we compare the hex of the two backrefs, we got one
>>     bitflipped.
>>
>>     Furthermore this does not only matches the symptom, but also possible
>>     to happen.
>>     The metadata itself is fine, but when adding the backref, bitflip
>>     happened in the key of the backref, resulting a missing backref for
>>     the correct metadata, while a backref doesn't has any metadata for it.
>>
>> Thus I believe it's a memory bitflip.
>>
>> Thanks,
>> Qu
> 
> Qu,
> 
> Your assumptions are spot on. One of the two memory dims is either bit
> flipping or stuck on 0/1. After running memtest86+, I can verify that
> some memory addresses create spoiled data. I'm currently running off
> the good DIMM as I get some new RAM ordered and recovering from
> backups (apparently my backups stopped in September of last year) and
> then trying to pull off the newer data that I need from the bad file
> systems.

Well, I'd say that filesystem should still be over 99% fine.
Even the memory hardware is faulty, it shouldn't cause huge damages for 
the filesystem.

> It's really odd that I never saw csum errors in dmesg and it
> only appears that metadata got corrupted.

That's because if the corruption happens for data, you won't be able to 
see any csum mismatch.

Because the corruption happens in memory, we calculate the csum using 
the bad data, thus no csum mismatch would happen.

You can only be sure by comparing with the backup.

> It looks like some of my
> more critical subvolumes I could either do a `btrfs send/receive` or
> do an `rsync` of them from my NVMe btrfs. I hope the HDD will have
> similar luck and since there weren't a lot of writes to my large
> volume, I'm hoping that it escaped corruption.

In fact, that bitflip seems to be the only corruption (that matters).
Thus you can go "btrfs check --repair", and still use the fs
(if after repair, the fs can pass btrfs check).

> 
> Thinking out loud here, with BTRFS being so good at detecting bit rot
> on disk, could that be expanded to in-memory data structures kind of
> like RAID with checksums?

In fact, if you're using newer kernel from day 1, then such corruption 
can be prevented directly.

Newer kernel (v5.15+?) would reject any write that has obviously bad 
metadata.

Thus in your case, it would result a RO mount, but no such corruption.
(But of course, if the memory bitflip happens for data, there is no way 
to catch it)

Thanks,
Qu

> But I guess the argument could be made to
> use server grade hardware with ECC if you want that level of
> protection.


> 
> Thank you,
> Robert LeBlanc
> 
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
