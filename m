Return-Path: <linux-btrfs+bounces-9233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863729B5A27
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 04:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A651C2191B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 03:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC8196C67;
	Wed, 30 Oct 2024 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b6+0UX+q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71654194C6C;
	Wed, 30 Oct 2024 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730257298; cv=none; b=JB1cFfp5IuHswVElYFyY58OSehfITtRpRX4oL9Ksh33cwBF5/HW8IvBl7SyFwj3uNVo8MwsLrhfu6zNLH6AARbD7cV+Zcu6QngoKgVZj2pfg8vHit+FuIJsoUEt+DSB7vRFLMPYWAuwvX08ofXV3P6Vr92RSsl+NuZ7EX2zg6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730257298; c=relaxed/simple;
	bh=eHKt1ejtyxCeaYuNJSSChn4McHmTlLEYS6+ZFzPkxt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9w9xRiwdIsaYmQkjo0MQ6ayrNk3Nzhkh5eq0JbmPqLY94p7oeXUddpyLMcKbcPMErQqqGys1iExWV4SrstWeZFkGk6ADGXbD/ZbjYp90hBpwUmcRsmjIol0realkGF36E1T1qkXO1xUhnq0qzXPhYEfcx2SRRRsKjLphFeC2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b6+0UX+q; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730257281; x=1730862081; i=quwenruo.btrfs@gmx.com;
	bh=PhRt9JEfCXhfGE49yUgcnbBzA3W7CnN2KqcBK9GAmrE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b6+0UX+qNMTlREeYfbYP/bXLSCagonUcn3o+YD7tZyIXu4gWmwp6gYtlqJXvDj+/
	 vGCj1SYB/fTx0npJrMsN/QfhA9pG8jOrfMVgSSTSbbv2M2MQOHrNkJ0E8JnOxSDcs
	 /P0jcnxbF+t3tNnUh6UYaYxlhpR/8OaSoIIY78OMba+tf1N6OT8eOGxImSiF6sn7W
	 soo1QnAkZSVPdxPJcwCoEw8CfXkrcB4pNoOMyKCsZ9rgxiTACbPoopJ8DFn1wpTPh
	 X9RzntOJor3l1hNw51tmiPgI1ETmh5n35Fj8u/E2zu9oUBbUWHj+jxwzW+IKcB4t8
	 9JBqafJ9qjPcveuyhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MiJV6-1tl7Cw1Wo2-00aFUZ; Wed, 30
 Oct 2024 04:01:20 +0100
Message-ID: <4d0603d4-1503-4e8f-bfe2-ed205b598072@gmx.com>
Date: Wed, 30 Oct 2024 13:31:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: simplify regions mark and keep start unchanged
 in err handling
To: iamhswang@gmail.com, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, wqu@suse.com,
 boris@bur.io, linux-kernel@vger.kernel.org,
 Haisu Wang <haisuwang@tencent.com>
References: <20241025065448.3231672-1-haisuwang@tencent.com>
 <20241025065448.3231672-3-haisuwang@tencent.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20241025065448.3231672-3-haisuwang@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rQxYgu5j4/Q8v5WCsfUd5CEp9ATChV2FKoSHe3FveRZfsjiWZWV
 mYX52ujUmlKxjC3I92EK4P8faLRAJBPNmJADS0JtNmquqGBV133NhnVdVKTL8437hVKPH6s
 T8Q2Hu6TnRkypBid81J5seGBej9Bn8vP1XNW1twsQZ+CyP6QSBMf0tRGn4+dh9kIt+XrIRN
 cKhexgOK5C9nRt3aZ7YgQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Uo+YEF0tym8=;zEN2LPs7DhU5LHxTzhxWUcM9d+x
 Bv9+wt+8aSA3PQ1qBKWfzwAC5p0FSnwuEwapEmiK0oq1yWXBL74woSWyPakp7mD6RV33QQYkG
 0L1wMZOHRaI+wjUpwuU0ULzGqf9jEo1kCk93gR5yydCTATNW5NdpzMtLlb0P3ggUdWz+lg6C9
 VUFOMb7kmDDnX6rVw9u8887qONfLlT/Tv08iFnyIUQeUAy+ND6ZqRCxFU5BiJQKmujlyblqle
 GuKXJPw+fT5BDYs7deIlQJFH3yHUah7Wg+UyBSOa/Sin3Lowsern9b2V+/9dkjSinZUGANwr8
 x8wknaXyduOsGM+4/x7sGVxihqCVU6L5pIt8V6mzPuxQ25SlpJufmzQrebTUkgFRIX6p/H6XT
 Qy8k/upAkXz2rl7qGqFm6ZCY9+KCIFUHg4SlxXdh9L14x6FIFhjCxtpfUnJNKcV6IrjhsrWkd
 SSqKpUhkJhKPyhwEV0HIqYRrMkIsr3Z/mX9XxtHhYgYUBVrq0UUGsLd0EM8zWU0aOHn5MAfY1
 IkCmhfnMbZdMWBBQctfV/5F9bdSn7AHlICgSllUX/RK2DChQf2S+NyYP/Cq8wsmHOmkgu2jhH
 mILdKSMOT/8D24yW8f4I2bpZk4a8UHcsU67UFiS6O07TRj/ikik3i33ZKOvq7m+H42mKlIhda
 TxYJpSGjSMwETS0TlwaXePyPuaj8j1rFjkfrV21GfMq8XJzXjnf7z17sXpC6wnQom9q8x+/zz
 ZBTxIQVw1SaMReEALOSNn7fBowKquKhUlecyd/5wtNOQNelZ6oeyyKhrF04QZlQxIJHD010yr
 UHFpySUSwewnfG4frL3Rgu0AYv2N/hSga9Y3r22Q0WZoE=



=E5=9C=A8 2024/10/25 17:24, iamhswang@gmail.com =E5=86=99=E9=81=93:
> From: Haisu Wang <haisuwang@tencent.com>
>
> Simplify the regions mark by using cur_alloc_size only to present
> the reserved but may failed to alloced extent. Remove the ram_size
> as well since it is always consistent to the cur_alloc_size in the
> context. Advanced the start mark in normal path until extent succeed
> alloced and keep the start unchanged in error handling path.
>
> PASSed the fstest generic/475 test for a hundred times with quota
> enabled. And a modified generic/475 test by removing the sleep time
> for a hundred times. About one tenth of the tests do enter the error
> handling path due to fail to reserve extent.
>

Although this patch is already merged into for-next, it looks like the
next patch will again change the error handling, mostly render the this
one useless:

https://lore.kernel.org/linux-btrfs/2a0925f0264daf90741ed0a7ba7ed4b4888cf7=
78.1728725060.git.wqu@suse.com/

The newer patch will change the error handling to a simpler one, so
instead of 3 regions, there will be only 2.

There will be no change needed from your side, I will update my patches
to solve the conflicts, just in case if you find the error handling is
different in the future.

Thanks,
Qu

> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Haisu Wang <haisuwang@tencent.com>
> ---
>   fs/btrfs/inode.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3646734a7e59..7e67a6d50be2 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1359,7 +1359,6 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   	u64 alloc_hint =3D 0;
>   	u64 orig_start =3D start;
>   	u64 num_bytes;
> -	unsigned long ram_size;
>   	u64 cur_alloc_size =3D 0;
>   	u64 min_alloc_size;
>   	u64 blocksize =3D fs_info->sectorsize;
> @@ -1367,7 +1366,6 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   	struct extent_map *em;
>   	unsigned clear_bits;
>   	unsigned long page_ops;
> -	bool extent_reserved =3D false;
>   	int ret =3D 0;
>
>   	if (btrfs_is_free_space_inode(inode)) {
> @@ -1421,8 +1419,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   		struct btrfs_ordered_extent *ordered;
>   		struct btrfs_file_extent file_extent;
>
> -		cur_alloc_size =3D num_bytes;
> -		ret =3D btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
> +		ret =3D btrfs_reserve_extent(root, num_bytes, num_bytes,
>   					   min_alloc_size, 0, alloc_hint,
>   					   &ins, 1, 1);
>   		if (ret =3D=3D -EAGAIN) {
> @@ -1453,9 +1450,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   		if (ret < 0)
>   			goto out_unlock;
>   		cur_alloc_size =3D ins.offset;
> -		extent_reserved =3D true;
>
> -		ram_size =3D ins.offset;
>   		file_extent.disk_bytenr =3D ins.objectid;
>   		file_extent.disk_num_bytes =3D ins.offset;
>   		file_extent.num_bytes =3D ins.offset;
> @@ -1463,14 +1458,14 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
>   		file_extent.offset =3D 0;
>   		file_extent.compression =3D BTRFS_COMPRESS_NONE;
>
> -		lock_extent(&inode->io_tree, start, start + ram_size - 1,
> +		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
>   			    &cached);
>
>   		em =3D btrfs_create_io_em(inode, start, &file_extent,
>   					BTRFS_ORDERED_REGULAR);
>   		if (IS_ERR(em)) {
>   			unlock_extent(&inode->io_tree, start,
> -				      start + ram_size - 1, &cached);
> +				      start + cur_alloc_size - 1, &cached);
>   			ret =3D PTR_ERR(em);
>   			goto out_reserve;
>   		}
> @@ -1480,7 +1475,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   						     1 << BTRFS_ORDERED_REGULAR);
>   		if (IS_ERR(ordered)) {
>   			unlock_extent(&inode->io_tree, start,
> -				      start + ram_size - 1, &cached);
> +				      start + cur_alloc_size - 1, &cached);
>   			ret =3D PTR_ERR(ordered);
>   			goto out_drop_extent_cache;
>   		}
> @@ -1501,7 +1496,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   			 */
>   			if (ret)
>   				btrfs_drop_extent_map_range(inode, start,
> -							    start + ram_size - 1,
> +							    start + cur_alloc_size - 1,
>   							    false);
>   		}
>   		btrfs_put_ordered_extent(ordered);
> @@ -1519,7 +1514,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   		page_ops =3D (keep_locked ? 0 : PAGE_UNLOCK);
>   		page_ops |=3D PAGE_SET_ORDERED;
>
> -		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
> +		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1=
,
>   					     locked_folio, &cached,
>   					     EXTENT_LOCKED | EXTENT_DELALLOC,
>   					     page_ops);
> @@ -1529,7 +1524,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   			num_bytes -=3D cur_alloc_size;
>   		alloc_hint =3D ins.objectid + ins.offset;
>   		start +=3D cur_alloc_size;
> -		extent_reserved =3D false;
> +		cur_alloc_size =3D 0;
>
>   		/*
>   		 * btrfs_reloc_clone_csums() error, since start is increased
> @@ -1545,7 +1540,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>   	return ret;
>
>   out_drop_extent_cache:
> -	btrfs_drop_extent_map_range(inode, start, start + ram_size - 1, false)=
;
> +	btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size - 1, =
false);
>   out_reserve:
>   	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>   	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
> @@ -1599,13 +1594,12 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
>   	 * to decrement again the data space_info's bytes_may_use counter,
>   	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
>   	 */
> -	if (extent_reserved) {
> +	if (cur_alloc_size) {
>   		extent_clear_unlock_delalloc(inode, start,
>   					     start + cur_alloc_size - 1,
>   					     locked_folio, &cached, clear_bits,
>   					     page_ops);
>   		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
> -		start +=3D cur_alloc_size;
>   	}
>
>   	/*
> @@ -1614,11 +1608,13 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
>   	 * space_info's bytes_may_use counter, reserved in
>   	 * btrfs_check_data_free_space().
>   	 */
> -	if (start < end) {
> +	if (start + cur_alloc_size < end) {
>   		clear_bits |=3D EXTENT_CLEAR_DATA_RESV;
> -		extent_clear_unlock_delalloc(inode, start, end, locked_folio,
> +		extent_clear_unlock_delalloc(inode, start + cur_alloc_size,
> +					     end, locked_folio,
>   					     &cached, clear_bits, page_ops);
> -		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
> +		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
> +				end - start - cur_alloc_size + 1, NULL);
>   	}
>   	return ret;
>   }


