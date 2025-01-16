Return-Path: <linux-btrfs+bounces-10986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CC8A143A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E631D188D7FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 20:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3312419FA;
	Thu, 16 Jan 2025 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fj3mjlLK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA95146A6F
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737060738; cv=none; b=H2D5vbUxhmPphiWHAvnrG+pisXar2HIS1ySUmTIAfkazx47vk94ULjap1jCsU3G5HidnvbPwSjrjjpqo5WKdiSSAUwYx7DpPDnZSr3TAunJsoM1LGgHzUn7XJFl8iUSyqdXS2fHz+t+def9UXkmow5RlKpeXnqiq3w6PUlMxiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737060738; c=relaxed/simple;
	bh=diRAHbsSy0WmI/uZcoIUxeHPpq5fc/XmNsy2dee3mTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghVV1zM8cvWMHdIqrudpdNKbAbS78bFor/f3AqFJrED/MbHGjPgFWKmTZ6n1WsR2/DV6xcS9NB2/QiZgjnM82jTa75+22uK0uqeC0kyxBEhRPRug2luaiOK63bGcRY3BgLFm2qP08EEwFjcNhE07ERLjF5yr0Ex+f9vM7CWlBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fj3mjlLK; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737060733; x=1737665533; i=quwenruo.btrfs@gmx.com;
	bh=1GzdlSfnoj5sfhysBRfRBeDJP3sozKnAQ+TFfuTkcTQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fj3mjlLKRp4sM+/LgimHur4qiYJCkj9LJeDgCewoWDVX/aFgv7fQQrPvMC0b3tDX
	 jInr+5SmMlttCL5+zHnLyjzNuh7mVd7PhEErFxRiWrJffZ58J5LPf0tBP6YVNXoK/
	 GQX5zkH3f+7Tf8TaBVoGDIWZvOmZRI3nfjbdUJ9rGYzWvib/QzgoO40OWHaxJ5zAR
	 xaE/TLF+34r87jrY/2OaLtOqWiGR2DdVTqDr/bDILCNz+68qB9sM6QpYX1ywLDFPw
	 ZgDoXXEc+OcA6rDCThdl9jRs4GCQpZ7tG3QRV6o3FopNiu30FNFevZElcKzZ1wFsr
	 kp2qRKZ3BCaqO+4wnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBDnC-1tgl6Y2uYY-00BwTn; Thu, 16
 Jan 2025 21:52:13 +0100
Message-ID: <46387df4-91d9-426d-8881-e0ae97bd86cf@gmx.com>
Date: Fri, 17 Jan 2025 07:22:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: remove loopback device resolution
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <6094201431aa981c6e0d149b6d528bc4b7a5af91.1737020580.git.wqu@suse.com>
 <20250116114219.GC5777@twin.jikos.cz>
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
In-Reply-To: <20250116114219.GC5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:22XGGJEmOUDy4Cm8fQIIVgPDVCVcZuSuYf7z89irVueSU+Zel1d
 Lrxy9sCNUJGlG/4yHyYrFnRZrGSRqkdByTUGV4xnfy5kTELBS6E/GBGL6bndNHCXYdbqYAE
 cIQ4Bi9mE3U7/Y66tAPdAy+cSk/LIU5JDty2e/3ANthsdcXipjwsgYCUIJtOxWxAPChPUx6
 hRI8QBFSI18D8bdF92s5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Crc3qUwcJH4=;QcszwlDlUsAt/Yd0V2caEnvgmZy
 16PocTNasqcdcMT+7uO13WWEqiPfeu/pB3/uy0Ahu3YzTBixhp8t7BO/iw1fKHhu3cvKFjVHR
 0JG5IBrtWUdarcMPGyvF4TCIHXPPy4ix6AHXHzf08VrwQ7qPxfFMfXa3jhFdq4C87dL5PUgkD
 Z3QRorBObE6CJ7WqiR48WRt8HcP+wivXnWzbRL+gC4egDXoXEgqN/0+JsRflB3RbIK3y73X06
 oXxbWWT/rPwnjekfX9Rzwch/rYH6HGRLJAfDRMA04NzQtcp5NXuDkeneiRA5v4BM3OUNQT79h
 A4obI+/ksqpxWxJzbW8VMt4JRpjGqhgWnzjmGHyZQN6QRYj03kn+IpXSq03wLAX/OGwsdcgSJ
 6wCBdakzLrgZbTc3zb3M9sqjt3ogfjfyxR2m0VnHcrmYdB2StwDnSOjGkAI/SMUPjB6+bNH1z
 erZcpbkq4bxcBE9LZ/xrdblCmDVvW+e2ga6G8knYu0hA11HD/0V6bhst37EZrnCQCx8LFgYXI
 990J4FYkeTL3Mixk+BMTk3aqSSB6AQOzsdP5TqVRMIcfcOWSCKV9pdIDioiFLcmXeorkAUXEN
 bLBpDvmStw207XF680q5dRMeVMZkVQ9pV2RZ8pKeFd9mgNPXcYMh6Wq+7clLMZfvMjXOf0Shm
 OSuzuogPkDIowrlHTC8Y0VdBC5MK4KeRRwU7wZu3iuk8puSunq+n53kbQixeQ9GLgbDBO82IW
 SBrq5T67z9M9OfELYxT13qbPKZ0RiHVSvnrjA1xumQvBvNeNDGT4YQ+8yX/t4vv1dMrCQbi9q
 MLbIqv95f9z/ueKg2c1IxhMkmBMfWIzUrPnQtFmd2ztlsoFMKS2Aa/KI/PDXzlHI5vCWp5plF
 8NTE6/gqME/1CVHYh5b/UpdzdGfdeMuXmTZZiML/xVRIUycWItewUl5QpgDl0uI4fwUQKUwbv
 xaQB/fjKW5Tlu+yy7APKjZi8B3gORquXSUHG3IqbWzVRKka7j9ja2eoR7VF3MBOfVIKl9njUc
 gYABdlTW3O0NXXItVwfazhNC4JWGtG815hJoJWBIg40tvuBhwZqCGzjiBD9gDRiVTOKWMjNaH
 Y7jok7W0PPaUA++Yy2sZk8p0XXwmP8AmlCIi5/A7oJOA6dTKz9nVdG83nYGQ7MuPJhc4T8DIp
 qndzg2AXC+osU9fv5/vWUTCBRR3/Yl/VcG0cNp/IWuQ==



=E5=9C=A8 2025/1/16 22:12, David Sterba =E5=86=99=E9=81=93:
> On Thu, Jan 16, 2025 at 08:13:01PM +1030, Qu Wenruo wrote:
>> [BUG]
>> mkfs.btrfs has a built-in loopback device resolution, to avoid the same
>> file being added to the same fs, using loopback device and the file
>> itself.
>>
>> But it has one big bug:
>>
>> - It doesn't detect partition on loopback devices correctly
>>    The function is_loop_device() only utilize major number to detect a
>>    loopback device.
>>    But partitions on loopback devices doesn't use the same major number
>>    as the loopback device:
>>
>>    NAME            MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINTS
>>    loop0             7:0    0    5G  0 loop
>>    |-loop0p1       259:3    0  128M  0 part
>>    `-loop0p2       259:4    0  4.9G  0 part
>>
>>    Thus `/dev/loop0p1` will not be treated as a loopback device, thus i=
t
>>    will not even resolve the source file.
>>
>>    And this can not even be fixed, as if we do extra "/dev/loop*" based
>>    file lookup, `/dev/loop0p1` and `/dev/loop0p2` will resolve to the
>>    same source file, and refuse to mkfs on two different partitions.
>>
>> [FIX]
>> The loopback file detection is the baby sitting that no one asks for.
>>
>> Just as I explained, it only brings new bugs, and we will never fix all
>> ways that an experienced user can come up with.
>> And I didn't see any other mkfs tool doing such baby sitting.
>>
>> So remove the loopback file resolution, just regular is_same_blk_file()
>> is good enough.
>
> The loop device resolution had some bugs in the past and was added for a
> reason that's not mentioned in the changelogs.
>
> The commits have some details why it's done, they also mention that
> partitioned devices are resolved so it's not that there's no support for
> that.
>
> 0cf3b78f404b01 ("btrfs-progs: Fix partitioned loop devices resolving")
> abdb0ced0123d4 ("Btrfs-progs: fix resolving of loop devices")

The problem of those two fixes are pretty simple, they just do not work
in the first place.

resolve_loop_device() is only triggered if is_loop_dev() returns >0 values=
.

But as I explained, resolve_loop_device() won't return >0 if a
partitioned loopback device is passed.


So why those patches are introduced in the first place?

Thanks,
Qu
> 09559bfe7bcd43 ("multidevice support for check_mounted")
>
> and some fixup commits.
>
> So before removing the code completely I'd like to see if there's a use
> case that can be broken, but I don't have anything in particular.
> There's only mkfs-tests/006-partitioned-loopdev that's quite simple and
> does not try to do any tricks with symlinks or partitions on the
> devices.
>


