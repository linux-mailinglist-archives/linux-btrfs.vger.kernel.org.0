Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A711E7DFBDE
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 22:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjKBVGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 17:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBVGE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 17:06:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764F18C
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698959152; x=1699563952; i=quwenruo.btrfs@gmx.com;
        bh=WNaHzVzd7/hGTJcigVvpnrMJiJGXdkVxgxcZoCWq+oc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=k+d1n8FW9uWf0UtOYBq0h6eWoDZyIITRhqsz/ORitl6gSq4vLezhhtjPkr46/1Dn
         hItsvxOoSobaWOXQI2mdGu8FyNbKh3VBmwGVwd+GkTNnP0WmoCV17jrMVZ1BWjQS4
         bg6DYV/rkRKoYVoUGVFKCOPf8jhRpmBroV2IMPItQ6rNJ5hrCBjxcb8Ie3Tnu1iZz
         VG8pj4WXMIqLDUuHyILtKTo/pg0tFDFHAZ30/nWUVJpMaY2tTUgFzLSgi39G3OGpS
         WlFtmBV9Qi1waDytVaAQb/3vrq85Af6y5wZxkKj4061CYQrdnIKwO9TWBlwRIHfdu
         jmpNp9norNfgA49qpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8GMk-1rTiNs02SW-014G0g; Thu, 02
 Nov 2023 22:05:52 +0100
Message-ID: <12595173-fdc6-4e49-9e37-e97a6b7e8606@gmx.com>
Date:   Fri, 3 Nov 2023 07:35:48 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
 <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
 <20231102203529.GA119621@zen.localdomain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231102203529.GA119621@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D8dYWWSLoBtlCFrMPnoDo0ogM0/sCL/qNBsL8D/syCiguPCP/Dk
 eQfOkyBszm1Q0xyabrqjCU2BPBD1Hb9V1uKPYhLCvITViyXGrrFEHldB4MgA0loXD5KPbp9
 45yiZixgwwkhVCitR7mdMSFWvfyloMMUMvbF7MwGYU79ZyKC6EjEdrttViLRtYRk51Jjd15
 jHJrmm7roQEl/7/L2BSZA==
UI-OutboundReport: notjunk:1;M01:P0:Qjf3aWomoKs=;MjqM0HkPEa5CKgZlazLiiG9oxlH
 hhwVbb9n2soHBMDbxD+lSlGuR+Ay8ByWyb+dRoV+RpxOZT6pa03ZV6Ud8qBRdFSYTsYDPigmc
 pwn+6EAJQTfGmkswAq3HfGDNpzbNex96lGmCmrKXzaGkdueyQZ+oairvXHd+IOe/ThLHLc7ui
 h25zO8RU4Ct/rPV2ikYUUNpUihYYTWreM/UtI2S8f+pz4JYdch+YL5fH9L2OhBSFT2r17sx0x
 ENcyIDIvCScqktGKd21PP9P8O9HpgMnycC2VFsUwSCQc857nZTfON4OqEGzwgh3ZAhjHqLBWI
 UuVm96Fqg/xSjr6mPcBh+Nub2AJr7QEj57Cz3alvClZky7nZx8bnjEd9aXCPi+xgc/S8KvBMx
 dmJObZGNR2yxs3DJbsBaRc960bxU8FU4eiDZFzWXNCulsqB2WN4C+CuqXYHUs2C6LAbsw62HL
 k9dHAhUKCBOOu+KWot9m61ND5uK5v9nxguSsitWa+DkVMpdGLJF69duUa1GFTafOk/EmoYNjT
 9Q7xvNUoNgw7zHqQoNsxOtTzuQhTK/PfYiVRiOYt3HpUPJKXjxvXHFRsLmUKIvJSjyuVnX5ss
 3fVeXKf+X9mg2CnpLR+eTttQIrdzpQFTl0nH4Tbcj9oUKEPY7wG83+FR7tDQUIc/1LA4uJunW
 QUXK3bmZdaVT/lFWFi0pv8e9HRjAgBtlly8M9WgCKT92d27YFvVpVXwg+nHNCwpDRHnz73xtq
 cxdxMf5q5bQu32E26RfahL7RQTEKzE6aw8w64sHaiLY9qeuIp+15XhfutuEIMNStc7TwnXGV+
 7GOm1hNVYxBOt3CyQw/QAdkhhn6gycemGl0CAWb3w5oNhhdp45T/4gg5+nAVP0k5cURlMnF52
 w2TOqHX4hQJqGmGzjCGZns/Gz0sCRA3TnNtkYxYahPK79Wn0sOdNCjYN24081PiwD3tZddwic
 hB5/xw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 07:05, Boris Burkov wrote:
> On Fri, Nov 03, 2023 at 06:47:59AM +1030, Qu Wenruo wrote:
>>
>>
>> On 2023/11/3 05:37, Boris Burkov wrote:
>>> On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
>>>> [BUG]
>>>> There is a bug report that ntfs2btrfs had a bug that it can lead to
>>>> transaction abort and the filesystem flips to read-only.
>>>>
>>>> [CAUSE]
>>>> For inline backref items, kernel has a strict requirement for their
>>>> ordered, they must follow the following rules:
>>>>
>>>> - All btrfs_extent_inline_ref::type should be in an ascending order
>>>>
>>>> - Within the same type, the items should follow a descending order by
>>>>     their sequence number
>>>>
>>>>     For EXTENT_DATA_REF type, the sequence number is result from
>>>>     hash_extent_data_ref().
>>>>     For other types, their sequence numbers are
>>>>     btrfs_extent_inline_ref::offset.
>>>>
>>>> Thus if there is any code not following above rules, the resulted
>>>> inline backrefs can prevent the kernel to locate the needed inline
>>>> backref and lead to transaction abort.
>>>>
>>>> [FIX]
>>>> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added =
the
>>>> ability to detect such problems.
>>>>
>>>> For kernel, let's be more noisy and be more specific about the order,=
 so
>>>> that the next time kernel hits such problem we would reject it in the
>>>> first place, without leading to transaction abort.
>>>>
>>>> Link: https://github.com/kdave/btrfs-progs/pull/622
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/tree-checker.c | 38 +++++++++++++++++++++++++++++++++++++=
+
>>>>    1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>>>> index a416cbea75d1..981ad301d29d 100644
>>>> --- a/fs/btrfs/tree-checker.c
>>>> +++ b/fs/btrfs/tree-checker.c
>>>> @@ -31,6 +31,7 @@
>>>>    #include "inode-item.h"
>>>>    #include "dir-item.h"
>>>>    #include "raid-stripe-tree.h"
>>>> +#include "extent-tree.h"
>>>>
>>>>    /*
>>>>     * Error message should follow the following format:
>>>> @@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buff=
er *leaf,
>>>>    	unsigned long ptr;	/* Current pointer inside inline refs */
>>>>    	unsigned long end;	/* Extent item end */
>>>>    	const u32 item_size =3D btrfs_item_size(leaf, slot);
>>>> +	u8 last_type =3D 0;
>>>> +	u64 last_seq =3D U64_MAX;
>>>>    	u64 flags;
>>>>    	u64 generation;
>>>>    	u64 total_refs;		/* Total refs in btrfs_extent_item */
>>>> @@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buf=
fer *leaf,
>>>>    	 *    2.2) Ref type specific data
>>>>    	 *         Either using btrfs_extent_inline_ref::offset, or speci=
fic
>>>>    	 *         data structure.
>>>> +	 *    All above inline items should follow the order:
>>>> +	 *
>>>> +	 *    - All btrfs_extent_inline_ref::type should be in an ascending
>>>> +	 *      order
>>>> +	 *
>>>> +	 *    - Within the same type, the items should follow a descending
>>>> +	 *      order by their sequence number
>>>> +	 *      The sequence number is determined by:
>>>> +	 *      * btrfs_extent_inline_ref::offset for all types  other than
>>>> +	 *        EXTENT_DATA_REF
>>>> +	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
>>>>    	 */
>>>>    	if (unlikely(item_size < sizeof(*ei))) {
>>>>    		extent_err(leaf, slot,
>>>> @@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buff=
er *leaf,
>>>>    		struct btrfs_extent_inline_ref *iref;
>>>>    		struct btrfs_extent_data_ref *dref;
>>>>    		struct btrfs_shared_data_ref *sref;
>>>> +		u64 seq;
>>>>    		u64 dref_offset;
>>>>    		u64 inline_offset;
>>>>    		u8 inline_type;
>>>> @@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buff=
er *leaf,
>>>>    		iref =3D (struct btrfs_extent_inline_ref *)ptr;
>>>>    		inline_type =3D btrfs_extent_inline_ref_type(leaf, iref);
>>>>    		inline_offset =3D btrfs_extent_inline_ref_offset(leaf, iref);
>>>> +		seq =3D inline_offset;
>>>>    		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > e=
nd)) {
>>>>    			extent_err(leaf, slot,
>>>>    "inline ref item overflows extent item, ptr %lu iref size %u end %=
lu",
>>>> @@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buf=
fer *leaf,
>>>>    		case BTRFS_EXTENT_DATA_REF_KEY:
>>>>    			dref =3D (struct btrfs_extent_data_ref *)(&iref->offset);
>>>>    			dref_offset =3D btrfs_extent_data_ref_offset(leaf, dref);
>>>> +			seq =3D hash_extent_data_ref(
>>>> +					btrfs_extent_data_ref_root(leaf, dref),
>>>> +					btrfs_extent_data_ref_objectid(leaf, dref),
>>>> +					btrfs_extent_data_ref_offset(leaf, dref));
>>>>    			if (unlikely(!IS_ALIGNED(dref_offset,
>>>>    						 fs_info->sectorsize))) {
>>>>    				extent_err(leaf, slot,
>>>> @@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buf=
fer *leaf,
>>>>    				   inline_type);
>>>>    			return -EUCLEAN;
>>>>    		}
>>>> +		if (inline_type < last_type) {
>>>> +			extent_err(leaf, slot,
>>>> +				   "inline ref out-of-order: has type %u, prev type %u",
>>>> +				   inline_type, last_type);
>>>> +			return -EUCLEAN;
>>>> +		}
>>>> +		/* Type changed, allow the sequence starts from U64_MAX again. */
>>>> +		if (inline_type > last_type)
>>>> +			last_seq =3D U64_MAX;
>>>> +		if (seq > last_seq) {
>>>> +			extent_err(leaf, slot,
>>>> +"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev t=
ype %u seq 0x%llx",
>>>> +				   inline_type, inline_offset, seq,
>>>> +				   last_type, last_seq);
>>>> +			return -EUCLEAN;
>>>> +		}
>>>> +		last_type =3D inline_type;
>>>> +		last_seq =3D seq;
>>>>    		ptr +=3D btrfs_extent_inline_ref_size(inline_type);
>>>>    	}
>>>>    	/* No padding is allowed */
>>>> --
>>>> 2.42.0
>>>>
>>>
>>> I believe this breaks simple quotas EXTENT_OWNER_REF_KEY items which
>>> have type 188 but come in before the other inline items.
>>
>> Does it mean EXTENT_OWNER_REF_KEY is another odd ball, which doesn't
>> follow the existing type/inline ref order?
>
> Yes, I suppose it does. I didn't see that invariant documented anywhere,
> so I apologize for breaking it. It does seem like a valuable invariant
> to keep the inline items sorted.

Not a big deal, in fact we all hit the same situation, and that's why
we're adding tree-checker, kinda like a slightly better documented
on-disk format.

>
> If it's possible at this stage to change the type number to be 170 or
> something, I think that would fix it, and would be a much less intrusive
> change than pushing the owner ref item to the back of the inline refs,
> which would complicate parsing a lot more, IMO.

I believe this is much better solution.

Especially we have EXPERIMENTAL flags for btrfs-progs, thus it should
give us quite some period to tweak the on-disk format.

Although even I submitted a tree-checker for this, I'm not a fan of the
existing weird ordering thing for inlined backrefs at all.

I'd prefer to have no order at all (it's not that bad, since the
backrefs are already inlined, but can still bring small perf drop), or
fully ordered (type and seq follow the same ascending or descending order)=
.

But this needs a on-disk format change, and even we introduced such
change it would still take a long time to deprecate the existing order.

So I'm afraid we would stick to the existing order.

>
> OTOH, in general, the parsing has to have special cases for the owner re=
f
> inline item since it is per extent, not per ref, so I don't see why it
> couldn't just skip it here too.

Yeah, it's not hard to do in the code, but for the sake of consistency,
I'd really prefer it to follow some existing order, even if the existing
one is already weird...



Another thing to mention is, that EXTENT_OWNER_REF seems to be inlined
only, has no keyed version.

I have already come upon a rare corner case:

   What if an EXTENT_ITEM is already so large that it can not add a new
   inline ref?

I guess this can only be a problem for converting, as for now squota can
only be enabled at mkfs time, thus the new EXTENT_OWNER_REF can always
be inlined.

Thanks,
Qu

>
> e.g., this works to fix it:
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 50fdc69fdddf..62150419c6d4 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1496,6 +1496,9 @@ static int check_extent_item(struct extent_buffer =
*leaf,
>   				   inline_type);
>   			return -EUCLEAN;
>   		}
> +
> +		if (last_type =3D=3D BTRFS_EXTENT_OWNER_REF_KEY)
> +			goto next;
>   		if (inline_type < last_type) {
>   			extent_err(leaf, slot,
>   				   "inline ref out-of-order: has type %u, prev type %u",
> @@ -1512,6 +1515,7 @@ static int check_extent_item(struct extent_buffer =
*leaf,
>   				   last_type, last_seq);
>   			return -EUCLEAN;
>   		}
> +next:
>   		last_type =3D inline_type;
>   		last_seq =3D seq;
>   		ptr +=3D btrfs_extent_inline_ref_size(inline_type);
>
>>
>> If so, can we fix it in the kernel first?
>>
>> Thanks,
>> Qu
>>>
>>> For a repro, btrfs/301 (available in the master fstests branch) fails
>>> with the patch but passes without it.
