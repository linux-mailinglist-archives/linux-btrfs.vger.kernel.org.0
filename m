Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384E3B99D5
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 02:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhGBACW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 20:02:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:34187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhGBACW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 20:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625183986;
        bh=lQTvw3fKnzPgaYZEA1fjyOw6IXIrjguAi0tTg/G02/g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l1gx1qp8oZsCj5Izcn2hh2qnuI1NSH4ZjGkZe8Rl9+ZsKG8gN/dVh28dtBfifgCu5
         JEOpS+0V6lhc3wuXIBQeOGYQYDKOt5q1omv8cntPhml6HnKIykpkZ5SDlsV7nmYQj9
         vK5MXWbczy8SwfFo45qacMJ564LcCfRnYkuk5Tyc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIx3C-1leh6B49og-00KRr3; Fri, 02
 Jul 2021 01:59:46 +0200
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20210701160039.12518-1-dsterba@suse.com>
 <20210701215740.GA12099@embeddedor>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <fc90ec53-1632-e796-3bf0-f46c5df790bb@gmx.com>
Date:   Fri, 2 Jul 2021 07:59:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701215740.GA12099@embeddedor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bBlIRarLpqtI4LBmnQALeObyssJvkZGn+4rQAXr4DhGjXikCIXM
 vTWIUwtJSvoftlI4h0/8r7UIv7cNGfZQUaZaoDH4V65+ItAVP3KvWkmsQlxIvIB+BCDvt62
 4Nq6+1UV09laSwdWQ7jXFdcUhH8DJe1podH3dzqkJr1YpzguwG5WkbXSZGp7z/DtYnD84LT
 wI/kGdLMxMDOTtE3DPkwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8s5mDgkBICY=:Xtxa7qVnVH8m4yn3sZIGmq
 HMZt7ADqH6Q2d/gy8NmMuQ+Ti3irlwiGreSf6Hl+swT2hR5AiGtrrhcgXTzL1mjFwOewBiM7L
 JnuZA4S7pvzth7ptfXtA/uCqbsZG6qMAIuZ/8WFWgfoT1gQXxf2Vp8VQKsTMJgafQWu0ny27Y
 Wqb6ZCfxYRbG3/nee+h8x3Vbd/38gBWrWGvHXGpUulGp8KsrbeV/ih4Ukfac9bjs7KUtV+POm
 Kdf+GIQNZEhwrjWAsrceGQ03hct2+oAab1j8LOLA2dpOUxEps+YyBKJm2r8yRhrinr/n1JDl4
 m9tdFM/JPfxCK2cBmFg7os9SaB1e5ztRxsgC8X5MT7R0/80NiCYnEZw+Vv1NJGwdPe1Ub37q8
 H9QriAvFW0X2yc+3MUyWKqemTnOY8eVH++dTBtfafBv53lqfOAmIQTTdFehudgJlE5tTJSGyQ
 5QGcNStIK1QR+Gt1FS5KpD87Z5c6LqrAObigkPEVpNc80fxUguPYVOdrILpaW81DGssELdbXg
 WSabkgnd2xssqOVGtPrO4RhIQWbNndf/zjejVWhmh2Aq6BMiw13WRtQuU/pp2QTXzhD6lm6r8
 r37WLs9INe0Yd0/mGWePOwgkDWCt450Nyii49CmbAO/cQp+txWhmkKRMfcl5PmTtLaFbqbjOl
 YI/nThohWssuOgk2T/0HIrJTxuXhjPzwW1svoy2cc/0zo1raWWEkl+qtnye+qjCf2Q17/YEC5
 2CVj2xpoZ57QkrLq2xdDqfttDbhK2AV+IIZr0ox3qUL4C7rjh97Jr1notVuFVFk7LSDqkSfL+
 LmVHzevcojooaz1/SjpgfpLco0BWFVR620Ct/gIKXGJ0IJLaeTJl4aTdvi1njM+vnIknKRJGg
 7L6VvVeWO7Y0IbuU8VWDIYivXBqcQPHonVzVD5kxnLze5Qpv5tkeXhxfMKq0tFxEjgA2ZpBeU
 jeWOsAyT8Ar1l3AdhJsGsMTfjX0gp6b0GXC5ySkli1Hcq9gHppKXN+60/bsJt72cK2X0dMVx1
 +1jd2sZZ4VseePdg8iYV9G9UuNA+X0zAekNEYX+8/5ehCVdNYz36T/QcHlzYD3DrT/2hnqIaD
 zp7wgtmGAszNu+XviEDyca3nxKzI8BYsXLyr2upkDjNeCcmR/7qU+fgbg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/2 =E4=B8=8A=E5=8D=885:57, Gustavo A. R. Silva wrote:
> On Thu, Jul 01, 2021 at 06:00:39PM +0200, David Sterba wrote:
>> On 64K pages the size of the extent_buffer::pages array is 1 and
>> compilation with -Warray-bounds warns due to
>>
>>    kaddr =3D page_address(eb->pages[idx + 1]);
>>
>> when reading byte range crossing page boundary.
>>
>> This does never actually overflow the array because on 64K because all
>> the data fit in one page and bounds are checked by check_setget_bounds.
>>
>> To fix the reported overflow and warning add a copy of the non-crossing
>> read/write code and put it behind a condition that's evaluated at
>> compile time. That way only one implementation remains due to dead code
>> elimination.
>
> Any chance we can use a flexible-array in struct extent_buffer instead,
> so all the warnings are removed?
>
> Something like this:
>
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 62027f551b44..b82e8b694a3b 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -94,11 +94,11 @@ struct extent_buffer {
>
>          struct rw_semaphore lock;
>
> -       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>          struct list_head release_list;
>   #ifdef CONFIG_BTRFS_DEBUG
>          struct list_head leak_list;
>   #endif
> +       struct page *pages[];
>   };

But wouldn't that make the the size of extent_buffer structure change
and affect the kmem cache for it?

Thanks,
Qu
>
>   /*
>
> which is actually what is needed in this case to silence the
> array-bounds warnings: the replacement of the one-element array
> with a flexible-array member[1] in struct extent_buffer.
>
> --
> Gustavo
>
> [1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-l=
ength-and-one-element-arrays
>
>>
>> Link: https://lore.kernel.org/lkml/20210623083901.1d49d19d@canb.auug.or=
g.au/
>> CC: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>>   fs/btrfs/struct-funcs.c | 66 +++++++++++++++++++++++++---------------=
-
>>   1 file changed, 41 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
>> index 8260f8bb3ff0..51204b280da8 100644
>> --- a/fs/btrfs/struct-funcs.c
>> +++ b/fs/btrfs/struct-funcs.c
>> @@ -73,14 +73,18 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_tok=
en *token,		\
>>   	}								\
>>   	token->kaddr =3D page_address(token->eb->pages[idx]);		\
>>   	token->offset =3D idx << PAGE_SHIFT;				\
>> -	if (oip + size <=3D PAGE_SIZE)					\
>> +	if (INLINE_EXTENT_BUFFER_PAGES =3D=3D 1) {				\
>>   		return get_unaligned_le##bits(token->kaddr + oip);	\
>> +	} else {							\
>> +		if (oip + size <=3D PAGE_SIZE)				\
>> +			return get_unaligned_le##bits(token->kaddr + oip); \
>>   									\
>> -	memcpy(lebytes, token->kaddr + oip, part);			\
>> -	token->kaddr =3D page_address(token->eb->pages[idx + 1]);		\
>> -	token->offset =3D (idx + 1) << PAGE_SHIFT;			\
>> -	memcpy(lebytes + part, token->kaddr, size - part);		\
>> -	return get_unaligned_le##bits(lebytes);				\
>> +		memcpy(lebytes, token->kaddr + oip, part);		\
>> +		token->kaddr =3D page_address(token->eb->pages[idx + 1]);	\
>> +		token->offset =3D (idx + 1) << PAGE_SHIFT;		\
>> +		memcpy(lebytes + part, token->kaddr, size - part);	\
>> +		return get_unaligned_le##bits(lebytes);			\
>> +	}								\
>>   }									\
>>   u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>>   			 const void *ptr, unsigned long off)		\
>> @@ -94,13 +98,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer=
 *eb,		\
>>   	u8 lebytes[sizeof(u##bits)];					\
>>   									\
>>   	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
>> -	if (oip + size <=3D PAGE_SIZE)					\
>> +	if (INLINE_EXTENT_BUFFER_PAGES =3D=3D 1) {				\
>>   		return get_unaligned_le##bits(kaddr + oip);		\
>> +	} else {							\
>> +		if (oip + size <=3D PAGE_SIZE)				\
>> +			return get_unaligned_le##bits(kaddr + oip);	\
>>   									\
>> -	memcpy(lebytes, kaddr + oip, part);				\
>> -	kaddr =3D page_address(eb->pages[idx + 1]);			\
>> -	memcpy(lebytes + part, kaddr, size - part);			\
>> -	return get_unaligned_le##bits(lebytes);				\
>> +		memcpy(lebytes, kaddr + oip, part);			\
>> +		kaddr =3D page_address(eb->pages[idx + 1]);		\
>> +		memcpy(lebytes + part, kaddr, size - part);		\
>> +		return get_unaligned_le##bits(lebytes);			\
>> +	}								\
>>   }									\
>>   void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
>>   			    const void *ptr, unsigned long off,		\
>> @@ -124,15 +132,19 @@ void btrfs_set_token_##bits(struct btrfs_map_toke=
n *token,		\
>>   	}								\
>>   	token->kaddr =3D page_address(token->eb->pages[idx]);		\
>>   	token->offset =3D idx << PAGE_SHIFT;				\
>> -	if (oip + size <=3D PAGE_SIZE) {					\
>> +	if (INLINE_EXTENT_BUFFER_PAGES =3D=3D 1) {				\
>>   		put_unaligned_le##bits(val, token->kaddr + oip);	\
>> -		return;							\
>> +	} else {							\
>> +		if (oip + size <=3D PAGE_SIZE) {				\
>> +			put_unaligned_le##bits(val, token->kaddr + oip); \
>> +			return;						\
>> +		}							\
>> +		put_unaligned_le##bits(val, lebytes);			\
>> +		memcpy(token->kaddr + oip, lebytes, part);		\
>> +		token->kaddr =3D page_address(token->eb->pages[idx + 1]);	\
>> +		token->offset =3D (idx + 1) << PAGE_SHIFT;		\
>> +		memcpy(token->kaddr, lebytes + part, size - part);	\
>>   	}								\
>> -	put_unaligned_le##bits(val, lebytes);				\
>> -	memcpy(token->kaddr + oip, lebytes, part);			\
>> -	token->kaddr =3D page_address(token->eb->pages[idx + 1]);		\
>> -	token->offset =3D (idx + 1) << PAGE_SHIFT;			\
>> -	memcpy(token->kaddr, lebytes + part, size - part);		\
>>   }									\
>>   void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>>   		      unsigned long off, u##bits val)			\
>> @@ -146,15 +158,19 @@ void btrfs_set_##bits(const struct extent_buffer =
*eb, void *ptr,	\
>>   	u8 lebytes[sizeof(u##bits)];					\
>>   									\
>>   	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
>> -	if (oip + size <=3D PAGE_SIZE) {					\
>> +	if (INLINE_EXTENT_BUFFER_PAGES =3D=3D 1) {				\
>>   		put_unaligned_le##bits(val, kaddr + oip);		\
>> -		return;							\
>> -	}								\
>> +	} else {							\
>> +		if (oip + size <=3D PAGE_SIZE) {				\
>> +			put_unaligned_le##bits(val, kaddr + oip);	\
>> +			return;						\
>> +		}							\
>>   									\
>> -	put_unaligned_le##bits(val, lebytes);				\
>> -	memcpy(kaddr + oip, lebytes, part);				\
>> -	kaddr =3D page_address(eb->pages[idx + 1]);			\
>> -	memcpy(kaddr, lebytes + part, size - part);			\
>> +		put_unaligned_le##bits(val, lebytes);			\
>> +		memcpy(kaddr + oip, lebytes, part);			\
>> +		kaddr =3D page_address(eb->pages[idx + 1]);		\
>> +		memcpy(kaddr, lebytes + part, size - part);		\
>> +	}								\
>>   }
>>
>>   DEFINE_BTRFS_SETGET_BITS(8)
>> --
>> 2.31.1
>>
