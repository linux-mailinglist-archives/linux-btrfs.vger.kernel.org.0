Return-Path: <linux-btrfs+bounces-10124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 656CA9E8351
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 04:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6ED165AFD
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D7022F11;
	Sun,  8 Dec 2024 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rE4L70Xy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4ABA4B;
	Sun,  8 Dec 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733628640; cv=none; b=Lr5J6QWkISu7Y24eYAHNcYuRewKkjlHffEmzHdyQuLR6TBaQulI5YRknnbNgnZnZpKkHAS+CWWDdrEadhf2AOR2hk49nmF3LNtpMIBFdsRTqPYTA+cdSaoNFAOKLHQ5H9ayS/WHyyWCsG8Yawg3SD9ulC6cw8zB0OZGsLzrAJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733628640; c=relaxed/simple;
	bh=BadLSRYtD5zwR9CRyQl1LtswiCY2ZLlLe1edxtR8doo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5dE2RRr9CA2RqDbGr9KZRcU/+ec0Fyxqx5vuq4nAvt+okBklloCen2pxei6HzunXrDgxovwQYG4o9APcylco5bPbd5VGT92RmVtUYYiQmZHmKNbrRUM8W6X2Cr/8cZvGSCVNTfcB9aWMQ29OsebrgDp2y5TttpQXT3Tkp8YZG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rE4L70Xy; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733628628; x=1734233428; i=quwenruo.btrfs@gmx.com;
	bh=BadLSRYtD5zwR9CRyQl1LtswiCY2ZLlLe1edxtR8doo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rE4L70Xytiuor2jKquEC7ZbRSAoGDIxqtVpdfVA6vttP1hxJOuEZ3tNsHkIL+8G3
	 pPkArncJeyhSRo1wQWK8EMTQlR5TfeQl+2WSxsxwIg2EGvxDPjA9eikntEp1n/6WY
	 280kkyrwxgM+RliNekBCAN5EszuVScYjEwdGPkqltw+G/+SphlTxtgMq7f0Tye7Ea
	 nK33PRqTR7Wl2j1sbCVy7B4UWc5Jo7QO+wfhjpYPBkA06CJxtN2j0mTDsJPlBXzKS
	 Z0yBkdALURfxikjcmufcezzVfahNa+ONrhOitw5vCTGyS7wIl5uMzbiNdT4Z65lWu
	 cEK2J+iaNzjO4mAKOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdebB-1ttBli1pqb-00aVHj; Sun, 08
 Dec 2024 04:30:27 +0100
Message-ID: <2c9c0cfa-d84f-4568-aeed-6489f5ce1c20@gmx.com>
Date: Sun, 8 Dec 2024 14:00:23 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/327: add a test case to verify inline extent data
 read
To: Anand Jain <anand.jain@oracle.com>, Zorro Lang <zlang@redhat.com>,
 Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20241115091926.101742-1-wqu@suse.com>
 <20241129030231.shgqx4ot4vbnht7w@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <2db76e13-443f-44fd-b3a2-3e1076606228@oracle.com>
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
In-Reply-To: <2db76e13-443f-44fd-b3a2-3e1076606228@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NSRjDsgacHKHQ/PAEegFobrebMwP4BASmNlnPxNAgUxSKxOr+1w
 3m9KqEy7IbGDTsn5Oug8X3RbBtn9xKEmFmz7miAtQUmNS1RJiIwm/v0NzNFwL3oSZuBmKv4
 COP/5FLEOSJb5vTrj96BQ6brDU5VwzIYkOcvsHrQzeHvmNwanFyixr1iRsmUXlF2nRJAS1z
 FF/brlVsAcsubDX0RcG0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f5JPKtw9ET0=;QjfnNvYCoaEgiWH0byN9oiKhp7W
 rYO6ThV+Rbeu43yMSstNhot0ZeQvFcna5FVzzc6rQj1qH6qMsQi9SyeyhgQv1L1g8fv0peRq4
 lDt3535ksa+8vCdpmbC9pRv19bwBkr8exKWDvb3sdtZyrK7Kb+ZcKMNosiQnfQnz7zkPop+Ti
 8jp0DwIgwPQzUuA+wJ9uvrJzRzCNAiAe2jO/1Tj63/G6NvKQp3HZAQZrvSvCZLnqfIwaojK6P
 8i02658IjNqj3+XTT2BYgNyR4rWwYBV1JBm5iWL4sGGi8MZZeQ8Oc7RZt2lG2MTYgMymvaMlN
 aNuQqqhfG1OZek7+3oLsUeDjXoAPD6dy94evuTpBTBNMLb4bfCYMhhk0S5W099sfxIEdr5EhR
 5b8uEqSfqtCLpvuRDGO61KoAlYWRz2sQJxcCooEIC8u/dZWlaZe9X/hkzCA2khr3/6XQvuF1H
 lwHcWpZ6SkftePg6opaw0H4rce3HZXSQrM5XJxJS2i+y1HzigEv8WtrrtvL3YOhYNwX20oddt
 LOlggli3OCcJnYFRIB2z41WxExPRsF+K4wvEidNVXaiJToW6K/oPzlmGSLBLs2TRWFNbXA1pj
 Qh3mOalb47X+AsVetgNuqsH3mX+QHxEnR+kIXULMV956GTYq+depk674ncKyD+EYOh4hv67y2
 DYlp8a8F+H6bWKsKKeoB2pCwLNumnkUKWPTzTzIJUMtk8OhHxF0ht/2B7uoHJtAN5v+3cO/xy
 LYgqCuQFscpTSBQp69Dwg5MQ2UklPVWd8DskMYCuEs8s5foe5fs6z6hubJwZ8qqTTyZHUSKF3
 vs53PaYPTVbhcghk5DrZanW5bIy+WVJqyEhZvQtgrOZu98d11RL9fRN2GMNuRqHBpFukuP1nG
 JISPGhUoLZks8FXLPVk29/IQd+Ml6qF75dzvf1ykTRkJ6hWLibINnuYrS49dZKQWROC/dumkK
 73C12GrMNXQqH0pHmQRLqRqetW4JAmMaoYS1E5crB5DE2NpSfJl4/7rQiVJXGTQKongi0X+cc
 nMNEsS+hl9mJFGH3FnTXUvm2D1P8avHdzDihxb8Tant9a+dCTxzNLbEQNysfDtNVma0eV3nUP
 rOStBXP9t/R52qwhsKGtxPF4Dm7CYZ



=E5=9C=A8 2024/12/8 13:43, Anand Jain =E5=86=99=E9=81=93:
> On 29/11/24 08:32, Zorro Lang wrote:
>> On Fri, Nov 15, 2024 at 07:49:26PM +1030, Qu Wenruo wrote:
>>> [BUG]
>>> When developing sector size < page size handling for btrfs, I'm hittin=
g
>>> a data corruption, which is only possible with the following out-of-tr=
ee
>>> patches:
>>>
>>> =C2=A0=C2=A0 btrfs: allow inline data extents creation if sector size =
< page size
>>> =C2=A0=C2=A0 btrfs: allow buffered write to skip full page if it's sec=
tor aligned
>>>
>>> [CAUSE]
>>> Thankfully no upstream kernels are affected, even if some one is
>>> mounting a btrfs created by x86_64 with inlined data extents, they won=
't
>>> hit the corruption.
>>>
>>> The root cause is that when reading inline extents, we zero out the
>>> whole remaining range until folio end.
>>>
>>> This means such zeroing out can cover ranges that is dirtied but not y=
et
>>> written back, thus lead to data corruption.
>>>
>>> This needs all the following conditions to be met:
>>>
>>> - Sector size < page size
>>> =C2=A0=C2=A0 So no x86_64 is affected. The most common users should be=
 Asahi
>>> Linux.
>>> =C2=A0=C2=A0 But they are safe due to the next two conditions.
>>>
>>> - Inline data extents are present
>>> =C2=A0=C2=A0 For sector size < page size cases, we do not allow creati=
ng new
>>> inline
>>> =C2=A0=C2=A0 data extents but only reading it.
>>>
>>> =C2=A0=C2=A0 But even all above cases are met by using a x86_64 create=
d btrfs with
>>> =C2=A0=C2=A0 inlined data extents, the next point will still save us.
>>>
>>> - Partial uptodate folios are allowed
>>> =C2=A0=C2=A0 This requires the out-of-tree patch "btrfs: allow buffere=
d write
>>> to skip
>>> =C2=A0=C2=A0 full page if it's sector aligned", or buffered write will=
 read out
>>> the
>>> =C2=A0=C2=A0 whole folio before dirting any range.
>>>
>>> So end users are completely safe.
>>>
>>> [TEST CASE]
>>> The test case itself is pretty straightforward:
>>>
>>> - Buffered write [0, 4k)
>>> - Drop all page cache
>>> - Buffered write [8k, 12k)
>>> - Verify the file content
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> For anyone who wants to verify the failure, please fetch the following
>>> branch, and reset to commit 4df35fbb829dfbcf64a914e5c8f652d9a3ad5227
>>> ("btrfs: allow inline data extents creation if sector size < page
>>> size").
>>>
>>> =C2=A0 https://github.com/adam900710/linux.git subpage
>>>
>>> The top commit e7338d321bdf48e3b503c40e8eca7d7592709c83
>>> ("btrfs: fix inline data extent reads which zero out the remaining
>>> part") is the fix.
>>> ---
>>> =C2=A0 tests/btrfs/327=C2=A0=C2=A0=C2=A0=C2=A0 | 58 ++++++++++++++++++=
+++++++++++++++++++++++++++
>>> =C2=A0 tests/btrfs/327.out |=C2=A0 2 ++
>>> =C2=A0 2 files changed, 60 insertions(+)
>>> =C2=A0 create mode 100755 tests/btrfs/327
>>> =C2=A0 create mode 100644 tests/btrfs/327.out
>>>
>>> diff --git a/tests/btrfs/327 b/tests/btrfs/327
>>> new file mode 100755
>>> index 00000000..72269fc7
>>> --- /dev/null
>>> +++ b/tests/btrfs/327
>>> @@ -0,0 +1,58 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
>>> +#
>>> +# FS QA Test 327
>>> +#
>>> +# Make sure reading inlined extents doesn't cause any corruption.
>>> +#
>>> +# This is a preventive test case inspired by btrfs/149, which can cau=
se
>>> +# data corruption when the following out-of-tree patches are applied
>>> and
>>> +# the sector size is smaller than page size:
>>> +#
>>> +#=C2=A0 btrfs: allow inline data extents creation if sector size < pa=
ge size
>>> +#=C2=A0 btrfs: allow buffered write to skip full page if it's sector =
aligned
>>> +#
>>> +# Thankfully no upstream kernel is affected.
>>> +
>>> +. ./common/preamble
>>> +_begin_fstest auto quick compress
>>> +
>>> +_require_scratch
>>> +
>>> +# We need 4K sector size support, especially this case can only be
>>> triggered
>>> +# with sector size < page size for now.
>>> +#
>>> +# We do not check the page size and not_run so far, as in the long
>>> term btrfs
>>> +# will support larger folios, then in that future 4K page size
>>> should be enough
>>> +# to trigger the bug.
>>> +_require_btrfs_support_sectorsize 4096
>>> +
>>> +_scratch_mkfs >>$seqres.full 2>&1
>>> +_scratch_mount "-o compress,max_inline=3D4095"
>
> Also, can you please add a comment explaining why max_inline is set to
> pagesize - 1?

It's just to override any possible mount option from the test config.

E.g. if one is running "-o max_inline=3D0" as custom mount option, the
test case will not exercise the inline extent creation part.

There is no special reason to go 4095, just to ensure we can create
inline extent so I use the max reasonable value.

Thanks,
Qu
>
> Thanks, Anand
>
>
>>> +
>>> +# Create one inlined data extent, only when using compression we can
>>> +# create an inlined data extent up to sectorsize.
>>> +# And for sector size < page size cases, we need the out-of-tree patc=
h
>>> +# "btrfs: allow inline data extents creation if sector size < page
>>> size" to
>>> +# create such extent.
>>> +xfs_io -f -c "pwrite 0 4k" "$SCRATCH_MNT/foobar" > /dev/null
>>
>> $XFS_IO_PROG
>>
>>> +
>>> +# Drop the cache, we need to read out the above inlined data extent.
>>> +echo 3 > /proc/sys/vm/drop_caches
>>> +
>>> +# Write into range [8k, 12k), with the out-of-tree patch "btrfs: allo=
w
>>> +# buffered write to skip full page if it's sector aligned", such
>>> write will not
>>> +# trigger the read on the folio.
>>> +xfs_io -f -c "pwrite 8k 4k" "$SCRATCH_MNT/foobar" > /dev/null
>>
>> $XFS_IO_PROG
>>
>>> +
>>> +# Verify the checksum, for the affected devel branch, the read of
>>> inline extent
>>> +# will zero out all the remaining range of the folio, screwing up
>>> the content
>>> +# at [8K, 12k).
>>> +_md5_checksum "$SCRATCH_MNT/foobar"
>>> +
>>> +_scratch_unmount
>>
>> This's not needed if it's not a necessary test step.
>>
>> Others look good to me, if no more review points from btrfs list, I'll
>> merge
>> this patch with above changes.
>>
>> Reviewed-by: Zorro Lang <zlang@redhat.com>
>>
>>> +
>>> +# success, all done
>>> +status=3D0
>>> +exit
>>> diff --git a/tests/btrfs/327.out b/tests/btrfs/327.out
>>> new file mode 100644
>>> index 00000000..aebf8c72
>>> --- /dev/null
>>> +++ b/tests/btrfs/327.out
>>> @@ -0,0 +1,2 @@
>>> +QA output created by 327
>>> +277f3840b275c74d01e979ea9d75ac19
>>> --
>>> 2.46.0
>>>
>>>
>>
>
>


