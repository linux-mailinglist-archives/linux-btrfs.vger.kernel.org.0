Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65239607222
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 10:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJUI1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUI1N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 04:27:13 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837891FAE77
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666340794;
        bh=Uh6G9iMpH0lsvTo2kxEZvAM0tKff/WIz73rT+S8Zcpo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H+iV3yeY7Whg/Y1iXaXzQ628yi31BrZXekEGkpt0mq1JQoC9LwA/cV+rjiSVhaOA8
         rBY6wsSXiSg2Y9TUMMCmM8F9ZskUcMl2gMzjZrRt01m9F+mf0ql0bNeEbgRo7RCgHW
         25/fU7BVMn975mfbrlHG2rPyzb3OUaCrveLrWaTA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzhnH-1ozJrl07iD-00vdGP; Fri, 21
 Oct 2022 10:26:33 +0200
Message-ID: <796812df-c849-ca04-a0e3-846478563f9e@gmx.com>
Date:   Fri, 21 Oct 2022 16:26:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] btrfs: btrfs: don't trust sub_stripes from disk
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Viktor Kuzmin <kvaster@gmail.com>
References: <20221021004403.eAzonZxNBMdAJAaPolyLYWT1R8ItQyLpUcdyy7uAquQ@z>
 <7550a460-a620-24e4-0e14-24078bf5eb63@oracle.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <7550a460-a620-24e4-0e14-24078bf5eb63@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KGVYzTOg5qHMIA9e5IeuXh7/4V6fCa3edOwdfBCVj6NWsdEHKtu
 km/3TWfLPik9YwsBLImcsV98U2uR68SE+q2zwCGX7yUU51+/8jWqFQBTJdFVi+YKXwtzuzc
 CTyrUKelizsq6+GoEwjG1tN35uoryUYp+xJMzHXfYJX8WlHT0/RDAbBfztrqIL9cscCV5sx
 6ws0aCcW84rQW6PCzXp2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2fmMlcEMaCM=:siZ8/rAHZnpduIAewPp7Nw
 umbY/JMAriEoNI2dAQgfAw7JX517fD5c1ZM2f4d+9EdJFfTFHbJ8aMBAuacpuN1UYAAVFRRp4
 z3zSNvXwpTlJZUBOK4VjdL7PoQ7XW/Pl+VS8xmzjd2Qoxk8+Zn9Y2vhx0etpjj3cp607xs5As
 X8m6mgkegyX2HLRPgc6ioKOnzMcmPQ9vwwAVwiIxrobU6gsmTuZ2eubHOINCRZYglEn6zUro6
 iqlpOMb32F664PD3RuJOY15wJySY2DQuK2IctBYsN2OHimeAZMo2hh+Yk2ChhFxs3D/l8KfOf
 nWJVReXkMgI2S58yCzwZqH3IcPoD42FJC+r7PAQvceZTvRHacd2BuTR9lLfHoX2VjTob9a36P
 IAwY4pCqkrUzqRWiiYjmDU6p08iUOvm5VzouWVXRJKXnWMlU1x3AGIaqH0rtXkNJUNRI4mUGT
 Tv9gFlne3psFk7Qxmn7DmKQ4OgA5VanhujOX8RjBBMj4DYmkKUMC0abdqL3qSQv2oRatS5KmL
 TtlW88QU0YTaI5Yugp68kl/ukP2zNnqlHgbVrYoJvoaIa7isw2E/ZTtfv53MWkoLZjE7ToKs2
 5I7wARhbKFGu4kHCS9/3RuQWDDoD3WiG3vLNVx7kLXyeImyw8ZNYXsRP5yVjcVIGxZwOU6FQv
 lI2kxM1FP93aqfoAEY3FzuBSqlKVvdjKdBGs0O1O048dAb3TXsbj+R4DXKMHRrcuBA4hrTuL/
 C3urYjLPIB3WTOc6m06hAVoVgQw9LkqGWkEJvr5SsrCLIbFlpD4e6cLfsS+lyQ6EcIQ6nKflk
 QkhXHfacIbsU9QGtQXX/0scBTWMi09OsIA8jpGHiOgi6oiMubRur/LRNqLPG6Kh0UCQ1i0fOw
 Q1fc+hTJfzkIO1KUWEsjkJXEuDPN54buVRZjPDnHzjCH6hu0fyiyRTLkX1K0LRO9ldnmRD3qo
 l2+CMIyeKs86upnd3+fhxtmJbndHnelcEqIH85kN2K9+NEHwEKvgc4h4BjGbVUAynxl4U2wlF
 Ze334tn+gnSg2Ov4j6v9WmehCQn0U+lSUwDJabT3o8NWsvTpPyXTHEthnIGzozujRxczVutZ4
 67klXnlceEl+urM6GutE2lT7oV7uUmGOePj7xhlKnKtBICQ1BbYjt7qvs252ds0249YmXO2jn
 9kQDz0KOkIKnR1LVMXp9HFwaI7Safcf1KFc/eA/U0ECPvVbvV7JcszXE+zfT9T1z6CN2nam8c
 z5OfETWZLoV/HNrObhEacSY2tQS3fkravP7fDg3jMm2BAP+puXIUUOMiEXg9A/iv9LVX1XUDW
 gIHdLhg1zeiBuH20CCxT1wR3qzSCvPWjT0DfB8iVtV7YV+H6jO1lE+o7xxPm2lryAC15kILer
 aKLJXRfDv6XsteYFOYpkY+htnUL/a7jM5ul1EAEteEctlacv9ACzbnigfOCJcKw5tpAor+X20
 WFglJrBhmmR9gfsjeTWO8/qFxY8NH4aStg6iKVHL60z+3O3cTtmUe4aO717X4hbbSnTdK0fLp
 oxnBNvx0EHnBoe2asAzMcuSB5maVG9TjKYVm5XuYcHoe1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/21 16:12, Anand Jain wrote:
> On 21/10/2022 08:44, Qu Wenruo wrote:
>> [BUG]
>> There are two reports (the earliest one from LKP, a more recent one fro=
m
>> kernel bugzilla) that we can have some chunks with 0 as sub_stripes.
>>
>> This will cause divide-by-zero errors at btrfs_rmap_block, which is
>> introduced by a recent kernel patch ac0677348f3c ("btrfs: merge
>> calculations for simple striped profiles in btrfs_rmap_block"):
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map->type & (BTRFS_BLOCK=
_GROUP_RAID0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BTRFS_BLOCK_GROUP_RAID10)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stri=
pe_nr =3D stripe_nr * map->num_stripes + i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stri=
pe_nr =3D div_u64(stripe_nr, map->sub_stripes); <<<
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> [CAUSE]
>> =C2=A0From the more recent report, it has been proven that we have some=
 chunks
>> with 0 as sub_stripes, mostly caused by older mkfs.
>>
>> It turns out that the mkfs.btrfs fix is only introduced in 6718ab4d33aa
>> ("btrfs-progs: Initialize sub_stripes to 1 in btrfs_alloc_data_chunk")
>> which is included in v5.4 btrfs-progs release.
>>
>> So there would be quite some old fses with such 0 sub_stripes.
>>
>> [FIX]
>> Just don't trust the sub_stripes values from disk.
>>
>> We have a trusted btrfs_raid_array[] to fetch the correct sub_stripes
>> numbers for each profile.
>>
>> By this, we can keep the compatibility with older fses while still avoi=
d
>> divide-by-zero bugs.
>>
>> Fixes: ac0677348f3c ("btrfs: merge calculations for simple striped
>> profiles in btrfs_rmap_block")
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Reported-by: Viktor Kuzmin <kvaster@gmail.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216559
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/volumes.c | 11 ++++++++++-
>> =C2=A0 1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 94ba46d57920..39588cb9a7b6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -7142,6 +7142,7 @@ static int read_one_chunk(struct btrfs_key *key,
>> struct extent_buffer *leaf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 devid;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 type;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 uuid[BTRFS_UUID_SIZE];
>> +=C2=A0=C2=A0=C2=A0 int index;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_stripes;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> @@ -7149,6 +7150,7 @@ static int read_one_chunk(struct btrfs_key *key,
>> struct extent_buffer *leaf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 logical =3D key->offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D btrfs_chunk_length(leaf, chun=
k);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type =3D btrfs_chunk_type(leaf, chunk);
>> +=C2=A0=C2=A0=C2=A0 index =3D btrfs_bg_flags_to_raid_index(type);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num_stripes =3D btrfs_chunk_num_stripes(=
leaf, chunk);
>> =C2=A0 #if BITS_PER_LONG =3D=3D 32
>> @@ -7202,7 +7204,14 @@ static int read_one_chunk(struct btrfs_key
>> *key, struct extent_buffer *leaf,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map->io_align =3D btrfs_chunk_io_align(l=
eaf, chunk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map->stripe_len =3D btrfs_chunk_stripe_l=
en(leaf, chunk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map->type =3D type;
>
>
>> -=C2=A0=C2=A0=C2=A0 map->sub_stripes =3D btrfs_chunk_sub_stripes(leaf, =
chunk);
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Don't trust the sub_stripes value, as for p=
rofiles other
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * than RAID10, they may have 0 as sub_stripes=
 for older mkfs.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * In that case, it can cause divide-by-zero e=
rrors later.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Since currently sub_stripes is fixed for ea=
ch profile, let's
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * use the trusted value instead.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 map->sub_stripes =3D btrfs_raid_array[index].sub_st=
ripes;
>
> It is a potential security threat, we have to fix this in the kernel.
> However, the code is doing correct to read from the disk instead of
> setting it to the expected value. So if the read sub_stripes is
> incorrect, why not return EUCLEAN so that the user will upgrade the
> btrfs-progs to fix the mkfs instead.

Or we will reject all older fses and cause compatibility problems.

And you're asking users to mkfs to "fix" some fses which can be safely
mounted just by older kernels?

That's not a fix, but a completely data wipe.
>
> IMO.
>
>
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map->verified_stripes =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em->orig_block_len =3D btrfs_calc_stripe=
_length(em);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < num_stripes; i++) {
>
