Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8742DCCCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 07:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLQG4t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 01:56:49 -0500
Received: from mout.gmx.net ([212.227.15.15]:41647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgLQG4s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 01:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608188114;
        bh=MoILj62SoNhZQNrxFMUky1kwJznzcXAr5oAC9CHeBn8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BvnoPvS9vD8bHbfYYea81VpIKbHlcTXEk6LDRmjkvR1I5Q+M8uVB2NT+e7dIwSKud
         kyKi5ROAqG9Rn+dWepYk4MSWEj7J5PaY10naewRWWhNmi5Jvft+vYdtAW6Vq76vhIn
         BcSCSz7b4Qs7YEggJGktWQhLTHwgpFPDPXXBC3wM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7b2d-1kk35w12jt-0080v0; Thu, 17
 Dec 2020 07:55:13 +0100
Subject: Re: [PATCH v2 07/18] btrfs: extent_io: make
 grab_extent_buffer_from_page() to handle subpage case
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-8-wqu@suse.com>
 <a6697d1f-5352-142d-40a2-872fe43a8ee5@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <d440d858-0a0a-63b7-d602-ddc0e30f355f@gmx.com>
Date:   Thu, 17 Dec 2020 14:55:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <a6697d1f-5352-142d-40a2-872fe43a8ee5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HP1CnbBS92w//wwGeDc9UDQVXsYfrUPcy/+/oDpzx4Y8xeku2bm
 o7dLqxthuhZqnL19yoFF0OtikgRcyi76TOvcjUYnX5vTiJEfGHW7x+faS+V6Wxbp9LhatqB
 37uSnEXEj3FpUWq2Y6esFFzYf0rOJ7y3fT0VxuYg7Q/7vknlUWftUcdAdUhuV8Kpf4Odouo
 YJwsSJMaX7aUea8aRLDrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:86JU1kC3WXE=:FXB3Oftv879nkvLFRthADH
 nIUqzNhzy/L7eKYMzVrAiAkMDJLC8VPT3yDVXsiYFE6Uwollh4LJmSPPWUO3SFt4NRn+t7ddc
 9Lu/y4fRou3T4wbpxfCFlabNc+4374NABpVuE16++ehdtdGRJrO4vuP+ikDXCvs+PiwA7BAGc
 3kf4eYNEXmOdoODcZnmas1EzsewPD69SYyJeUQa84XH+7w1GYN3oUGemKUGWKhoCy91UVkz58
 scJmf/qR85z/UfShQ7EG0mNLYDOOD/ZNI+yVF2qqKmXGHnrX9QWuC+6IuD5ESsC0Hv4/7a4ip
 5i496FjxFGKrmHa2i89zDPn/Ucqdn8VIAGJUga3qkIbKBPPj2xiw09gKerrEdcqRR685siuEl
 qwMttGhM4c2X1ao9dRHrq7grzw7qxzVgKc4E70HteBkeWj8LJ9D615oxY0MLZcohYi5aSTZvz
 TdWoBopyVHS27DPBnvzxhTNVvjAhFCE8hfaOwQseCAowx+KLVI7qe65shnAs/cyCAKrZ1zo4E
 CO0jiHzw285W0tc9s29HBncqSUIhJpTC0zWv9uqDxMJ1ye5D/HZRzVd0vXTC2/S/KmHFHk3dx
 i08awqsTjm/ULEr5kTv1NgbkG9oMRiWEKRsxBP/sznf1qlZ5f/eYR/9oGoNA+mP7BMa0P4Uqu
 I0bodfqFjILCd/b+9mkM+bC4g0tmBeUiCoFeO2eEye2QFgqActM4C5c9jodFFuWPhXB4bw8t6
 jTfZTssurTBxjoqt9Ty6MN7rPmGXfygPU5+zFA+dnMezHiYiX48wSDABKnzCHuOLAbetI/ioc
 gceLR4mh+z6sxB87NshOYjS1SXxg0d2LLR8/xBQJPEbadxFnEpA+4GnkWP8Afk7zoWiOt22YN
 eitV0tV6WGhmh+pfOmCA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/10 =E4=B8=8B=E5=8D=8811:39, Nikolay Borisov wrote:
>
>
> On 10.12.20 =D0=B3. 8:38 =D1=87., Qu Wenruo wrote:
>> For subpage case, grab_extent_buffer_from_page() can't really get an
>> extent buffer just from btrfs_subpage.
>>
>> Although we have btrfs_subpage::tree_block_bitmap, which can be used to
>> grab the bytenr of an existing extent buffer, and can then go radix tre=
e
>> search to grab that existing eb.
>>
>> However we are still doing radix tree insert check in
>> alloc_extent_buffer(), thus we don't really need to do the extra hassle=
,
>> just let alloc_extent_buffer() to handle existing eb in radix tree.
>>
>> So for grab_extent_buffer_from_page(), just always return NULL for
>> subpage case.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/extent_io.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 51dd7ec3c2b3..b99bd0402130 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5278,10 +5278,19 @@ struct extent_buffer *alloc_test_extent_buffer(=
struct btrfs_fs_info *fs_info,
>>   }
>>   #endif
>>
>> -static struct extent_buffer *grab_extent_buffer_from_page(struct page =
*page)
>> +static struct extent_buffer *grab_extent_buffer_from_page(
>> +		struct btrfs_fs_info *fs_info, struct page *page)
>>   {
>>   	struct extent_buffer *exists;
>>
>> +	/*
>> +	 * For subpage case, we completely rely on radix tree to ensure we
>> +	 * don't try to insert two eb for the same bytenr.
>> +	 * So here we alwasy return NULL and just continue.
>> +	 */
>> +	if (fs_info->sectorsize < PAGE_SIZE)
>> +		return NULL;
>> +
>
> Instead of hiding this in the function, just open-code it in the only ca=
ller. It would look like:
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b99bd0402130..440dab207944 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5370,8 +5370,9 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>                  }
>
>                  spin_lock(&mapping->private_lock);
> -               exists =3D grab_extent_buffer_from_page(fs_info, p);
> -               if (exists) {
> +               if (fs_info->sectorsize =3D=3D PAGE_SIZE &&
> +                   (exists =3D grab_extent_buffer_from_page(fs_info, p)=
));
> +               {
>                          spin_unlock(&mapping->private_lock);
>                          unlock_page(p);
>                          put_page(p);
>
>
> Admittedly that exist =3D ... in the if condition is a bit of an anti-pa=
ttern but given it's used in only 1 place
> and makes the flow of code more linear I'd say it's a win. But would lik=
e to hear David's opinion.

Personally speaking, the (exists =3D=3D *) inside the condition really loo=
ks
ugly and hard to grasp.

And since grab_extent_buffer_from_page() is only called once, the
generated code shouldn't be that much different anyway as the compiler
would mostly just inline it.

So I still prefer the current code, not to mention it also provides
extra space for the comment.

Thanks,
Qu
>
>>   	/* Page not yet attached to an extent buffer */
>>   	if (!PagePrivate(page))
>>   		return NULL;
>> @@ -5361,7 +5370,7 @@ struct extent_buffer *alloc_extent_buffer(struct =
btrfs_fs_info *fs_info,
>>   		}
>>
>>   		spin_lock(&mapping->private_lock);
>> -		exists =3D grab_extent_buffer_from_page(p);
>> +		exists =3D grab_extent_buffer_from_page(fs_info, p);
>>   		if (exists) {
>>   			spin_unlock(&mapping->private_lock);
>>   			unlock_page(p);
>>
