Return-Path: <linux-btrfs+bounces-18465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A1C2462D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A142D3A70F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD948337119;
	Fri, 31 Oct 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KvIKEuQ2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488920013A
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905606; cv=none; b=YZccjWk48MxALju1yANhUMIIM4n/nSZZzxbBmlJTrTTlvg83YJVNpcjhH9s2VYnddO2cK1eb9gEgFNyjpJYF1rh5Td+jOjMq6dyWt0FjZ86JPJzVph5pEZrZwwGFcVkQicrGDf3G6f5+CIcI9M4QcaCA0mcI01LowRhd2sWrOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905606; c=relaxed/simple;
	bh=m0/QVjlE3uigaBj3ZJC0s5hh9XVcGSRPjv3O1kvLkoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW94bTh43aaTWjrwdxHCSdPl2YFbGkvRW6WYaOE5sOawQkL0dfLAzVmQHMc4xrEH6XfFNkBTJabopmVFbS3M8Rq4zktETxJjkMWCxPvmZ5EYodIJeZMG72o5kC+h936wL/MEAyWUBQxKrHxz9y3I2e+Ar7vxUVwFM1bWL1LFYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KvIKEuQ2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761905601; x=1762510401; i=quwenruo.btrfs@gmx.com;
	bh=2JAkoNsk3hoQERS4zmn6eJ1BpCkZjCBstB9I0pp9KWM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KvIKEuQ2zSYIRMeEUb8KwoTCDK9VtXLQwI+QX19kYSQtbD4bMtHHXy/hzXzBJfF4
	 1ll/FKLQyuUVW484ldq/wQB4e8rzC0d+Inz1QQB3EoXtJB+lbH7ObGoE37y+J0L+O
	 oYFYFUFXiVdyPYsCXkXfDV/4dq5bLivOkByn8OwQyT5rR+6JSBcc0aqtygIzZ3K0Y
	 kzlEC1+1q/O1WTXskvs2PpPo0VIRyZt/2y/BWjOKjDAJunuXHIekYgeOSBqPUP7oy
	 0+7CX9QUSjDiu+AmByr4Ts7hqDM4d4Rvu8hg1TFac1lfjC00LY+4+oaNY6oU0VwTx
	 CqX+vNV+KEpiQAvI+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N8ofO-1wICnu1NqA-014zhq; Fri, 31
 Oct 2025 11:13:20 +0100
Message-ID: <a5c148c7-11fe-4da3-9002-ae9e5bef98c7@gmx.com>
Date: Fri, 31 Oct 2025 20:43:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fallback to buffered IO if the data profile has
 duplication
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <fe6582f4535be27e11a6125f89265ebe8c82aac6.1761867805.git.wqu@suse.com>
 <CAL3q7H7+UKqz5JDcLBQ+sJH-A40MR5_3M+GhskQ1Zw1+OJftxA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7+UKqz5JDcLBQ+sJH-A40MR5_3M+GhskQ1Zw1+OJftxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3ZCM50MgSS0j7Cjn8gzvYdSe5zZEnxSVV3DM/TXMjsa2cbK6FfB
 2NNu1mvDr7FDbOirNuyuSHN/ZgziZpK2/YDSUllK30Uqy2xl7i30i/LFW1SMWlrUHSHy3yE
 SW2LLoXslNEvf6nCIanljvWAtRnhDGK77aEsWmvW4Twqu8DJva/udI9fFViPn+htT2jMvm9
 4gs8RlqqJeA79ZTgYrfUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+goJYYBpCpc=;zKVnUPh4ITbtFb9HZUWiw9SKZmS
 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



=E5=9C=A8 2025/10/31 20:28, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Oct 30, 2025 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [BACKGROUND]
>> Inspired by a recent kernel bug report, which is related to direct IO
>> buffer modification during writeback, that leads to contents mismatch o=
f
>> different RAID1 mirrors.
>>
>> [CAUSE AND PROBLEMS]
>> The root cause is exactly the same explained in commit 968f19c5b1b7
>> ("btrfs: always fallback to buffered write if the inode requires
>> checksum"), that we can not trust direct IO buffer which can be modifie=
d
>> halfway during writeback.
>>
>> Unlike data checksum verification, if this happened on inodes without
>> data checksum but has the data has extra mirrors, it will lead to
>> stealth data mismatch on different mirrors.
>>
>> This will be way harder to detect without data checksum.
>>
>> Furthermore for RAID56, we can even have data without checksum and data
>> with checksum mixed inside the same full stripe.
>>
>> In that case if the direct IO buffer got changed halfway for the
>> nodatasum part, the data with checksum immediately lost its ability to
>> recover, e.g.:
>>
>> " " =3D Good old data or parity calculated using good old data
>> "X" =3D Data modified during writeback
>>
>>                0                32K                      64K
>>    Data 1      |                                         |  Has csum
>>    Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
>>    Parity      |                                         |
>>
>> In above case, the parity is calculated using data 1 (has csum, from
>> page cache, won't change during writeback), and old data 2 (has no csum=
,
>> direct IO write).
>>
>> After parity is calculated, but before submission to the storage, direc=
t
>> IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
>> has a different content.
>>
>> Now all data is submitted to the storage, and the fs got fully synced.
>>
>> Then the device of data 1 is lost, has to be rebuilt from data 2 and
>> parity. But since the data 2 has some modified data, and the parity is
>> calculated using old data, the recovered data is no the same for data 1=
,
>> causing data checksum mismatch.
>>
>> [FIX]
>> Fix this problem by introduce a new helper,
>=20
> introduce -> introducing
>=20
>> btrfs_has_data_duplication(), to check if there is any data profiles
>=20
> is any -> are any
>=20
>> that have any duplication. If so fallback to buffered IO to keep data
>> consistent, no matter if the inode has data checksum or not.
>>
>> However this is not going to fix all situations, as it's still possible
>> to race with balance where the fs got a new data profile after
>> btrfs_has_data_duplication() check.
>> But this fix should still greatly reduce the window of the original bug=
.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D99171
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/direct-io.c  |  9 +++++++++
>>   fs/btrfs/space-info.c | 18 ++++++++++++++++++
>>   fs/btrfs/space-info.h |  1 +
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
>> index 962fccceffd6..3165543f35bc 100644
>> --- a/fs/btrfs/direct-io.c
>> +++ b/fs/btrfs/direct-io.c
>> @@ -12,6 +12,7 @@
>>   #include "volumes.h"
>>   #include "bio.h"
>>   #include "ordered-data.h"
>> +#include "space-info.h"
>>
>>   struct btrfs_dio_data {
>>          ssize_t submitted;
>> @@ -827,6 +828,14 @@ ssize_t btrfs_direct_write(struct kiocb *iocb, str=
uct iov_iter *from)
>>          if (iocb->ki_pos + iov_iter_count(from) <=3D i_size_read(inode=
) && IS_NOSEC(inode))
>>                  ilock_flags |=3D BTRFS_ILOCK_SHARED;
>>
>> +       /*
>> +        * If our data profile has duplication (either extra mirrors or=
 RAID56),
>> +        * we can not trust the direct IO buffer, the content may chang=
e during
>> +        * writeback and cause different contents written to different =
mirrors.
>> +        */
>> +       if (btrfs_has_data_duplication(fs_info))
>> +               goto buffered;
>> +
>>   relock:
>>          ret =3D btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
>>          if (ret < 0)
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 63d14b5dfc6c..02b5ebdd3146 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -2203,3 +2203,21 @@ void btrfs_return_free_space(struct btrfs_space_=
info *space_info, u64 len)
>>          if (len)
>>                  btrfs_try_granting_tickets(space_info);
>>   }
>> +
>> +bool btrfs_has_data_duplication(struct btrfs_fs_info *fs_info)
>> +{
>> +       struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
>> +       bool ret =3D false;
>> +
>> +       down_write(&sinfo->groups_sem);
>> +       for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
>> +               if (!list_empty(&sinfo->block_groups[i]) &&
>> +                   (btrfs_raid_array[i].ncopies > 1 ||
>> +                    btrfs_raid_array[i].nparity !=3D 0)) {
>> +                       ret =3D true;
>> +                       break;
>> +               }
>> +       }
>> +       up_write(&sinfo->groups_sem);
>=20
> This is huge and rather heavy.
> Taking the lock in write mode will block with concurrent extent
> allocations which take it in read mode.
>=20
> We could lock in read mode instead, but this can be much simpler by doin=
g this:
>=20
> return (btrfs_data_alloc_profile(fs_info) &
> BTRFS_BLOCK_GROUP_PROFILE_MASK) !=3D 0;

Thanks a lot for the btrfs_data_alloc_profile() helper, I know the=20
semaphore is super expensive but didn't find a good solution and even=20
considering implementing a cached version.
With this it's way more simpler.

Will go the helper and check for SINGLE/RAID0.

Thanks,
Qu

>=20
> Thanks.
>=20
>=20
>=20
>> +       return ret;
>> +}
>> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
>> index a4c2a3c8b388..15b96163a167 100644
>> --- a/fs/btrfs/space-info.h
>> +++ b/fs/btrfs/space-info.h
>> @@ -315,5 +315,6 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_=
space_info *space_info, bool
>>   int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space=
_info);
>>   void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>>   void btrfs_return_free_space(struct btrfs_space_info *space_info, u64=
 len);
>> +bool btrfs_has_data_duplication(struct btrfs_fs_info *fs_info);
>>
>>   #endif /* BTRFS_SPACE_INFO_H */
>> --
>> 2.51.2
>>
>>
>=20


