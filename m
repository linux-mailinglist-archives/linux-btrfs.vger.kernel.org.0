Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4C513F6B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 02:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353512AbiD2ANR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 20:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353514AbiD2ANO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 20:13:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D27561F
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651190987;
        bh=XhOoz2m1SD8bOl6/idlsY5ugTBA0CPwDCTLdA9wBg7I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eCCHH6jUbv0MtBMGOlmXw20pmoG45gH/iEZyKXlfwdzZhvbSHUUsD/LMkUUwwQupv
         lmgqVMRSv0hxBptW0K6BBbLB55wFFWJ2a1k8lYL0gPbD3VVm1rSDitRRTUOR2GZrf5
         5dPijGSW26uwG7D7hHSSCybrYltQOO7ikeR6xtbU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3se2-1ntCNm0uKe-00zk4d; Fri, 29
 Apr 2022 02:09:46 +0200
Message-ID: <c3aeca2d-61bc-9a00-dcca-61aa6bf99c45@gmx.com>
Date:   Fri, 29 Apr 2022 08:09:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v2 04/12] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1651043617.git.wqu@suse.com>
 <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
 <YmqYm+iFDSRTbV5W@infradead.org>
 <b27d0b0f-89de-13a5-013b-323e03d7cc40@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <b27d0b0f-89de-13a5-013b-323e03d7cc40@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dFzTpx3LYy0QsABvVrdW80d+ULEkRelEottV55g8og6TsTn0+zs
 XGo5koHKettRPbLmwr2Lr6pLnDhhFxB1FNE9cj3fkHPxdSoRZWwSYDSWNBwcL+Iw4YEczXr
 WhZwWtpKfMSJOleX/A1zBUl8l93bEx8SLhlo6QQ0MxJPcJ1Zl6lcuzh8+mo9z4EmX5QSERl
 wSk6bH/goEIy7AIpslAmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OdZiCH8IV38=:CNf8b0E9Haw5Ftr0ASBL21
 tLS/3n8cW8PeCL4KNLJdCzUesxQprh07ssmDsKVD/NnUXI+SP8buMKVB600972DWgTG26uNur
 Om9WfdU2qW06F6wdI+Qf8HWk3iLLxcSz9nU7/oPaT7IqIk9UuTFidrQuWq6+4LBaQoBKuVqnk
 ZDxAIwUACO2czOOsneTzDTdoJPQMGAsIGB8GuNUZVnQ2/3Dcc0vubzVTIjvTF8i8KGRhXZ0yf
 0aVzsTs1v8yDkMb5neOXfyjcbH8qKBz1DWZkDT+W8ZapfEoXDEgI7g9pkD4MD1WbYgibmK59V
 YK+/o4juLN6GfHf7UdhNDyRGp4NN75CUsZE9/Xm2fPozYNJdiJuin1CPRnzq6q+TGWQATevCv
 X9K6ECk8CseiNODtrmyEJ4OTD+5hm++HxGLG5KC4PjZlLOMIVP/GGQBHw+821wX2RQpJq8Fn+
 yk57XibDkXOn4J4p6iZCHX7rxsWRypAMxSh1oiv65RsYjkER544LHAIQQAUsnCfeRogN3p7A4
 wIa2AiZocyv28PVK8cSdwV8LLxx/7uzK6jbFPm0gVHBzyDeMcyiYcizJSGD82kcehtI6Vma/b
 tVNTuTIdHVmmWm71l7qMNG4us1hZnWPJJjK5BeigeiCn2JSgv5rIXn7K7cC8OML2mlKGM5GMa
 74l2TMer8tCZpu66ZU1VoeHg+wfJ/uXpu7UQXvteWNtnKf7nUBHFc4iKXgpL+YvQT0ORhfpYA
 3KN2xCT04Z/nUZctj1JyHN7PrPis6H6f8sHpKnVjIS0LV6PlREUTjdWeVqC5kEx7D1lkUPx/H
 1Y2opeSNDtfNKXD6RBVg0UucgOMv3VlYoG3zQFWTayHWAp3vkSILVnOShjWRaP6lqA/VHswPY
 yFehWv4Tn5pd/M17glLhC4z0ZRolPMZDzLZR7NMAswcJDrjF+HiV2tIt4EXeT5ZRR0xxKCoAs
 MMVUGMmSolzOY1fakD0v7Ea/mIOgTuQVmf6Qs7EnsxYLfYGqSzXNKj0tWfT9JPXBE2Ut8XsmS
 9eKoYq023z4tHYdPVbVMLMD4KVMTg+hvqK1+f/DWbwmzFeWwu+P2UFgCqgSfwcaQ6RAH9Zh6a
 /n4WkI/PBLSVr0=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/29 06:51, Qu Wenruo wrote:
>
>
> On 2022/4/28 21:37, Christoph Hellwig wrote:
>> On Wed, Apr 27, 2022 at 03:18:50PM +0800, Qu Wenruo wrote:
>>> Currently we only allocate two bitmaps and initialize various members,
>>> no real work done yet.
>>
>> I'm rather worried about these allocations.=C2=A0 These are called from
>> the I/O completion work queues, which can be rather deadlock heavy.
>> Never mind that just failing an I/O repair/recovery when we are out
>> of memory seems like a rather bad idea.
>
> That's why there is a btrfs_read_repair_ctrl::error member.
>
> If we failed the memory allocation, then we will not do any repair.
>
> To me, memory allocation is a much bigger problem.
>
>
> Although we can put the bitmap into btrfs_bio structure, and
> pre-allocate it for every bio we're going to submit.
>
> But I'm not sure if the pre-allocation way is a good idea, considering
> read-repair should be a relatively code path.

s/code/cold/

But at least for the bio submission path, we have way less strict
context, thus it's indeed a better call sites.

On the other hand, we're already allocating memory inside endio
function, for a long long time.

Check endio_readpage_release_extent(), they all need to pre-allocate
memory for extent tree update (although using mostly ATOMIC gfp flags).

I guess it's an abuse and we would like to remove it in the long run?

Thanks,
Qu

>
>>
>>> +=C2=A0=C2=A0=C2=A0 if (!ctrl->initialized) {
>>
>> I don't think you need the initialize field.=C2=A0 Just check for
>> failed_bio being non-NULL to simplify this.
>
> That's indeed simpler.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const u32 sectorsize =3D f=
s_info->sectorsize;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(ctrl->cur_bad_bitma=
p =3D=3D NULL &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ctrl->prev_bad_bitmap =3D=3D NULL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * failed_bio->bi_ite=
r is not reliable at endio time, thus we
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * must rely on btrfs=
_bio::iter to grab the original logical
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * bytenr.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(btrfs_bio(failed_bi=
o)->iter.bi_size);
>>
>> Also things would be lot more readable if the code inside this branch
>> just moved into a helper that you call if ->failed_bio is not set.
>
> Indeed.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl->cur_bad_bitmap =3D b=
itmap_alloc(ctrl->bio_size >>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize_bits, GF=
P_NOFS);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctrl->prev_bad_bitmap =3D =
bitmap_alloc(ctrl->bio_size >>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->sectorsize_bits, GF=
P_NOFS);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Just set the error bit,=
 so we will never try repair */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ctrl->cur_bad_bitmap =
|| !ctrl->prev_bad_bitmap) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kf=
ree(ctrl->cur_bad_bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kf=
ree(ctrl->prev_bad_bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ct=
rl->cur_bad_bitmap =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ct=
rl->prev_bad_bitmap =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ct=
rl->error =3D true;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> I don't think we need the extra error value either, you can just check
>> one of the bitmap pointers for NULL.=C2=A0 That being said, as mentione=
d
>> above I'm really worried about these huge allocations that can fail.
>> I think we need a mempool of some fixed size here and use that, and jus=
t
>> change the algorithm to work in chunks based on this upper bound.
>>
>>> +/* Strucutre for data read time repair. */
>>> +struct btrfs_read_repair_ctrl {
>>
>> Can we keep that structure private?=C2=A0 Based on the rest of the seri=
es
>> there actually is a fair amount of code using it, what about isolating
>> it in a new read_repair.c instead of in the giant extent_io.c and
>> inode.c files?
>
> I was considering putting it into read_repair.c, and since you're also
> mentioning that, I guess it's a good idea now.
>
> And if we're going to make that structure private, I guess we have to
> pre-allocate it in btrfs_bio as a pointer then.
>
> Thanks,
> Qu
>
