Return-Path: <linux-btrfs+bounces-10508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75A9F57E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1790C165395
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 20:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F901F9A99;
	Tue, 17 Dec 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="iuubaHaj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA01F8EFF
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467907; cv=none; b=MyFqRZc0yW1hRrSPpa9yzWqgC9nkm4U1LGyx1XgGoDy9uqkQDBqfZgScvJvkTxNNZQ2soZEQ1stj7Zi0EbC8P7hhwfr0NhvHb/+5lpAwtCJrNamjtI858R/d8QJ5qaco0iOkN4DQXg9JFsysmHDp2ECE1RvY+o1a6hngenTOUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467907; c=relaxed/simple;
	bh=Lb+KaSXig0Lps836gItLdWO1gzt1x/mgF/ThxSA/MOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8ocfjNQvHuQWtBAR+aI7pvcsiCSLCK6OFMfncJOoeWl3490HRXhrVeC/R11pRtGPR+pBrU1edjLDyLtGh6xmlrLJ+L4ntvXoGDCffqIwb7R1MLwk8CBu+9JXWA9A4gkasWPp68vDePjDmlMbJ7o84KITcanVZs11E00u8sO0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=iuubaHaj; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734467897; x=1735072697; i=quwenruo.btrfs@gmx.com;
	bh=GvGJLWBgcTb5rUfYfj1NO/W/RmU1lQ0nUC8KR7cmr8k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iuubaHajpE+msKUg7hY2AoCgK/amXmN7AGKeEsrN8EZ2H9y3IWXQLE+5oo1dEGVO
	 Qi6vlRW3elmfercx+TjRIOgugQv9+CsrkYK6wxrj5ztDyGW1+ZQ2hsDSf6XVur6AP
	 S+uc6245joMnvyXpZQNh3r8qXE5bRKHLDmjni7y1Em03eOXoxpv95MQh/q50xC4od
	 a/9758QgSdIvhtF1gY1N8tDJJ1gV5g88cM6JrlTwvKvtSzEi83+ntj5eSeLq4ARN0
	 h6YEOHUjkaIPUyh7QcE+fakThV8qAri6691ijMm4FGH3q9U/ZvwJT9AGalD+dUxoH
	 7LHVeNsW/v/SzwolWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1ttww23i4c-00g9Df; Tue, 17
 Dec 2024 21:38:17 +0100
Message-ID: <b5671e8c-295e-4ca3-b2b3-65495ffa1894@gmx.com>
Date: Wed, 18 Dec 2024 07:08:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle free space tree rebuild in multiple
 transactions
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
 <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
 <0509f570-3ff8-498e-9cc5-9b45d56fff2c@suse.com>
 <CAL3q7H5c8oYYBuhEQg8xo=MyA9pGhYnq-42FoS1usHgVBbTK-A@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5c8oYYBuhEQg8xo=MyA9pGhYnq-42FoS1usHgVBbTK-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2nE1ZDZPUZf+4mFhdeWCO0RnqPp9Q3Y1Xk4Xp/CGp+QE1md82HA
 1OKgJv5H26iVaICnJTOjnfJmrD/Oq6R17h/sdV9BVCQOZ+4w1p5uuJnI63EtOA2pnFGZ9Go
 99Xw7a9/tcidgyMxbTeWfYQnfeMjphIVZNQcbDdlZe8q4CV0Gs0Hs0EUj1aKPQs8Ck/HCHK
 npYhEER44cAs1K94+phhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ri+Rsy/tJEg=;7jIaOR23GE2CM36EWf7zikudGKF
 kmKGn0P18e8KmHL5uIs9S08WOlQOeewDTzPoF1U5R2wacBlBkYRRqIAayL8QJdnDcm+BPhu3E
 UGR63XVsMUZmv+FfwokUC34W+XJ/cmFtE2n9YXvu28s8i5ahdHrINA4J0Z14i/glqxB4jhF7q
 G4SIuqiuVVVz2Y8wlyF8dVjhWpCodJ6boGbZqo8b1lzD7NXe15oiyZHqaL4vc5gl57cGqUVkl
 7tokZvkKYQmlQSBNTpfGECOLqX2Irm12lpYmzSscXCHsBE4Y7o+PRBKD4p8zF3NRGL1Rgcwpe
 m1v7RHbKAs9K7hxiaTCWpEs24sWGJHHaxjaxnXaWjq7phugRRJFxXyvlt25tLrquG53s/bsG8
 FmtP4/rAcDebISI/dtYykErIZRqTWw8UjqtbnrWCVRNE974MZAtEMVYCg+zzlJHvi+acxWz29
 Y6VviGuDwsdKJLUO+xcNEe8vgP2isPL3vRyWqQ3TWoNPZduWei6+t1xwBTsEnQdwF8vhrEK02
 HCy0PiZVSilkJfN9TuABg3bu9bjCpF4IdSRguhATVvryD4IXRuc60EBWzKoj9yQU1x+/DV2f9
 tshTYwQSgsiqcsnK5gUjh83EvcnzRmX6CkqofqoPUI53/RvMCT2UTBjyukxFaxWgIaz69O/FK
 pS4an1ZUYSVR/QlrjwnOWMcZtlCyeWL0/lWgP+aNvr39IlICrVCmzkr0F4wkpX/BVF+L9xqE4
 YLHdPdf3DkiHRdXi21YgEWRY3lqO8ytaLaQwTZ7R4GGscmv/K48kFICuwq3PubT4XmSdT6c9H
 tUKxQj1EAHTuqdzZSEhSAP5FPrf6tohU9JSzG8Te7t6Xk2UFmNPmjE8xjpPmv+q5UDYFAIjhX
 klzsX5EN5MWTlPYytxXZW8gXsp3mC/hDOs7LeDVa7cyhVN1glwhTrNbH6Exi6gUwsy9NBRMbf
 eXbaYkplu5GG6x7l3vLi06Knhz++JeW5GMrhikAX0wAELyfVoRoHPbkHcdj2Z+aeVctx75zWg
 H29/ISIMbs8J2U9btfxMyb7L86agdArYFgW/ECrmoygT+Gi8Z+gGWKppio2hx+7nTPTEWYuH0
 Tf+DhNUNf931E5zpuN3QGwo5hCa7aS



=E5=9C=A8 2024/12/17 21:06, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Dec 17, 2024 at 9:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/17 19:15, Filipe Manana =E5=86=99=E9=81=93:
>>> On Tue, Dec 17, 2024 at 7:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>> During free space tree rebuild, we're holding on transaction handler =
for
>>>> the whole rebuild process.
>>>>
>>>> This will cause blocked task warning for btrfs-transaction kernel
>>>> thread, as during the rebuild, btrfs-transaction kthread has to wait =
for
>>>> the running transaction we're holding for free space tree rebuild.
>>>
>>> Do you have a stack trace?
>>> Does that happen where exactly, in the btrfs_attach_transaction() call
>>> chain, while waiting on a wait queue?
>>
>> Unfortunately no, thus it's only based on code analyze.
>>
>> The original reporter's stack are not related to free space cache
>> rebuild, but on metadata writeback wait:
>>
>> [101497.950425] INFO: task btrfs-transacti:29385 blocked for more than
>> 122 seconds.
>> [101497.950432]       Tainted: G        W  O       6.12.3-gentoo-x86_64=
 #1
>> [101497.950435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>> disables this message.
>> [101497.950437] task:btrfs-transacti state:D stack:0     pid:29385
>> tgid:29385 ppid:2      flags:0x00004000
>> [101497.950442] Call Trace:
>> [101497.950444]  <TASK>
>> [101497.950449]  __schedule+0x3f0/0xbd0
>> [101497.950458]  schedule+0x27/0xf0
>> [101497.950461]  io_schedule+0x46/0x70
>> [101497.950465]  folio_wait_bit_common+0x123/0x340
>> [101497.950472]  ? __pfx_wake_page_function+0x10/0x10
>> [101497.950477]  folio_wait_writeback+0x2b/0x80
>> [101497.950480]  __filemap_fdatawait_range+0x7d/0xd0
>> [101497.950489]  filemap_fdatawait_range+0x12/0x20
>> [101497.950493]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
>> [101497.950536]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
>> [101497.950572]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
>> [101497.950606]  ? start_transaction+0xc0/0x820 [btrfs]
>> [101497.950640]  transaction_kthread+0x159/0x1c0 [btrfs]
>> [101497.950674]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
>> [101497.950705]  kthread+0xd2/0x100
>> [101497.950710]  ? __pfx_kthread+0x10/0x10
>> [101497.950714]  ret_from_fork+0x34/0x50
>> [101497.950718]  ? __pfx_kthread+0x10/0x10
>> [101497.950721]  ret_from_fork_asm+0x1a/0x30
>> [101497.950727]  </TASK>
>>
>> Furthermore, the original reporter doesn't experience real hang.
>> The operation can finish (very large stream receive), sync and properly
>> unmount.
>> I believe the original report is mostly caused by the following reasons=
:
>>
>> - Too large physical RAM
>>     96GiB, causing too huge page cache
>>
>> - HDD
>>     Low IOPS
>>
>> - Mostly random metadata writes?
>
> Looking at that trace, I don't see how this change relates to it.
> That is, how this batching helps prevent that.

Exactly, this batching fix is unrelated to the report, just as I said.

Thanks,
Qu
>
> That happens when committing a transaction and we're in the unblocked
> transaction state, starting writeback of the metadata extents and
> waiting for the writeback to finish.
>
> Since the free space tree build code uses the same transaction handle
> to build the whole free space tree,
> the transaction kthread would block when calling
> btrfs_commit_transaction(), waiting for the free space tree build task
> to release its handle - but that's not what is happening here.
>
> The transaction kthread is doing the commit, and already in the
> unblocked transaction state, writing all dirty metadata extents.
> So that means it's not getting blocked by free tree build task holding
> a transaction handle - it may be holding a transaction handle open,
> but it's a different transaction already, since when the current
> transaction is in a state >=3D TRANS_STATE_UNBLOCKED, other tasks can
> start a new transaction.
>
> And each transaction has its own io tree to keep track of the metadata
> extents it created/dirtied (trans->transaction->dirty_pages),
> so even if the task building the free space tree keeps COWing and
> creating free space tree nodes/leaves, it doesn't affect the io tree
> of the
> committing transaction - these extent buffers will be written by the
> transaction used by the free space tree build task when it commits,
> and not by the one being committed by the transaction kthread.
>
> We should have the stack trace in the change log, a link to the
> reporter's thread and an explanation of how this batching helps
> anything - I don't see how, as explained above.
>
> Thanks.
>
>
>>
>>>
>>>>
>>>> On a large enough btrfs, we have thousands of block groups to go
>>>> through, thus it will definitely take over 120s and trigger the block=
ed
>>>> task warning.
>>>>
>>>> Fix the problem by handling 32 block groups in one transaction, and e=
nd
>>>> the transaction when we hit the 32 block groups threshold.
>>>>
>>>> This will allow the btrfs-transaction kthread to commit the transacti=
on
>>>> when needed.
>>>>
>>>> And even if during the rebuild the system lost its power, we are stil=
l
>>>> fine as we didn't set FREE_SPACE_TREE_VALID flag, thus on next RW mou=
nt
>>>> we will still rebuild the tree, without utilizing the half built one.
>>>
>>> What about if a crash happens and we already processed some block
>>> groups and the transaction got committed?
>>>
>>> On the next mount, when we call populate_free_space_tree() for the
>>> same block groups, because we always start from the first one, won't
>>> we get an -EEXIST and fail the mount?
>>> For example, add_new_free_space_info() doesn't ignore an -EEXIST when
>>> it calls btrfs_insert_empty_item(), so we will fail the mount when
>>> trying to build the tree.
>>
>> We are still fine:
>>
>> btrfs_start_pre_rw_mount()
>> |- rebuild_free_space_tree =3D true;
>> |  This is because our fs only has FREE_SPACE_TREE, but no
>> |  FREE_SPACE_TREE_VALID compat_ro flag.
>> |
>> |- btrfs_rebuild_free_space_tree()
>>      |- clear_free_space_tree()
>>         Which deletes all the free space tree items.
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/free-space-tree.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
>>>> index 7ba50e133921..d8f334724092 100644
>>>> --- a/fs/btrfs/free-space-tree.c
>>>> +++ b/fs/btrfs/free-space-tree.c
>>>> @@ -1312,6 +1312,8 @@ int btrfs_delete_free_space_tree(struct btrfs_f=
s_info *fs_info)
>>>>           return btrfs_commit_transaction(trans);
>>>>    }
>>>>
>>>> +/* How many block groups can be handled in one transaction. */
>>>> +#define FREE_SPACE_TREE_REBUILD_BATCH  (32)
>>>>    int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
>>>
>>> Please put a blank line after the macro declaration and place the
>>> macro at the top of the file before the C code.
>>>
>>>>    {
>>>>           struct btrfs_trans_handle *trans;
>>>> @@ -1322,6 +1324,7 @@ int btrfs_rebuild_free_space_tree(struct btrfs_=
fs_info *fs_info)
>>>>           };
>>>>           struct btrfs_root *free_space_root =3D btrfs_global_root(fs=
_info, &key);
>>>>           struct rb_node *node;
>>>> +       unsigned int handled =3D 0;
>>>>           int ret;
>>>>
>>>>           trans =3D btrfs_start_transaction(free_space_root, 1);
>>>> @@ -1350,6 +1353,15 @@ int btrfs_rebuild_free_space_tree(struct btrfs=
_fs_info *fs_info)
>>>>                           btrfs_end_transaction(trans);
>>>>                           return ret;
>>>>                   }
>>>> +               handled++;
>>>> +               handled %=3D FREE_SPACE_TREE_REBUILD_BATCH;
>>>> +               if (!handled) {
>>>> +                       btrfs_end_transaction(trans);
>>>> +                       trans =3D btrfs_start_transaction(free_space_=
root,
>>>> +                                       FREE_SPACE_TREE_REBUILD_BATCH=
);
>>>
>>> This is a fundamental change here, we are no longer reserving 1 unit
>>> but 32 instead.
>>> Plus the first call to btrfs_start_transaction(), before entering the
>>> loop, uses 1.
>>> For consistency, both places should reserve the same amount.
>>>
>>> But I think that changing the amount of reserved space should be a
>>> separate change with its own changelog,
>>> providing a rationale for it.
>>>
>>> It's odd indeed that only 1 item is being reserved, but on the other
>>> hand the block reserve associated with the free space tree root is the
>>> delayed refs reserve (see btrfs_init_root_block_rsv()),
>>> so changing the number of units passed to btrfs_start_transaction()
>>> shouldn't make much difference because the space reserved by a
>>> transaction goes to the transaction block reserve
>>> (fs_info->trans_block_rsv).
>>>
>>> And given that free space tree build/rebuild only touches the free
>>> space tree root, I don't see how that makes any difference, or at
>>> least it's not trivial, hence the separate change only for the space
>>> reservation
>>> amount and an explanation about why we are doing it.
>>>
>>> Thanks.
>>>
>>>
>>>> +                       if (IS_ERR(trans))
>>>> +                               return PTR_ERR(trans);
>>>> +               }
>>>>                   node =3D rb_next(node);
>>>>           }
>>>>
>>>> --
>>>> 2.47.1
>>>>
>>>>
>>
>


