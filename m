Return-Path: <linux-btrfs+bounces-15806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B523EB18B78
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 10:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D566317E251
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Aug 2025 08:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3ED1FF7D7;
	Sat,  2 Aug 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bmiZ8ft8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB1188CC9;
	Sat,  2 Aug 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124631; cv=none; b=thbyPP721xFJQp/LCQHMgcPgm7EgkViMRbvThcpPvEjrACIZUQi/jtnNuaYP+TyiY31ESALrWATqALatcfseIaHO9s9hOJLem6I5ZnVqCmVqD1MsXKz5K5bKifP0ZZUieNqnQgluPHHYS+uyqFCu1ILKkG0TXwLPX5WumGZ3XAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124631; c=relaxed/simple;
	bh=ZtuAx377Y/vTf03dnfArcz3uwXeDUbSfBMxK4TVmKmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVv1ufrKz4oyxg7AIo3BS3DTNrOBMeOwlWyuEzIhA9UqxjL86GGos38cINX84a7d6zXcGDbyRRg4g2BryCxpCOifdqpTPvKNuADM4Nf6u5nb4BahzK2x+x8Zu3Uep5hHriIWNfDxU/qU88DB3WW3vgMudmvWlgeezsq7s8ZllHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bmiZ8ft8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754124623; x=1754729423; i=quwenruo.btrfs@gmx.com;
	bh=FvaoL+ah8aXNGLcgrUShwarwYBvaGKnJ3kv+ZkC3iwM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bmiZ8ft8madeEDj2daqSOCoi2VVbxcRCMBh92Enyx6pFz9UjDQrCW9FmYlYCT9gJ
	 zPIjeEUF7hDseRwVV/dVGeXBsDulzEWXy7mHFdsRvPe3vTFtp8v/aGCNwbk0h+TiI
	 uG03Knw3lHzHl1KFrnQnBv1UZmI/9SrUVFzF8FYvwB+4hbvgPQ6whNbuVwVHXXHl+
	 su4GfsoHuiUBzR85wAtym5O1sX5bmchKMgaK4F853vcnTZNyEWs/J8Tn2VcmNOx2X
	 SHYia0tqkc86QlBhfz7xFZ3+7kdbw0Y8NUUbZA4rTL7P89HmsQIAkuoIwLG7tT1L/
	 vCX4y7Beqlmiula9gA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4s0t-1uhJ840apT-007Mn0; Sat, 02
 Aug 2025 10:50:23 +0200
Message-ID: <88c659f6-b0a6-4ca3-bbc7-8064ec608c32@gmx.com>
Date: Sat, 2 Aug 2025 18:20:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs/282: use timed writes to make sure scrub has
 enough run time
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250711084305.183675-1-wqu@suse.com>
 <aI3LmZVbl5H--QJ8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
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
In-Reply-To: <aI3LmZVbl5H--QJ8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CXOPBELsZnoU0u4xRMxlIbF54caRVObvhGjpde1fgpG2x4QwdJS
 BhuuBZoM1uYOicOISYyF1DsyqWSCVXz8rO50nzKJLW27rWFm6Mh/D/s6k9ZeavqLWFuMDh6
 n+1ATXrZ7+PZQZXl0N7Wn/fVZdZl03ucwBpTjRhQWNh9DGpWilXi6mCAnhRH6LTPA1/ZdQ2
 RyO5Txe7IJ73xh/2q0kpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kp37kAmFlOM=;snZyA4htvWBBFjnhPhFK9rZYxBv
 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
 3tcmklpcDY2JR8bDx/PGwMU=



=E5=9C=A8 2025/8/2 18:12, Ojaswin Mujoo =E5=86=99=E9=81=93:
> On Fri, Jul 11, 2025 at 06:13:05PM +0930, Qu Wenruo wrote:
>> [FAILURE]
>> Test case btrfs/282 still fails on some setup:
>>
>>      output mismatch (see /opt/xfstests/results//btrfs/282.out.bad)
>>      --- tests/btrfs/282.out	2025-06-27 22:00:35.000000000 +0200
>>      +++ /opt/xfstests/results//btrfs/282.out.bad	2025-07-08 20:40:50.0=
42410321 +0200
>>      @@ -1,3 +1,4 @@
>>       QA output created by 282
>>       wrote 2147483648/2147483648 bytes at offset 0
>>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>      +scrub speed 2152038400 Bytes/s is not properly throttled, target =
is 1076019200 Bytes/s
>>      ...
>>      (Run diff -u /opt/xfstests/tests/btrfs/282.out /opt/xfstests/resul=
ts//btrfs/282.out.bad  to see the entire diff)
>>
>> [CAUSE]
>> Checking the full output, it shows the scrub is running too fast:
>>
>> Starting scrub on devid 1
>> scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
>> Scrub started:    Tue Jul  8 20:40:47 2025
>> Status:           finished
>> Duration:         0:00:00 <<<
>> Total to scrub:   2.00GiB
>> Rate:             2.00GiB/s
>> Error summary:    no errors found
>> Starting scrub on devid 1
>> scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
>> Scrub started:    Tue Jul  8 20:40:48 2025
>> Status:           finished
>> Duration:         0:00:01
>> Total to scrub:   2.00GiB
>> Rate:             2.00GiB/s
>> Error summary:    no errors found
>>
>> The original run takes less than 1 seconds, making the scrub rate
>> calculation very unreliable, no wonder the speed limit is not able to
>> properly work.
>>
>> [FIX]
>> Instead of using fixed 2GiB file size, let the test create a filler for
>> 4 seconds with direct IO, this would more or less ensure the scrub will
>> take 4 seconds to run.
>>
>> With 4 seconds as run time, the scrub rate can be calculated more or
>> less reliably.
>>
>> Furthermore since btrfs-progs currently only reports scrub duration in
>> seconds, to prevent problems due to 1 second difference, enlarge the
>> tolerance to +/- 25%, to be extra safe.
>>
>> On my testing VM, the result looks like this:
>>
>> Starting scrub on devid 1
>> scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
>> Scrub started:    Fri Jul 11 09:13:31 2025
>> Status:           finished
>> Duration:         0:00:04
>> Total to scrub:   2.72GiB
>> Rate:             696.62MiB/s
>> Error summary:    no errors found
>> Starting scrub on devid 1
>> scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
>> Scrub started:    Fri Jul 11 09:13:35 2025
>> Status:           finished
>> Duration:         0:00:08
>> Total to scrub:   2.72GiB
>> Rate:             348.31MiB/s
>> Error summary:    no errors found
>>
>> However this exposed a new failure mode, that if the storage is too
>> fast, like the original report, that the initial 4 seconds write can
>> fill the fs and exit early.
>>
>> In that case we have no other solution but skipping the test case.
>=20
> Hi Qu,
>=20
> Thanks for tuning the test, we have also been facing intermittent failur=
es
> on btrfs/282.
>=20
> I was just wondering if for faster devices, would it make sense to use
> the io cgroup controller, eg:
>=20
>    echo "252:0 rbps=3D1048576 wbps=3D1048576" > /sys/fs/cgroup/io_limit/=
io.max
>=20
> To limit the throughput so we have >=3D 4s scrub runs. Or does that also=
 have
> some undesired effects like you mentioned for dm_delay here [1]

If cgroup works, it will be the best solution, we can fix the throughput=
=20
to 512MiB/s, and use a 2GiB file to ensure 4s of scrub runtime.

This will get rid of the speed test part.

The only problem is I'm not familiar with the cgroup infrastructure, if=20
you can enhance the test case to use cgroup, it would be awesome.

Thanks,
Qu

>=20
> Regards,
> Ojaswin
>=20
> [1] https://lore.kernel.org/all/103e1b45-19d9-4438-b70d-892757f695fc@gmx=
.com/
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>=20


