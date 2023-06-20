Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD27B736AE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjFTLYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 07:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjFTLYe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 07:24:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28717CF
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687260269; x=1687865069; i=quwenruo.btrfs@gmx.com;
 bh=vSbhJDyI2oS7NTp2HQNZL4lfLLGt8CD2aT49fT9kqiM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JXL9VIUj8rAo+F1YCgGCmxn8aedavWOgOxGmDD4DianuLjRujmbkOksEa5tYfiqvstzfkjs
 7X8N/cb1RmfglV+xpNtD3/0cJH9+LWndzSoH1NaBVzC8Yyw2y4FX90PcUdO9zTlYVXHasPw1k
 9kQktiXOyYTUHKMOEfkZhAxjG6JF63Ywa72q/fa5WHiXM5vcx06srP//BflxRADROQBS5T3BY
 dLX9p5xE0/0tIKbEcgzg2UNWU51RaC7nOwa3Td2BiaUFAR1Dck3e1v2QsKwJaXIf6i4QpiwtB
 cWkaHkxLCJDh/NqP6IxuEIDc/9fs3u17OWifUmHNpTE86ho1keww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1qATXk1Ej6-007lO2; Tue, 20
 Jun 2023 13:24:28 +0200
Message-ID: <fd37dee1-0597-ef23-67b0-9cd0b3c2f780@gmx.com>
Date:   Tue, 20 Jun 2023 19:24:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] btrfs: fix u32 overflows when left shifting @stripe_nr
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <1974782b207e7011a859a45115cf4875475204dc.1687254779.git.wqu@suse.com>
 <20230620102743.GI16168@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230620102743.GI16168@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HiKAlH8Z+iBjDH7YS8Lju2AhwE9GHqktYHdgAG+nJspgb2Mylvo
 f/IvR37rA82Q0OboLWolbV0vZQZW4lTZUgeZLR04pB3s0TE7x00MWOkJdpPaRLRoUmkZa2N
 OTQkcXX94bQry7FBCqKDa/GRaMCRsthvfmdBtnpeJpQzvj42Iz/ceqQN1gkl7yd54LQwoRS
 AVACLYmA9UgM6cZOoHVtQ==
UI-OutboundReport: notjunk:1;M01:P0:XAccHAHZVxY=;XJB36ab16zfsuHdVck1K0rotWA3
 pukH1ehr6O0s5i11+N/lXVXMwOx4x/ULhiKiUFxB/UAdESRtges+dPFe36f09OqRExAwUoQzh
 AcVUUiXs+hNaFyG4xCgSP3U7BPHfIyzQogAfqZLALsVi0NlusfJ92uN3iY5exp5P6EMu6FXwF
 uWh8xm28F3p2HtS6VnPn5DV5HqCRRQOiy3sRBfNhfGmQpLWQYCskv+v1Rxeep9PxHlBAzUqqD
 Mc68iR9nxwJwqkBATknTljbYRGiU40Y9r5Tm/t+LhBIwM0e5r3Hv7NPmJ3in1zR7AFXwZBzY3
 hsu83yfXGdltD5XV6QSoXAXwDprEKoSFEE/elh5AtyHJlN3rTqzRoWFtWY5XEx9IwCI3pvEe3
 RzYo5L3Pv3pCtgvrwVlHxq8BeNRt0Ph8lJCrg0v557+0X0qG8fpjm7RFxS2GPZk0fj7SA1NL5
 O0gsizWhxSesE8yS25g1YByDp4WiJstACz+XlynPDBORrWl8YlwjTHeUzoazqbXdq1/f91Aez
 EePZBuz45u5tJaJl1Hb0kFmUpRwl0BjaICmxa4OPnCqYdTokd8s+6bTgyxEalHfXE8JRTqFZ2
 oOQv2CdMQB+j+ALr//mAFsLjisGPYDMVOSq9KiKolTT+Ca/z9NXofhsxqDtlawtVikpjW1ck8
 kXatQChvr9bKI71XoPY80BEIQQGXNE0UE06ro2nFJrbUeMcUH/4u4ruqOZYS4+xG8uTvS2h/i
 WQb0YiUKO1dZDfm5GerUMOXH5+sZmqMUiZ8e+V29Eo0WEkPODWWga3hDlveqini5ELRyDMu8r
 mdAYvgr9C/7CFHGV975L5wsiHVoK8p7JegCLxYpM/SBRyb+hz7kACNkXLZ32mhI74e7rzIu83
 U1eZhbf3sIcKbykqR0HJNMe5w0kOr2hG8wQ+kQLlPKZo/kQU8YIF0B9d5hUKuihCswGpP0Qxw
 NXhIb6MOcp98gHytOljhPYvUHjw=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/20 18:27, David Sterba wrote:
> On Tue, Jun 20, 2023 at 05:57:31PM +0800, Qu Wenruo wrote:
>> [BUG]
>> David reported an ASSERT() get triggered during certain fio load.
>>
>> The ASSERT() is from rbio_add_bio() of raid56.c:
>>
>> 	ASSERT(orig_logical >=3D full_stripe_start &&
>> 	       orig_logical + orig_len <=3D full_stripe_start +
>> 	       rbio->nr_data * BTRFS_STRIPE_LEN);
>>
>> Which is checking if the target rbio is crossing the full stripe
>> boundary.
>>
>> [CAUSE]
>> Commit a97699d1d610 ("btrfs: replace map_lookup->stripe_len by
>> BTRFS_STRIPE_LEN") changes how we calculate the map length, to reduce
>> u64 division.
>>
>> Function btrfs_max_io_len() is to get the length to the stripe boundary=
.
>>
>> It calculates the full stripe start offset (inside the chunk) by the
>> following command:
>>
>> 		*full_stripe_start =3D
>> 			rounddown(*stripe_nr, nr_data_stripes(map)) <<
>> 			BTRFS_STRIPE_LEN_SHIFT;
>>
>> The calculation itself is fine, but the value returned by rounddown() i=
s
>> dependent on both @stripe_nr (which is u32) and nr_data_stripes() (whic=
h
>> returned int).
>>
>> Thus the result is also u32, then we do the left shift, which can
>> overflow u32.
>>
>> If such overflow happens, @full_stripe_start will be a value way smalle=
r
>> than @offset, causing later "full_stripe_len - (offset -
>> *full_stripe_start)" to underflow, thus make later length calculation t=
o
>> have no stripe boundary limit, resulting a write bio to exceed stripe
>> boundary.
>>
>> There are some other locations like this, with a u32 @stripe_nr got lef=
t
>> shift, which can lead to a similar overflow.
>>
>> [FIX]
>> Fix all @stripe_nr with left shift with a type cast to u64 before the
>> left shift.
>>
>> Those involved @stripe_nr or similar variables are recording the stripe
>> number inside the chunk, which is small enough to be contained by u32,
>> but their offset inside the chunk can not fit into u32.
>>
>> Thus for those specific left shifts, a type cast to u64 is necessary.
>>
>> Reported-by: David Sterba <dsterba@suse.com>
>> Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_ST=
RIPE_LEN")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix all @stripe_nr with left shift
>> - Apply the ASSERT() on full stripe checks for all RAID56 IOs.
>> ---
>>   fs/btrfs/volumes.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b8540af6e136..ed3765d21cb0 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(=
struct btrfs_fs_info *fs_info,
>>   	stripe_nr =3D offset >> BTRFS_STRIPE_LEN_SHIFT;
>>
>>   	/* stripe_offset is the offset of this block in its stripe */
>> -	stripe_offset =3D offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>> +	stripe_offset =3D offset - ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT)=
;
>
> This needs a helper, mandating a type cast for correctness in so many
> places is a bad pattern.

The problem is, we still need to manually determine if we need a cast or
not.

For a lot of cases like "for (int i =3D 0; i < nr_data_stripes; i++) { do
with i << BTRFS_STRIPE_LEN_SHIFT;}", it's safe to go with 32 bit and
left shift.

So even with a helper, it's still the same, we need to manually decide
if we need such conversion.

Thanks,
Qu
>
>>
>>   	stripe_nr_end =3D round_up(offset + length, BTRFS_STRIPE_LEN) >>
>>   			BTRFS_STRIPE_LEN_SHIFT;
>>   	stripe_cnt =3D stripe_nr_end - stripe_nr;
>> -	stripe_end_offset =3D (stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
>> +	stripe_end_offset =3D ((u64)stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) =
-
>>   			    (offset + length);
>>   	/*
>>   	 * after this, stripe_nr is the number of stripes on this
>> @@ -6033,7 +6033,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(st=
ruct btrfs_fs_info *fs_info,
>>   	for (i =3D 0; i < *num_stripes; i++) {
>>   		stripes[i].physical =3D
>>   			map->stripes[stripe_index].physical +
>> -			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>> +			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
>>   		stripes[i].dev =3D map->stripes[stripe_index].dev;
>>
>>   		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
>> @@ -6199,15 +6199,18 @@ static u64 btrfs_max_io_len(struct map_lookup *=
map, enum btrfs_map_op op,
>>   		 * not ensured to be power of 2.
>>   		 */
>>   		*full_stripe_start =3D
>> -			rounddown(*stripe_nr, nr_data_stripes(map)) <<
>> +			(u64)rounddown(*stripe_nr, nr_data_stripes(map)) <<
>>   			BTRFS_STRIPE_LEN_SHIFT;
>>
>> +		ASSERT(*full_stripe_start + full_stripe_len > offset);
>> +		ASSERT(*full_stripe_start <=3D offset);
>>   		/*
>>   		 * For writes to RAID56, allow to write a full stripe set, but
>>   		 * no straddling of stripe sets.
>>   		 */
>> -		if (op =3D=3D BTRFS_MAP_WRITE)
>> +		if (op =3D=3D BTRFS_MAP_WRITE) {
>>   			return full_stripe_len - (offset - *full_stripe_start);
>> +		}
>
> No { }
>
>>   	}
