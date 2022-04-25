Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A870B50DF21
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbiDYLre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiDYLrT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:47:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0D52625
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650887044;
        bh=u6ZyQ4Cs6h0UIA6IEFWuLkp7he9fT0DRwmKM9j3hUec=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=exS/PisoAv3x0I5bM+pb1ZjBvI+hVa8VldjahokXfBIwTILr1nfoeUzPPZu7lTX9y
         IRBFFxsx41cddGmws60ohYO3s1a2prtACzYcjSjSzzTQ3RILlx60cykPYdl3v8vTDW
         nn7/CCJ/jfh7yRe6+dDtkb2I5AW9ksnrlm/PL1x0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNJq-1nMWkD1Ojq-00VRG9; Mon, 25
 Apr 2022 13:44:04 +0200
Message-ID: <1b88f1dc-e551-c706-324d-ee069f8ae95e@gmx.com>
Date:   Mon, 25 Apr 2022 19:43:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-4-hch@lst.de>
 <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
 <20220425091920.GC16446@lst.de>
 <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
 <20220425110928.GA24430@lst.de>
 <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com>
 <20220425111925.GA25233@lst.de>
 <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com>
 <20220425113458.GA26412@lst.de>
 <9d6e5424-e872-7767-e1c7-6eb35d53250e@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <9d6e5424-e872-7767-e1c7-6eb35d53250e@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LMXGeuCaSyyzSkaXGbIqk4BFTGqHDctcsJSGl3l4c+yWfIYvwAX
 IFqgf3KeV3Vkq/UFcaaRAFNDNJ1l4NqCYDP9r+PF6XXlQX1MvWvnj9jQtXyOw4AloSAHKS6
 xYcnwav//Q4Jp5gHwrqDMDq7yay6vt4Q2O69zdJzeWhyoAIugjwpFj/ICRaswyc6ULRvnQO
 xHQARXrd3HFMdFYbHJyDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJ/THPyTi/Y=:W/GXf7EXb9K8ff41hCRQPc
 hhZuGrb1LRIw/rlnXlIPpLY9ThQ+6rA4nXS5+MB1r8GlsVRLfzc9auBpCup3q9M2nd/BiV9Jf
 NCN6oIheEoWVJUyJsxoNb2osIAGz94IrvsDw3zsa0dXGbvTCypprLUBeZYEntSluWgdLZzW9e
 fNDd6/bc3L2Vp4ilwNgd8UcrO8Bo/s4bMiRvQwJ35yoq01b8k9y784CifFGCd53qGqS2N/wnl
 U8sQSkYQTL2HM1Yv10e+TmvOLWJD8QWZN52zz7+sBwHflJ29vaNP1pIh5OnHPzgfJxVLjxw5k
 maCUYcCGbRBSief22jKbAbg4T2TwyyBzCPP6neEt+5aQ2q8FkIsw4wzuGr1o7vsPPmcXEZ9g8
 YJF4LwhiFo7Yv4MRWO2HyNIVfdY2ofxqax4uHkDmHOJlQgM9GSyoDrXphOm4I+xMC/qrWbU+C
 CaNsvgCzctniaZUCfE4fC2w1rKaBsVjZ/GGk8ww2lGRVJb6YBMhZlfu4+qRq6Zn4fbl5gUaw9
 Qfb1c52Sw4Df3yr3oc21lRtnA1BquV4EWCi9G7v0/01MO/aUipcHPxEdtMzPfsFH0ttJksxfC
 3O9BQzO2Jkl/UrVzFQfygSIJAVCGazoAAwpIbboCKgIgykx54ovlXt4tFjcliaNvQNZfYirsv
 nMTkNrHYZYibiZ6pkQENtxspikRsfjNw3Tfkza94MlGtoDDybVmdRUqaI/PiCj7mhy4slrNoa
 5bIgwr/RTXB0vCoAp/8sD5UVup3zrkKKbqfpA3wxZV9x9Lr08rjbRe5XdidcOmKOQzqR8XYyr
 e47sXYqLLBJ717KDzOaceWnDV13ArfNwMEmUhk03T5ca3eamZNZGA7JFAuL4ykl7gjTTHNlVn
 ZwAXXFmz6PZdlZbyszwdPESeqqrvPsVg9X+vRYf25D8hdtsPdNYdgC2yMCFQix6LteK0kjfMA
 Ja9MipEmUtFfanhZTDV6EEY7oJ9gLdSI2S6S6ljfXokQmqmcri8uIO6MhJ8H/i8nj99LnPzL1
 X4b+Fy5CdIqMU3k+S82eKByLCZFPOf3HSs04HHBKsmaGA/s+Hbj9vMakDb9r0NH76pZyKqpRp
 1YE642FvQ16koU=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 19:40, Qu Wenruo wrote:
>
>
> On 2022/4/25 19:34, Christoph Hellwig wrote:
>> On Mon, Apr 25, 2022 at 07:31:08PM +0800, Qu Wenruo wrote:
>>> Then it comes against the btrfs read time repair.
>>>
>>> Currently we split bio to make sure we never need to split bio at
>>> btrfs_map_bio() time.
>>>
>>> But this is against common layer separation.
>>>
>>> And we really want the ability to read a partially corrupted bio (some
>>> part matches csum, some doesn't), no matter if the bio is cloned or no=
t.
>>>
>>> Especially, we already have cloned bio which needs repair (for dio).
>>
>> I have a barely working version based on your patches to split the
>> bio in btrfs_bio_map that solves this problem.=C2=A0 But the next step
>> only removed the save iter for writes, where the only user is
>> index_one_bio.=C2=A0 And the fix for that is pretty trivial :)
>
> That's only for RAID56, aren't you going to remove btrfs_bio usage
> completely for all write (including buffered, non-compressing write)?

Wait, are you going to use some methods like this to avoid
chained/cloned bio while still split the bio?

	page =3D grab_page_from_existing_bio();
	pgoff =3D grab_pgoff_from_existing_bio()
	new_bio =3D bio_alloc()
	bio_add_page(new_bio, page, sectorsize, pgoff);

So that you can create a regular new, non-cloned bio, but still using
the same page/pgoff from an existing bio...

Thanks,
Qu
>
> Thanks,
> Qu
>>
>> ---
>> =C2=A0From c8fe61748ebc583a7f57c8e5de79f92428e5717c Mon Sep 17 00:00:00=
 2001
>> From: Christoph Hellwig <hch@lst.de>
>> Date: Mon, 25 Apr 2022 13:23:54 +0200
>> Subject: btrfs: stop looking at btrfs_bio->iter in index_one_bio
>>
>> All the bios that index_one_bio operates on are the bios submitted by t=
he
>> upper layer.=C2=A0 These are never resubmitted to an actual device by t=
he
>> raid56 code, and thus the iter never changes from the initial state.
>> Thus we can always just use bi_iter directly as it will be the same as
>> the saved copy.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>> =C2=A0 fs/btrfs/raid56.c | 3 ---
>> =C2=A0 1 file changed, 3 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index 1a3c1a9b10d0b..8b40353bb89db 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -1218,9 +1218,6 @@ static void index_one_bio(struct btrfs_raid_bio
>> *rbio, struct bio *bio)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 offset =3D (bio->bi_iter.bi_sector <=
< SECTOR_SHIFT) -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 rbio->bioc->raid_map[0];
>> -=C2=A0=C2=A0=C2=A0 if (bio_flagged(bio, BIO_CLONED))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_iter =3D btrfs_bio(=
bio)->iter;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio_for_each_segment(bvec, bio, iter) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 bvec_offset;
>
