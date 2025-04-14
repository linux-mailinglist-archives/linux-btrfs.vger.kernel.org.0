Return-Path: <linux-btrfs+bounces-12973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60CEA87535
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 03:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CB18913E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 01:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECBD17A2FF;
	Mon, 14 Apr 2025 01:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oru4Fq0X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43035288DB
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744593641; cv=none; b=hZvjsKqQyCoF5hRdXGX4mpAjPTMvT+h+KYifk0G3FwgC23HWgt8Isg9Yj/L9iBfHGfMVYhw5iGJKpF3s2ETcmjrkdfH7qXv6+s44BVJpLqFcIO28jfBooU51FeBhPjNG5YIaF9BdlzZf5WwzlCIZED2caDxz41Ch1alk9xA3eA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744593641; c=relaxed/simple;
	bh=UAoz/pzXPf12js6ikwOEWHmWLmCyCrvVDHRFkHknPRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvEhkx7P0NWLKMhiLOPmc3nH37GecZ+vyYOP0rJ+CBDbB7ZeujZZTsHoTDbozv88sDF9DHYvE9DeDp7WzXrxUzE4cV0+99d+LGNmMWjNuc58wYIxBTvea3Lly8k3or/QQRlfLpevannORYckhSGP0nnnmuXqVl+raSExfdJb6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oru4Fq0X; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744593636; x=1745198436; i=quwenruo.btrfs@gmx.com;
	bh=12RveJkRY90WHXXSn0ObgOwvNxUgG8ljt9eulIrgGmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oru4Fq0XsFVDghZASkjBtdV08vPBu0Nt/pt52eC4JfsLhHKsbV9hDFm3gGTeujWH
	 UzlZ6F5Tvs5WcLJ9y0eHFz8GrzHQAa53stkFn06WE+FEBHax6gWrFHldQKU8/AAOJ
	 kFE6vW62vxMDMaLdrWLjtcbDRgbUqkE2IHFM6nXtwKOzs8hADzz2nJHMQ+ibaW4eC
	 wFiUtD3cUxgRyuOLTU+tG1oHdT/tW9C+LauHc+hFpI3QJ2mu9+b29YhJI4BRUQOEc
	 W2DbC0zxuthty4JujojBjo5K5aImxm1rqcxEfmatLFtcKnJFLbVcdcbiPGOGSoHU2
	 9QSXWpnmQaBOdsLbsQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhlKs-1tQh193dKq-00pjDa; Mon, 14
 Apr 2025 03:20:36 +0200
Message-ID: <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
Date: Mon, 14 Apr 2025 10:50:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1744344865.git.wqu@suse.com>
 <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain>
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
In-Reply-To: <Z_qycnlLXbCgd7uF@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:68YvdLVdHeGrgMlrdruHEXevaFT52qtHsMQ1MKLUSpY4UDwloCo
 Lu5bYcPdATWH3iFzvRxUX3ODoDJIpcPv20Q5ZPxOuzDSGqjKtK5A6T9/23wSbwolTkeUNuC
 /oUFiIXUR+tNbMY9gmEw6qe3belCnCSwqMuiICJla/ip5wn3odrOdJUhNM8xZpy8yE3Nuw1
 tltEkTu95MlYh6GJaYYgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fRx+DxpgqxM=;4iLCqJKACTMSMWYawFvwWBy6UeV
 12O3Lqv+ZU6zllUueepGF4JUbWSV6oUiTe0uNaH5BcgfkiOcCM0k8C2SjaDUgUYY4XIJrG7No
 lnyrRo7mYPEX/97+xprjMcqEnWBga7K1VNRDfzGqrmRguxAVLPvOyiE06/H64GHTgNKoTAIF0
 rXgbXVbdLxrc8udJO2Qhy5aMY0C527xYggIHvYgAk0lE6TEyqx7NXfBygzZo41gonF/6Sit58
 bj0k/50kC3FiNLmu/zVX2J/NrE2mF+r/jbO4Bmp327AlhD27uQmKGaQF/V9DIWjYD6nbeYHuh
 u9E7/NHYQ7TNP6vHTBP8XldlNEzrVZy0xgQHUlTkwrIlpUqGw01wNviUY7fxoAul4BcZAJZEJ
 ly86OFVfTQO+LKJVVHtWxIncf9KxNpmGpMz6p7r8616/ZM4SGFEtQEscgIwgGdPvb9SO14xq2
 XvoeD90t8mdClwRKO39CqkiiaZQmafXunhWBbLx5kMrQpRTIKodiJq7JZ4GcfuwNW5amGxGwp
 AiRqGhDxB7wpW3K2ifPg+LRP9jkapcVEA1fX59pyfIq2zXQc+meYS9VADjfuvvcMFeTO0pp4M
 vgjJyNkWHhRk4Zc3Ns4C8fr51AN4Wq22PmpagHuUsxoooO1ZoJd4GxOoICWXOau4o3HDHHlkm
 DFWJEMsmOtlRM+cezlDKhiTtgR5QCdcZqMe9ROY09R7xf6RXmXvldm40hzdxnDg00SIJSjZhd
 mk43bcWT9htMMoyYcoe+RhouLJFPrgoxN37v/YzTks+xfvM8DVQzpEhzAPM4RYnim/Hry4o8h
 lb1M/feKDc/K14wt8BthrT3o6mhbz1w6XyH9EnOWZ5Ad6R0JBjytAOZMKRIdlPApF+mQlUrN3
 t8SXzfQ24OeCNEOJDvSdi4wAGGOP3nRwQdMGco5ZNbpDD+CedfqiVcE+VtmFXQWbBsLudfgln
 S+OX1f3YeW1KJuWUsSHI/kdqbglFq8fuwvkpus0OiIYobPikVUafhiXQPBXjutxBlXYJE8Hl8
 WttGjdYolsNaxfvRBvqd+HqcAjIpwSA1Z2W5dgq0JpEbETjUXuaVOdwes3mUc1PNy9zNWlSG8
 aFUfXtjeQlxuRvwZt2lGLuLAcigUpPLnIEyZJ/uj+qoub/ijH4PuAar+5y05K/a9mrvhpRX3q
 +yA1Ou3Ge4pCxURYfWCe2kZP+azdMJcD1ZdaJhvTj+qRhDJjgxQu9b0ENc1f1y0UyzP0KS0sz
 dIfumhW4oOScLvLCA8bsa9HGDSTH2vC0P1sxB/Jxjqf/5Fsszsj/PO6grAoTZ1YurDTVzC5ws
 qCf/3VNgQX78fswGaSyeicpVON1dUuonVCytJtwGGAI8jt8nrxz7lndRbg+uHoj56Ijn9LUMu
 0Cd8gGgUpCm1p7ou5kW7tiPcO+Ppid937rJX1UqxxW/UGmYMk0Px+3WPtXDTiT+xhOLyCTaUL
 /M1MKTA==



=E5=9C=A8 2025/4/13 04:05, Andy Shevchenko =E5=86=99=E9=81=93:
> Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:
>> [BUG]
>> For the following fsx -e 1 run, the btrfs still fails the run on 64K
>> page size with 4K fs block size:
>>
>> READ BAD DATA: offset =3D 0x26b3a, size =3D 0xfafa, fname =3D /mnt/btrf=
s/junk
>> OFFSET      GOOD    BAD     RANGE
>> 0x26b3a     0x0000  0x15b4  0x0
>> operation# (mod 256) for the bad data may be 21
>
> [...]
>
>> +static int zero_range_folio(struct btrfs_inode *inode, loff_t from, lo=
ff_t end,
>> +			    u64 orig_start, u64 orig_end,
>> +			    enum btrfs_truncate_where where)
>> +{
>> +	const u32 blocksize =3D inode->root->fs_info->sectorsize;
>> +	struct address_space *mapping =3D inode->vfs_inode.i_mapping;
>> +	struct extent_io_tree *io_tree =3D &inode->io_tree;
>> +	struct extent_state *cached_state =3D NULL;
>> +	struct btrfs_ordered_extent *ordered;
>> +	pgoff_t index =3D (where =3D=3D BTRFS_TRUNCATE_HEAD_BLOCK) ?
>> +			(from >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
>
> You want to use PFN_*() macros from the pfn.h perhaps?
>
>> +	struct folio *folio;
>> +	u64 block_start;
>> +	u64 block_end;
>> +	u64 clamp_start;
>> +	u64 clamp_end;
>> +	int ret =3D 0;
>> +
>> +	/*
>> +	 * The target head/tail block is already block aligned.
>> +	 * If block size >=3D PAGE_SIZE, meaning it's impossible to mmap a
>> +	 * page containing anything other than the target block.
>> +	 */
>> +	if (blocksize >=3D PAGE_SIZE)
>> +		return 0;
>> +again:
>> +	folio =3D filemap_lock_folio(mapping, index);
>> +	/* No folio present. */
>> +	if (IS_ERR(folio))
>> +		return 0;
>> +
>> +	if (!folio_test_uptodate(folio)) {
>> +		ret =3D btrfs_read_folio(NULL, folio);
>> +		folio_lock(folio);
>> +		if (folio->mapping !=3D mapping) {
>> +			folio_unlock(folio);
>> +			folio_put(folio);
>> +			goto again;
>> +		}
>> +		if (!folio_test_uptodate(folio)) {
>> +			ret =3D -EIO;
>> +			goto out_unlock;
>> +		}
>> +	}
>> +	folio_wait_writeback(folio);
>> +
>> +	clamp_start =3D max_t(u64, folio_pos(folio), orig_start);
>> +	clamp_end =3D min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
>> +			  orig_end);
>
> You probably wanted clamp() ?

Thanks a lot for the help!

It's way more readable than the open-coded one.

>
>> +	block_start =3D round_down(clamp_start, block_size);
>> +	block_end =3D round_up(clamp_end + 1, block_size) - 1;
>
> LKP rightfully complains, I believe you want to use ALIGN*() macros inst=
ead.

Personally speaking I really want to explicitly show whether it's
rounding up or down.

And unfortunately the ALIGN() itself doesn't show that (meanwhile the
ALIGN_DOWN() is pretty fine).

Can I just do a forced conversion on the @blocksize to fix the warning?

Thanks,
Qu

>
>> +	lock_extent(io_tree, block_start, block_end, &cached_state);
>> +	ordered =3D btrfs_lookup_ordered_range(inode, block_start, block_end =
+ 1 - block_end);
>> +	if (ordered) {
>> +		unlock_extent(io_tree, block_start, block_end, &cached_state);
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +		btrfs_start_ordered_extent(ordered);
>> +		btrfs_put_ordered_extent(ordered);
>> +		goto again;
>> +	}
>> +	folio_zero_range(folio, clamp_start - folio_pos(folio),
>> +			 clamp_end - clamp_start + 1);
>> +	unlock_extent(io_tree, block_start, block_end, &cached_state);
>> +
>> +out_unlock:
>> +	folio_unlock(folio);
>> +	folio_put(folio);
>> +	return ret;
>> +}
>

