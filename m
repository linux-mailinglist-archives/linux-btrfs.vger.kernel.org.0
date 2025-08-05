Return-Path: <linux-btrfs+bounces-15870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E68AB1BCEB
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE687A4F2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E22BD598;
	Tue,  5 Aug 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rpi07ozV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540A285069
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754435059; cv=none; b=YvTZTxKYeS/wH8uV98DYl6L1x9HgQCcEaj1Oyzb/PdCUAXGqC28bS7uiCQcZQw59ipQLpxLwztEjp+UxVV4leAzPCQSEc+7yV0MzqCsnXujxrpO7pFe1DndNEw/vceFg9MJhoW770FzZtHnfNd7e1U3cx1NEQPEISAIeYfBDjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754435059; c=relaxed/simple;
	bh=kdf5ckvlmiNMGaxYN1BrY92fCnDUsnhnvR3qmP0ghSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAmDwPTKefMQKHIo9rlfECVztZho5sTtru9yaUrl3p/ey+bIPwFQRU3+Qdn3FsBvFeSi5sqo6RpEXkdsrwWWm9bmTUEJAYgEH0hU+kqwXA5gGfL4yW8N0dEZklIKRJ5GhGhScGxKNRJp8pVkrIQ0R2/Q82NmadMq/ZDmXq6BzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rpi07ozV; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1754435051; x=1755039851; i=quwenruo.btrfs@gmx.com;
	bh=BUwkcyUMJzKvF7q4Z4jsplqlNZVYTTDNddK9GL7kMko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rpi07ozVpIBaRh3cmUvQPX8Y9+Mz37HfR+beoA0/j/xHtTtsbsFFudxdf9RrzyMg
	 3YNbuy8w87LguwXSqWYAnDo1uovvVzderZN0vveswQ1kS3NbgJcgcgL/yHtz6xf9q
	 F7tH4X6eyO66PuPhMBrp1Nu7ZkxpkcG1pJH+KlZbTjleO/h48aVoXSJ8H6IQJ0XgD
	 O/dHHzmJfHstX5icWCENrNgc1Ca43zxHBrDJBsnCFptwrUKXJvGyLRsx8RNxhbITN
	 eRZlMIKYOwEwSrAAC3WIYjprsI5GkVFjs+JeIZDCVtxfLbm21xv5wEiqcnYY4Z62f
	 VR+9bqrh9IGn84JE9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUnK-1uRDIG2jTO-00zKn4; Wed, 06
 Aug 2025 01:04:11 +0200
Message-ID: <5cafb498-c74a-4431-8a2e-b81a519c8a30@gmx.com>
Date: Wed, 6 Aug 2025 08:34:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] btrfs-progs: remove device_get_partition_size_sysfs()
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1754116463.git.wqu@suse.com>
 <7d924138ebae9196c7a6889b29e44e7549bda83d.1754116463.git.wqu@suse.com>
 <20250805191558.GC4106638@zen.localdomain>
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
In-Reply-To: <20250805191558.GC4106638@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qD15AdllyNMOkJKnOgXMj1aKwgEKyAx1E/oLLO3RrPb8Jq1OdbD
 BQChExHQgEmCLUtllH7oUPDdgSOob41+CCNPKjWPpy6SUuUXzicSdeWIvKlg2EF+AyYgk94
 iS70MRIDWFft9ciJlTc2TEaL7CVzeWUoPRc5g31SxbeHyJliVyZqPRSmMuJqzWhZhqsWN+y
 OdReCwJhDIyl0TQOzkE9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:munlPGq6lbg=;E+rnKbDgvqACIjXC0CqaqEWy9o1
 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
 3NM7czS6RlVWKBEN+WKrTqzew2Yl3hmcuCV



=E5=9C=A8 2025/8/6 04:45, Boris Burkov =E5=86=99=E9=81=93:
> On Sat, Aug 02, 2025 at 04:25:51PM +0930, Qu Wenruo wrote:
>> The helper is introduced for cases where the unprivileged user failed t=
o
>> open the target file.
>>
>> The problem is, when such failure happens, it means the distro's file
>> mode or ACL is actively preventing unrelated users to access the raw
>> device.
>>
>> E.g. on my distro the default block device mode looks like this:
>>
>>    brw-rw---- 1 root disk 254, 32 Aug  2 13:35 /dev/vdc
>>
>> This means if an unprivileged end user is not in the disk group, it
>> should access the raw disk.
>>
>> Using sysfs as a fallback is more like a workaround, and the workaround
>> is soon getting out of control.
>>
>> For example the size is not in byte but in block unit. This is already
>> causing problem for issue #979.
>=20
> shifting by sector size doesn't seem like a crazy thing for us to simply
> fix.
>=20
>>
>> Furthermore to grab the correct size in bytes, we have to do all kinds
>> of sysfs probing to handle partitions (to get the block size from paren=
t
>> node) and dm devices (directly from the current node).
>=20
> I don't quite understand this justification, is this another fix we
> would have to make or is it what we are already doing?
>=20
>>
>> With the recent error handling enhancement, I do not think we should
>> even bother using the sysfs fallback, the error message should be enoug=
h
>> to inform the end user.
>=20
> I think that given we have users reporting being confused by size being
> off by a factor of 512, it makes more sense to make them happy by just
> shifting rather than throwing the whole thing out.

Yep, I'll drop the last patch.

Thanks,
Qu

>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   common/device-utils.c | 39 +--------------------------------------
>>   1 file changed, 1 insertion(+), 38 deletions(-)
>>
>> diff --git a/common/device-utils.c b/common/device-utils.c
>> index b52fbf33a539..7a0a299ccf83 100644
>> --- a/common/device-utils.c
>> +++ b/common/device-utils.c
>> @@ -333,49 +333,12 @@ int device_get_partition_size_fd_stat(int fd, con=
st struct stat *st, u64 *result
>>   	return 0;
>>   }
>>  =20
>> -static int device_get_partition_size_sysfs(const char *dev, u64 *resul=
t_ret)
>> -{
>> -	int ret;
>> -	char path[PATH_MAX] =3D {};
>> -	char sysfs[PATH_MAX] =3D {};
>> -	char sizebuf[128] =3D {};
>> -	const char *name =3D NULL;
>> -	int sysfd;
>> -	unsigned long long size =3D 0;
>> -
>> -	name =3D realpath(dev, path);
>> -	if (!name)
>> -		return -errno;
>> -	name =3D path_basename(path);
>> -
>> -	ret =3D path_cat3_out(sysfs, "/sys/class/block", name, "size");
>> -	if (ret < 0)
>> -		return ret;
>> -	sysfd =3D open(sysfs, O_RDONLY);
>> -	if (sysfd < 0)
>> -		return -errno;
>> -	ret =3D sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
>> -	if (ret < 0) {
>> -		close(sysfd);
>> -		return ret;
>> -	}
>> -	errno =3D 0;
>> -	size =3D strtoull(sizebuf, NULL, 10);
>> -	if (size =3D=3D ULLONG_MAX && errno =3D=3D ERANGE) {
>> -		close(sysfd);
>> -		return -errno;
>> -	}
>> -	close(sysfd);
>> -	*result_ret =3D size;
>> -	return 0;
>> -}
>> -
>>   int device_get_partition_size(const char *dev, u64 *result_ret)
>>   {
>>   	int fd =3D open(dev, O_RDONLY);
>>  =20
>>   	if (fd < 0)
>> -		return device_get_partition_size_sysfs(dev, result_ret);
>> +		return -errno;
>>  =20
>>   	if (ioctl(fd, BLKGETSIZE64, result_ret) < 0) {
>>   		int ret =3D -errno;
>> --=20
>> 2.50.1
>>
>=20


