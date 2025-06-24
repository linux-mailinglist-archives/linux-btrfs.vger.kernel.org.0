Return-Path: <linux-btrfs+bounces-14930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D984BAE7103
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 22:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B7A1BC034C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE01257430;
	Tue, 24 Jun 2025 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="s7oNQzo9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0882405E8
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798013; cv=none; b=DTvgdv2K981BZH/H1vGOiaNdFr5sYYOgnDwy9CUBXR6kNWtmZFcgr6M4/D8+Tys5WlKd8PjPgS652nKdEKoWiX1VPm3/QVV1TXsuS1+sc1hvdYZB244JFo0YGMzr65i2jeFiydbWmUNzhZs0SpEJn0/t8vS30m3IADV/9da3rXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798013; c=relaxed/simple;
	bh=8BYx6DYRSZx7EcYxnS/2MYddK6DZJaIb0zwldr1WLRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nChP0iZnhA55vjT+5AMdM1zQIK5yFCMsRiLickW4J3CItVAAqH8+YIQUIyvHeBNcmiRIsDGuEPOovIetolFbO9rer3on6MmxGqqSqF0yNEsZqZxuDlg994EBnOKECLnrK8H/qbBZmZrhAwiQVmxaDdQqYQ4aQ3BL3txmCEDj+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=s7oNQzo9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750798008; x=1751402808; i=quwenruo.btrfs@gmx.com;
	bh=1/P6jmJmB6bzxQRkVRGCHOcs0bgXzvk/xe/5knj0P8s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=s7oNQzo9gVk2QeS+PxNmAgZPtVt8Nq36hScAfZDVXkCAVv/jXFDJbld6W851SrWT
	 RIBQwepWJtQlaAKdtZOac3y3FbDuj2Tf3OwTCuxoaiz7v2yHS4ztrvs+dFHCLupaq
	 lM59JU3dT5hTmdi8y9BiDzKNgpW0/g65hPt6YKasdLCDWUQqkzNhdfLxemq8rLvmi
	 HI5as5rc8Db+/xYoKPWAmlAA7fGLzdSmkBnenDkPRW/ABKiqDnIC5Q2CF5vWc+aRn
	 cKsCzX3BfgawbEfwDVsIDc+1VtvztinlAVosfDC6XaXnEnYIN/C7tRHh/V6KZeMYA
	 mOydpCBpoIorHBlFOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1OXT-1urlzY2ZUh-00rEus; Tue, 24
 Jun 2025 22:46:48 +0200
Message-ID: <50f1f675-6046-49c0-842b-3f469735d25d@gmx.com>
Date: Wed, 25 Jun 2025 06:16:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix a stupid bug masked by CONFIG_BTRFS_DEBUG
To: Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <9b16023e2cb31b509405dd5525bbd5d19a2f384b.1750746917.git.wqu@suse.com>
 <DAUST0RXUM9H.3ORVRVN7V3A4O@wdc.com>
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
In-Reply-To: <DAUST0RXUM9H.3ORVRVN7V3A4O@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o5f3GmUoR4CK/vW2gzahhX4aiOK7sX/Qu0kTXk1EE+cw3kd0sOU
 qXweqgFPX0RDreBfktMYCRrP1GkZeHliyOW+gCIcjBO9XHbVbeFbH+p2cqsk58yJ2XaaL31
 VGM+A4ICYUCV7vOIpKVYJqcLb1/pMIT7sukdvUcxFEhoOSm1In+i3Zbg5N3LhCTyt8Q0OAJ
 phhCbbvTQ5ZFem9h0lD3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o9oL72Pq4tc=;SbEOyXFdyzPFKzwpK+OX4iy3H9t
 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



=E5=9C=A8 2025/6/24 22:59, Naohiro Aota =E5=86=99=E9=81=93:
> On Tue Jun 24, 2025 at 3:35 PM JST, Qu Wenruo wrote:
>> [BUG]
>> Naohiro reported a weird bug that with CONFIG_BTRFS_DEBUG=3Dn and
>> CONFIG_BTRFS_EXPERIMENTAL=3Dy, test case btrfs/005 will crash with the
>> following call trace:
>>
>>   page: refcount:5 mapcount:0 mapping:00000000a5ae9eff index:0x1c pfn:0=
x113658
>>   head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount=
:0
>>   memcg:ffff888116d31280
>>   aops:btrfs_aops [btrfs] ino:101 dentry name(?):"tmp_file"
>>   flags: 0x2ffff800000406c(referenced|uptodate|lru|private|head|node=3D=
0|zone=3D2|lastcpupid=3D0x1ffff)
>>   page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
>>   ------------[ cut here ]------------
>>   kernel BUG at mm/filemap.c:1498!
>>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>   CPU: 9 UID: 0 PID: 264 Comm: kworker/u50:3 Not tainted 6.16.0-rc1-cus=
tom+ #261 PREEMPT(full)
>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/0=
2/2022
>>   Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>>   RIP: 0010:folio_unlock+0x42/0x50
>>   Code: 37 01 78 05 c3 cc cc cc cc 31 f6 e9 38 fb ff ff 48 c7 c6 58 e6 =
45 82 e8 4c 69 05 00 0f 0b 48 c7 c6 b8 f3 47 82 e8 3e 69 05 00 <0f> 0b 90 =
66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
>>   Call Trace:
>>    <TASK>
>>    end_bbio_data_read+0x10d/0x4c0 [btrfs]
>>    ? end_bbio_compressed_read+0x49/0x140 [btrfs]
>>    end_bbio_compressed_read+0x56/0x140 [btrfs]
>>    process_one_work+0x1ff/0x570
>>    worker_thread+0x1cb/0x3a0
>>    ? __pfx_worker_thread+0x10/0x10
>>    kthread+0xff/0x260
>>    ? ret_from_fork+0x1b/0x1b0
>>    ? lock_release+0xdd/0x2e0
>>    ? __pfx_kthread+0x10/0x10
>>    ret_from_fork+0x161/0x1b0
>>    ? __pfx_kthread+0x10/0x10
>>    ret_from_fork_asm+0x1a/0x30
>>    </TASK>
>>
>> [CAUSE]
>> CONFIG_BTRFS_EXPERIMENTAL=3Dy enables the large data folio support for
>> btrfs, as can be seen from the "order: 2" output.
>>
>> On the other hand function btrfs_is_subpage() checks if we need to go
>> through the subpage routine.
>>
>> Meanwhile CONFIG_BTRFS_DEBUG enables another debug-only feature, 2k
>> block size, making BTRFS_MIN_BLOCKSIZE to be 2K.
>>
>> And at compile time if page size is larger than the minimal block size,
>> btrfs_is_subpage() will do the proper check.
>> But if page size is no larger than minimal block size,
>> btrfs_is_subpage() is hard coded to return false as we believe there is
>> no need for subpage support.
>>
>> But CONFIG_BTRFS_EXPERIMENTAL enables large data folio support, and
>> without CONFIG_BTRFS_DEBUG, btrfs_is_subpage() will always return false=
,
>> causing bugs when hitting a large folio.
>>
>> [FIX]
>> Remove the PAGE_SIZE > BTRFS_MIN_BLOCKSIZE checks completely.
>>
>> This fix will be folded into the large data folio enablement patch.
>>
>> Reported-by: Naohiro Aota <Naohiro.Aota@wdc.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/subpage.h | 14 --------------
>>   1 file changed, 14 deletions(-)
>=20
> I did a similar hack (putting "return fs_info->sectorsize <
> folio_size(folio);" to btrfs_is_subpage() in the "#else" branch) and it
> worked well. So, this patch itself seems fine.
>=20
> But, doesn't this mean some code under "btrfs_is_subpage()" condition is
> necessray even on the non-subpage setup? Then, should we promote the
> code to the "normal" case, instead? Sorry if I get the "subpage" concept=
 wrong.

The name "subpage" is no longer proper with larger folios.

The original term "subpage" is there because at that time our target is=20
still page, thus only when block size < page size needs the extra=20
infrastructure to record per-block status.

But with large folios, even if block size =3D=3D page size, we can still=
=20
have a large folio covering multiple pages, and we need the=20
infrastructures to track per-block status inside a large folio.

The more correct term would be "subfolio", but that also implies a folio=
=20
can be larger than a page.

Hopes this would resolve your concern.

Thanks,
Qu

>=20
>>
>> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
>> index 7889a97365f0..453857f6c14d 100644
>> --- a/fs/btrfs/subpage.h
>> +++ b/fs/btrfs/subpage.h
>> @@ -93,7 +93,6 @@ enum btrfs_folio_type {
>>   	BTRFS_SUBPAGE_DATA,
>>   };
>>  =20
>> -#if PAGE_SIZE > BTRFS_MIN_BLOCKSIZE
>>   /*
>>    * Subpage support for metadata is more complex, as we can have dummy=
 extent
>>    * buffers, where folios have no mapping to determine the owning inod=
e.
>> @@ -114,19 +113,6 @@ static inline bool btrfs_is_subpage(const struct b=
trfs_fs_info *fs_info,
>>   		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
>>   	return fs_info->sectorsize < folio_size(folio);
>>   }
>> -#else
>> -static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *f=
s_info)
>> -{
>> -	return false;
>> -}
>> -static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_inf=
o,
>> -				    struct folio *folio)
>> -{
>> -	if (folio->mapping && folio->mapping->host)
>> -		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
>> -	return false;
>> -}
>> -#endif
>>  =20
>>   int btrfs_attach_folio_state(const struct btrfs_fs_info *fs_info,
>>   			     struct folio *folio, enum btrfs_folio_type type);


