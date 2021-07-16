Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F393CBF86
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jul 2021 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhGPW7m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 18:59:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:46625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229879AbhGPW7m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 18:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626476201;
        bh=XydBX1Fuiqm/y/b+eNcAjUtum2jPK4n2kMQZlWwdSHQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HiQjKVS1P81YydxKc7K56YMz5ZZwwTVQbz4biiXSp4zFpA7i6pIGjfTq7xfcuqGl1
         svwmRLB21E4mnl3OTZfEogKBBGDgzBjdAfJxc8DY7HMMuBM7QkNpkhTM5C3K7AKfSI
         DkL12PEzOIyrU/0tCWTDFdfFjMMtoXySiVkhd0qQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXUD-1lnoit2hVf-00JcHf; Sat, 17
 Jul 2021 00:56:41 +0200
Subject: Re: [PATCH v3 1/2] btrfs-progs: export util functions about file
 extent items
To:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <20210714145437.75710-1-realwakka@gmail.com>
 <47ac7559-820a-6a32-3f2a-72f9cb633503@suse.com>
 <20210716163021.GA1203@realwakka>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <8392b5df-31b3-0ff7-7ee6-1308a368b6e7@gmx.com>
Date:   Sat, 17 Jul 2021 06:56:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210716163021.GA1203@realwakka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0+1elJDAKu5MRh6UDSM5wqNv2cbJm4DkQRVBpDSti+RutRpWVPw
 RoPXXoQ6C2shQYPYW9B8OZjAiBJ4Ko0EHaDDCVbAiEJXYnskGo4gVLgjQ4jKp8yDATTUK7E
 MWtivdqdDVSiBW5pwyaX/rJYxFNZ9E8+bPEXUHRGzUk+1WEp5/wUkaUeMjRkobMUOxfKlzK
 qSA3DEqMJ7erw3OE1QZxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MyIg4oCUOOo=:Xxn1ll6wqWEVRVMns9prBq
 aYOcx5CfLVFbok0rQ1XSkDcEfrr7InWZLfIq7a+a4sY6O7a08XVFFbvIa74RyClWyyru7Kejb
 j5jEI0psbVcZpRvZUEuPrUFVzgfopd1wCH/zhp9TMUsDb6LnAMEiQhz7uCt5adxt3tAnIBARB
 AUqFR+dlX5roKgjbdEYyjrfWJ8B82cQ47DTARii+arxJDEgSsMnKMufWW6aZ+Az00X0gWS5/A
 WxW700eeHGTmMBJz/sHy6BrAQ6mTC0eZMcmP+vOj/FNxu8lTQYm/7yA46fOY4ZzxdZR2X85cX
 gIAtRbYJjhgzFbW5evhcr+NhIgPOER+Itw5XOB1BnBTKtlLddMlKyFavmhrkoNBHn+dBL6YUd
 ZT5hsA+KTp2T2okws50bNrYnjmG+ZNYF8H4EGa4t7EIs7v+foGCOwoVTlqKk0b3b7F2XRcUWH
 nVbTxJq+sFpzQIE9HDErm2TN0/VUCA7u0c17OVeWXdQlm6oL1aAqBEpWfbwsNNrlLWBFehOWg
 Hd9sz2gu4gGN61wN32d7OiNpdrKFsj0tF7ZnMMLJbcJBXw5vDAaXmi7EcIsYPxrzgEYOR8JIQ
 GLPBes0monxRjrNr9OzogRFT/U6Y8wJ2bt3XjlOypwEW/y3e5fFtCQrctxLegc1ecqn0uQTXF
 Vw33JkIme9QzIgygHtKpGmU+8QfeKZqFVZy9ikE7NEyhtxjV/uBME3x+NvoNDeFcJIDjlH02b
 9t81QUxbx3eEe1MTfz+fOwqWOYSrSQRSj/cNv+ADyLSKmCAI4EChatUXpFnmi4+8BWEj6D/kX
 nT/PKR8OYei4Ng95i+G662KPAEdIHaJqhBucT3tLfmxyRFaLDxVk25U+WkL1zDYyMTphqs7vp
 lZanNG8vENM7vOO4PMAPQWBxQ/pRZ0I4CiufTzppo0eqbIl+mN48m2u8bjHfaCyOEFCByzhF/
 yDqLxr/5meBLf20jbsGy6IwEQULwZDzNQnNHJwiJ6PS78Jek8G2mgQtLt7DQA/MTqKmGiGkT/
 X/p7ogyXhzZRIGlbxbov0JETon+07g3u5bVg0dRvGx9mCcDZyGC9mwKXKMAg0Io4tv8lPwPti
 RyUCiRd0SxN955BeAYKHevoLLONgPcojjIgi7SmGKldrJh/ZYtzuOJsBw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/17 =E4=B8=8A=E5=8D=8812:30, Sidong Yang wrote:
> On Thu, Jul 15, 2021 at 06:46:08AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=8810:54, Sidong Yang wrote:
>>> This patch export two functions that convert enum about file extents t=
o
>>> string. It can be used in other code like inspect-internal command. An=
d
>>> this patch also make compress_type_to_str() function more safe by usin=
g
>>> strncpy() than strcpy().
>>>
>>> Signed-off-by: Sidong Yang <realwakka@gmail.com>
>>> ---
>>> v2:
>>>    - Prints type and compression
>>>    - Use the terms from file_extents_item like disk_bytenr not like
>>>      "physical"
>>> v3:
>>>    - export util functions for removing duplication
>>>    - change the way to loop with search ioctl
>>> ---
>>>    kernel-shared/print-tree.c | 18 ++++++++++--------
>>>    kernel-shared/print-tree.h |  3 +++
>>>    2 files changed, 13 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
>>> index e5d4b453..bfef7d26 100644
>>> --- a/kernel-shared/print-tree.c
>>> +++ b/kernel-shared/print-tree.c
>>> @@ -27,6 +27,8 @@
>>>    #include "kernel-shared/print-tree.h"
>>>    #include "common/utils.h"
>>> +#define COMPRESS_STR_LEN 5
>>
>> It's already too small to contain all the strings.
>>
>> We have a default branch:
>>
>>   	default:
>>   		sprintf(ret, "UNKNOWN.%d", compress_type);
>>
>> In that case, our minimal value should be strlen("UNKNOWN.255") + 1, wh=
ich
>> is 12 bytes.
>>
>> Your old rounded up 16 bytes is in fact perfect in this case.
>>
>> Despite that, this patch looks good to me.
>
> Thanks for review.
>
> I've been thought about this. should COMPRESS_STR_LEN be exported?

I guess yes.

Thanks,
Qu

> Developer that use this function needs to know max length of string.
> Or we can choose the simple implementation that just return const char*
> like btrfs_file_extent_type_to_str(). But it will be hard to print
> unknown compress_type.
>
> Thanks,
> Sidong
>>
>> Thanks,
>> Qu
>>> +
>>>    static void print_dir_item_type(struct extent_buffer *eb,
>>>                                    struct btrfs_dir_item *di)
>>>    {
>>> @@ -338,27 +340,27 @@ static void print_uuids(struct extent_buffer *eb=
)
>>>    	printf("fs uuid %s\nchunk uuid %s\n", fs_uuid, chunk_uuid);
>>>    }
>>> -static void compress_type_to_str(u8 compress_type, char *ret)
>>> +void btrfs_compress_type_to_str(u8 compress_type, char *ret)
>>>    {
>>>    	switch (compress_type) {
>>>    	case BTRFS_COMPRESS_NONE:
>>> -		strcpy(ret, "none");
>>> +		strncpy(ret, "none", COMPRESS_STR_LEN);
>>>    		break;
>>>    	case BTRFS_COMPRESS_ZLIB:
>>> -		strcpy(ret, "zlib");
>>> +		strncpy(ret, "zlib", COMPRESS_STR_LEN);
>>>    		break;
>>>    	case BTRFS_COMPRESS_LZO:
>>> -		strcpy(ret, "lzo");
>>> +		strncpy(ret, "lzo", COMPRESS_STR_LEN);
>>>    		break;
>>>    	case BTRFS_COMPRESS_ZSTD:
>>> -		strcpy(ret, "zstd");
>>> +		strncpy(ret, "zstd", COMPRESS_STR_LEN);
>>>    		break;
>>>    	default:
>>>    		sprintf(ret, "UNKNOWN.%d", compress_type);
>>>    	}
>>>    }
>>> -static const char* file_extent_type_to_str(u8 type)
>>> +const char* btrfs_file_extent_type_to_str(u8 type)
>>>    {
>>>    	switch (type) {
>>>    	case BTRFS_FILE_EXTENT_INLINE: return "inline";
>>> @@ -376,12 +378,12 @@ static void print_file_extent_item(struct extent=
_buffer *eb,
>>>    	unsigned char extent_type =3D btrfs_file_extent_type(eb, fi);
>>>    	char compress_str[16];
>>> -	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
>>> +	btrfs_compress_type_to_str(btrfs_file_extent_compression(eb, fi),
>>>    			     compress_str);
>>>    	printf("\t\tgeneration %llu type %hhu (%s)\n",
>>>    			btrfs_file_extent_generation(eb, fi),
>>> -			extent_type, file_extent_type_to_str(extent_type));
>>> +			extent_type, btrfs_file_extent_type_to_str(extent_type));
>>>    	if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>>>    		printf("\t\tinline extent data size %u ram_bytes %llu compression=
 %hhu (%s)\n",
>>> diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
>>> index 80fb6ef7..dbb2f183 100644
>>> --- a/kernel-shared/print-tree.h
>>> +++ b/kernel-shared/print-tree.h
>>> @@ -43,4 +43,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 t=
ype);
>>>    void print_key_type(FILE *stream, u64 objectid, u8 type);
>>>    void btrfs_print_superblock(struct btrfs_super_block *sb, int full)=
;
>>> +void btrfs_compress_type_to_str(u8 compress_type, char *ret);
>>> +const char* btrfs_file_extent_type_to_str(u8 type);
>>> +
>>>    #endif
>>>
>>
