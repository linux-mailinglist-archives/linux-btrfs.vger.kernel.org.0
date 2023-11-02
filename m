Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F25D7DFB5B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 21:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjKBUSQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 16:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 16:18:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC70181
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Nov 2023 13:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
        s=s31663417; t=1698956284; x=1699561084; i=quwenruo.btrfs@gmx.com;
        bh=f70qEi9KxufzJ3G7OIYcIaPER4eH7W2pv3W9N8L+51Y=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=NFAd6ErYXzBs3+Cdfn6dJxDasbnrP2Zxv1YvAJC2QyVaiHsNhgTNz5bsJVDiDtkP
         F38UONbqOvUNSC7qOzZ1NwiqqnStmNjdnTnpOd1n41dwi9nT99BFvh3ykKN+YZyNM
         QpGz/JfU5nwS/Qgg0NNfboMDwA9HnAqSGfFDwIvXiT0+L98UMP5KzIAoyw54YwEiX
         B6oraJnyqM212DiPabroTwet77g7ZmyBt21qtjHikvFUeoeqO71fmZ2KYgRB0opay
         TzWe36GqziVKlS9bP3U7wpE+mnZ9PYYLrlumrPVWIK+57rUjktCX3kfxu+286sYc5
         kAXlAvxovKzuzZIX1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHG8g-1rBtff36Tg-00DFix; Thu, 02
 Nov 2023 21:18:04 +0100
Message-ID: <d69a339c-0cc2-4168-ac90-f6c1b91517b4@gmx.com>
Date:   Fri, 3 Nov 2023 06:47:59 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: add type and sequence check for
 inline backrefs
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
 <20231102190720.GA113907@zen.localdomain>
Content-Language: en-US
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
In-Reply-To: <20231102190720.GA113907@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gVLpefOrQePnCtTrR4NqPPMgjoUv2Kf54JUtSo6lmytBam2TT76
 t0lN7G067+7XIHOA4hxsdfdLSMSTXhwv2Y1Gv4Gfyz1isMtqTTYaffaIUZW+m0bpp4n9Zh7
 GF6IIOH1+DRWWivSIXNEYnuG0R6yFAe3cHGxr4YtBQI1rpgcgxTB4Y7E8f4E0ns2B+7RT7o
 Eqo4SGCVfbPEHlAIngSYA==
UI-OutboundReport: notjunk:1;M01:P0:jDMTqTKqfJo=;7XY/l/YEsD9JGoFaFdrcDOkE6K9
 3e+aw5efOfkwurdaer6w1Yt73EbnsfdHTLho8NByvRVQTR9MWRfKypfvupJj4Dpep1YP+HGCH
 o/vty2eT5Nb8e8lmJ7qg5q0U5PosXl7r7+n/p7PUglB/2UqYRqj4azLunpVzZWmhhauj+f4vU
 vz57IXG1yaN49JkxT26huASx3okaC+OEcGx2IVlsTWwmMxXpUbRbor5aXm8AgwxCPJ0Rry8m9
 sKewqEYDSjHMmpuySVFsfpnLC1EcXF2h/LlxG964+VlpjJSSXWcwTkrrBCPaGiMq1oWDtN6sV
 3JFvJY+IF/aMkssNeqvWWl+zUea4zyekvLs2TltemDL1z5Zg8UaZIDA/GPuCkzI6MoW+3SOGz
 r4zLtxKirEaunxIi14MR05cyLfgiJF0jxAQ+5sIzLbGcBTA7QFO+ViAKdSghk3F7X+LaKMMeJ
 m5lszPOUOWNq7nb4jM4JIgdfJm81CFaRQdSAnsNynb2o65sOfabtmbQvEuHLk5NU0la7Ys4Cx
 L3oML4yJkQuZ9vkYQf7MYWVqddAwZmoxClJgYqWnrQ4oUNHBOHiNNvhu5Cmzd0EmcBoHowtqi
 rkHtzju1vGLuGdRUfNEin45bdSGfq8/aQK/fsYHGmBsG+OZQ47LSRECsEdVnbiADrZcnwgDxM
 jWZOneheg1MbFghaUZd2rfumsA/Iil0zb4c8yc6Gn6uhx0gexOWY3/MQOBdo0SV+MfU4nh4nC
 oZmK5PfTvwC4ObUuetEk8rXLSFDM1uTLNzJCI3PDBqqyyllufhqnfGhI7wgI2SE1l5RslJ+0J
 9NdN1vqYxQy8rQzCZiukPehzITY/hIAp5qZfYmCS7UIqBNwjiDfNd5/zFTF8koUy8oDLAcbsa
 09SsZSa+ideWoS5NQtO+Xf1GBHM90h+QdUmLOnSNV2UpQ6CstjCpYobr7VbsH/Whg+P1kzomg
 7wrVmPNgenHVnq44vn04JZNSEDo=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/11/3 05:37, Boris Burkov wrote:
> On Tue, Oct 24, 2023 at 12:41:11PM +1030, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that ntfs2btrfs had a bug that it can lead to
>> transaction abort and the filesystem flips to read-only.
>>
>> [CAUSE]
>> For inline backref items, kernel has a strict requirement for their
>> ordered, they must follow the following rules:
>>
>> - All btrfs_extent_inline_ref::type should be in an ascending order
>>
>> - Within the same type, the items should follow a descending order by
>>    their sequence number
>>
>>    For EXTENT_DATA_REF type, the sequence number is result from
>>    hash_extent_data_ref().
>>    For other types, their sequence numbers are
>>    btrfs_extent_inline_ref::offset.
>>
>> Thus if there is any code not following above rules, the resulted
>> inline backrefs can prevent the kernel to locate the needed inline
>> backref and lead to transaction abort.
>>
>> [FIX]
>> Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added th=
e
>> ability to detect such problems.
>>
>> For kernel, let's be more noisy and be more specific about the order, s=
o
>> that the next time kernel hits such problem we would reject it in the
>> first place, without leading to transaction abort.
>>
>> Link: https://github.com/kdave/btrfs-progs/pull/622
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
>> index a416cbea75d1..981ad301d29d 100644
>> --- a/fs/btrfs/tree-checker.c
>> +++ b/fs/btrfs/tree-checker.c
>> @@ -31,6 +31,7 @@
>>   #include "inode-item.h"
>>   #include "dir-item.h"
>>   #include "raid-stripe-tree.h"
>> +#include "extent-tree.h"
>>
>>   /*
>>    * Error message should follow the following format:
>> @@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buffer=
 *leaf,
>>   	unsigned long ptr;	/* Current pointer inside inline refs */
>>   	unsigned long end;	/* Extent item end */
>>   	const u32 item_size =3D btrfs_item_size(leaf, slot);
>> +	u8 last_type =3D 0;
>> +	u64 last_seq =3D U64_MAX;
>>   	u64 flags;
>>   	u64 generation;
>>   	u64 total_refs;		/* Total refs in btrfs_extent_item */
>> @@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buffe=
r *leaf,
>>   	 *    2.2) Ref type specific data
>>   	 *         Either using btrfs_extent_inline_ref::offset, or specific
>>   	 *         data structure.
>> +	 *    All above inline items should follow the order:
>> +	 *
>> +	 *    - All btrfs_extent_inline_ref::type should be in an ascending
>> +	 *      order
>> +	 *
>> +	 *    - Within the same type, the items should follow a descending
>> +	 *      order by their sequence number
>> +	 *      The sequence number is determined by:
>> +	 *      * btrfs_extent_inline_ref::offset for all types  other than
>> +	 *        EXTENT_DATA_REF
>> +	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
>>   	 */
>>   	if (unlikely(item_size < sizeof(*ei))) {
>>   		extent_err(leaf, slot,
>> @@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buffer=
 *leaf,
>>   		struct btrfs_extent_inline_ref *iref;
>>   		struct btrfs_extent_data_ref *dref;
>>   		struct btrfs_shared_data_ref *sref;
>> +		u64 seq;
>>   		u64 dref_offset;
>>   		u64 inline_offset;
>>   		u8 inline_type;
>> @@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buffer=
 *leaf,
>>   		iref =3D (struct btrfs_extent_inline_ref *)ptr;
>>   		inline_type =3D btrfs_extent_inline_ref_type(leaf, iref);
>>   		inline_offset =3D btrfs_extent_inline_ref_offset(leaf, iref);
>> +		seq =3D inline_offset;
>>   		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)=
) {
>>   			extent_err(leaf, slot,
>>   "inline ref item overflows extent item, ptr %lu iref size %u end %lu"=
,
>> @@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buffe=
r *leaf,
>>   		case BTRFS_EXTENT_DATA_REF_KEY:
>>   			dref =3D (struct btrfs_extent_data_ref *)(&iref->offset);
>>   			dref_offset =3D btrfs_extent_data_ref_offset(leaf, dref);
>> +			seq =3D hash_extent_data_ref(
>> +					btrfs_extent_data_ref_root(leaf, dref),
>> +					btrfs_extent_data_ref_objectid(leaf, dref),
>> +					btrfs_extent_data_ref_offset(leaf, dref));
>>   			if (unlikely(!IS_ALIGNED(dref_offset,
>>   						 fs_info->sectorsize))) {
>>   				extent_err(leaf, slot,
>> @@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buffe=
r *leaf,
>>   				   inline_type);
>>   			return -EUCLEAN;
>>   		}
>> +		if (inline_type < last_type) {
>> +			extent_err(leaf, slot,
>> +				   "inline ref out-of-order: has type %u, prev type %u",
>> +				   inline_type, last_type);
>> +			return -EUCLEAN;
>> +		}
>> +		/* Type changed, allow the sequence starts from U64_MAX again. */
>> +		if (inline_type > last_type)
>> +			last_seq =3D U64_MAX;
>> +		if (seq > last_seq) {
>> +			extent_err(leaf, slot,
>> +"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev typ=
e %u seq 0x%llx",
>> +				   inline_type, inline_offset, seq,
>> +				   last_type, last_seq);
>> +			return -EUCLEAN;
>> +		}
>> +		last_type =3D inline_type;
>> +		last_seq =3D seq;
>>   		ptr +=3D btrfs_extent_inline_ref_size(inline_type);
>>   	}
>>   	/* No padding is allowed */
>> --
>> 2.42.0
>>
>
> I believe this breaks simple quotas EXTENT_OWNER_REF_KEY items which
> have type 188 but come in before the other inline items.

Does it mean EXTENT_OWNER_REF_KEY is another odd ball, which doesn't
follow the existing type/inline ref order?

If so, can we fix it in the kernel first?

Thanks,
Qu
>
> For a repro, btrfs/301 (available in the master fstests branch) fails
> with the patch but passes without it.
