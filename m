Return-Path: <linux-btrfs+bounces-16534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6650B3C616
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 02:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F267BD6EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB8F37160;
	Sat, 30 Aug 2025 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VGGke6J4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1635971
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513073; cv=none; b=MhC6IZSrDXU9SeTjyp5LMadKRfaaSZPEcVHq6qJ2LxKd6ubLorhww2c0XcEkeTWBCCg9eyDL85iGAyolkPpcc99p+dnKegyb9/5XbKkRys0fbiM3XZQzKfUiMIAuqizD1jcVeezfrLyCqkzjBoRnkbS4IDBtZ7CQ6VD4weXzzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513073; c=relaxed/simple;
	bh=K3zexbQmc76qyMHXAIxB+dlh5mh1GZGc7CdAGjvwJE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4MFMvz+QmEuEESdY2vTxksK3jQbecjhgyDQYAO817tHmj9lWk5kJ8WS7nQVYH8AsxMM/Eco0ZMz3+kphTou1wsW0L09mgS2/ZovpZjj26B/tpyGV7BauJnAvQI1+sCn+4Q51z/oNCQvASTwSy2G0WwHjVkxfXcqkpVVkmA+FvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VGGke6J4; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1756513067; x=1757117867; i=quwenruo.btrfs@gmx.com;
	bh=SFB8o+6TAcjPsDIfGXUWGaLxC4Pd1KbdB6Mc3t7zMco=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VGGke6J44y/THjpdrZ0QtNROyi/nwjBxQUB6dRjH7O1g5yOohEtvA02unZXzGpxT
	 ufMvzvMlje8NOyC3hJqITdqgg0TFKrtl6ujQIXCVmmRMWnOyE/LQPyv+vJWiVHdzq
	 OQvas791qPHYDFHOVR9gWVax1KfW6I/0x+lGQw2tlznozaNw7i3qTLvSGUdVfnQeG
	 iJaG6rqPo7Pq+p1fSvyJTF+C1eB/ZYj0N/70p22+mQ5U48ak3y93s0JhV5hzlLEI5
	 jO+Zf+T1LdIuIYRsz9p3QRuzpiwMM0eBsmWkYF+Chr+74wE8+QwU06jQTebjiz9cu
	 i7Ns4dkr2ry1u2C2mw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYNNo-1uvymm2aSg-00YqkN; Sat, 30
 Aug 2025 02:17:47 +0200
Message-ID: <37165ecc-8b33-4459-be5d-1bf486bd9b05@gmx.com>
Date: Sat, 30 Aug 2025 09:47:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix lzo compression level output
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <9182b66aba2db19b939fdd3ceaafb07217210c1a.1756436553.git.wqu@suse.com>
 <20250829233830.GA5333@twin.jikos.cz>
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
In-Reply-To: <20250829233830.GA5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:weEANhttcxQVUG5Bz95jDdMDs8Vf5PrgxbZu60r2lO+kOPxtnTl
 2DVdzLE0EhBIADHiZh/36sx+RO7+tbHd2rFICcAt66XojMenhnZXEFr51XwwZKkh3mEcFJu
 z86KnAOIQMo0eOVZC0CUVXpCEsHZ9OKo4UWoF3AWgV/c+bklRd+ewMiCfapjD0zyOvH5zLJ
 JIZ26NFA3vhL0/KzI4UCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dHhbSss8Vk0=;qqbt7SW0jlRjBr2VGhu6hy9BpnB
 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



=E5=9C=A8 2025/8/30 09:08, David Sterba =E5=86=99=E9=81=93:
> On Fri, Aug 29, 2025 at 12:32:34PM +0930, Qu Wenruo wrote:
>> [BUG]
>> Since commit "btrfs: accept and ignore compression level for lzo", we
>> will always set the lzo compress level to the default one.
>>
>> This makes test case btrfs/220 fail with the following messages:
>>
>>   FSTYP         -- btrfs
>>   PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc3-custom+ #281 SMP PR=
EEMPT_DYNAMIC Thu Aug 28 11:15:21 ACST 2025
>>   MKFS_OPTIONS  -- /dev/mapper/test-scratch1
>>   MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>>   btrfs/220 5s ... - output mismatch (see /home/adam/xfstests/results//=
btrfs/220.out.bad)
>>       --- tests/btrfs/220.out	2022-05-11 11:25:30.749999997 +0930
>>       +++ /home/adam/xfstests/results//btrfs/220.out.bad	2025-08-29 12:=
26:54.215307784 +0930
>>       @@ -1,2 +1,8 @@
>>        QA output created by 220
>>       +Unexepcted mount options, checking for 'compress=3Dlzo,relatime,=
space_cache=3Dv2,ssd,subvol=3D/,subvolid=3D5' in 'rw,relatime,compress=3Dl=
zo:1,ssd,space_cache=3Dv2,subvolid=3D5,subvol=3D/' using 'compress=3Dlzo'
>>       +Unexepcted mount options, checking for 'compress=3Dlzo,relatime,=
space_cache=3Dv2,ssd,subvol=3D/,subvolid=3D5' in 'rw,relatime,compress=3Dl=
zo:1,ssd,space_cache=3Dv2,subvolid=3D5,subvol=3D/' using 'compress=3Dlzo'
>>       +Unexepcted mount options, checking for 'compress=3Dlzo,relatime,=
space_cache=3Dv2,ssd,subvol=3D/,subvolid=3D5' in 'rw,relatime,compress=3Dl=
zo:1,ssd,space_cache=3Dv2,subvolid=3D5,subvol=3D/' using 'compress=3Dlzo'
>>       +Unexepcted mount options, checking for 'compress-force=3Dlzo,rel=
atime,space_cache=3Dv2,ssd,subvol=3D/,subvolid=3D5' in 'rw,relatime,compre=
ss-force=3Dlzo:1,ssd,space_cache=3Dv2,subvolid=3D5,subvol=3D/' using 'comp=
ress-force=3Dlzo'
>>       +Unexepcted mount options, checking for 'compress-force=3Dlzo,rel=
atime,space_cache=3Dv2,ssd,subvol=3D/,subvolid=3D5' in 'rw,relatime,compre=
ss-force=3Dlzo:1,ssd,space_cache=3Dv2,subvolid=3D5,subvol=3D/' using 'comp=
ress-force=3Dlzo'
>>       +Unexepcted mount options, checking for 'compress-force=3Dlzo,rel=
atime,space_cache=3Dv2,ssd,subvol=3D/,subvolid=3D5' in 'rw,relatime,compre=
ss-force=3Dlzo:1,ssd,space_cache=3Dv2,subvolid=3D5,subvol=3D/' using 'comp=
ress-force=3Dlzo'
>>       ...
>>       (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/adam/=
xfstests/results//btrfs/220.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> That commit changes lzo parsing use btrfs_compress_str2level() all time=
.
>> This means even lzo doesn't support compress level, we will still set
>> the default level, which is 1 for lzo.
>>
>> And btrfs_show_options() will use compress_level for every compression
>> algorithm, causing the mount option output change thus the test case
>> failure.
>>
>> [FIX]
>> Just change btrfs_show_options() to skip the compress level for lzo.
>>
>> Please fold this one into the original commit.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>
>=20

Thanks, now folded into the original patch, with minor comment appended.

Thanks,
Qu

