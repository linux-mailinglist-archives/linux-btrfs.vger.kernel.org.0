Return-Path: <linux-btrfs+bounces-3312-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548387C44C
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 21:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7010B20FF6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 20:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E31763E5;
	Thu, 14 Mar 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TeGQHDbj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B526FE28
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448252; cv=none; b=tBvVKL40Lr5fJNxy4iHCbAf5lb+4ybyzE/HKRIYQJw6ExOvYugluZQBL5ES9yzS/TURHiHzJj5fxFjep5SGoyAJuPhQ0vxu8VlWkKBQdnRVfghQayaH6wOjufqbBPA5zxImPc6NdrUeWaReI9qyFrsF8oRVBAPtAMX7gUUhSVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448252; c=relaxed/simple;
	bh=WRaWu3kl1N7bsvmdTPbJlwgxVXRhYd8ZWbg5Q0sv8fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cM9ifzZigfEkmlmKvUlHh7KzOQ6oVksoWs9NaqYE0ovA39B/UOlerwctMvc7vzYde/OQTHa9C+qDe//fWzogjHhlMY4P6q36nmqhsOq5037+67r773D1VzruUK81K/JAwGH4TYx+6G4uhKE32YrmikbDBTFM1Wdt4SnqMqLrhB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TeGQHDbj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710448244; x=1711053044; i=quwenruo.btrfs@gmx.com;
	bh=LVnIhnDtLYDJ7GIUkSy13VZ8Ych7k46WlNVBTz0E9J0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TeGQHDbjt7XWndKnqluorsII1oPrc3JJgAmp7sN07YN+TKLWR9jZj2XWQN8RrBze
	 haw3jUbJl1Dk7ApKm/NPSvv/+b2OS2ZyNAtbFPrIFKxe//wty4rjYQK5PSHg/GYvh
	 MHBzXzs8uED6/KSIXj7IIHbQt3NcSdXKKU+tELYVQu0BwpzOTnaEVaf70upF7RMEF
	 jU6UbRvywyUPIa4UVAfQ46mZcmFOJD0gP5vkUasRkpIpQoJKDxoWE7J8Qzb8WIKx6
	 t1ml/DSQvfhXQwUjoHBZWdyj8bNH898Fo/fTIzazv3WiKJGcT4cocTfWRia2C3vsf
	 1rCJs6FNlQVJnY0GDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MI5QF-1rXx923EbX-00FAZP; Thu, 14
 Mar 2024 21:30:44 +0100
Message-ID: <45f95dc2-cd2b-47af-a02b-d306efd2e85a@gmx.com>
Date: Fri, 15 Mar 2024 07:00:40 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] btrfs: scrub: refine the error messages
Content-Language: en-US
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1710409033.git.wqu@suse.com>
 <20240314173512.GA3485866@zen.localdomain>
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
In-Reply-To: <20240314173512.GA3485866@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kTETq8IHiry9YYYxKg+4s7W7mYpDx0v5NRLkjxMU1yVGCkmKX7C
 jnTxXYKTu0OHky94f/yF54TknmtkJGKOMirpbW9VdK82p9SPE0qbblvkAev4LKOdzmI1k+R
 maSnB3GwGnaSYWDJEHIav32+aeWp1Fwgdd825U/25OUWBjhixIUI74xVhz46a1od0MNj5uN
 xudQ0UfNSGHaN3u6eqNiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:frqYF+enhUk=;wT0eJbOx+R8jHhn6vHWmqbu+mdE
 fdKZ6O2olfRqGb1w1Enuz5Vp21f7FGZfuZn/BD0bL0kaGWC54Rolj0EQacFvcR8BdWQ5Xqsin
 HvwT5jK7Ks0ABaZz1pdm9SUl+BIae73+OBpUCSRhGX2jBt9VImg2AVkKOtYX3fzMPz+LGHS91
 4O/QTG9thQoi5TCDASWfSycRaXQcxC2g+II39RLHbmJ8lFKE/TY1dAtdKzMJVvaiISV6sCxTy
 HHaCwZLDoWEduYGrN+6d6vB3h+//7VP5djDn4267fnm9n3Dn9qX+kWaQma9vavaO9LtE/4qee
 qG4EMwPE4ZvrhkNWg7j3Rks/RH2aKnhlUuEz736WJ7hFEwOvdUxY+CVXLVpvfHgYByQJ9cfkx
 RVeraxOf0h2tPYrmp3lffGXRMl+mc6SYoioyoV/vY1aXjcWlKHR8QnRZcoAAPoPpJfz0jOZyu
 /TuhkPyjCgBho8CN/qPFueQDxki8+I754eCYOSSga1K0a9yJVV0ScUbrXn5nxwJrxLiN303p2
 2iZGZE0P9GW2H6L9pd0pMjtRgJov3Wuf9rETZd4z6ZzcUmdhUXwzwAIqozTVH6j0T7RypNL3g
 aKx7KO12r8ZJk73eHY3zqHmJBBdKSKKNxN+gFLoH1+YMir2i9+8OpSEqwJEAq8UBio/k1gPJX
 q4l8H6QR60ovYHTcr/TnS3rE5swPVaDWK2mfmgWrkGq2+7W5ZJ0tAPgHBh3etfXeuR8pm3xEO
 mZyNnexsLRBmnwpqN1MBabFZw25spZi9kHHDkMgt0HI42UA9UwXw6YDCjpcU8CJL9mvygyjAb
 rTOv1aB0/mjFKvw45SaiK9j868PvedrJAxBCZ7CrFvYZ4=



=E5=9C=A8 2024/3/15 04:05, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Mar 14, 2024 at 08:20:13PM +1030, Qu Wenruo wrote:
>> During some support sessions, I found older kernels are always report
>> very unuseful scrub error messages like:
>>
>>   BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd=
 0, flush 0, corrupt 2823, gen 0
>>   BTRFS error (device dm-0): unable to fixup (regular) error at logical=
 1563504640 on dev /dev/mapper/sys-rootlv
>>   BTRFS error (device dm-0): bdev /dev/mapper/sys-rootlv errs: wr 0, rd=
 0, flush 0, corrupt 2824, gen 0
>>   BTRFS error (device dm-0): unable to fixup (regular) error at logical=
 1579016192 on dev /dev/mapper/sys-rootlv
>>
>> There are two problems:
>> - No proper details about the corruption
>>    No metadata or data indication, nor the filename or the tree id.
>>    Even the involved kernel (and newer kernels after the scrub rework)
>>    has the ability to do backref walk and find out the file path or the
>>    tree backref.
>>
>>    My guess is, for data sometimes the corrupted sector is no longer
>>    referred by any data extent.
>>
>> - Too noisy and useless error message from
>>    btrfs_dev_stat_inc_and_print()
>>    I'd argue we should not output any error message just for
>>    btrfs_dev_stat_inc_and_print().
>>
>> After the series, the error message would look like this:
>>
>>   BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fil=
eoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647=
872
>
> Stoked on this series, thanks for doing it!
>
> qq: would it be helpful to also include the actual/expected csum? I
> think it's particularly helpful when one or the other is either zeros or
> the checksum of the zero block.

It's a little too long to add (especially considering SHA256).
And even with CRC32C, I have difficulty to expose any all zero/one checksu=
m.
(Maybe I did too few support recently?)

Thanks,
Qu

>
>>
>> This involves the following enhancement:
>>
>> - Single line
>>    And we ensure we output at least one line for the error we hit.
>>    No more unrelated btrfs_dev_stat_inc_and_print() output.
>>
>> - Proper fall backs
>>    We have the following different fall back options
>>    * Repaired
>>      Just a line of something repaired for logical/physical address.
>>
>>    * Detailed data info
>>      Including the following elements (if possible), and if higher
>>      priority ones can not be fetched, it would be skipped and try
>>      lower priority items:
>>      + file path (can have multiple ones)
>>      + root/inode number and offset
>>      + logical/physical address (always output)
>>
>>    * Detaile metadata info
>>      The priority list is:
>>      + root ref/level
>>      + logical/physical address (always output)
>>
>>    For the worst case of data corruption, we would still have some like=
:
>>
>>     BTRFS warning (device dm-2): checksum error at data, logical 136478=
72(1) physical 1(/dev/mapper/test-scratch1)13647872
>>
>>    And similar ones for metadata:
>>
>>     BTRFS warning (device dm-2): checksum error at meta, logical 136478=
72(1) physical 1(/dev/mapper/test-scratch1)13647872
>>
>> The first patch is fixing a regression in the error message, which lead=
s
>> to bad logical/physical bytenr.
>> The second one would reduce the log level for
>> btrfs_dev_stat_inc_and_print().
>>
>> Path 3~4 are cleanups to remove unnecessary parameters.
>>
>> The remaining reworks the format and refine the error message frequency=
.
>>
>> Qu Wenruo (7):
>>    btrfs: scrub: fix incorrectly reported logical/physical address
>>    btrfs: reduce the log level for btrfs_dev_stat_inc_and_print()
>>    btrfs: scrub: remove unused is_super parameter from
>>      scrub_print_common_warning()
>>    btrfs: scrub: remove unnecessary dev/physical lookup for
>>      scrub_stripe_report_errors()
>>    btrfs: scrub: simplify the inode iteration output
>>    btrfs: scrub: unify and shorten the error message
>>    btrfs: scrub: fix the frequency of error messages
>>
>>   fs/btrfs/scrub.c   | 185 ++++++++++++++++----------------------------=
-
>>   fs/btrfs/volumes.c |   2 +-
>>   2 files changed, 66 insertions(+), 121 deletions(-)
>>
>> --
>> 2.44.0
>>
>

