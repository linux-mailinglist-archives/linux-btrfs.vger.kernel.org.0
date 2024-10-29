Return-Path: <linux-btrfs+bounces-9199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F29B4206
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 07:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDF1C216AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 06:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8540E201032;
	Tue, 29 Oct 2024 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GLzN+i3e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33017C96;
	Tue, 29 Oct 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181843; cv=none; b=bjX56l4E2+Q/mwc9LmOcojUm3iSrm87+zN3bh6x4nCryN24eqy0UsKfmjbG1WpGqRF3D/XK4K5NQmXY0OWHOTvi2qELi2HhEB7UF8ysY1G5RP8+4/YCjjQyHmcT7Oux8QmFLnrk+9+UCX3QCRlSlEIWEk/tp+I3fpfSvodHlHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181843; c=relaxed/simple;
	bh=/WbhDooRn6B7Mmh/Sq403i2rtU2+i0tGNo6BKRgAV/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoIJI8gknqTIPoAvgfjZx+aDo2f60psT5xuwgvgLhBAlMM10dgB3rtYWpnh0V0HjeDEsou0/EmtQ8b6SewaWsJBWoJrz8K/bI1mCxnzjG6hjU5xHuOP2L+mvwaQ03KRtABGZmcSf9i0Er0RqrVEedeDIuwx3qR/Wlrgc3SQE7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GLzN+i3e; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730181836; x=1730786636; i=quwenruo.btrfs@gmx.com;
	bh=FSmQaQEaip4BCjwcKPb6Rbi6Sasls+girsN+YI38tao=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GLzN+i3emhs6AnxNyD3f+Sz9bDP63y00OhdJBwehGCRefrQlbyvr2zylv7lba7kh
	 lbjQPq0nHoVZDuJ3ZkTapiFa0lRlsOiFYxAeU4Y7MF/rPLThNOOUVmwa7zea9XuV3
	 qHkyxp5Jlcx8ZB59uVT9rjvoB8Z1rFlCb6Ib46394DDwk8paWIBv8RPfOK4DCQ76B
	 hGZZacT0BqzrZtW6JxR8CGSHbQiazRayXE2vs1cN53WKnqPrd/q+Zotqj/NYGx/SN
	 Ozs/pb7hTBx6Sv4GV2ejyVNZw7Ap1T/ZSS9rtaLQPzC/eqQhQ78t0HucoXGF0oV89
	 q/WhX6FUIbluRPXU7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1tKfl62o35-00NAYA; Tue, 29
 Oct 2024 07:03:56 +0100
Message-ID: <b78d9fe5-f9c9-4235-b748-78153ef28f20@gmx.com>
Date: Tue, 29 Oct 2024 16:33:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/366: add a new test case to verify if
 certain fio load will hang the filesystem
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20241028233525.30973-1-wqu@suse.com>
 <20241029055639.hskowarhtrowgiwe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20241029055639.hskowarhtrowgiwe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cqTCF4Ma84r/sPufqsSpuS09TcbyoU0EAYJCWI0yxUcOcnI/Hbs
 lDsKV/Ik40JZNKe/ddiDx1o2jfzDbMf7K3xH8SMNykL5ALzdL4AVAXPOpwKESTEZKf3SoyQ
 1Wzf+ToxryR7rhsgBOlpvRefjKR0RZd+awCHrcVuBtAhVFdYN+rEPgaN2yKEylZcCFl1nVq
 qIxK+ZZlkFIHDtkSbvIsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oSXCL4Lmc6A=;9HfI2Fu0v41j3mdD+HHLmRNdj6u
 zB+Cgtq0qstpRpBF2aXYvDpJw4unbKEuAfu26texoEFMAxTz/ifkBx9VQx7oa8EeDjCyVJ17j
 HTvwug9G6KBRnWRGEsL8Xb6xoRowU/Q6m1KCCmUguu5druwKFsvIS7QftjEICczPjE4IrdMI2
 QbGIPuI5l6UI5vNMetx5XTqhfub9qZhWVxG4lkLNhWqnHbyxF4ETEwVWDvI7FTc31yv1DgYnn
 rOQ8WqFvjk9NPBWdb36qbWI7wz3nHBrDdIQqtzU8HKcfNNdV1FGONWL7nTzmXCqJUZaGgIz6S
 P0lJlR9AyPafpGnYO5XPWIqvK8oPygGR5wC7oYq841i3/SNUNQKmvPwCyFcSjJpp9uTmrbAkk
 x+7fZU+KHv3b6yt2xN6Me0GWxTtW3yvOXaPPY4sMSPqPRLdEbeUlQ3ZQTtEBQ9OCUW9kggBVG
 dK/JwC6HB3iouAFxNTlyCLL44JA5e0wjXbO8j+SF5bdGyldFWLIGoR1BZ4XENhFgcLRHOC6cK
 dCKJIUJV/EcnYAYjalmEPOJiLMi9f6o5GpxudSYxjI/+Ftx5JHmfXm0EoRbYGORTAILqo1CPn
 ACwo9iytgJN8K5Idee76jeKfBMBqyok96UV4fq0nBB1OpJG3m9Cb3qCOy/tVosgVr4q02IaB4
 GqqQOqKQmKzpYSs+8geDHlhlmjCDVZDCwQ8uGtkVr2nnTp/LkTLq1XEY7BaqRIO5eQFRbSuu1
 26WjVej0kmDQUqMHvhS638GWdEWRh3suoMkuwfnyhtorwFdbD0IRWqeLZZXrlVTwtDHIGYv1O
 b4rLlKEXm20bMfKEZYlLNKAg==



=E5=9C=A8 2024/10/29 16:26, Zorro Lang =E5=86=99=E9=81=93:
> On Tue, Oct 29, 2024 at 10:05:25AM +1030, Qu Wenruo wrote:
[...]
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick
>                              ^^
>                              rw
>
> I think we can keep the "rw" group as g/095 does.

If that's the only missing part, mind to add that rw group when merging?

The remaining two points may not need modification, explained inlined.

>> +	# Now read is triggered on that folio.
>> +	# Btrfs will need to wait for any existing ordered extents in the fol=
io range,
>> +	# that wait will also trigger writeback if the folio is dirty.
>> +	# That writeback will happen for range [48K, 64K), but since the whol=
e folio
>> +	# is locked for read, writeback will also try to lock the same folio,=
 causing
>> +	# a deadlock.
>> +	$FIO_PROG $fio_config --ignore_error=3D,EIO --output=3D$fio_out
>
> Looks like this test doesn't mix DIO and buffered IO, so this EIO ignori=
ng might not be
> needed.

I'm not sure about the EIO part, but at least job2 and job3 are all
doing writes, one is buffered and the other is direct.
So it's still mixing both.

>
>> +	# umount before checking dmesg in case umount triggers any WARNING or=
 Oops
>> +	_scratch_unmount
>> +
>> +	_check_dmesg _filter_aiodio_dmesg
>
> This test removed mmap test part, so this dmesg filter might not be need=
ed either ?
> If so, don't need to import above "./common/filter" either.

Since it's still mixing buffered and direct IO, I can hit the aiodio
error message just like this:

[91619.077752] BTRFS warning (device dm-2): read-write for sector size
4096 with page size 65536 is experimental
[91619.086204] BTRFS info (device dm-2): checking UUID tree
[91619.473510] Page cache invalidation failure on direct I/O.  Possible
data corruption due to collision with buffered I/O!

So I'm afraid we need the filter too.

Thanks,
Qu

>
> Others looks good to me.
>
> Thanks,
> Zorro
>
>> +
>> +	echo "=3D=3D=3D fio $i/$iterations =3D=3D=3D" >> $seqres.full
>> +	cat $fio_out >> $seqres.full
>> +done
>> +
>> +echo "Silence is golden"
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/366.out b/tests/generic/366.out
>> new file mode 100644
>> index 00000000..1fe90e06
>> --- /dev/null
>> +++ b/tests/generic/366.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 366
>> +Silence is golden
>> --
>> 2.46.0
>>
>>
>
>


