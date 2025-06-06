Return-Path: <linux-btrfs+bounces-14522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE636ACFC55
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 08:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E875170AD0
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 06:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2AB24EF88;
	Fri,  6 Jun 2025 06:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DrRhJW8t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747724DD0E;
	Fri,  6 Jun 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749189671; cv=none; b=ijMAvH/kmIl+fxmgvRfiyQKXnV9JpkYrbqWxoLWmRvgVif+Jmckwfv0HNDW/BCJHgTXZ0Ime8yUicMWrtFkuEfXdu+N1C8iC+nF02QONW4Xuba9nfLS+RZq5s98bnx4OkXb1iLxqx9AkK1llOkcYCjqSQSCDR/jhzOz8tx2U8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749189671; c=relaxed/simple;
	bh=jiFF3Itfxy4xCY3odOQIM7SjqWLExZZZml+T9HR3t8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soTCw/NSSDmLKDrGF2xSODAnwT3WcrWA3IOLzc51dCUAfwElGVbir0jM5PQk4fNrHu1hDOQ9iz9mTOu+py4lcqTh/3ZuaaOJtsyu55F+Gk5Cq6rD8fPvTq2fkchgZNCoUmh3DXUjE1gbIv8zSJjvYnx0TFXRfi2U5YNZH7DvPjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=DrRhJW8t; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749189662; x=1749794462; i=quwenruo.btrfs@gmx.com;
	bh=VsvDKFT8kZsAt4DmdzN3tWgY5mr7+SbmF/CLpsCJeUI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DrRhJW8tiEMiKM22wL0WlADmaky+qvZJmw145A8kslJsR8vSmQOGP+W/sUbiJKKe
	 0/njdQROZGlc4jR6qabgfZy7SMl9kxXhFe/9GWCs6Q4rANyFGj1qOKJyT4g2BykSN
	 o8ZiVkFThITGpiH3UerIk/TVNG6jyC0DX9U3lDILKu5/iCr2m7tKOoHttBta21g+D
	 M6eOKfmXSj/E55F6/CtqzcRZh6F2sTZWGug0Ehq9v4Yo1zRG6+4DV6OxRtBnsm3UV
	 R4DpnLVBWjs7vaA/nPcGI5YvoHZTsv6SP2NahV1W6geXUD2WY87YH1G6qQ1nMNt2S
	 sv1lcy6WDsUm74dYOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhQC-1vApNh1sn6-00lk4T; Fri, 06
 Jun 2025 08:01:01 +0200
Message-ID: <c966cbd6-3016-4735-9853-91a75144e429@gmx.com>
Date: Fri, 6 Jun 2025 15:30:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test failure
 properly
To: Zorro Lang <zlang@redhat.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20250604235524.26356-1-wqu@suse.com>
 <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <dbf243a2-ac0e-437c-a308-9832f89ca274@gmx.com>
 <20250606010622.imrfexkypzq5zpm6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250606010622.imrfexkypzq5zpm6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kgz/mtdcCurxIi1MUEJX2QDgP70/AlAtk9FgXjmAZyP5L+iUwxt
 xdZF/tkdx+iS7HuXHXqqo8JQpfWGsWMmpmN/1wQmgtVqTi0IFs6Cl7IQj62BN97BR+PVRn6
 PNpAjLbfktO1MemYVTK7dJyYBS8pvI6zl5RO5KT71aCzyy/m4VRTcBurQBMPzidb9oQMzIU
 h35XyHkS6QhxNVpv++qWA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8iK6+NwBlgk=;P8q2wPFlbiiSNzmJkmh9LhY1bAD
 /7Ky+k5eP3Da5/s5n8DyBX8aRuvpYhrOmSAwXdHOHGXTyTQmx508dXacCBCF4tnL9/b/VPw3P
 72QyH/F9G1+9luf8sdaH5sWYRV3iael3NUyavJiBQriGjxtOlLcyKKuH4tcdVPS933+R+y3ZQ
 bA+tXhYB80zEk+Q28LOcHj+RMkLOsSbCqpO948wY9UkCOzX+DquItVAnHElcu2yHJ53MB4QXz
 Uru4ELa84iPKbM+ec07RgOGJ1IsX+8o7M8IUWEVMfmoxZLyK7hETQGZKqnu1nk5zatArGrQAO
 z9mnqLktZopGyqREovKLn9EdEyXqyPLNCRAUR7OEyWfnelDELLoEc8DVxl55NpAOwDXRos/bM
 lXe1F6mXV2Quxg7Wf9X+F+GUp35IL+fGksfx8yJ8u3DYsrSupelc2CU1UeUfT/696kYiDpD+M
 Fa3Tba1SnqiKGhHybUJ6uje8bK8Dr+QtXdiSx7e92T92NRCi3ElM3RQX3vLD90HJcZro8LcTy
 yQFFGl5K2vF6qetjW/j2CVsteYWXyQhZrHu0Tl5D0eCUvDFup8nb0TS+MOtDC+RvZiZl+RuQh
 00mdGgR49h4uCqx1/Z4OTxgXogHBxESi/JtWtu0h+qKhrIqyq/O+dIltRD/d9ekGvHRRZ/qA0
 6IOX3E7FTYAa11ggi+FuilkoBgNTj3Vxgcndt5js0LXgbaAAuW+jiC/M7fTYs8OOMOJj5EZuj
 am9a1stDWMt8q002AQioZ2tEfvQBX+2LnA7y4YzqzidgVMXttXkQoWuUUo5lCtqpje/5BCcsF
 SPVnN5ZaUTzp/BnNrW7Pc3YtkiCQGCuH8ayqfeWdaZwbwc0W3P9SkQw+/K0mauMd7UD5TtVef
 2j0dLdChnCtdQqLpOqWuWNFSyDAU2P/1CUgutufpZ/nzIwH3kelG76JObZMahJNu8t9s0W00/
 We53uw8ov7goW+qJ9/w58NZgMSv8NcZQ7KfkUudU6VRkvP6McpYYaltrK9HchLbN4RiaXxP9V
 MV+kOYTE2fKGuysR56Retc7RdhrONXxww1lFjqVnWprafHFB6rg37VbXf5vfiHOg1cWsm2x3c
 kwUubr7SaVe4LycbXbC8RPldaZ6np0KfNy1MLqqqSyezDvc5VRZkKCMbgYm1P9ybDflMXe4dD
 M/cHwQZ/OMK7KAw8vVZsrdIZnmQozw5QAAB+wXRjKf2g5/zqiQp1PSjy5WyFOFB0qjAH6VR+R
 qmJvXzPC2BJG0+VGldY1hAcVJVQY4Lr8hSLve1dBfelQd9L79p8Xpa97Ue/HNJtQooTC/cXrM
 IVYfkMZ08nmv3lhyGRsTC67WD2EJnU4Zm0xwshtQw98JM+sjQ7/6WwxAuRZLFys3D75dBbnqo
 ZvR0XUyPQPJEnhwkCzi7lZy1djmmTtJ/Gh0igf3oE7X16iOZnzvkeURZR4SvpsE+wCPZKs+OK
 gW1rBSxCkenbDmfLQgZVZ0UKRCMgm0ucOatSLG1urmquVb7cZGFh7vMF3Iqq9MGWqVz4lEfh+
 9g2B+qUdqIBfuU4XW2xV4lMq0++v4m83Y1lEtxUqmnuMpnN28bRB72sP8mnWlxVBJZZM8q9Gd
 YvJ978K8Ybh6P4d5T6sRS5M22uo/c8OA8dnRnF+afs6+8WZr/YUgMOsVvrzG2/vHs7tn8EAjH
 uHE5P487i+38dH8KA26Pbp+DjmxNK4+zvk+O3nN05pYA==



=E5=9C=A8 2025/6/6 10:36, Zorro Lang =E5=86=99=E9=81=93:
> On Fri, Jun 06, 2025 at 07:39:56AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/6/6 02:40, Zorro Lang =E5=86=99=E9=81=93:
>>> On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
>>>> [BUG]
>>>> When I was tinkering the bdev open holder parameter, it caused a bug
>>>> that it no longer rejects mounting the underlying device of a
>>>> device-mapper.
>>>>
>>>> And the test case properly detects the regression:
>>>>
>>>> generic/741 1s ... umount: /mnt/test: target is busy.
>>>> _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is incon=
sistent
>>>> (see /home/adam/xfstests/results//generic/741.full for details)
>>>> Trying to repair broken TEST_DEV file system
>>>> _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is i=
nconsistent
>>>> (see /home/adam/xfstests/results//generic/741.full for details)
>>>> - output mismatch (see /home/adam/xfstests/results//generic/741.out.b=
ad)
>>>>       --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
>>>>       +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05=
 09:18:03.675049206 +0930
>>>>       @@ -1,3 +1,2 @@
>>>>        QA output created by 741
>>>>       -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or moun=
t point busy
>>>>       -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or moun=
t point busy
>>>>       +rm: cannot remove '/mnt/test/extra_mnt': Device or resource bu=
sy
>>>>       ...
>>>>       (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/a=
dam/xfstests/results//generic/741.out.bad'  to see the entire diff)
>>>>
>>>> The problem is, all later test will fail, because the $SCRATCH_DEV is
>>>> still mounted at $extra_mnt:
>>>>
>>>>    TEST_DEV=3D/dev/mapper/test-test is mounted but not on TEST_DIR=3D=
/mnt/test - aborting
>>>>    Already mounted result:
>>>>    /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
>>>>
>>>> [CAUSE]
>>>> The test case itself is doing two expected-to-fail mounts, but the
>>>> cleanup function is only doing unmount once, if the mount succeeded
>>>> unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
>>>>
>>>> [ENHANCEMENT]
>>>> To avoid screwing up later test cases, do the $extra_mnt cleanup twic=
e
>>>> to handle the unexpected mount success.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    tests/generic/741 | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/tests/generic/741 b/tests/generic/741
>>>> index cac7045e..c15dc434 100755
>>>> --- a/tests/generic/741
>>>> +++ b/tests/generic/741
>>>> @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
>>>>    # Override the default cleanup function.
>>>>    _cleanup()
>>>>    {
>>>> +	# If by somehow the fs mounted the underlying device (twice), we ha=
ve
>>>> +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
>>>> +	# unmounted for fsck.
>>>> +	_unmount $extra_mnt &> /dev/null
>>>
>>> Hmm... I'm not sure a "double" (even treble) umount is good solution f=
or
>>> temporary "Device or resource busy" after umount. Many other cases mig=
ht
>>> hit this problem sometimes.
>>> Maybe we can have a helper to do a certain umount which make sure the =
fs
>>> is truely umounted before returning :)
>>
>> This is not about the umount after EBUSY.
>>
>> The problem is, the test case itself is expecting two mounts to fail.
>> But if the mount succeeded, it will mount twice and need to be unmounte=
d
>> twice.
>>
>> It's to make the cleanup to match the test case's worst scenario.
>=20
> Oh, sorry I didn't get your point. If so, how about _fail the case direc=
tly if
> the first mount (which should be failed) passed, e.g.
>=20
>    diff --git a/tests/generic/741 b/tests/generic/741
>    index cac7045eb..5538b3a1b 100755
>    --- a/tests/generic/741
>    +++ b/tests/generic/741
>    @@ -44,6 +44,9 @@ mkdir -p $extra_mnt
>     # Filters alter the return code of the mount.
>     _mount $SCRATCH_DEV $extra_mnt 2>&1 | \
>                            _filter_testdir_and_scratch | _filter_error_m=
ount
>    +if [ ${PIPESTATUS[0]} -eq 0 ];then
>    +       _fail "Unexpected mount pass"
>    +fi
>=20
> Anyway, I can't say which way is better, both are good to me, depends on=
 your
> choice :)

I thought it was recommended to let the test continue and rely on the=20
golden output to detect errors.

I'm fine either way. This is only triggered because I did cause a=20
regression during my development.

There is no real world hit (yet), so it's not that urgent.

Thanks,
Qu

>=20
> Thanks,
> Zorro
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Zorro
>>>
>>>>    	_unmount $extra_mnt &> /dev/null
>>>>    	rm -rf $extra_mnt
>>>>    	_unmount_flakey
>>>> --=20
>>>> 2.49.0
>>>>
>>>>
>>>
>>>
>>
>=20


