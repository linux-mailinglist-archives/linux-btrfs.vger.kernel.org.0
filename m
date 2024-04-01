Return-Path: <linux-btrfs+bounces-3806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06D18938BD
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 09:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858D1281BC4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Apr 2024 07:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488FC121;
	Mon,  1 Apr 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ipqaqqer"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16FBA33;
	Mon,  1 Apr 2024 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711957883; cv=none; b=neqmiPKNIXbRrFfZEjzVemeqQ8p+/v5MAYWdFKtfpaagwzjpH4Zmd6zI7LM9N984rlqRsUlQmyD72RYaRgOtspq7cUhDmw+NWX5wAb6xNNA1tSGqUNEOMor6x54xueOOQFasPGXWAja+wPSjNZp12j1Q7M6letEw2vRsd+GkDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711957883; c=relaxed/simple;
	bh=ckf+XjftQP/yJ20Skj5Sy8pIjyZY/QaifKGYAJUysII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3vEXPrXghx2e/Adznk8JfUruBcBAai1lM7houqvuTTaiusDJc1cjQBXqmi1N3ZsrnnIGcnn8RTdxZTibWzR6psU2p0XIh7HJAVD6MbNyja5hKIJXH8kXvqzX6EL9cJAfrJVum0BD+JeWgSMrIDXLiFOp4mZ6DD+SncRg5nFHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ipqaqqer; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1711957875; x=1712562675; i=quwenruo.btrfs@gmx.com;
	bh=evwqzPPkIDH5dJqX71+aGmXeUV7xpRth2yV02V2h1jU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=IpqaqqerEDtyh9kfJYQvzWb9JFMwGraeKRyJ2gToU7nMpz+gxIhPsbWIOtHueaCj
	 gcuvnlQQXtFcm1rvzmhdWQk+53KHrpnMMqUPjGlc6Nv4jMDJUGvIDsT86FUF43Rkx
	 kgv4XfYXckeD9Kn4L377rmpWUrYYCfl93QmjpgcHUGqRqX5SrZVMKfrMs63WHR9b1
	 k8N+Zv9/MCBzbi1mBKGJzMyyBjCjuHPg3Tl9JlFeGVUTBaxnrpDZtfpPB2w9PTVdr
	 P3orfFD2WCMatdK9Kj+f4CeJ2qJIhovqZ1JHu4SvTVaau8owwcPObAX9LPuYqDDI/
	 Wu+JkFvJwC8RLIkxeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVNB1-1sIJPB2sND-00SNwi; Mon, 01
 Apr 2024 09:51:15 +0200
Message-ID: <0e32055d-f603-4de4-b354-b7a7e016953a@gmx.com>
Date: Mon, 1 Apr 2024 18:21:11 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/btrfs: lookup running processes using pgrep
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <572b5b3f11cc414bd990d1580f8bf287f4797676.1711952124.git.anand.jain@oracle.com>
 <a21b3427-ae9f-42e3-a335-3fcb3c10e081@gmx.com>
 <1c581fa7-f481-48b8-8a55-fed0ea5ed38f@oracle.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <1c581fa7-f481-48b8-8a55-fed0ea5ed38f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nFVRQm/TPIQuXa+3FeHFcjXL4J9dH1XgUWZrdqS8dlpnf5msSyF
 WXgFGRqRfdhUiZoC8NKQlGpYNbIIJp4eLPmVt+RRKkU/k2Bz479g14Y4BYYf7Xjf4bw33sg
 7/0SBEf9kKG6Om8r8oeZL5La0UVOn/GBMB98I61Uco98tkrlD2A4ZKWGdgSeu74hJpsoJNj
 mf6w77jqDKFZXfzW4s9lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kbWSoTKQ12Y=;CuzOK/ZQ6O48mQwGq9GORxif6n7
 GMfjN5nH3kgMhoMHtNbCwi3qIo48CBO/btn+5cXzQO0c9Zxv4uBJJ2kkw9STVF0R0/CE3436+
 tWFF1DF80lTdKG+39IRyvwKoiy0lLE3qhSEoiAzPhbghhtYi4qlPYBcgXXvw7nhuwuLhga1sB
 RJZ8jHFAipAXwKqWq8vEH+W6i8MREGfDeRAtn3PxWLBBn0im1o6Fgk5rYmLQ/IA6ijuh44Xiw
 whMO3lFTGPmiRpeMf7p78WxU/h78Dyd0iOU36tzubn4+JPo0u6et4ppzy8ZTuBM8bfd13j91o
 oURBhmXVoKrEdtfN4EWpdzj3gkPoa+YpnbPiKaO7/EV0rOt4OYDj+QTAmahNCcLO31C/dOpNd
 YeEQDRCN/TgLI9Bcj00HTVu8HulxuxpsRHDwWO7g/wv2JsPcNa1a47uoyIDBflVW9XhvUybl8
 DbZ3VkLT7+oNqW0aV5lWp04wDDlLUt1YRv8IXdPcfwtbV/TyIBo6Q8FUXVr5qLUOvwJ3G5VoP
 jcsMBC/30Wi+2SStft6NuRWjUrNrtdTtLMwVg2sLe1p137WxMWBTvYvX4wG4P95D0PrS8zayW
 FEbb/e7RWjHwQw7BSXp/f804djafMoHxXnMsGVVwgf25klZxX7xvPI4mr4Dzt7uP0dGoL3gfK
 iNG+qXu/4v/yXD2/Z/IHP91yivOzi2Fbsg5CB8Jhl4yfIcVcRDsr5oidg3Qv85j9hVkr9L77L
 JPK9EJ+eaxx/hVR6ajgN8ITcr1md0C49Xbta/1XXeoQc3GXos3baK6+873eeUzIh+9Jlp1a61
 4VLdIZiRZPuvLSwEHcsviZn6WrkughgNKq0/VuRU31zyw=



=E5=9C=A8 2024/4/1 18:10, Anand Jain =E5=86=99=E9=81=93:
>
>
> On 4/1/24 14:21, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/4/1 16:46, Anand Jain =E5=86=99=E9=81=93:
>>> Certain helper functions and the testcase btrfs/132 use the following
>>> script to find running processes:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0while ps aux | grep "balance start" | grep -qv=
 grep; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0<>
>>> =C2=A0=C2=A0=C2=A0=C2=A0done
>>>
>>> Instead, using pgrep is more efficient.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0while pgrep -f "btrfs balance start" > /dev/nu=
ll; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0<>
>>> =C2=A0=C2=A0=C2=A0=C2=A0done
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> Looks good to me.
>>
>> Although there are already several test cases utilizing pgrep, I'm not
>> 100% sure if pgrep would exist for all systems.
>>
>> Shouldn't there be some checks first?
>>
>
>
> Actually, I checked on that and noticed that pgrep comes from
> the same package as ps. So we are fine.
>
>  =C2=A0$ rpm -ql procps-ng | grep -E "bin/pgrep|bin/ps"
>  =C2=A0/usr/bin/pgrep
>  =C2=A0/usr/bin/ps
>
> Thanks, Anand

So I guess busybox based system won't be supported anyway for fstests?

In that case it looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
>
>> Thanks,
>> Qu
>>> ---
>>> =C2=A0 common/btrfs=C2=A0=C2=A0=C2=A0 | 10 +++++-----
>>> =C2=A0 tests/btrfs/132 |=C2=A0 2 +-
>>> =C2=A0 2 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/common/btrfs b/common/btrfs
>>> index 2c086227d8e0..a320b0e41d0d 100644
>>> --- a/common/btrfs
>>> +++ b/common/btrfs
>>> @@ -327,7 +327,7 @@ _btrfs_kill_stress_balance_pid()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill $balance_pid &> /dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait $balance_pid &> /dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for the balance operation to fin=
ish.
>>> -=C2=A0=C2=A0=C2=A0 while ps aux | grep "balance start" | grep -qv gre=
p; do
>>> +=C2=A0=C2=A0=C2=A0 while pgrep -f "btrfs balance start" > /dev/null; =
do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0 }
>>> @@ -381,7 +381,7 @@ _btrfs_kill_stress_scrub_pid()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill $scrub_pid &> /d=
ev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait $scrub_pid &> /d=
ev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for the scrub =
operation to finish.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ps aux | grep "scrub start=
" | grep -qv grep; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while pgrep -f "btrfs scrub star=
t" > /dev/null; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0 }
>>> @@ -415,7 +415,7 @@ _btrfs_kill_stress_defrag_pid()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill $defrag_pid &> /=
dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait $defrag_pid &> /=
dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for the defrag=
 operation to finish.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ps aux | grep "btrfs files=
ystem defrag" | grep -qv
>>> grep; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while pgrep -f "btrfs filesystem=
 defrag" > /dev/null; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0 }
>>> @@ -444,7 +444,7 @@ _btrfs_kill_stress_remount_compress_pid()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill $remount_pid &> /dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait $remount_pid &> /dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for the remount loop to finish.
>>> -=C2=A0=C2=A0=C2=A0 while ps aux | grep "mount.*${btrfs_mnt}" | grep -=
qv grep; do
>>> +=C2=A0=C2=A0=C2=A0 while pgrep -f "mount.*${btrfs_mnt}" > /dev/null; =
do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0 }
>>> @@ -507,7 +507,7 @@ _btrfs_kill_stress_replace_pid()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kill $replace_pid &> =
/dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait $replace_pid &> =
/dev/null
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Wait for the replac=
e operation to finish.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while ps aux | grep "replace sta=
rt" | grep -qv grep; do
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while pgrep -f "btrfs replace st=
art" > /dev/null; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 done
>>> =C2=A0 }
>>> diff --git a/tests/btrfs/132 b/tests/btrfs/132
>>> index f50420f51181..b48395c1884f 100755
>>> --- a/tests/btrfs/132
>>> +++ b/tests/btrfs/132
>>> @@ -70,7 +70,7 @@ kill $pids
>>> =C2=A0 wait
>>>
>>> =C2=A0 # Wait all writers really exits
>>> -while ps aux | grep "$SCRATCH_MNT" | grep -qv grep; do
>>> +while pgrep -f "$SCRATCH_MNT" > /dev/null; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 1
>>> =C2=A0 done
>>>
>

