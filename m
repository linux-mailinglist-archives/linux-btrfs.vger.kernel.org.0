Return-Path: <linux-btrfs+bounces-15617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A4B0CE72
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 01:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A6E1AA41DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 23:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C397A248F48;
	Mon, 21 Jul 2025 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gVOesVwM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A122417C5
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753142116; cv=none; b=W9L9tVwYmGhakSf6fO3uLmeH9R7aDIqrcsnLSnMqksK4dLSlDc7Z+ftAf/WoDZ5oHtfiY+xHGEvm94D/aP8ADuwKsoKyAkzvmc0LwLcaPZ111MmY/nfhW8b9JLZYYhqguJ50AgyAvGGPB8dcq0YKIL5EsTRmevq3e3Qblyxx3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753142116; c=relaxed/simple;
	bh=/yThrY/tC9X8GhF0tzBGzxfP4+3RXtWGslBvw9lZXYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdL1nHy0j6FB1amt8xODIc7AgxIKfedVNOr3Ueqsjltiyyt9UzTwCEFGPrxZWsqnNtiOc/uU4mnq5QM8vpLtZZKs9N5OBMJfXvEhobOqHIxOWAl+E/hxg1TxG3QjjNs5DvRSD7I8Y5Qk4Fae/p26NhZSAxMpWVCvUMHFV0QGJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gVOesVwM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753142108; x=1753746908; i=quwenruo.btrfs@gmx.com;
	bh=IMPbcPxqgQVDC0Q8bUCm2Hf2DXCBLYzfzrZdt4fNu/k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gVOesVwMSiu9wbRZ6PFpOQ9ycmIS0UJPcG/8FHzTfGxQbozlwBPcPyFT672rhEgM
	 lIO5IC8uDT+Tnrp8RV+2ZszbHF3Gd7cd5mOGfoZ4m5bxhzTsW/Sz+P8lqUzmko2/q
	 yFQS0IOnXP23hrd2qpeF5Z6WKBkKh/CRNPCXXpAtPEGmIcgwJmq5iVktTBlT4eZha
	 aTFKkAe/U9S8QkmrAFq6pm6l4tEyeySzCjJ4VxC5HVRdYCsRbn4UgWLSoTn8txGDm
	 PiMBUEV0j42r6H/FhNpv7Y8m2LCT0I4HAt2Q0Y6HD64LP/WF2/9nXllUXI8Yae9u0
	 fbAsqeCOfwMGMKFCYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVeMA-1uCTaJ1bBk-00PV1j; Tue, 22
 Jul 2025 01:55:07 +0200
Message-ID: <e18e85f6-da0b-4e7a-82b5-3e66035c2858@gmx.com>
Date: Tue, 22 Jul 2025 09:25:04 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove unnecessary xa lock for
 btrfs_free_dummy_fs_info()
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <a7028fb9bc67996dd7c1c547e66ffbbea8485183.1752879168.git.wqu@suse.com>
 <20250721153918.GB87532@zen.localdomain>
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
In-Reply-To: <20250721153918.GB87532@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fNFa6zaWvoEtbY/41yT10z0UsS32j1+SsnIy9MErcY6DDySrKUH
 DQtxaQjX/qmTHZy9m7dSSpdqF5w34w2hMIHm/HzNc5TUkQQ+sr/LWO5/NHLzdM19+Bd2BK6
 U2NVf1zOt1pj11hkgP5EHEqaHt22oiuEfOSCPPARXjVH/lzofGr96naic5ZAjcbT3fAbukd
 vEVa6ZbpZPygRJZwz6zsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KB5KGbGXaxI=;e12aahWHL+U1HafDxcr6oM+aUaK
 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



=E5=9C=A8 2025/7/22 01:09, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Jul 19, 2025 at 08:27:34AM +0930, Qu Wenruo wrote:
>> xa_for_each() is utilizing xa_for_each_range(), which in turns calls
>> xa_find() and xa_find_after(), both are already taking RCU lock
>> internally.
>>
>> Although RCU lock is not enough if there is a concurrent entry adding,
>> but for btrfs_free_dummy_fs_info() there won't be any concurrent entry
>> adding at all, thus we are safe to remove the xa lock.
>=20
> Do you have an argument for why the eb is not being protected by RCU as
> we discussed on Leo's patches?
>=20
> We take the eb->refs_lock in free_extent_buffer() here in the loop in a
> pretty similar pattern to the non test code.
>=20
> Intuitively, I would argue having the test code more closely mirror the
> real code feels valuable, even if you can prove that there is no race
> possible with how this is called from the test code.

You're right, and this patch is just before/around the time you pointed=20
out the rcu usage in extent buffers.

So please discard the patch.

Thanks,
Qu

>=20
> Thanks,
> Boris
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/tests/btrfs-tests.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.=
c
>> index b576897d71cc..e4cd3970e893 100644
>> --- a/fs/btrfs/tests/btrfs-tests.c
>> +++ b/fs/btrfs/tests/btrfs-tests.c
>> @@ -169,13 +169,8 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info=
 *fs_info)
>>  =20
>>   	test_mnt->mnt_sb->s_fs_info =3D NULL;
>>  =20
>> -	xa_lock_irq(&fs_info->buffer_tree);
>> -	xa_for_each(&fs_info->buffer_tree, index, eb) {
>> -		xa_unlock_irq(&fs_info->buffer_tree);
>> +	xa_for_each(&fs_info->buffer_tree, index, eb)
>>   		free_extent_buffer(eb);
>> -		xa_lock_irq(&fs_info->buffer_tree);
>> -	}
>> -	xa_unlock_irq(&fs_info->buffer_tree);
>>  =20
>>   	btrfs_mapping_tree_free(fs_info);
>>   	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
>> --=20
>> 2.50.0
>>
>=20



