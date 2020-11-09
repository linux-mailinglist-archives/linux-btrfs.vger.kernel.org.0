Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0F2AB0FD
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 06:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgKIFtS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 00:49:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:43293 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgKIFtS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 00:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604900953;
        bh=JJhd2mP2sUrRQzjjzrf+Us6+WIwX0/jq6UUkVLPhnTY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RWGiMuoii2IN4odIHxRSlPTiG5ao0TyyyvIAqTd/VQjn+5gTs92wVo99+v650Z7tY
         rZ4y5cNOj7V0t4RMn2xfJ87O9I0/yQzyz8vGgGSIXsImRPNDROjJOvOIxX4fhshPdT
         giH7j2Z4KnTFtdom8jrPplQ4dri26hp4964hzrCI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsUp-1kXLDr1rlH-00HLbR; Mon, 09
 Nov 2020 06:49:13 +0100
Subject: Re: [PATCH 19/32] btrfs: handle sectorsize < PAGE_SIZE case for
 extent buffer accessors
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-20-wqu@suse.com>
 <d8eec47a-69c9-5173-1efb-0e7106068d70@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <13125d88-0c75-9c9e-0ae8-e393985695fa@gmx.com>
Date:   Mon, 9 Nov 2020 13:49:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d8eec47a-69c9-5173-1efb-0e7106068d70@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VFrMcRt6jF5qwUoXWw/1Q+gidzkoFwVIhyhpUbPHY69/3oHVAir
 p06T91hZ/P7Vjy+m/zcYbZIx5VAsEBaCvoDu2O7vcg67AvawJi3svu8VQwPs/ORNnVuFOL+
 mAulFc05y0+5nT3agBR2vwaUDliaKFZMCy3dMOSP1SX04xR0mUEJme/shy8GOQwHczmZ0C9
 h+BKXQ3zNCTopC0oyT8Mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NIo17UB3mXc=:rIw5on4bcfHyJmH0i3gal7
 gK9LNm3jx+e8xizT4hma88Qa21Kq9bVaRWvQQppwMkGL2cZLJYSde1Zqykd41ylSFOR2xyuR0
 zyCuTYySj3blbTUJUpTNCUssF/AwG580wbJvtAS4kx+M4MWn6JKcEl/kgqbjBW9vLLPWn2mS7
 pysUFpPMNYvpA+ex9RBdAPxnZVlQWdjh782ry3x6P3LYs0PYEuOHgygBfk6T680TwkhsqbV6w
 l1e0ygR9yKsAiPzTIKh33JFMC8HJe9WZjXR/Ig6apxc8Wx1hlU6r7k1c/pon/9s9U0FNEkGhu
 GObB02KeamHCT3/O4W5M+dgKjpavfd3VwFt5K01DgTPSLonb9RABABXt+zY9rUNcl3EYzs5y0
 j7oSXPrmI76E3WWle7BtKDSBDM78WcwLKvR4uG7TvEebPHdR+VAV7hT2iQS/aBUfArcHYG0xR
 8gUZDQG947F2Z0z6YfdbxexQGQPGKoDClzx6bJTq6MxlGGOSqvKg6VjOnB2SqOPuw6ooibZ9P
 kVnTqI3daMrdZaiMgRomwGjGUo4lD+/l3DsXq51s+MKz31tL+mYb0NinolK+/iaEZUWS8ipJR
 UXrocsNVtihz8neqVv+z4Jx/IlqCyD7ZZ8aoQIksqlqkKHFtA0BPY47qcYf0smsOpt5wUD1j7
 /HOVcUyvLcx8GwIRJLOU/2nyuRmYUJgCeqibHGTksUaLae7EwpcfFQ1jx9Qdlfug8271UvPGC
 FmaE9JSugxxgrh1M4Z+u1kT++NB8kVgMyIH05bvUT3JQctTHI1VN/99VMQRAEw1huEK4MyfVr
 +OePdL3K+IsG7FMjqEgQltEP//2bj2yNRR0LTZW8pwE4G+HjRRW3D5PXG21SO1neEVkjGhJ9O
 6GRi/NL/Gtvp1OmkLOkg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/6 =E4=B8=8B=E5=8D=888:51, Nikolay Borisov wrote:
>
>
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> To support sectorsize < PAGE_SIZE case, we need to take extra care for
>> extent buffer accessors.
>>
>> Since sectorsize is smaller than PAGE_SIZE, one page can contain
>> multiple tree blocks, we must use eb->start to determine the real offse=
t
>> to read/write for extent buffer accessors.
>>
>> This patch introduces two helpers to do these:
>> - get_eb_page_index()
>>   This is to calculate the index to access extent_buffer::pages.
>>   It's just a simple wrapper around "start >> PAGE_SHIFT".
>>
>>   For sectorsize =3D=3D PAGE_SIZE case, nothing is changed.
>>   For sectorsize < PAGE_SIZE case, we always get index as 0, and
>>   the existing page shift works also fine.
>>
>> - get_eb_page_offset()
>>   This is to calculate the offset to access extent_buffer::pages.
>
> nit: This is the same sentence as for get_eb_page_index, I think you
> mean this calculates the offset in the page to start reading from.

Sorry, the for index, it's "to calculate the *index* to access", while
for this it's "to calculate the *offset* to access".

>
>>   This needs to take extent_buffer::start into consideration.
>>
>>   For sectorsize =3D=3D PAGE_SIZE case, extent_buffer::start is always
>>   aligned to PAGE_SIZE, thus adding extent_buffer::start to
>>   offset_in_page() won't change the result.
>>   For sectorsize < PAGE_SIZE case, adding extent_buffer::start gives
>>   us the correct offset to access.
>>
>> This patch will touch the following parts to cover all extent buffer
>> accessors:
>>
>> - BTRFS_SETGET_HEADER_FUNCS()
>> - read_extent_buffer()
>> - read_extent_buffer_to_user()
>> - memcmp_extent_buffer()
>> - write_extent_buffer_chunk_tree_uuid()
>> - write_extent_buffer_fsid()
>> - write_extent_buffer()
>> - memzero_extent_buffer()
>> - copy_extent_buffer_full()
>> - copy_extent_buffer()
>> - memcpy_extent_buffer()
>> - memmove_extent_buffer()
>> - btrfs_get_token_##bits()
>> - btrfs_get_##bits()
>> - btrfs_set_token_##bits()
>> - btrfs_set_##bits()
>> - generic_bin_search()
>>
>
> <snip>
>
>> @@ -3314,6 +3315,39 @@ static inline void assertfail(const char *expr, =
const char* file, int line) { }
>>  #define ASSERT(expr)	(void)(expr)
>>  #endif
>>
>> +/*
>> + * Get the correct offset inside the page of extent buffer.
>> + *
>> + * Will handle both sectorsize =3D=3D PAGE_SIZE and sectorsize < PAGE_=
SIZE cases.
>> + *
>> + * @eb:		The target extent buffer
>> + * @start:	The offset inside the extent buffer
>> + */
>> +static inline size_t get_eb_page_offset(const struct extent_buffer *eb=
,
>> +					unsigned long offset_in_eb)
>
> nit: Rename to offset, you already pass an extent buffer so it's natural
> that the offset pertain to this eb.

I intended to reduce the confusion to allow caller to know what to pass in=
.

But you're right, the "offset_in_eb" doesn't really bring anything.

Will rename them.

Thanks,
Qu
>
>> +{
>> +	/*
>> +	 * For sectorsize =3D=3D PAGE_SIZE case, eb->start will always be ali=
gned
>> +	 * to PAGE_SIZE, thus adding it won't cause any difference.
>> +	 *
>> +	 * For sectorsize < PAGE_SIZE, we must only read the data belongs to
>> +	 * the eb, thus we have to take the eb->start into consideration.
>> +	 */
>> +	return offset_in_page(offset_in_eb + eb->start);
>> +}
>> +
>> +static inline unsigned long get_eb_page_index(unsigned long offset_in_=
eb)
>
> nit: Rename to offset since "in_eb" doesn't bring any value just makes
> the variable's name somewhat awkward.
>> +{
>> +	/*
>> +	 * For sectorsize =3D=3D PAGE_SIZE case, plain >> PAGE_SHIFT is enoug=
h.
>> +	 *
>> +	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
>> +	 * and has ensured all tree blocks are contained in one page, thus
>> +	 * we always get index =3D=3D 0.
>> +	 */
>> +	return offset_in_eb >> PAGE_SHIFT;
>> +}
>> +
>>  /*
>>   * Use that for functions that are conditionally exported for sanity t=
ests but
>>   * otherwise static
>
> <snip>
>
>> @@ -5873,10 +5873,22 @@ void copy_extent_buffer_full(const struct exten=
t_buffer *dst,
>>
>>  	ASSERT(dst->len =3D=3D src->len);
>>
>> -	num_pages =3D num_extent_pages(dst);
>> -	for (i =3D 0; i < num_pages; i++)
>> -		copy_page(page_address(dst->pages[i]),
>> -				page_address(src->pages[i]));
>> +	if (dst->fs_info->sectorsize =3D=3D PAGE_SIZE) {
>> +		num_pages =3D num_extent_pages(dst);
>> +		for (i =3D 0; i < num_pages; i++)
>> +			copy_page(page_address(dst->pages[i]),
>> +				  page_address(src->pages[i]));
>> +	} else {
>> +		unsigned long src_index =3D get_eb_page_index(0);
>> +		unsigned long dst_index =3D get_eb_page_index(0);
>
> nit: unsigned long src_index =3D 0, dst_index =3D 0; and remove the ASSE=
RT()
> below
>
>> +		size_t src_offset =3D get_eb_page_offset(src, 0);
>> +		size_t dst_offset =3D get_eb_page_offset(dst, 0);
>> +
>> +		ASSERT(src_index =3D=3D 0 && dst_index =3D=3D 0);
>> +		memcpy(page_address(dst->pages[dst_index]) + dst_offset,
>> +		       page_address(src->pages[src_index]) + src_offset,
>> +		       src->len);
>> +	}
>>  }
>
> <snip>
>
