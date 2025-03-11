Return-Path: <linux-btrfs+bounces-12175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B336A5B707
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 04:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C615171E98
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 03:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57DD1E570B;
	Tue, 11 Mar 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pn6MO3Ha"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C471C5799
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662180; cv=none; b=ZjdJmW8sJm7gjAc/5+8obyK7sP3jNGShH2NC5gbxXImLyoUglDUskfcwillunMjEutKjvbsQuCbzB7kVEX32hAYwMJlEql5PAgTZxU7MRGoW+gAlZ0kq35fEm59Qs2HfMq1+x7YOxiU6tmPd2ENxn6bppg6VOR7mY0XLtDmjEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662180; c=relaxed/simple;
	bh=/nszh8ki2+OX6wknBNjDNwfBhz8ts+Tx+91vNveTDAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5RhTUy37KO2fyPg+ggqQc1S5I7GyNhz1rgBhHbdvgzIY8cMMBgjLDlNGdvLo3KXbDJNkEgGl0bNlBMP4JpSScTMLSz8FtMUJMGZCWDzA2VBWJ/qPg/ReLgdjV+H3BtoxGrtEnKRnvQBzGjfN8fDBXcty13UlAGD4JOdvJrrDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pn6MO3Ha; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741662171; x=1742266971; i=quwenruo.btrfs@gmx.com;
	bh=YA7POplKEmefIBGAFBuFUFtiwzpJ0bFbwtuHMJ1jdFw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pn6MO3HaS+h6b0NVwmG3om5jbCKqUvf/13c7V6+DQy8Vg7rfy7qui8kd4+JbxnPG
	 j18S7v3t+9dmkRwUt6DAgqHJWiV/W42oALHPgZgW+YqiflVHVtpLf8+LGp4DAkzZa
	 EUhbk6b12mZG3eD9LnDxU1dEqrjifguqWEn4hoyPXtCXGrmlO5w1Ko5w0ifKFv/8r
	 nszh84Q9pyZ06jIaBuktLxtgpx2IS3iAhFHIxN7P5dIgxq1mdZOrSYo8ZJjTWS+hm
	 zvdT6hawpMgthPY9VI8sjQw5VwL9loYd+URX0BRoJ+cBTHSGR9ar8qM/I2gRZOdUI
	 fVxyOmLBISt9sX0YxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXGrE-1tjdjw2hzS-00JSFR; Tue, 11
 Mar 2025 04:02:51 +0100
Message-ID: <2aabef6b-cd3d-422d-a808-68863d0f913a@gmx.com>
Date: Tue, 11 Mar 2025 13:32:47 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add extra warning if delayed iput is added when
 it's not allowed
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <65dce6b59ca3aa2bcd2e492271dcc3faa6f0a9ad.1741583506.git.wqu@suse.com>
 <CAL3q7H7jU5TKHxmo9QQbSxz+BnTvO1PXZzgy3xY-3txhhjFA+A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H7jU5TKHxmo9QQbSxz+BnTvO1PXZzgy3xY-3txhhjFA+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J1zlNbUKvfhlGnorYemDW7k+hxkKVWcqb3xjMUJzKqLazQd/p+1
 dzny+wzjFdve0p7R9W94gwjQ4JOHTy1RPf17322nBb17xloVMtWi/F5k6owouYlP6OSW1HW
 lj/qtG1wBjjwKJIbs0039wsxFyRGlIDKZ/ZDlj1Yz4NGG+Ji/5wXzW/muCxAusP0UY1FdPl
 nMWbRxp5riy3kEKjRKexw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jEvGwqD18O4=;0uvc/uyIqzzq7nDapa3YcAQHGBM
 +AQAbwuHHo0AggeHv0CxwVIEGl4zKl42cq3QEgU9IBzBiErE96Ec0YoOrbIdw6VgbptMrI1CS
 1aLRoxSbbf61sTtXaHaCCw2nKgEsKXVEMwTsKCC1lCVCFsic3Dm7XA1DIM0KG/qUpPSSLup9Z
 vVtq3GJUHjhZTrPsDp0ERY/JFC9BKb5gZhDDSbqjQCcXqeOBrXfV6JbABHM20pkxJHzQlOANk
 HgXjIETcjAbnR0z33xghLiRddJFLQFj3Rod/IjV4mVJA4m6cZohDJoyHVbLZoNrPEf+kNz1Ca
 TNhMOtOb4ufKHzN/Lc97LIYbG6ApA/IPNVASdRWJup5AANikGLz0X84LSzYtFiYGUzOKbJdw9
 0ne/9BD/PqqVvHViceSNDZJ+75seq0n9tVAhPDd0fmB1duj0xQCD0z4esJLBGIl5OGtVGdhTB
 5z16Kvafrp5nG7/dZ4TSbsofHREVJaujH/nKiATPXpMpeI14zbuX2P+VLuA5iqQeYVA8V45ke
 Iv/vufuWy/SPl2pJA9SwQqFxzphuKrdC+9yYbjvDtKC1oA+lsoZX2dtDB82X4M+6h3v5wOvWW
 l/KIyBL6uUkH3KHxpZOF8K+j0J65uB9wZp/YR7ercukUdCZ6BEfOxWiQM2/eRmO08qKAmf8yZ
 f9MCAtbniuNfKoS4y3iL8OwytRjuFq5rKkY8LvOZcPyzXjaTFhdtkLLAklwWdHR4JKj1R3QGB
 ZR2o6K1pVCyUtKqbSWUJjBTgnpnnpfNb8zY4V/QCSr55ud0n5ok7GyL3iL0YhGqGh+8bLMcWD
 x9j9RCSZWTEtv9UkXu4G8q+Tto1eMAxMpRP/1JEPMJOHYijAVySDk16NTejPp8bvLNiO+3yZ6
 CxuWXWMdcz5qfnXv7YqghWSzmmBEnsoe7ADn+PfKi/QBKItjs39KFBNxBB9KoTecwk3PGMakm
 B2Gu68s/yh2Jl8JplpAWwAWpcMnkA3BykpNI5L1weXBOG6gkj2/xNn7d/MuyqKorhLr4m5eFb
 tCzpCzoQl7m8FZ8QPIoQSMeDC0jdv8OFIFMMDlELSyRjCIL5fcCgyskpKqxiurr/UwWOKuN0H
 uuY2EOPo3bnxVShUL1OH5fn2vQl7mYtd8G4lb6JjGDQN91O0pB5xURDvIrArejOzU9XJagkeD
 AbK+6AcLZS4Ch+7u1Aq1Fa/imXhSngzGHqd+aJQp2sE7Tx+PSDqnQx3oU0C3Ss+htOvvQwLOa
 rJHOVeWtgYbgKIjXbGdCxWsZUe/xCF8N25xFan44N1pBczvrr2AnwBzaaFRws24c99NF5XQhG
 5LaASFgfQhi8tHB7g/yo8mbme9TwC2YIIehOohMlUmdSWHBsw8MKmCBSLJBls9UTNhqwvZr82
 rz+YMrTkWYXhkLWQ8xqLTFzNPCEfN6mdTEU2Mt/x7gEQSaqWn9adHYZWzv



=E5=9C=A8 2025/3/10 21:12, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Mar 10, 2025 at 5:15=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Since I have triggered the ASSERT() on the delayed iput too many times,
>> now is the time to add some extra debug warnings for delayed iput.
>>
>> All delayed iputs should be queued after all ordered extents finish
>> their IO and all involved workqueues are flushed.
>>
>> Thus after the btrfs_run_delayed_iputs() inside close_ctree(), there
>> should be no more delayed puts added.
>>
>> So introduce a new BTRFS_FS_STATE_NO_DELAYED_IPUT, set after the above
>> mentioned timing.
>> And all btrfs_add_delayed_iput() will check that flag and give a
>> WARN_ON_ONCE() for debug builds.
>>
>> And since we're here, remove the btrfs_run_delayed_iputs() call inside
>> btrfs_error_commit_super().
>
> This is a bad idea to make such unrelated change in the same patch.
> After all this one is about adding a warning and making things easier
> to catch.
>
> It should either go as a separate patch or it fits much better in the
> previous patch ("btrfs: run btrfs_error_commit_super() early").

Sure, I also prefer to push the removal of btrfs_run_delayed_iputs()
into that commit.

I'll update that one with extra commit message.

>
>
>> As that function will only wait for ordered extents to finish their IO,
>> delayed iputs will only be added when those ordered extents all finishe=
d
>> and removed from io tree, this is only ensured after the workqueue
>
> It's not "io tree", that's used for extent locking, setting delalloc
> ranges, etc.
> You mean the ordered extents tree in the inode (struct
> btrfs_inode::ordered_tree).
>
>> flush.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Set the new flag early
>> - Make the new flag unconditional except the WARN_ON_ONCE() check
>> - Remove the btrfs_run_delayed_iputs() inside btrfs_error_commit_super(=
)
>> ---
>>   fs/btrfs/disk-io.c | 6 ++----
>>   fs/btrfs/fs.h      | 3 +++
>>   fs/btrfs/inode.c   | 4 ++++
>>   3 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 671f11787f34..466d9c434030 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4384,6 +4384,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_=
info)
>>          /* Ordered extents for free space inodes. */
>>          btrfs_flush_workqueue(fs_info->endio_freespace_worker);
>>          btrfs_run_delayed_iputs(fs_info);
>> +       /* There should be no more workload to generate new delayed ipu=
ts. */
>> +       set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
>>
>>          cancel_work_sync(&fs_info->async_reclaim_work);
>>          cancel_work_sync(&fs_info->async_data_reclaim_work);
>> @@ -4540,10 +4542,6 @@ static void btrfs_error_commit_super(struct btrf=
s_fs_info *fs_info)
>>          /* cleanup FS via transaction */
>>          btrfs_cleanup_transaction(fs_info);
>>
>> -       mutex_lock(&fs_info->cleaner_mutex);
>> -       btrfs_run_delayed_iputs(fs_info);
>> -       mutex_unlock(&fs_info->cleaner_mutex);
>> -
>>          down_write(&fs_info->cleanup_work_sem);
>>          up_write(&fs_info->cleanup_work_sem);
>>   }
>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>> index b8c2e59ffc43..3a9e0a4c54e5 100644
>> --- a/fs/btrfs/fs.h
>> +++ b/fs/btrfs/fs.h
>> @@ -117,6 +117,9 @@ enum {
>>          /* Indicates there was an error cleaning up a log tree. */
>>          BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
>>
>> +       /* No more delayed iput can be queued. */
>> +       BTRFS_FS_STATE_NO_DELAYED_IPUT,
>> +
>>          BTRFS_FS_STATE_COUNT
>>   };
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 8ac4858b70e7..d2bf81c08f13 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -3435,6 +3435,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *=
inode)
>>          if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
>>                  return;
>>
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +       WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info-=
>fs_state));
>> +#endif
>
> As commented before, I would not add this under CONFIG_BTRFS_DEBUG,
> just leave it there to always run.
> Like that it'll be much faster to discover issues, as users typically
> don't run a kernel with CONFIG_BTRFS_DEBUG.

OK, since it's already WARN_ON_ONCE(), which won't flood the dmesg again
and again, I'm also fine put it into production kernels.

Thanks,
Qu

>
> Thanks.
>
>
>> +
>>          atomic_inc(&fs_info->nr_delayed_iputs);
>>          /*
>>           * Need to be irq safe here because we can be called from eith=
er an irq
>> --
>> 2.48.1
>>
>>
>


