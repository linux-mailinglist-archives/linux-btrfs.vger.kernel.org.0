Return-Path: <linux-btrfs+bounces-10581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC59F6EAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 21:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2033618918CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 20:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4E61FBC96;
	Wed, 18 Dec 2024 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wn0V6I+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD5155C87
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552292; cv=none; b=lB1jvMNUg+IPpOQwgXT3T5i6OrlSuxIn71mxgCSVoMWoSrutPrYSQ7NtB8TyF4vNEhMLyxFROpKItkNnBZw1s2/UKGln8qpfA6A+5ITK3lovMTsq2kLlS8U0AjcXidjxO/W/GzbTilBOHghX2euj5diiGPmGV8Nt4pBy2BHSCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552292; c=relaxed/simple;
	bh=hODHNMLM9Nx2R7G1L/ZX9jYkzYv8YT6fCL/5+Yk//z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UR8UXyTIIeUm5Me13sJVEc9wkjdELwrbR5lxoo3MHWVDXfVsZ9gkfK0E5unVLos/GwQWu4R+PUkQPRY1QU2mHLYN5qwegJdOqsezrBInp9gJZkp2SBQZufrPhXIQZE8CcejtvF8l4NwLvH3D1CJzlxqjPoonN55GNrWzl+TEYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wn0V6I+O; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734552287; x=1735157087; i=quwenruo.btrfs@gmx.com;
	bh=FXXFNsPFLw1dc/xgaN357jL1TECfwWaLCvTm0WNDnBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Wn0V6I+O2atOghF48ZmaZ/qZuYcszBP1KlM+x1nrZLHX/B8JLySxT0l8RTnkjhHP
	 GMjSVn/PXf/b4TubSIHR8AfusPvBMSEDiSid3xsA1MJYgoxh8W6CTzuWapYv26Rbz
	 gTiZ7B9d3ZhSIlhkl3IyZ8NRGsuAH0AHwv2zZP+ReJsVoAszgbz2dPTrNxxecOT8w
	 9G5zgxF3f2fuYi/qncsFJf4b+95lRC0aQOku7S9iuqQ9LseOOxyp0XnXrFfIT7EPg
	 A9MUi7hEfIqLHrDcn4TEsApJWei2MGz/wlDiH7adN6VKZ9NJJp7kN29MCIXVlova8
	 X8EvThKSeKde3MFrqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmlTC-1tp3Zw1qWU-00kjvh; Wed, 18
 Dec 2024 21:04:47 +0100
Message-ID: <7c7594f7-bc26-4a4f-ad6f-f83bfbdabaed@gmx.com>
Date: Thu, 19 Dec 2024 06:34:43 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle free space tree rebuild in multiple
 transactions
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
 <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
 <0509f570-3ff8-498e-9cc5-9b45d56fff2c@suse.com>
 <CAL3q7H5c8oYYBuhEQg8xo=MyA9pGhYnq-42FoS1usHgVBbTK-A@mail.gmail.com>
 <b5671e8c-295e-4ca3-b2b3-65495ffa1894@gmx.com>
 <CAL3q7H4JtteM6WhbrR4=+85EvBxk9Tw2rJzjHy8sjdwmmj2UEA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4JtteM6WhbrR4=+85EvBxk9Tw2rJzjHy8sjdwmmj2UEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aP5T9RlRtPln4X4DCKqCAB+E6DGyfvYYPWkcILAyo+jCVm4OcTv
 B+88MUMoXjIRIMb54Ki+fpzhCX3L+pi5aWQ0loSe36uARaZ90zsBvyaVXXKywEDvdwnCZg5
 N2Plh9bbjZERIxZ6kLjwYRLhcmedBujxACiK7XwnnBM8MneLcElXNVoaK4GRijPW/uKEoe1
 zefxaEBUqpmYCQ5PFl4KQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k9ZY44ABJHs=;S0YagRAcO1icTUeyPU2J2NVDyhQ
 XK1SuV9IFo0utY/lLPlBMgW5ABe5+/nPs2RYad8TdHet8CHSNxAGsJWwNOlvFEMXrXE428R93
 LqpwFSMX2ux9dKxRF1a3PMFGJFoDHIiG2ihIxzooJMpvu5SDmwc55rOKudTUi964R0j+OF/zy
 KY128qD7nNfWbS+RQoCTKG31rkEJt+MNSpabflv/977fUcEDomCJ1OnT/dk3DPHwrfoKafg1p
 MUEuvbtSecxeTolhQ0cDiuAsXo0kQ3kaEYsROOG6QpiptBnRgGilRM5BbCJEnMz50F8LzhV0P
 PRo8PMj2AflEcLqkkSqm+evxNFrmRDZkaL/7nDxqwGh+yRrAqGz0TSsS35EGp7DjQ/t79IYmy
 B9mk4kTHox331+mByF5zMLBEW/FA74z+CHxKH1h0aVbCQZQEg5Yvm9pa/35wQukXve9O9zBX6
 QfF3o+i16irn5+bfGwQ8lq5ALvBCy8Vv2QHldDBHs4QABGWXIkAdWwlHmjtsEUCN7M+zvm5Iw
 7rG50FEyYuBqYRigeTZ6VAb4RCTjv2BASZtPLs+GzL+eqqKF4qH7/LZhUIuVsbhjX+V0G1lJm
 FU0YIUWNoAlAs3AUtHX0WC3TvahDEeYAi788eetYmakCFoJ3w7VNhPQNjEOpnrlxgZ9fjQO3o
 GgrOspUtVq6snK/BeKzO1uurD2n+y+UpMxtXHO825EAcY97UptIRhRllyKjfT7UY7aG8hkXeF
 3zN6xYF5h0RIBhtbjmf14tSrrAu+Q4y45dl5/0Y71Yayu6o6Dp3PZj6cWGgXxUAHRAun65PrN
 XH/q73R7FsZ+QT/9uKgeWKmWX7d9oY63vtuQ0XfONk3U9C7Iu949kk1di1z7OtPCeFTcsSDHb
 Awjs3Dn3ujYf2yBP0NlfCEv8MhZELdnrcKWxIQN4sx9s6E5aBmhHT3olyi1BVfR4vyk78SRgH
 S5N3w26Moc9kEhuCgrnti4ZWQf/1Fq+DRF2Xte60HHyHsz/CiqnhH3QpuLlVN0OUhda3ELHgq
 pbNTRs29Gg3MXcK8SsKsoVSQiZSigmLSZpQbsplSL4+GjLOzuxCB/pE7VLGt/fbdyS35BZx7A
 yDGC/PA1RsiOMuqYVKfol0hXyw1Tw+



=E5=9C=A8 2024/12/18 22:15, Filipe Manana =E5=86=99=E9=81=93:
> On Tue, Dec 17, 2024 at 8:38=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/17 21:06, Filipe Manana =E5=86=99=E9=81=93:
>>> On Tue, Dec 17, 2024 at 9:02=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/17 19:15, Filipe Manana =E5=86=99=E9=81=93:
>>>>> On Tue, Dec 17, 2024 at 7:31=E2=80=AFAM Qu Wenruo <wqu@suse.com> wro=
te:
>>>>>>
>>>>>> During free space tree rebuild, we're holding on transaction handle=
r for
>>>>>> the whole rebuild process.
>>>>>>
>>>>>> This will cause blocked task warning for btrfs-transaction kernel
>>>>>> thread, as during the rebuild, btrfs-transaction kthread has to wai=
t for
>>>>>> the running transaction we're holding for free space tree rebuild.
>>>>>
>>>>> Do you have a stack trace?
>>>>> Does that happen where exactly, in the btrfs_attach_transaction() ca=
ll
>>>>> chain, while waiting on a wait queue?
>>>>
>>>> Unfortunately no, thus it's only based on code analyze.
>>>>
>>>> The original reporter's stack are not related to free space cache
>>>> rebuild, but on metadata writeback wait:
>>>>
>>>> [101497.950425] INFO: task btrfs-transacti:29385 blocked for more tha=
n
>>>> 122 seconds.
>>>> [101497.950432]       Tainted: G        W  O       6.12.3-gentoo-x86_=
64 #1
>>>> [101497.950435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
>>>> disables this message.
>>>> [101497.950437] task:btrfs-transacti state:D stack:0     pid:29385
>>>> tgid:29385 ppid:2      flags:0x00004000
>>>> [101497.950442] Call Trace:
>>>> [101497.950444]  <TASK>
>>>> [101497.950449]  __schedule+0x3f0/0xbd0
>>>> [101497.950458]  schedule+0x27/0xf0
>>>> [101497.950461]  io_schedule+0x46/0x70
>>>> [101497.950465]  folio_wait_bit_common+0x123/0x340
>>>> [101497.950472]  ? __pfx_wake_page_function+0x10/0x10
>>>> [101497.950477]  folio_wait_writeback+0x2b/0x80
>>>> [101497.950480]  __filemap_fdatawait_range+0x7d/0xd0
>>>> [101497.950489]  filemap_fdatawait_range+0x12/0x20
>>>> [101497.950493]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
>>>> [101497.950536]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
>>>> [101497.950572]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
>>>> [101497.950606]  ? start_transaction+0xc0/0x820 [btrfs]
>>>> [101497.950640]  transaction_kthread+0x159/0x1c0 [btrfs]
>>>> [101497.950674]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
>>>> [101497.950705]  kthread+0xd2/0x100
>>>> [101497.950710]  ? __pfx_kthread+0x10/0x10
>>>> [101497.950714]  ret_from_fork+0x34/0x50
>>>> [101497.950718]  ? __pfx_kthread+0x10/0x10
>>>> [101497.950721]  ret_from_fork_asm+0x1a/0x30
>>>> [101497.950727]  </TASK>
>>>>
>>>> Furthermore, the original reporter doesn't experience real hang.
>>>> The operation can finish (very large stream receive), sync and proper=
ly
>>>> unmount.
>>>> I believe the original report is mostly caused by the following reaso=
ns:
>>>>
>>>> - Too large physical RAM
>>>>      96GiB, causing too huge page cache
>>>>
>>>> - HDD
>>>>      Low IOPS
>>>>
>>>> - Mostly random metadata writes?
>>>
>>> Looking at that trace, I don't see how this change relates to it.
>>> That is, how this batching helps prevent that.
>>
>> Exactly, this batching fix is unrelated to the report, just as I said.
>
> So I think this batch thing is not really appropriate:
>
> 1) There's the thing about the space reservation mentioned earlier;
>
> 2) Picking 32 or any other number may result in unnecessary churn by
> calling end_transaction() / star_transaction() too often,
>     as we're likely to be able to process much more than 32 block
> groups before the transaction kthread attempts to
>     commit the transaction.
>
> Instead of that, just periodically call
> btrfs_should_end_transaction(), and release the handle and start a new
> one if it returns true.

That sounds much better indeed.

Will go that path.

Thanks,
Qu

>
> This is all we need since it returns true when the transaction kthread
> attempts to start the commit (state set to TRANS_STATE_COMMIT_START).
> This way the kthread won't wait for potentially too long in the
> transaction's wait queue and trigger any warning about being blocked
> for too long.
>
> Thanks.
>
>
>>
>> Thanks,
>> Qu
>>>
>>> That happens when committing a transaction and we're in the unblocked
>>> transaction state, starting writeback of the metadata extents and
>>> waiting for the writeback to finish.
>>>
>>> Since the free space tree build code uses the same transaction handle
>>> to build the whole free space tree,
>>> the transaction kthread would block when calling
>>> btrfs_commit_transaction(), waiting for the free space tree build task
>>> to release its handle - but that's not what is happening here.
>>>
>>> The transaction kthread is doing the commit, and already in the
>>> unblocked transaction state, writing all dirty metadata extents.
>>> So that means it's not getting blocked by free tree build task holding
>>> a transaction handle - it may be holding a transaction handle open,
>>> but it's a different transaction already, since when the current
>>> transaction is in a state >=3D TRANS_STATE_UNBLOCKED, other tasks can
>>> start a new transaction.
>>>
>>> And each transaction has its own io tree to keep track of the metadata
>>> extents it created/dirtied (trans->transaction->dirty_pages),
>>> so even if the task building the free space tree keeps COWing and
>>> creating free space tree nodes/leaves, it doesn't affect the io tree
>>> of the
>>> committing transaction - these extent buffers will be written by the
>>> transaction used by the free space tree build task when it commits,
>>> and not by the one being committed by the transaction kthread.
>>>
>>> We should have the stack trace in the change log, a link to the
>>> reporter's thread and an explanation of how this batching helps
>>> anything - I don't see how, as explained above.
>>>
>>> Thanks.
>>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> On a large enough btrfs, we have thousands of block groups to go
>>>>>> through, thus it will definitely take over 120s and trigger the blo=
cked
>>>>>> task warning.
>>>>>>
>>>>>> Fix the problem by handling 32 block groups in one transaction, and=
 end
>>>>>> the transaction when we hit the 32 block groups threshold.
>>>>>>
>>>>>> This will allow the btrfs-transaction kthread to commit the transac=
tion
>>>>>> when needed.
>>>>>>
>>>>>> And even if during the rebuild the system lost its power, we are st=
ill
>>>>>> fine as we didn't set FREE_SPACE_TREE_VALID flag, thus on next RW m=
ount
>>>>>> we will still rebuild the tree, without utilizing the half built on=
e.
>>>>>
>>>>> What about if a crash happens and we already processed some block
>>>>> groups and the transaction got committed?
>>>>>
>>>>> On the next mount, when we call populate_free_space_tree() for the
>>>>> same block groups, because we always start from the first one, won't
>>>>> we get an -EEXIST and fail the mount?
>>>>> For example, add_new_free_space_info() doesn't ignore an -EEXIST whe=
n
>>>>> it calls btrfs_insert_empty_item(), so we will fail the mount when
>>>>> trying to build the tree.
>>>>
>>>> We are still fine:
>>>>
>>>> btrfs_start_pre_rw_mount()
>>>> |- rebuild_free_space_tree =3D true;
>>>> |  This is because our fs only has FREE_SPACE_TREE, but no
>>>> |  FREE_SPACE_TREE_VALID compat_ro flag.
>>>> |
>>>> |- btrfs_rebuild_free_space_tree()
>>>>       |- clear_free_space_tree()
>>>>          Which deletes all the free space tree items.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>     fs/btrfs/free-space-tree.c | 12 ++++++++++++
>>>>>>     1 file changed, 12 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.=
c
>>>>>> index 7ba50e133921..d8f334724092 100644
>>>>>> --- a/fs/btrfs/free-space-tree.c
>>>>>> +++ b/fs/btrfs/free-space-tree.c
>>>>>> @@ -1312,6 +1312,8 @@ int btrfs_delete_free_space_tree(struct btrfs=
_fs_info *fs_info)
>>>>>>            return btrfs_commit_transaction(trans);
>>>>>>     }
>>>>>>
>>>>>> +/* How many block groups can be handled in one transaction. */
>>>>>> +#define FREE_SPACE_TREE_REBUILD_BATCH  (32)
>>>>>>     int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info=
)
>>>>>
>>>>> Please put a blank line after the macro declaration and place the
>>>>> macro at the top of the file before the C code.
>>>>>
>>>>>>     {
>>>>>>            struct btrfs_trans_handle *trans;
>>>>>> @@ -1322,6 +1324,7 @@ int btrfs_rebuild_free_space_tree(struct btrf=
s_fs_info *fs_info)
>>>>>>            };
>>>>>>            struct btrfs_root *free_space_root =3D btrfs_global_root=
(fs_info, &key);
>>>>>>            struct rb_node *node;
>>>>>> +       unsigned int handled =3D 0;
>>>>>>            int ret;
>>>>>>
>>>>>>            trans =3D btrfs_start_transaction(free_space_root, 1);
>>>>>> @@ -1350,6 +1353,15 @@ int btrfs_rebuild_free_space_tree(struct btr=
fs_fs_info *fs_info)
>>>>>>                            btrfs_end_transaction(trans);
>>>>>>                            return ret;
>>>>>>                    }
>>>>>> +               handled++;
>>>>>> +               handled %=3D FREE_SPACE_TREE_REBUILD_BATCH;
>>>>>> +               if (!handled) {
>>>>>> +                       btrfs_end_transaction(trans);
>>>>>> +                       trans =3D btrfs_start_transaction(free_spac=
e_root,
>>>>>> +                                       FREE_SPACE_TREE_REBUILD_BAT=
CH);
>>>>>
>>>>> This is a fundamental change here, we are no longer reserving 1 unit
>>>>> but 32 instead.
>>>>> Plus the first call to btrfs_start_transaction(), before entering th=
e
>>>>> loop, uses 1.
>>>>> For consistency, both places should reserve the same amount.
>>>>>
>>>>> But I think that changing the amount of reserved space should be a
>>>>> separate change with its own changelog,
>>>>> providing a rationale for it.
>>>>>
>>>>> It's odd indeed that only 1 item is being reserved, but on the other
>>>>> hand the block reserve associated with the free space tree root is t=
he
>>>>> delayed refs reserve (see btrfs_init_root_block_rsv()),
>>>>> so changing the number of units passed to btrfs_start_transaction()
>>>>> shouldn't make much difference because the space reserved by a
>>>>> transaction goes to the transaction block reserve
>>>>> (fs_info->trans_block_rsv).
>>>>>
>>>>> And given that free space tree build/rebuild only touches the free
>>>>> space tree root, I don't see how that makes any difference, or at
>>>>> least it's not trivial, hence the separate change only for the space
>>>>> reservation
>>>>> amount and an explanation about why we are doing it.
>>>>>
>>>>> Thanks.
>>>>>
>>>>>
>>>>>> +                       if (IS_ERR(trans))
>>>>>> +                               return PTR_ERR(trans);
>>>>>> +               }
>>>>>>                    node =3D rb_next(node);
>>>>>>            }
>>>>>>
>>>>>> --
>>>>>> 2.47.1
>>>>>>
>>>>>>
>>>>
>>>
>>


