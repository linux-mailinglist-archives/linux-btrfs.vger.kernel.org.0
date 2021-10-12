Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2242A38A
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 13:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhJLLow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 07:44:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:40365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236273AbhJLLow (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 07:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634038968;
        bh=STpdm/DLAElVHxJC6FqStiO+j3YmFqy2vh8bve6jSbg=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=k5FCw0HgUMH8mLN3omdpWazntpj1ynw1nUZ1CQCqfImiblinneP8drmZLXXiTrAcM
         TRVlzpf39UuQskMABsbtzEYRWmXMefRWI1h4QD/SAVONZIkM/McaTsquSLUBEgetEA
         I0AYHHJHKXjLy/mK9apIV1fv/SZzPdixqTnixc7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKsnP-1mJQHd0gdp-00LGRV; Tue, 12
 Oct 2021 13:42:48 +0200
Message-ID: <32c39029-8434-e3f9-0d72-740fe6f44bff@gmx.com>
Date:   Tue, 12 Oct 2021 19:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211012021719.18496-1-wqu@suse.com>
 <b331b0a3-8119-d66e-c49e-742262ad4a9f@suse.com>
 <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs-progs: print-tree: fix chunk/block group flags
 output
In-Reply-To: <504c9584-e760-54a4-7ae4-1c4f26ec5323@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6weV6XN2Uzly5ejI25w9AJLavzGuxtjapO5U69UcL90Bg3X5jTd
 y6J+C9XDT+0rZx5CY632xMhQojJfo8dZQ3A1to+/GPFHv9qKdYz5jf77iBBtKcT9shRa4Af
 dwtDD1mlAS1tL/dGJgBkVMHkGF7sx81f6XUVnoRuTgCPAY56q2bdGJir/QobinXnBNx19nN
 cLwSUOUtkf0Saj6AizChw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vxIOu1bqNe4=:Co5T/AT258mh8KA4XX6ZhH
 sv7nU0GIhUWB7hHSYTDNUIrHJWitLS1A7zt6uIk55Gl25R+ZpyuGoBon39M71ecsC+VUVthMi
 x8pbu/RYE2OksAZNNyMVKN7LHa7JBVec9cXKyPGwd/lNAcLTbUOE+Yp30i7TgrZezOc5h37si
 4XukfNrxj9qKLNAUQG7PLzaanexafSnBdsg6niC8qsWk7twb7jtVpGV3LCyuGnMExjp5Meon0
 Zjmd7pPt4uTvqBBHLjGs3bFFjHVVndtLuZEt0XNwiyfXmLY//bIl5jmgfm/cH7gHvvVdlF+Vw
 epuJEKs+EOluT7scIYMibV9M2WTWP/6MRqohcYPxvNVYS2yg2+6Vct0UhxnPMPqr79OI0F2w1
 LfegCKa0LbYVFU4vwW7Y3plPeJa2Wuwjp/JgY33qih5Tm6agLg0fd6DcHIkft45kv3/jRCPYJ
 B17Di1V4Cp6pZRo5H/zT0saBv3pVqohowpDzfbrRc0BbihkKAYTG+KiA7V2YiIpHRaJ1NiAqW
 FXzFfpNoDt6GqhqFEG9BG5tDH8AcmWD51cI4XQvK1dVriKAD3FMMJquRvYWegolGZNI0YKv2q
 keUvUTPz+RNIiHBBA5Ng8EYhxNP0KPtmylNGpqDMIxoRhspVLZqqnG/pd7n4eBS4SPA6v2wuK
 pe/wnl2KgCqGjo2oWgP5NyxubkZu4TVyvMkBTaKdB3gwtLRW/Pi6X57g85nHYtyVDzZt1m3jD
 9OcdF+SoLIWSKVtch25wsxVCRpdocKvL/hCWqmCuJOPSnwosUpcXzCu0mp2ZYRiw1Y/etCDSB
 qtKwEIsyqpKib+ftUiGFWHeqNfMtytEt9sv+vJwCGcuL/sCN7mpbkJAqnRQBHYffrr16G1Fh7
 pTurDVco1L1qIojQVnpSoEY2Q5LN028JOxudGadDmRp1eDbDNUTzRg+BWg1vVSoW5y9yOxYVu
 syi6He5IwFg5I0EZ2tj/KWHnmnlYXpMaqFXbEOho/AIjswP05xHGKgSTr9KkAukHRs2IVRs1+
 c3vk1+JZh1EAfPWCKNAbP256hjU6Md2x4BMYxkKDmz943LrfMNmVqqJmRALLugvKmO7Wqb5RY
 rlY2HlygfjngVI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 18:38, Nikolay Borisov wrote:
>
>
> On 12.10.21 =D0=B3. 13:35, Nikolay Borisov wrote:
>> <snip>
>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   kernel-shared/print-tree.c | 47 +++++++++++++++++++++++-------------=
--
>>>   1 file changed, 29 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>>> index 67b654e6d2d5..39655590272e 100644
>>> --- a/kernel-shared/print-tree.c
>>> +++ b/kernel-shared/print-tree.c
>>> @@ -159,40 +159,51 @@ static void print_inode_ref_item(struct extent_b=
uffer *eb, u32 size,
>>>   	}
>>>   }
>>>
>>> -/* Caller should ensure sizeof(*ret)>=3D21 "DATA|METADATA|RAID10" */
>>> +/* The minimal length for the string buffer of block group/chunk flag=
s */
>>> +#define BG_FLAG_STRING_LEN	64
>>> +
>>>   static void bg_flags_to_str(u64 flags, char *ret)
>>>   {
>>>   	int empty =3D 1;
>>> +	char profile[BG_FLAG_STRING_LEN] =3D {};
>>>   	const char *name;
>>>
>>> +	ret[0] =3D '\0';
>>>   	if (flags & BTRFS_BLOCK_GROUP_DATA) {
>>>   		empty =3D 0;
>>> -		strcpy(ret, "DATA");
>>> +		strncpy(ret, "DATA", BG_FLAG_STRING_LEN);
>>
>> I find using strncpy rather odd, it guarantees it will copy num
>> characters, and if source is smaller than dest, it will overwrite the
>> rest with 0. So what happens is you are copying 4 chars here, and
>> writing 60 zeros. Frankly I think it's better to use >>
>> snprintf(ret, BG_FLAG_STRING_LEN, "DATA");

Well, you just told me a new fact, strncpy() would set the the rest bytes.

I thought it would just add the terminal '\0' if it's not reaching the
size limit.

But you're right, strncpy() would reset the padding bytes to zero.

>>
>>>   	}
>>>   	if (flags & BTRFS_BLOCK_GROUP_METADATA) {
>>>   		if (!empty)
>>> -			strcat(ret, "|");
>>> -		strcat(ret, "METADATA");
>>> +			strncat(ret, "|", BG_FLAG_STRING_LEN);
>>> +		strncat(ret, "METADATA", BG_FLAG_STRING_LEN);
>>>   	}
>>>   	if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
>>>   		if (!empty)
>>> -			strcat(ret, "|");
>>> -		strcat(ret, "SYSTEM");
>>> +			strncat(ret, "|", BG_FLAG_STRING_LEN);
>>> +		strncat(ret, "SYSTEM", BG_FLAG_STRING_LEN);
>>>   	}
>>> -	strcat(ret, "|");
>>>   	name =3D btrfs_bg_type_to_raid_name(flags);
>>>   	if (!name) {
>>> -		strcat(ret, "UNKNOWN");
>>> +		snprintf(profile, BG_FLAG_STRING_LEN, "UNKNOWN.0x%llx",
>>> +			 flags & BTRFS_BLOCK_GROUP_PROFILE_MASK);
>>>   	} else {
>>> -		char buf[32];
>>> -		char *tmp =3D buf;
>>> +		int i;
>>>
>>> -		strcpy(buf, name);
>>> -		while (*tmp) {
>>> -			*tmp =3D toupper(*tmp);
>>> -			tmp++;
>>> -		}
>>> -		strcpy(ret, buf);
>>> +		/*
>>> +		 * Special handing for SINGLE profile, we don't output "SINGLE"
>>> +		 * for SINGLE profile, since there is no such bit for it.
>>> +		 * Thus here we only fill @profile if it's not single.
>>> +		 */
>>> +		if (strncmp(name, "single", strlen("single")) !=3D 0)
>>> +			strncpy(profile, name, BG_FLAG_STRING_LEN);
>>> +
>>> +		for (i =3D 0; i < BG_FLAG_STRING_LEN && profile[i]; i++)
>>
>> nit: It's guaranteed that the profile is shorted than
>> BG_FLAG_STRING_LEN, then this check can simply be profile[i] without th=
e
>> i/BG_FLAG_STRING_LEN constant comparison.

I don't want to do any assumption here.

In fact I originally wanted to choose 32 as BG_FLAG_STRING_LEN, but it's
not safe already.

Considering the following output:
"DATA|METADATA|UNKNOWN.0xffffffff00000000"

Which is already 40 chars.

Since we're already doing all the strn*() calls just to avoid such
pitfalls, I tend to be extra safe here, thus I hope to keep the extra
check against BG_FLAG_STRING_LEN.

>>
>>> +			profile[i] =3D toupper(profile[i]);
>>> +	}
>>> +	if (profile[0]) {
>
> Actually profile[0] here is guaranteed to be nonul - it's either
> UNKNOWN... or whatever btrfs_bg_type_to_raid_name returned. So you can
> simply use the strncat functions without needing the if.

You forgot SINGLE type.

In that case, profile[0] can be "\0".

>
>>> +		strncat(ret, "|", BG_FLAG_STRING_LEN);
>>> +		strncat(ret, profile, BG_FLAG_STRING_LEN);
>>>   	}
>>
>> This if can really be put in the above 'else' branch and eliminate the
>> check altogether.

Then these lines needs to be copied to two branches:

- UNKNOWN branch
- Non-SINGLE branch

Thus it's better to kept inside the if (profile[0]) branch, as it covers
two cases.

Thanks,
Qu

>>
>>>   }
>>
>> <snip>
>>
