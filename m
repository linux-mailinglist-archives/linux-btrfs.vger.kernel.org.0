Return-Path: <linux-btrfs+bounces-19674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 698EBCB7552
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 00:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E0AA300F5B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 23:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4464285058;
	Thu, 11 Dec 2025 23:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="p3+pEoch"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB91E9B12
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765494414; cv=none; b=B2g3egcDTXTM6C+SA8XIk4ZAglIQL4KeuIrA2UVOj+FlHJA+HgFXwU3VWnoNyHakuGf5Ygi/0tG1ALG5oS/X5r/O7fAMFK/EU6RcKl4YBYKQb6u5z9kQD3uPueBXVDfqx9D5/7m460Ueh1J2EtEaY4iVs+aunZzL8ttactkWplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765494414; c=relaxed/simple;
	bh=syzmgdWyRdo2rw1q3X0bbGxo0XCF2JSbx++1K5YE3Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCGDJw+RBIcv5ZC301VCm0n/w3YBdF13yVHrYyBkna4bxE55mhgDIGxsZQcZ/tEus2MfsSrHlalqMyQFkowxnWQ1UmcVWvZNcpRn1qNPSwrwSF5QMRZ5Myc1TxAQxdfCDYymAjH0ZiYwdg+bolNdIXG7jvAQZzboLxJxvDcGCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=p3+pEoch; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765494406; x=1766099206; i=quwenruo.btrfs@gmx.com;
	bh=bNcUTjIoGPDQXo8hwz/NXTcRXckBUv/rfrCRBIPEflk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p3+pEochgX+lZ9rS7s1n8GqtVjT0GrsF2Vu9bhIm86+00vkfCq7XREgEdo+yAbDu
	 mQa0TVMMV5KFacU+wqHzkAV+BAxrlRxbHVw+MBbZz+CvvFV62nnB6WMsRFttVynfO
	 Qoxp+VGSlVuu5j++JYll6cLPNtWTh68gnW3DqSj6bJWZrJqgUU35zu87UndMH9OzT
	 Io1P7Hg2qbJtAUGOUiH1rDKwKcZMN+hLe+PZ4HKUG0znkWCSVjEJpz6kHMeFrC7QZ
	 HBAX2c2OiejPlg5xVre+wfS4qjjMz1w1hiBrggWeZkyCCDzKi4O+oS3rvUPsdzULS
	 vkaFGXphMZGYDZxnSg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My36T-1wENSc3k59-014lXO; Fri, 12
 Dec 2025 00:06:46 +0100
Message-ID: <597ed92a-4395-4990-97ff-a03b89c05f5c@gmx.com>
Date: Fri, 12 Dec 2025 09:36:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: add an ASSERT() to catch ordered extents
 without datasum
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1765418669.git.wqu@suse.com>
 <4d0eff22caa7217a4c1972a755043ee3324c5348.1765418669.git.wqu@suse.com>
 <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DhE/6rTw24DxETrsVUSlyqrDfcwk/iKvGwqnConSykTd7m8Y8H+
 ioOLO/PxTyba2h8yDUo7JZ1P6pwBw1Y3OfCCwIp5XbqL7wOKixUJri0BUl9873wfDuvmPar
 XN8v8givH40aH3CHoxXERFen2LCEPrzr4VbsZz77NGyzLuvt9spLYZTGdgaLAdbb2+0MGfn
 1kCXe53og2+EU2pEwxN5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9Jk513yDiJA=;NYDlCV2e8Q4FcZXHS+/RA5A++Vh
 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
 jbdMwg0y6t8ERQHev2q5xr3mYP0U4



=E5=9C=A8 2025/12/11 22:11, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Dec 11, 2025 at 2:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Inside btrfs_finish_one_ordered(), there are only very limited
>> situations where the OE has no checksum:
>>
>> - The OE is completely truncated or error happened
>>    In that case no file extent is going to be inserted.
>>
>> - The inode has NODATASUM flag
>>
>> - The inode belongs to data reloc tree
>>
>> Add an ASSERT() using the last two cases, which will help us to catch
>> problems described in commit 18de34daa7c6 ("btrfs: truncate ordered
>> extent when skipping writeback past i_size"), and prevent future simila=
r
>> cases.
>=20
> How exactly does this new assertion catches that case described in that =
commit?

If go with the example of patch 1, the OE range [60K, 64K) has no data=20
checksum but the inode has data checksum, thus will immediately trigger=20
the ASSERT().

Thanks,
Qu

> We had csums there, just not for the whole range of the ordered
> extent, just for the range from its start offset to the rounded up
> i_size (which is less than the ordered extent's end offset).
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/inode.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 461725c8ccd7..740de9436d24 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -3226,6 +3226,21 @@ int btrfs_finish_one_ordered(struct btrfs_ordere=
d_extent *ordered_extent)
>>                  goto out;
>>          }
>>
>> +       /*
>> +        * If we have no data checksum, either the OE is:
>> +        * - Fully truncated
>> +        *   Those ones won't reach here.
>> +        *
>> +        * - No data checksum
>> +        *
>> +        * - Belongs to data reloc inode
>> +        *   Which doesn't have csum attached to OE, but cloned
>> +        *   from original chunk.
>> +        */
>> +       if (list_empty(&ordered_extent->list))
>> +               ASSERT(inode->flags & BTRFS_INODE_NODATASUM ||
>> +                      btrfs_is_data_reloc_root(inode->root));
>=20
> No need to inode->root, we have a local variable with the root already.
>=20
>> +
>>          ret =3D add_pending_csums(trans, &ordered_extent->list);
>>          if (unlikely(ret)) {
>>                  btrfs_abort_transaction(trans, ret);
>> --
>> 2.52.0
>>
>>
>=20


