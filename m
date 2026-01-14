Return-Path: <linux-btrfs+bounces-20525-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26BD21438
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D813019B6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A39357A3A;
	Wed, 14 Jan 2026 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SMfiST2y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA52D73B8
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424767; cv=none; b=jdZ1LfMXKeEdq24iFS+LxzxVhf/vqE6DU8rmnMolOHbn4pqKwlLeJotjPM40ZMwTjFC6IbI5TKhwX2ue/l8SGRypRYxoieMLfA8JrKhJEJ8prTMWrmokhirFDHOsRW32NWT2bMUldyplnDRVoh3Pc4Fd1N8SDp8/23OFuYRKkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424767; c=relaxed/simple;
	bh=655pQXBWpDhg3ULAEIOLGXW4HiTGprDPnTKbV2UaU+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvpOZmo+/j2aFt39R4voEM7aPDBH4ZUMQvkg/vcPShNeIgSqSA0WU1pIyUBXXTc6iJXZFQ120fB78PjVSB49VK+qK1MCpFiDMmNBcqZAPyX+7XnqZixvv+sBurpFX2LHg3pa+rG3/goUw9VQYr4dZnaZEGibrgFs5w5ykyq00c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SMfiST2y; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768424762; x=1769029562; i=quwenruo.btrfs@gmx.com;
	bh=pu2QaIvd8xQklA6LbU1w8pCOOtk9Ix6oW4l0CSnFFro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SMfiST2yianuqJ5MF4pxDeREXegWVMZ39dkjVehOF8VHhZVxyFPiPxBBu9qkJN3G
	 B1evOGsHiDqnp1yUfc1UGNx+MmfEkch4MVpUa35Ajq/v/ksMh52fX5k0//5rzNCvD
	 G8axlEODEAeQfojzlw/mp+9y5EKbk6mDS4Y+wwkCcRUE7FJag370UZNT60zaLAHhZ
	 kxGU3lyviildgxoXSE7iewqIOtrqc5zxGT13Qmp0fCZIj7N2EiPmWLJVN1oKsqkDg
	 vEGMx8Fkzu/bOpjkW/vj7aaK79/tLwh2qJgQJDMYtZ+zT1kFLiWdjALyUiCwyoMLk
	 CgVt9luRbPCPKcIz+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6lpG-1vk0Cy1LBe-000B4r; Wed, 14
 Jan 2026 22:06:02 +0100
Message-ID: <2debc9e7-a6d5-4bc4-a85c-052371221300@gmx.com>
Date: Thu, 15 Jan 2026 07:35:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: minor improvement on cow_file_range() error
 handling
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <179097dcd57ea022d37d97eb0bcc69dcd24243ba.1768356495.git.wqu@suse.com>
 <CAL3q7H4FbrDYSfwNTDkje4dKY13bosbxJap8u8zM8pUHuqWtAg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4FbrDYSfwNTDkje4dKY13bosbxJap8u8zM8pUHuqWtAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qf0zMQYXG1oQD1kASBEWuVhZtMw0Gnns09BlmvBvaRWJEl1UVPa
 Ao06Vd2gXCUlkrheV85QvYafA8KtWpH98q8VdbwWw8yxm0/vwlx6fB7JSG2L34SfdcIpPkC
 TB/bK8f9/CE/t9ARbsmCyE6tCORaAmhCYqV0GBmFo3onoP9GwB1LbfGevjR8UOkIv1vDLy2
 EVJO+X1LB69ykaTLf7s/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MNiFLVnRqho=;SU4e+urM+KVPePkCynUGcDKW2Ns
 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
 hfxD6GqE=



=E5=9C=A8 2026/1/14 22:13, Filipe Manana =E5=86=99=E9=81=93:
> On Wed, Jan 14, 2026 at 2:08=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> There are some minor problems related to the error handling of
>> cow_file_range():
>>
>> - The label out_unlock: is not obvious
>>    In fact we only go that tag for error handling.
>>
>> - mapping_set_error() is not always called
>>    It's only called if we have processed some range.
>>
>> Enhance those minor problems by:
>>
>> - Rename out_unlock: to error:
>>    So it's clear we only go there for error handling, not some generic
>>    handling shared by the common path.
>>
>> - Always call mapping_set_error()
>>    Not hiding it behind certain error pattern nor behind @lock_folio
>>    parameter, which is always provided for all call sites.
>=20
> We don't need to call mapping_set_error() in cow_file_range(), as
> that's always called in the upper call chain already:
>=20
> extent_writepage() -> writepage_delalloc() ->
> btrfs_run_delalloc_range() -> cow_file_range()

And also in the lower call chain, e.g. cow_one_range() also calls=20
mapping_set_error().

So we can remove those duplicated calls and only rely on the higher=20
level one.

Thanks for pointing this out,
Qu

>=20
> Any error returned by cow_file_range() is propagated up to
> extent_writepage(), which does:
>=20
> done:
>      if (ret < 0)
>             mapping_set_error(folio->mapping, ret);
>=20
> Thanks.
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 67220ed62000..62d43b5bf910 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -1456,12 +1456,12 @@ static noinline int cow_file_range(struct btrfs=
_inode *inode,
>>
>>          if (unlikely(btrfs_is_shutdown(fs_info))) {
>>                  ret =3D -EIO;
>> -               goto out_unlock;
>> +               goto error;
>>          }
>>
>>          if (btrfs_is_free_space_inode(inode)) {
>>                  ret =3D -EINVAL;
>> -               goto out_unlock;
>> +               goto error;
>>          }
>>
>>          num_bytes =3D ALIGN(end - start + 1, blocksize);
>> @@ -1553,7 +1553,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>>                          ret =3D -ENOSPC;
>>                  }
>>                  if (ret < 0)
>> -                       goto out_unlock;
>> +                       goto error;
>>
>>                  /* We should not allocate an extent larger than reques=
ted.*/
>>                  ASSERT(cur_alloc_size <=3D num_bytes);
>> @@ -1570,7 +1570,8 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>>                  *done_offset =3D end;
>>          return ret;
>>
>> -out_unlock:
>> +error:
>> +       mapping_set_error(inode->vfs_inode.i_mapping, ret);
>>          /*
>>           * Now, we have three regions to clean up:
>>           *
>> @@ -1593,9 +1594,6 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>>                  clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC;
>>                  page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE=
_END_WRITEBACK;
>>
>> -               if (!locked_folio)
>> -                       mapping_set_error(inode->vfs_inode.i_mapping, r=
et);
>> -
>>                  btrfs_cleanup_ordered_extents(inode, orig_start, start=
 - orig_start);
>>                  extent_clear_unlock_delalloc(inode, orig_start, start =
- 1,
>>                                               locked_folio, NULL, clear=
_bits, page_ops);
>> --
>> 2.52.0
>>
>>
>=20


