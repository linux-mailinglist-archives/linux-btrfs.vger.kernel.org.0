Return-Path: <linux-btrfs+bounces-14512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29EFACF987
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD216FE9A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 22:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1527FB1C;
	Thu,  5 Jun 2025 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l0AXc5GN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C17720D4F9;
	Thu,  5 Jun 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749161408; cv=none; b=uTxuzZ/VWYSKFup7wI/vPIQQnrhX4tOGgztqxwd2/3o22AKxK1T4ek06ctTM8EjwRNjNYljZC/qNllIJvLy4Fdq1fB0xT0m9mI7EjZNG57uxzVhS8D//WmM/zlVcc6LGtqp6ir0VrD+03mbJ8m/822vmzQjHomLDVv+terfTjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749161408; c=relaxed/simple;
	bh=01DHrbsbfqzEN+JO6nMGP0dhkq5zQsr7FMS4NM5IPZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZKOWLHihDomudwOZEAjFUYbbAYHFW9wS1cCbGI6vLjxrKTBSz5Lyv4hPidgCaiVk2CShQhq2eqkkOeWiFEin0zm4qEr0oFDgwjFLnfL/NdGs3p/9xSq2YAzPjDbfXI0diFd2P3POOPedd1PvWCFa4Qg6cxNDQg7xmFVgn3PKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=l0AXc5GN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749161401; x=1749766201; i=quwenruo.btrfs@gmx.com;
	bh=0TU4HnyPR1GIstRt9DcbiC91bgpPFAbdtsDJr0jCKy4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l0AXc5GNKsB4C2WKYK2NORYArKoiwvEoh58a600JPFDIi+aIcWP41WVxuxLJ8MHR
	 PjaSrkbfQY0EGi/5QuvfQKzTlk8Zaa4GaAFA43Vu+kDBr1f0q2wFcxOnxkb+hkmiV
	 AXs14H6qntjJ7JoMWV0fUnGHYPg0/2R1ruMnKQVkEWBPrwSm5qP49GEg1ILp44N9I
	 EfiuCrEuTfFy7FWXdmkLDLDH0PZwHkFO+ceUucrEwZmcyDvGF4plttgICaj6bXhWm
	 b5WR0cfQMIJzD92SLWAODl6bBrYNegky+9PayPfZwc259vLee/SmsGBRvzoTUVGsO
	 UzLvUzNXPIIsZiwLBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqaxU-1v9qw41YLQ-00kdUI; Fri, 06
 Jun 2025 00:10:00 +0200
Message-ID: <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>
Date: Fri, 6 Jun 2025 07:39:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test failure
 properly
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250604235524.26356-1-wqu@suse.com>
 <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pFaXEGKuOnJyjswuBmje5x2c5UucdBc9KNytEz7RfTD+SEdgkLX
 LKFjpMDq7nyPQcKuenDFaM1ZUkostlI2wvAIMDvvVskwxiqFcltw2didxYcbMVLoVjHerE/
 bSfRmEh6A+NBITCj/w2HGe0+RD9+vGBIVWs8Rf5h6/OB+O1XLMwfYwutaQVHn4Tscv1R7Aq
 4wVYAU2EA+8AzHA88cOHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3WzDT+Ra+b8=;BwFJiVPxRm1wXlT8pg1T7gw1l/k
 /AtNKzzMIiROfJNNIifYivFhfOnAzZFWjtNl3YZc9nRu8o/YjD0rnMky/86cbnF+xkRSLwpM0
 oi1pzgcNGuQA0ehnGe+MCgLCvqjtuJzUtufgJPSznK9Gh759Bv2Fr13eV3ELl9JTT3lx0c2o6
 xPVuDCSLCcwCj7pMjIZbRbHf+ZUvqNp6Nf8LMa5nbcBWZe8joLKWG40WsW7HjOhxlGj2DmQXL
 kT5UNlLnd9TzItsbWI45QLvlv2bTyFmwe7uegYw6l2uiIN2BUXeJ9wAHH8KpJv7FrqFOOIAKc
 uddJjfGgYWyl4lVcdP/CfZVtJTW49pQxENfQNwjxFCJcf38CKyNYMjsOgZfQwAWrzn+LmRK5H
 1lvQbADFWnR110K5r6dWoHqd0LWRiRfeTCbLMP2eKC1FaabGdC2smfM/nVH50nL2V0bnNf3IH
 XvEftNejKfMgquGUtxTckaKPKXRxFZca+9KDYBPaME6MqETPx2PfqGoiv3vFBrUZD4pWzsd6/
 yX0awDiw7sBZpNxIUAvKeBuBFBX1pqehKccm5CaS8GmwG9+Wgfb0IYbiLapmsqmvc+SnJ9SXE
 4p3R+whRxcMiYziK4pmtE/+A/C6QvA8GqTQEKC9ft6yJeYKZQBQ2xL9ZzRvy7R/deISllMkjg
 3gfzM5pX9B/lIitcRMhpJWIkuQ+IkIRPg4i8HAJds7GQ/5xeYqxB39PhntT3IF92yIvBb8WZi
 q0+1sMNwCxGK2+f2C7ZU6HEKf6smpEUrPkvaCiWUa0QWT/9nj7x4aEvff8xOiP5SenrQJ5mm/
 Sm4TdST4Y5mttmh8XsGvNVldP+ijw1dI8vPQ2niemhuwyQWWRB50IWvWYduQHDK//cI/L+6Yq
 GVDymz9Zn30+YCtnXnbKFl/jK9fZJPJTvhdoJ45sKxX8Tz7slsDgqBQuHZf2ezjYLuIsG8z1V
 +JZKH11l1a4CSNhl3MU6/tlYJbvSUinz9bG81W10LQIFfwxSzsK/eau2Vtopjww0E/iouZ7Rl
 1XB+XFG6OiuGbshF+oHbVBeFzm8jUG7LQF0/JKh9UkLteC5/ZEiFhovI1HZZn8tx0G9gxk+Z2
 t2bUsCoCIDNJqPaYWCq7A62XKINO8hV7AmKeEiWGEqM31eHcecA0B5oEKmZvc09kpCMUdgfx2
 AmJEcYUsMrs8Nr9DfS7CIFUpnBwU/aISn5E+TAo9n2F51H6DKlBcLDAOPPFibBXghL7oj/snI
 /1kGOctohx65jtSFJ8QCgNZ4P1ytbQil68+YKbqMR0rPLa5HN1IE6PRYY2CJCPGmpG76jxiye
 Oo+zf7XesOcMVHMTbTzBPbgJXA9qTYB/PLa4kmvDt8D0QMb9nB2GdHmKmMGPXCi0GLbEIjqNZ
 FQCcxVXJW2jIET6JyyxFtezAFa6tRGEbokOK4rBhfDxNqarwVJWo1+NIWPpz6IFkWjdZcOyV3
 AJo7UKWa3wG74DM7inH7vaHMxSzxs0D1wcOblgbtRsXEhsBHYi0fPvxWuY6rj13EwUbOiJefg
 8SfDHptF3NPAaynTqQhVQtn9DaAERSnGUBPedVe+GJtOpZcVLqc5HHIQ0aTQDQbXzUVpnWyHx
 nh1bzrQksDM0N/42Q64hznuNng72pJ7XOT+hjqcoW4feAE5epw26tmC9+iKq9Qiid0fLSTLeZ
 xoLnZrkvjFPQvn9IDLdRowlkW08x+kRFFHQRrCI5NApjbzL75JAPSSQcdSLrYd9sb0uo4FpBP
 kTXoh/JKNwnVBZqw868JIX9Uh5Z1SQ8bmejySa53HKO5hK3vkEHIR9MR8AJC7LAas3wOxW6QC
 n1nIQuui3INnlj7KDUginwxlDJ5LRu6thIbyMdziW4C+dUfePwGKsnNIh5hJ8wrH5c7C+YEci
 4gaHVawEtBcW8U1VZrctBwT4yOKfW4hX4Qv+Y+83fUGwylyWY0wOl2RWHe9Hi8anrnwp/2T10
 8L7+yNcZzPMDgtOcBxZGkbsUqe1JGcOWQfm/0IO2/s14JHCMeav5C6pF+0Oxjbq98F5JPatwB
 Se8tKqRnG+282WJRHsBGagPlWl3KZXvuBUdaacDrm1k7SKCT44znG1OpkNCj2fAPA8Qaww7i6
 mazZJt+wTPMf/SzPUE12B755cFMWLbe1g97QFD3aHvt1t2CKUeLNEw/w/AmEHXZNcEK38pvbk
 xrqHjpktRJg5LQRPw/Cja+lTDXyNuDxxGH7CwSGz9KmmYo3DOwBikt5BSOs3Mx55ohj0RO1dv
 8alIqao+8NMh6PmcISXsTG9uoGuaHOn0pFk1mxsP9Ef+7pj1NT/egczc+6cCohQy6cuR7RmLC
 VrTyY8U0IWDUC+l8WdxTLl7UzlCigTPVubqrP2dI0AUwsPsPdSYN7M9RSqJU8j4S02OFE338z
 8t2w2aIyDdXouVSM6DPSwynqm/SD17MkU+wk7hkYoLvIf5pQXM7FNMD/FYTqcLcUYvOTOVtCX
 mSE0DxeZWrNhMDDGixKXd2EHA5JiFl3g8ytEFD03fIUFa2nu4g4VAWF27/jdXjS6cA5Pr2Ta2
 s6JaklzR9hhMugXIw7jHOJVoNpqi6YqWR4PSRzTWYsvlhhzW1GLkt0EtsT2hn5ErPwluv+HLl
 QkJTLxZEoYLzdLF5ioEXPdLxTgNgSHTQN+7JAIHrXihJShUpWcjDR6ZGTbhLBEd3P06A7mBsh
 2scqD4RUlbtJSAed4phQsSMtR1COvu4KG30I89NtDLPyw7rCCj+peZYhCKV3yssbl+YulHC0J
 SngnBaSp8RHXt2NHctRa3q3Op/B8rJLc3xESNaD+QdMHkLZ8qYGg8uZ5ghxlafIVOYC3k6xrI
 sZTZmm9KrMe98M+tlH5fNldB2r9nm679cH0S41g2NcCicDpxa9IW/OtiL8buzU1+1jKtt5zlS
 wZ3maUgxWr0Y/bJLVtvPxJgIGPh9EMUPgZByJuVI8kHtV0Ml6sHkEYNI+WjTkU5owyXZ3sF/6
 oRZqdMPKQSig5BQseaIYrWbNWA5VerUIwOGw8X7A3ol7iDYyUdFx+SIbnSPfSJzKa1w7Z73VQ
 AJgRjebBaYlCEThmuEDYDCc/rHT+P9nGE5V2qMIi+r+iJz8C0tD/aj6czZE6HsNaEvXgagObO
 AIINGrLpP2xWIr/xXnIck/b0VJun1/TaltRvohxum4fno4I6+LMQ865fDr/CW6V6Ijuj0CkjD
 ri6lIQ2W4hqgsTA+/u1Zo6kb1zhvncQPzTmQuV9eWbvJoyqHGdxbh0f1zdFc9Wn6363UVvEKk
 Nx5PrywJNC9loKgaJ7I+x2HxNKyMnTLDvYrIRg==



=E5=9C=A8 2025/6/6 02:40, Zorro Lang =E5=86=99=E9=81=93:
> On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
>> [BUG]
>> When I was tinkering the bdev open holder parameter, it caused a bug
>> that it no longer rejects mounting the underlying device of a
>> device-mapper.
>>
>> And the test case properly detects the regression:
>>
>> generic/741 1s ... umount: /mnt/test: target is busy.
>> _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsi=
stent
>> (see /home/adam/xfstests/results//generic/741.full for details)
>> Trying to repair broken TEST_DEV file system
>> _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inc=
onsistent
>> (see /home/adam/xfstests/results//generic/741.full for details)
>> - output mismatch (see /home/adam/xfstests/results//generic/741.out.bad=
)
>>      --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
>>      +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09=
:18:03.675049206 +0930
>>      @@ -1,3 +1,2 @@
>>       QA output created by 741
>>      -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount p=
oint busy
>>      -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount p=
oint busy
>>      +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam=
/xfstests/results//generic/741.out.bad'  to see the entire diff)
>>
>> The problem is, all later test will fail, because the $SCRATCH_DEV is
>> still mounted at $extra_mnt:
>>
>>   TEST_DEV=3D/dev/mapper/test-test is mounted but not on TEST_DIR=3D/mn=
t/test - aborting
>>   Already mounted result:
>>   /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
>>
>> [CAUSE]
>> The test case itself is doing two expected-to-fail mounts, but the
>> cleanup function is only doing unmount once, if the mount succeeded
>> unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
>>
>> [ENHANCEMENT]
>> To avoid screwing up later test cases, do the $extra_mnt cleanup twice
>> to handle the unexpected mount success.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/generic/741 | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/generic/741 b/tests/generic/741
>> index cac7045e..c15dc434 100755
>> --- a/tests/generic/741
>> +++ b/tests/generic/741
>> @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
>>   # Override the default cleanup function.
>>   _cleanup()
>>   {
>> +	# If by somehow the fs mounted the underlying device (twice), we have
>> +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
>> +	# unmounted for fsck.
>> +	_unmount $extra_mnt &> /dev/null
>=20
> Hmm... I'm not sure a "double" (even treble) umount is good solution for
> temporary "Device or resource busy" after umount. Many other cases might
> hit this problem sometimes.
> Maybe we can have a helper to do a certain umount which make sure the fs
> is truely umounted before returning :)

This is not about the umount after EBUSY.

The problem is, the test case itself is expecting two mounts to fail.
But if the mount succeeded, it will mount twice and need to be unmounted=
=20
twice.

It's to make the cleanup to match the test case's worst scenario.

Thanks,
Qu

>=20
> Thanks,
> Zorro
>=20
>>   	_unmount $extra_mnt &> /dev/null
>>   	rm -rf $extra_mnt
>>   	_unmount_flakey
>> --=20
>> 2.49.0
>>
>>
>=20
>=20


