Return-Path: <linux-btrfs+bounces-14448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4719ACDAC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 11:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8090017107D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D300528CF5A;
	Wed,  4 Jun 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Diqu19bU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1F81DAC92;
	Wed,  4 Jun 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028670; cv=none; b=FuPZlgD+cmjdA7/eZyLkcE+yFqLTv5RAflHkEIVp8xuWa5cRdVZmufaK2Qbsu/mSnWBXjcNi4Vt0Ykrrjm0lNPM8rUjt65leDJroFZhbSRXBXUZ1daw/m6u0PCGkPQ75sUX0hOUw86oRy+vedNicjTrBNZSeYRVPcMFXzoLIvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028670; c=relaxed/simple;
	bh=XXRncdG+YtfAK5ScVH2uhclXZOWb+zQ7qSzpQ4EerpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1bWhRr5jv3PVmre1uIkp+HFeaeoto0yFktapO3fw019gZWN2hQ58KdQdmX+upo+NynP7d07EQxH/nMvMcOFEIXaHI0AN3afAJeSnsTgcGnS3elVAIHH1jZ3r9oxXDD5wX47NPJKhmISgHVjk6VbRYXRl5uY8JHVbOLgMbmO4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Diqu19bU; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749028665; x=1749633465; i=quwenruo.btrfs@gmx.com;
	bh=X/4TmdIaAR7+Rr724uXJNxSo65Pnan7vyRfV9AbJI1k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Diqu19bUicJb+sHXwT3hkWoKcJBCR3s90RXSHfnCa3EBwmzb9SUT5sQRpHmwo7Jk
	 FA1KLRasF1zRjhGOae1Lsj4+i2t63JHqBo0R/vGm/bBzLc8UPHbX1cziJ08inpX6I
	 EnoRNhftJ/tCcutdWYGwvaYhyaUT+4YmFcAHT3K6MPMXdDnFYaOOXlkVGwJ9i87Qi
	 6x0fF3a+MKRHAfzH2K7zUfUa9Ho8FPtgU5zvJZwC2JSff7w4mdjckOW9h0HMypD5W
	 xJImKoZLXYgUfyyBUJ6ky+PsGJzZT31dxBaYNUiNcKLCZP20KOfiU/Xbo6UFQ9pCL
	 BwcLRQIqw71qHHCLhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1ubdgE1gyE-00Cx8i; Wed, 04
 Jun 2025 11:17:44 +0200
Message-ID: <76226c51-78c5-4113-a04d-694a50b98557@gmx.com>
Date: Wed, 4 Jun 2025 18:47:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/730: exclude btrfs for now
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250604062509.227462-1-wqu@suse.com>
 <aEAC5WTF_tGh_RpN@infradead.org>
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
In-Reply-To: <aEAC5WTF_tGh_RpN@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:snI0sYA7DTnwRZgT3s82Gtrtil/6rGu6/Ks9aYyda+4Adu08Erk
 RtYpJG4HrlnPYK/1sq60/ey5l5IrjzSQXc0z6K8IZsGSQJBa3yGpWvtPqTb4V7NpNFuMuTs
 88pXhkmM8uY0cTxyKYMQRIqABhTMFNeKtlq2EV8H50uERtBrvLdA2JKKVciBVkO1ztrEMVb
 G6aOZeJ+FwrI2JARmEDfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PalSqhHld6w=;dQZNlVwMUtsLnMqtAZ+Bg2VsG8R
 +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
 J+3w=



=E5=9C=A8 2025/6/4 17:55, Christoph Hellwig =E5=86=99=E9=81=93:
> On Wed, Jun 04, 2025 at 03:55:09PM +0930, Qu Wenruo wrote:
>> - Btrfs doesn't support shutdown callbacks
>>
>> - The current shutdown callbacks are per-fs
>=20
> The callsbacks are per-block device.
>=20
>>    Meanwhile btrfs is a multi-device fs, it needs to know which block
>>    device is triggerring shutdown, and needs to do extra evaluation
>>    (e.g. can the remaining devices support RW operations) before
>>    triggering a full fs shutdown.
>=20
> Exactly for that reason.

Right, the ext4/xfs can go a superblock shutdown because they are single=
=20
device fs (except the external journal device), and fs_holder_ops=20
handles the single device failure by calling back into the super block=20
shutdown call back.

For a multi-device fs, it should go through the blk_holder_ops, which=20
btrfs doesn't provide when opening the devices.

>=20
>> +++ b/tests/generic/730
>> @@ -26,6 +26,10 @@ _require_test
>>   _require_block_device $TEST_DEV
>>   _require_scsi_debug
>>  =20
>> +if [ "$FSTYP" =3D "btrfs" ]; then
>> +	_notrun "btrfs doesn't support per-fs shutdown yet"
>> +fi
>=20
> Please don't add these horrible fs excludes to tests.  Add a helper
> in common to check if something is supported.
Although there is the _require_scratch_shutdown, it's only checking the=20
full fs shutdown ioctl.

I guess it means, if a fs supports per-bdev shutdown, it won't hurt to=20
also provide a full-fs shutdown ioctl?

Thanks,
Qu

