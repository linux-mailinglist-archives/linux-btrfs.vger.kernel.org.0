Return-Path: <linux-btrfs+bounces-9091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16E9AC666
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26396281EA2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD2199384;
	Wed, 23 Oct 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DIfdvxCU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CD145323;
	Wed, 23 Oct 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675683; cv=none; b=BnwSlVdAK6NUxq/fKGaRZzqgvGtvXE4vY8eDueIcU4Pr2ri4pheyMFpJKZUOJpWOM3d8qvnAT2Wowt4xNJMx4Fj+SAvGgFnQPBF27tpM0j+utYCdUiGTF5j8OJeZo5uSmT1K7WevwmJZUVYVky/Y1Af9F+A7EF1Ljn90OAwkrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675683; c=relaxed/simple;
	bh=rlMR3UIfQEaBa2hJRgFDHZ26CyFAJ/oxOOrJQ9z3WhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=geHyqygZU0A2KmFPZi+KHKkzax1m0QqHUA0sat31cNaYXCm51EPE2B27p/x/4nBTkjI+WQGET0i0rn1JmXAVVJlMEM/3KbLPzvLVIug457ouiqS3mWBEH4ViJZzmRsFkLdrjF0IIYU/m2xvQzYCA21i3VKO3eaoiqnR6Akx9ARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DIfdvxCU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1729675674; x=1730280474; i=quwenruo.btrfs@gmx.com;
	bh=rlMR3UIfQEaBa2hJRgFDHZ26CyFAJ/oxOOrJQ9z3WhA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DIfdvxCUlXVIdWLFwY6DGv5vIKI8OdGss84onWoioRBoTBxNoHutgVHEN6mvOy+Z
	 g0i3K67Ng80+Zd9xbJ16M0ibznqB9PNHbiWe7HjrNIshiqPqO8ah6nBkzbcq7OrAZ
	 wpjOAPy/1ibhaJ+t6mBqltgkym0MHSaojHX8pOR61wk2JXVebgvXjA+MnJQLNqtcO
	 0UedvsRxTRXAV9XI7DljDpi8fnzx4EmxgE3xA9OmJT1uqI22BOrUyCIko4v8ao2Ld
	 QFkPQ50a1sCCbaeaWn4bYvCWzGDJnfldIuxwTcdyVvqP54jwIELr30azKZXxdfQZn
	 mvdcPSG0XIunVg2Qtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfYm-1tABV32QFk-0070Fe; Wed, 23
 Oct 2024 11:27:54 +0200
Message-ID: <4265cdf6-b28b-444e-94aa-67f9b051c5f1@gmx.com>
Date: Wed, 23 Oct 2024 19:57:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org, Long An <lan@suse.com>
References: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
 <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
 <8f1acfa5-37f9-4deb-af9e-d2f7576e0c26@gmx.com>
 <20241023041228.d3rkmmci5vnw5ict@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <1a2e7839-09c3-4584-be31-c783f940c41f@oracle.com>
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
In-Reply-To: <1a2e7839-09c3-4584-be31-c783f940c41f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WHzA06wFpnzfdUkWKPT0F8w1K0wi9a8wxABfcd7NoVLLpMzwHgl
 6xNRSM67gZiifO6tFQNUH+cBhxr5dqpwxrwsANNWhEXnHlWj4BjWH7KGNWhoNeTpm7pdJ1L
 4SiMn1UVDpE3hRDo1ZT3ZCxOUIhMx/djgAqHLSZfVG+9Ke5jXgwki54OzCPv1V2d0Y1OQLp
 pNLDPv0ByJyqN5OWYSycw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LNQVVj8BrzY=;3nTlWr4cBes8wWiJpollMHMMpzA
 gwxtuD5dEo3HWBtQCcBRTUjbtlLtpq7y3ZvDdK4KQWkmrTPLCvVIQx64IGhtTFCB7AshYSRjR
 kDyqryc9KOe2BTLjjyEPRE0lpYt3WA9JpTuqhIEuoSCrWGNEDnZ1prHPSTVkvFWEXPcKiJCHd
 hI6CYIrTBk/2F4Y/lr7XgzUue+raVhmtF9sXG9RD6cTn2M+ya7Z2VdtB3dyA8Lmfljolx3KZZ
 U2OwlFpXP9RYEx7FNVQfisj43YuF4GHK/8uVF+/0zaVS3S8a9ThwbaCbjMWk5TkuXWr09pBYP
 1mKGfZ+RlTQswulq5A2AmrOHNCLBDWaT/bVenAk/uiOCpcso9dcJEZiks1Recmd9pYdIIeqEV
 y6jrRDhgzyC5UCIEiYM4nTjsWD/mr0yVQm1ruiLSvLoNOUprezLNYt5dG4U8jmsfm5/mDRixr
 7gaCSg9pJgmTzYM8RDPdEc7+QSp92c+zLyRQgefleQJxnSTMfcD6HchMpVhqUXnCyPZt5yrdG
 xrFT739O1Sk9GyZCjjCtGaR3M46MbEDRHPyRiV2maAU6JTohlsWOUBI4rs2yr1TDENl08uzb0
 dGRYg/MxxHx6Ko2LWF9WhWbhZwHwZit+b0hekKdelkuS/0MgVdMnD8ydwsFHWS63qjYMXPmfL
 KxjyYgkqWEjhPDt6YQj1e0Me3+3y+crUzKq6Oqf2OrTD49Fo5ArwjbKc0qOazgWz093M0tNEQ
 T77YMBmtPvjVzlicPoGSnh0baeOiSfOeY/XzyYpq3INN3h7jCwSacJ8RCzkLHrcL8S2kQgUGh
 rtmjdocg9soHRe7hw1k4xVldOMb3m8+08dXi4++K4/RRM=



=E5=9C=A8 2024/10/23 19:30, Anand Jain =E5=86=99=E9=81=93:
>
>
> On 23/10/24 12:12, Zorro Lang wrote:
>> On Tue, Oct 22, 2024 at 01:12:15PM +1030, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2024/10/19 08:45, Anand Jain =E5=86=99=E9=81=93:
>>>> On 18/10/24 08:04, Qu Wenruo wrote:
>>>>> [FALSE FAILURE]
>>>>> If SELinux is enabled, the test btrfs/012 will fail due to metadata
>>>>> mismatch:
>>>>>
>>>>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs
>>>>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 localhost 6.4=
.0-150600.23.25-default #1
>>>>> SMP PREEMPT_DYNAMIC Tue Oct=C2=A0 1 10:54:01 UTC 2024 (ea7c56d)
>>>>> MKFS_OPTIONS=C2=A0 -- /dev/loop1
>>>>> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/loop1=
 /
>>>>> mnt/scratch
>>>>>
>>>>> btrfs/012=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch (see=
 /home/adam/xfstests-dev/
>>>>> results//btrfs/012.out.bad)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --- tests/btrfs/012.out=C2=A0=C2=A0=
=C2=A0 2024-10-18 10:15:29.132894338 +1030
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +++ /home/adam/xfstests-dev/results//=
btrfs/012.out.bad
>>>>> 2024-10-18 10:25:51.834819708 +1030
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,6 +1,1390 @@
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 012
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Checking converted btrfs agains=
t the original one:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -OK
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +metadata mismatch in /p0/d2/f4
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +metadata mismatch in /p0/d2/f5
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +metadata and data mismatch in /p0/d2=
/
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +metadata and data mismatch in /p0/
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
>>>>>
>>>>> [CAUSE]
>>>>> All the mismatch happens in the metadata, to be more especific,
>>>>> it's the
>>>>> security xattrs.
>>>>>
>>>>> Although btrfs-convert properly convert all xattrs including the
>>>>> security ones, at mount time we will get new SELinux labels,
>>>>> causing the
>>>>> mismatch between the converted and original fs.
>>>>>
>>>>> [FIX]
>>>>> Override SELINUX_MOUNT_OPTIONS so that we will not touch the securit=
y
>>>>> xattrs, and that should fix the false alert.
>>>>>
>>>>> Reported-by: Long An <lan@suse.com>
>>>>> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1231524
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 tests/btrfs/012 | 5 +++++
>>>>> =C2=A0=C2=A0 1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/tests/btrfs/012 b/tests/btrfs/012
>>>>> index b23e039f4c9f..5811b3b339cb 100755
>>>>> --- a/tests/btrfs/012
>>>>> +++ b/tests/btrfs/012
>>>>> @@ -32,6 +32,11 @@ _require_extra_fs ext4
>>>>> =C2=A0=C2=A0 BASENAME=3D"stressdir"
>>>>> =C2=A0=C2=A0 BLOCK_SIZE=3D`_get_block_size $TEST_DIR`
>>>>> +# Override the SELinux mount options, or it will lead to unexpected
>>>>> +# different security.selinux between the original and converted fs,
>>>>> +# causing false metadata mismatch during fssum.
>>>>> +export SELINUX_MOUNT_OPTIONS=3D""
>>>>> +
>>>>
>>>> SELINUX_MOUNT_OPTIONS is set only when SELinux is enabled on the
>>>> system,
>>>> so disabling SELinux will suffice.
>>>
>>> Are you suggesting to disable SELinux just to pass the test case?
>>>
>>> Then it doesn't sound correct to me at all.
>>>
>>> It should be the test case to adapt to all kinds of systems, not the
>>> other way.
>>
>> Hi Anand, I think Qu is right, it's not worth disable the whole SELinux
>> (at the beginning of fstests running), just for a single test case.
>> I just hope to make sure btrfs forks agree this's a failure which shoul=
d
>> be fixed in test side, but not change the selinux config for btrfs-prog=
s.
>> If you're sure about it, I'll merge this patch :)
>>
>
> Yes, I realized that a bit later.
>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
>
>
> Even if we create _require_selinux() and _reset_selinux_mount_options(),
> there are only a few consumers, such as btrfs/075 and generic/700 for
> the former, and btrfs/008, btrfs/019, and generic/700 for the latter.
> Do you think it is better?

I think the current way of overriding SELINUX_MOUNT_OPTIONS is good enough=
.
There aren't that many test cases bothering xattr that carefully (except
those fssums ones).

Thanks,
Qu
>
> Thx, Anand
>
>
>> Thanks,
>> Zorro
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> -------
>>>> fstests/common/config:
>>>> if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : ${SELINUX_MOUNT_O=
PTIONS:=3D"-o context=3D$(stat -c %C /)"}
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 export SELINUX_MOUN=
T_OPTIONS
>>>> fi
>>>> ----------
>>>>
>>>> Thanks, Anand
>>>>
>>>>> =C2=A0=C2=A0 # Create & populate an ext4 filesystem
>>>>> =C2=A0=C2=A0 $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqre=
s.full
>>>>> 2>&1 || \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _notrun "Could not create ext4 =
filesystem"
>>>>
>>>>
>>>
>>>
>>
>


