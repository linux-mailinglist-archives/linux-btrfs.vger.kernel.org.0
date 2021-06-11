Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2B63A3DE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFKISn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 04:18:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:51245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFKISm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 04:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623399401;
        bh=P4PPlIVnIdpO6qOe2/JwERVm+PbJf+0YbQR7DPbj1Xg=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=TvQFt0s8chbaEGIfKeqjyHSpq/5bDuBm413dpsC1FX8XRS1v6/JjDKLvzBXaMYfYs
         lXG4J3DpApMladFDJP6Wvp3oQcl8w98UOXkgPKQnJJqiWNVuyRK6+8Qf/HD5Po44VQ
         PicU6WIvoT1kyaH+Uu7ETuACQv9TYdJIeN1r4KtQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUowb-1lie1x1TSj-00QgP1; Fri, 11
 Jun 2021 10:16:41 +0200
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210611013114.57264-1-wqu@suse.com>
 <20210611013114.57264-9-wqu@suse.com>
 <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 8/9] btrfs: make btrfs_submit_compressed_read() to
 determine stripe boundary at bio allocation time
Message-ID: <3542ce4c-f2ce-c834-6866-eee6c28a967e@gmx.com>
Date:   Fri, 11 Jun 2021 16:16:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB741678D81425B3F3E24DD28D9B349@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iV4Ez1mc5S/E65TMwiHNNNDUOy1s5HmUkvBZu27mT9M1upiM7UX
 R/Og6mzPehdBClRHLzY0SEmH16joqyPwz6ODrS+lZFDqKE0T9rMC+JQXxRamMvbR4TgDBGG
 Y7S7kvBcOHd6GznnLlgM26ea1sVSToEON82bBTw0jK+J1reNB1vhJD7Tyrqh/2cdCDXsXPa
 O74w4JzmZfxVLNQvT/Bzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ck6CEOUFVKU=:OCHSE/d9dvsHAMwGDIlPuH
 5e6WEKnJFmTvDHA5dteKlLjCWYRRhBZF/if8SvAb/4FBuEHr/qTUQesbq6jja8fmiMqb2wqUF
 BEn2S/0A58ARCcnWrXJy1zq8krH4IhGZJWVZXWft2c1X1zW/B1kIfH7mxVBiDpIpGjS0Mn28Q
 nf5AoVSViVISKQiM4POeBLXIV7zugQBzy0iS616qO5MT6ZR2WqS/vPwhsUeEQBkoDe19EAVNs
 e/l70TyDWiHR52WVr4XXanZVKc7BVpq3Lxmh94Vdmn1rQqtkMPvEqjCzTRtqHva5eYAYprGae
 Gm2rvNDFCLCsM35iOoPqYSK/9IUFm8KzfgM6krCyNHmUeE8dfo02j2Teqh9o2DKR6AuNITMAE
 LClu17zJ/8XTdIm2srFdAnc4Y500/RsGdIpmJRayLoinUwY5SJTJUfkE2VpjuD4Q30igCUPnC
 OACP/RqyUj9ZV1VLKlv/idj0PzA3SZmRhiqW/lRtrUeX5wHBzNmMcyT8iw5MMYHuaQ1ZceHoa
 mHXDGiTbRls3guY5EZ1GL/3AHOkw+PKN5nSRJII/zXG++TvrNMLEDvuJ8jc8sLThePSIQuyLx
 HWx3opZc8MF6h5EC6yOBc/e/ahDfeEZfQKz4mWQeyiTL/rhbtb6T+rVB46g8miLkeRTYY+xIZ
 94QYoPeNS14uCtxxO2iq2xRlAX03zBKCoF/PQETnIZk9AUiAJQ3pW75Ul3A+SDEx+i2pW7osd
 6G8UyTfQ7sCwzLIXebslg2Cq/QTZqZEOI8KB0Xf1BzUuViyG04TwsHY+hNAwRyZKyMwU0xkif
 kx8ut7YvNXVF+C4+aie7ds0CS97BFdLGNlEIl5vNOEN5MHYWG2YByilRcNpwaMQeVFFsGhAP2
 hPOMkCfBWdZJm5o4QER7GweYrh+DFAbHw3fquW7I7Ze5ikvKoipZQ/NU60gMkOt602NbigbSY
 EG853HkEi2Qw+ZyW6t8TzFF7JkTQI5jmBfF5+hUMvO0sbDhbSuTYrOGL/S4qVRGVvUrvnsUdy
 8ORQX43RDEAd0r717aELHbBYHJyTZedw+fL/HUrfzKq8U1Ixl9iWIkr6hHD/SxYK2jauze3kS
 PHyUkxKvvBbE24TznSwQeU4BvD49m8z2UjsTYGPlk0PtuCkzrWPWmL23A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/11 =E4=B8=8B=E5=8D=883:49, Johannes Thumshirn wrote:
> On 11/06/2021 03:32, Qu Wenruo wrote:
>> +		/* Allocate new bio if not allocated or already submitted */
>> +		if (!bio) {
>> +			bio =3D alloc_compressed_bio(cb, cur_disk_bytenr,
>> +				bio_op | write_flags,
>> +				end_compressed_bio_write,
>> +				&next_stripe_start);
>> +			if (IS_ERR(bio)) {
>> +				ret =3D errno_to_blk_status(PTR_ERR(bio));
>> +				bio =3D NULL;
>> +				goto finish_cb;
>> +			}
>> +		}
>> +		/*
>> +		 * We should never reach next_stripe_start, as if we reach the
>> +		 * boundary we will submit the bio immediately.
>> +		 */
>> +		ASSERT(cur_disk_bytenr !=3D next_stripe_start);
>> +
>> +		/*
>> +		 * We have various limit on the real read size:
>> +		 * - stripe boundary
>> +		 * - page boundary
>> +		 * - compressed length boundary
>> +		 */
>> +		real_size =3D min_t(u64, U32_MAX,
>> +				  next_stripe_start - cur_disk_bytenr);
>> +		real_size =3D min_t(u64, real_size,
>> +				  PAGE_SIZE - offset_in_page(offset));
>> +		real_size =3D min_t(u64, real_size,
>> +				  compressed_len - offset);
>> +		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
>>
>> -	/* create and submit bios for the compressed pages */
>> -	bytes_left =3D compressed_len;
>> -	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {
>> -		int submit =3D 0;
>> -		int len;
>> +		added =3D bio_add_page(bio, page, real_size,
>> +				     offset_in_page(offset));
>> +		/*
>> +		 * Maximum compressed extent size is 128K, we should never
>> +		 * reach bio size limit.
>> +		 */
>> +		ASSERT(added =3D=3D real_size);
>>
>> -		page =3D compressed_pages[pg_index];
>> -		page->mapping =3D inode->vfs_inode.i_mapping;
>> -		if (bio->bi_iter.bi_size)
>> -			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,
>> -							  0);
>> +		cur_disk_bytenr +=3D added;
>>
>> -		if (pg_index =3D=3D 0 && use_append)
>> -			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);
>> -		else
>> -			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);
>
> I think you still need to distinguish between normal write and zone appe=
nd here,
> as you adding pages to an already created bio.

Oh, my bad, forgot to handle the zoned append differently.

> Adding one page to an empty bio
> will always succeed but when adding more than one page to a zone append =
bio, you
> have to take the device's maximum zone append limit into account, as zon=
e append
> bios can't be split. This is also the reason why we do the device
> lookup/bio_set_dev() for the zone append bios, so bio_add_zone_append_pa=
ge() can
> look at the device's limitations when adding the pages.

Did you mean that for the bio_add_zone_append_page(), it may return less
bytes than we expected?
Even if our compressed write is ensured to be smaller than 128K?

Thanks,
Qu
