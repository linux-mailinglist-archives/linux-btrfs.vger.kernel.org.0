Return-Path: <linux-btrfs+bounces-12975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DBA87641
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 05:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AAE16DD96
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 03:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF3C1865EB;
	Mon, 14 Apr 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hXGLz45v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1563CF
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744601851; cv=none; b=Avvpm2ROfcswGcoM6netpSEIDcPdKyEwiOUtWswA/FiOiXcL1saP4ThjXBzxSRyJJXvO1me9eg+4aSsWZT39t2MRSPzRqxX/abLX9k/wHNqqSuLqLTgWQ5eG+uvoA4qVtq8zQYMuz2bxtxrWLi1xeL+TKqMb/EleLxU7STie7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744601851; c=relaxed/simple;
	bh=fnIWa/lxjGz+Tc56zT1mb67VxtZyfIjG07CmsrAqCS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0xlf1Hm/kMFessRWVXUHJpwfhyhesmtFBSLKRhbirzso8z1K3Y+JuttzJAfMMFBHUiA/+EuVgaC0TJhJCx/EhR0UbNDcE438X8XH+sA+xcUX60jPgG5JaqVm5m/H2rSFTXb4uofqTqGhC9qeYCzBSM+7yklNp4EhZg3iNwQcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hXGLz45v; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744601846; x=1745206646; i=quwenruo.btrfs@gmx.com;
	bh=fnIWa/lxjGz+Tc56zT1mb67VxtZyfIjG07CmsrAqCS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hXGLz45vLkUsxGxZVUvaPXzkHec6jmp8UaEHR6fJ0N/JuRY4nt9QuXQ2SaVWdI+2
	 13iT8qsE+oWOqGWvLxqIGW7Fa2Ffm49FXU+5R+OUanWZVc/zA2NpgXD5t4SFFgRuM
	 4FbhO7KfyjrQvUeh05WRIqKzF++G+291YItl9IAdXA5uLEwzCHx/cBAyjZoJ1PyHb
	 Jo7Wrq3v72Zp/1twagsA0wPHG30NObyU3S+Bfk/meY00W3cTGDfD+9gxdpqw+sck3
	 DxC56h5agON4frBRmXM0E1KPpUE6VHITzFfiAiRpenOTJs7oiFOOLbnQ1EJCcpHMf
	 tJfM9aJ617L8Z4/IPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MG9gE-1tnjgY00Pk-006MGt; Mon, 14
 Apr 2025 05:37:26 +0200
Message-ID: <d6e721ab-a600-4eea-9436-d043447067ed@gmx.com>
Date: Mon, 14 Apr 2025 13:07:23 +0930
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
 <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
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
In-Reply-To: <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P+0oAiRoZyh+ImPiz/ZuaCVav4qV48lQ8eTMpwbgE7AkvK6MSru
 TvcW9i1A9R9Pds45y6r2GI9XokxnCWPrVVHzx7KQr/Z33VJZ1VxOCswhu9GWVXuv5ZNHHmJ
 exEkoRjVnZUIS0QQMdZ1OBcspGNLsUjeA4fmrp4PbOL24cROomTYPaB/caVQQ2z5PcEOdRf
 EXxXj1ej2LVkqTHC+p5AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XzYrAYUfxYk=;UQmQ5miv7QygNfSNnmyUcNEgIh5
 tVk6b6SoFYFYt4FS75HfbVnzEjfMT8Zjekk4as+p8XCDDTbwchcHYkSzR/jSgDl2DSxuEJIBK
 t5MaE55l2O0VQ3k3f4XkoGwZTa+jsF+jL/8rhv5mde0NGT+NWaWITiKBZPdUDUgHBMwblTlvl
 loY0wDdIu5iNEqtLH+Mri5nFL8ztNBpzTLNZfhIPZlOKzsFlqBjLrfDii6Bin9jWja09K28ti
 akAyBVKsrg1xRVQw7fr9AHA3jr47XYyBslLnrIgmh5q/ThjEpskd9AiV8LfIzr7MQxh3mgX6H
 DfxCMxT4cCsVlfOe7JRaRKgfAhEV8jNjYtKBuUXJ9ZMl81XTe39c4E+OvVKkz46ghtuheS+lF
 F1VIaSBkXcSW9SkYjvGZjoKzWArTH25xoM+j/fghdQvffCSuBhfmlATUY+ZSZxFnM5ZvRDyTz
 SPM77p7UmFZYsht0Ix3854e3EsMligBywH5VMT/o9LlGgg3yHexf2Fky8uxu+zLhm1gzhl6lx
 3PcxpGOCBx/CQ3enSCSyrlQ6opyJsD2E4YKZioTFefKEYV+zy7YynT9whjuHJDo2osojZwZhq
 x4TZ82wn0HdxLlDId3QwQQszYyWfrUa9ucX2U8943UKyxrFh1WMx3PFhaHgg8FKSCOcNGk9s8
 vAepy+3XBLASdtZrHEsNJMb/E16IHSvD+ohI8oE9CQMLNLnTSNMrH5x/M6CYGNtELaKYRJJMJ
 YlaYMvikkH3n4R82eWnWUgokwG5+FrKfzp5jTcoQJW/pXTNf6d8qcwoycMq+PpAA95fD+3VjV
 0nUV6zSmVYTLWrGzqVmvUZZTgwt7ncB/Xa2jwpsiJh19flbLXvYh9MeVjKRlXYu/1kCu8PXgP
 v1HOpMMlpjPjNjbpwvX40XXa1+Y3ly4tEJJoKeKY1cHA//gYCdermInfOJQ5D79lRd05f90B7
 P0hBq3bsgG8fKgRaxivQbBedQdrmQjC9lBjIJzpjfe01dOeh+896EJFUDOcEEYanaTaIlCn3i
 5Ysg//IYBywEJ+9oqp167JKfDwn8ewBrR4X/BvHay6ufwBGxdsbX8YU5Y51H+jskS5EsqcuF6
 /XqmAw4XduU5ZWbCXBUfZOsEsiNSEZKzQ1nUgdKq+yt5Er7Cfp2l1fwnyJzjHw4EVAQVT4qnP
 Gr9R+MJLj7W31aRgclzVf6UrSmgkPC2xO9zELDmrVCDX+4ei0Ejl6I28UIeTX48SezusV0smZ
 2Q/JklcMkELmmtRE9OGxnkcpqXwJkG0fqvzjFHoeMDGINBmYX9k9D1pZkFlOT7lHcgrbLYCas
 YopQ3+EwJvcW1QjEt22Gvkl85jb+6ZYeJFl/WhioewxRZy3GRyqmf94J764f142dKIcNauwE0
 i/qVzTu+WA1urgDJGClQLprvZYtpFHx8/FaE70lsWSpoRI/BVoBa6TBe00dQLyDntVVCpkx2H
 0tDd1YQ==



=E5=9C=A8 2025/4/14 10:50, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2025/4/13 04:05, Andy Shevchenko =E5=86=99=E9=81=93:
>> Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:
>>> [BUG]
>>> For the following fsx -e 1 run, the btrfs still fails the run on 64K
>>> page size with 4K fs block size:
>>>
>>> READ BAD DATA: offset =3D 0x26b3a, size =3D 0xfafa, fname =3D /mnt/btr=
fs/junk
>>> OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GOOD=C2=A0=C2=A0=C2=A0 BAD=C2=A0=
=C2=A0=C2=A0=C2=A0 RANGE
>>> 0x26b3a=C2=A0=C2=A0=C2=A0=C2=A0 0x0000=C2=A0 0x15b4=C2=A0 0x0
>>> operation# (mod 256) for the bad data may be 21
>>
>> [...]
>>
>>> +static int zero_range_folio(struct btrfs_inode *inode, loff_t from,
>>> loff_t end,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 u64 orig_start, u64 orig_end,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum btrfs_truncate_where where)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 const u32 blocksize =3D inode->root->fs_info->sect=
orsize;
>>> +=C2=A0=C2=A0=C2=A0 struct address_space *mapping =3D inode->vfs_inode=
.i_mapping;
>>> +=C2=A0=C2=A0=C2=A0 struct extent_io_tree *io_tree =3D &inode->io_tree=
;
>>> +=C2=A0=C2=A0=C2=A0 struct extent_state *cached_state =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 struct btrfs_ordered_extent *ordered;
>>> +=C2=A0=C2=A0=C2=A0 pgoff_t index =3D (where =3D=3D BTRFS_TRUNCATE_HEA=
D_BLOCK) ?
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (f=
rom >> PAGE_SHIFT) : (end >> PAGE_SHIFT);
>>
>> You want to use PFN_*() macros from the pfn.h perhaps?
>>
>>> +=C2=A0=C2=A0=C2=A0 struct folio *folio;
>>> +=C2=A0=C2=A0=C2=A0 u64 block_start;
>>> +=C2=A0=C2=A0=C2=A0 u64 block_end;
>>> +=C2=A0=C2=A0=C2=A0 u64 clamp_start;
>>> +=C2=A0=C2=A0=C2=A0 u64 clamp_end;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The target head/tail block is already bloc=
k aligned.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If block size >=3D PAGE_SIZE, meaning it's=
 impossible to mmap a
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * page containing anything other than the ta=
rget block.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (blocksize >=3D PAGE_SIZE)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +again:
>>> +=C2=A0=C2=A0=C2=A0 folio =3D filemap_lock_folio(mapping, index);
>>> +=C2=A0=C2=A0=C2=A0 /* No folio present. */
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(folio))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!folio_test_uptodate(folio)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_read_folio(N=
ULL, folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_lock(folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio->mapping !=3D ma=
pping) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
lio_unlock(folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo=
lio_put(folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to again;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!folio_test_uptodate(f=
olio)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D -EIO;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 go=
to out_unlock;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 folio_wait_writeback(folio);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 clamp_start =3D max_t(u64, folio_pos(folio), orig_=
start);
>>> +=C2=A0=C2=A0=C2=A0 clamp_end =3D min_t(u64, folio_pos(folio) + folio_=
size(folio) - 1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 orig_end);
>>
>> You probably wanted clamp() ?
>
> Thanks a lot for the help!
>
> It's way more readable than the open-coded one.
>
>>
>>> +=C2=A0=C2=A0=C2=A0 block_start =3D round_down(clamp_start, block_size=
);
>>> +=C2=A0=C2=A0=C2=A0 block_end =3D round_up(clamp_end + 1, block_size) =
- 1;
>>
>> LKP rightfully complains, I believe you want to use ALIGN*() macros
>> instead.
>
> Personally speaking I really want to explicitly show whether it's
> rounding up or down.
>
> And unfortunately the ALIGN() itself doesn't show that (meanwhile the
> ALIGN_DOWN() is pretty fine).
>
> Can I just do a forced conversion on the @blocksize to fix the warning?

Nevermind, it's a typo, it should be "blocksize" not "block_size", the
latter is a different function defined in blkdev.h.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>>> +=C2=A0=C2=A0=C2=A0 lock_extent(io_tree, block_start, block_end, &cach=
ed_state);
>>> +=C2=A0=C2=A0=C2=A0 ordered =3D btrfs_lookup_ordered_range(inode, bloc=
k_start,
>>> block_end + 1 - block_end);
>>> +=C2=A0=C2=A0=C2=A0 if (ordered) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_extent(io_tree, blo=
ck_start, block_end, &cached_state);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_unlock(folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio_put(folio);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_start_ordered_extent=
(ordered);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_put_ordered_extent(o=
rdered);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto again;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 folio_zero_range(folio, clamp_start - folio_pos(fo=
lio),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 clamp_end - clamp_start + 1);
>>> +=C2=A0=C2=A0=C2=A0 unlock_extent(io_tree, block_start, block_end, &ca=
ched_state);
>>> +
>>> +out_unlock:
>>> +=C2=A0=C2=A0=C2=A0 folio_unlock(folio);
>>> +=C2=A0=C2=A0=C2=A0 folio_put(folio);
>>> +=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>
>


