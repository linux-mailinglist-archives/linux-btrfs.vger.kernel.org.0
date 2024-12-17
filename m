Return-Path: <linux-btrfs+bounces-10470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C59F46C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 10:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1E47A2A44
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17DA1DDA37;
	Tue, 17 Dec 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dkn9ym4d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF095148314
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426164; cv=none; b=iOYlKJML69h+5QGZn0sgyOmPMTd84yonOqyY2i9KIbhKnqU5VIQs1NVVmYa4Pm6uTHtVLMsGIfuSr8WjU7RIoW9MWcWItmJqIAMpSdtHQ1jyoylopHxTeqvM7W2epAXuAIjEx384g/A3IR5/ok5g1UmmaVKvJdTbM2X0VhKKVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426164; c=relaxed/simple;
	bh=ItmRUZepoinPUCtmvt3jBfkdq+KWTl/bRhoeETIGFyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtkZzj0tdfemN0NI6bv4a0/AD+ixvW3SkX2eK6F3+b6Rxbg+RJqMmVozKiVpjRAC9Xkb3efBA70Yxw95YSYiXM1XSO5IhUJb8s21aPCEXVb0itzfaU9iDEUXGclFrKLaRm3WmL8reuOCn1rwUHw3YH6iLF9VS6CjQuFTPGkgnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dkn9ym4d; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e2880606so4636913f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734426160; x=1735030960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aSwURn9YihnfW4xVkVxOHddJjyG5Agq6W8EFk8UAvf4=;
        b=Dkn9ym4dFw3/JLtmCHExCAINKbD5yXPJNANv0PG/TlR7+Ve3cPWPAy4SczF3072m2I
         TUewVRJBB+PmEyCsOdhfAEkOIWGTQCZWuBG08avRETJ61VdYBAtJ0DqnpETUlU/b4lNy
         esrFI9o4qHBvoGxxio2EDxE2wRDbBWU5vhwAKpOWnmgXOZUGYNNKhgVUepLEitVSO0vV
         j4KYzSIxN+AyZ/kjBL6qNboc9UkoPoj+G2NH01eclifiRBm2kDbeuqzHZCGDPRKBLaMW
         r3Iecf/t678AvgFfDqlekplKTfjSc2W37x92TRFiZtjGYxY2kWNchg1IHeiD0uGjYcjm
         Exfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734426160; x=1735030960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSwURn9YihnfW4xVkVxOHddJjyG5Agq6W8EFk8UAvf4=;
        b=DCCoon1do/08bwSgKSE0wKeqwQBpy5Kmnwi75sUyhVM1nhyAzbfa7Qn0tuADSQQFJl
         oHVG+RWSr3BX6mOB8wsACcXNzNhsX6SlOZcaqhbKXQQKeD0cLqKrfm+6KI/cSK3v1n41
         E9p61NJ6oS3HdFaOBngjGKlbRGw8df3i6TzsTnllniZnqrfKMoHulaRRlibaic50AWZV
         ITaMhAO3AiCx3CXhUC2BBC4tr5FSWf1a0IPPq+XSd0vdJcfWEjHrpIKXLfAP+VhGtNqW
         ZAF7Uew1OQJr4+m+M/hm0cMHCffy6D0yz6r15pWthYgxwSu1B2EGkrGiIZnw+pl3+eap
         9nlA==
X-Gm-Message-State: AOJu0YymXGNXsQJb2q9EXkUvPvOkwjDQg3/B7WNsCANFugAUL/tNJJsW
	6pyT7PaL0/wtEZfIGkH3D1/u/pbgOsTc+y6hInJg4Cm5flE5rZEM2BQarzdxXco=
X-Gm-Gg: ASbGncsug1bCFr5rqb3eHuG7Q4EDlcDLoET+u83J6zfIOaLg/eWE/LVcU3K30IqJQA7
	R5X4h2imrJCRsQfUEbJI8f7RU9B9kG4W4ArZwuLSkycF0T08RvUkBz1ueHTie73KBp+fLol46Nv
	rCp+ZXi/rm6J78PcCoMkyX8vFoqG4+dfBB+wJZGmJLn4Hg2KxIpLqaPXqZ+dvEf1StMedHh0s/6
	oxMM0y1aMXviJar24dGgvtV5lTAKG9C6WmeJBVaw3WsBlttees1sKxN7IgqXA0PCoRu+9Sb9D+U
	eHeNW3bM
X-Google-Smtp-Source: AGHT+IG60825TYc10un0R9cf7aWFgSP/fi1jyH47Z4THrTHGtSo9R26B2MWMduyIQZ6E5D6+dnzTjA==
X-Received: by 2002:a05:6000:4615:b0:386:605:77e with SMTP id ffacd0b85a97d-3888e0bfb19mr13098965f8f.49.1734426159724;
        Tue, 17 Dec 2024 01:02:39 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b78e47sm6362877b3a.101.2024.12.17.01.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 01:02:39 -0800 (PST)
Message-ID: <0509f570-3ff8-498e-9cc5-9b45d56fff2c@suse.com>
Date: Tue, 17 Dec 2024 19:32:34 +1030
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
Cc: linux-btrfs@vger.kernel.org
References: <58dac27acbab72124549718201bec971491b5b1a.1734420572.git.wqu@suse.com>
 <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <CAL3q7H7xPN+w4xYWaDUceYDZTot5Nab3V19afhnfko3w6A74Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/17 19:15, Filipe Manana 写道:
> On Tue, Dec 17, 2024 at 7:31 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> During free space tree rebuild, we're holding on transaction handler for
>> the whole rebuild process.
>>
>> This will cause blocked task warning for btrfs-transaction kernel
>> thread, as during the rebuild, btrfs-transaction kthread has to wait for
>> the running transaction we're holding for free space tree rebuild.
> 
> Do you have a stack trace?
> Does that happen where exactly, in the btrfs_attach_transaction() call
> chain, while waiting on a wait queue?

Unfortunately no, thus it's only based on code analyze.

The original reporter's stack are not related to free space cache 
rebuild, but on metadata writeback wait:

[101497.950425] INFO: task btrfs-transacti:29385 blocked for more than
122 seconds.
[101497.950432]       Tainted: G        W  O       6.12.3-gentoo-x86_64 #1
[101497.950435] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[101497.950437] task:btrfs-transacti state:D stack:0     pid:29385
tgid:29385 ppid:2      flags:0x00004000
[101497.950442] Call Trace:
[101497.950444]  <TASK>
[101497.950449]  __schedule+0x3f0/0xbd0
[101497.950458]  schedule+0x27/0xf0
[101497.950461]  io_schedule+0x46/0x70
[101497.950465]  folio_wait_bit_common+0x123/0x340
[101497.950472]  ? __pfx_wake_page_function+0x10/0x10
[101497.950477]  folio_wait_writeback+0x2b/0x80
[101497.950480]  __filemap_fdatawait_range+0x7d/0xd0
[101497.950489]  filemap_fdatawait_range+0x12/0x20
[101497.950493]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
[101497.950536]  btrfs_write_and_wait_transaction+0x5e/0xd0 [btrfs]
[101497.950572]  btrfs_commit_transaction+0x8d9/0xe80 [btrfs]
[101497.950606]  ? start_transaction+0xc0/0x820 [btrfs]
[101497.950640]  transaction_kthread+0x159/0x1c0 [btrfs]
[101497.950674]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
[101497.950705]  kthread+0xd2/0x100
[101497.950710]  ? __pfx_kthread+0x10/0x10
[101497.950714]  ret_from_fork+0x34/0x50
[101497.950718]  ? __pfx_kthread+0x10/0x10
[101497.950721]  ret_from_fork_asm+0x1a/0x30
[101497.950727]  </TASK>

Furthermore, the original reporter doesn't experience real hang.
The operation can finish (very large stream receive), sync and properly 
unmount.
I believe the original report is mostly caused by the following reasons:

- Too large physical RAM
   96GiB, causing too huge page cache

- HDD
   Low IOPS

- Mostly random metadata writes?

> 
>>
>> On a large enough btrfs, we have thousands of block groups to go
>> through, thus it will definitely take over 120s and trigger the blocked
>> task warning.
>>
>> Fix the problem by handling 32 block groups in one transaction, and end
>> the transaction when we hit the 32 block groups threshold.
>>
>> This will allow the btrfs-transaction kthread to commit the transaction
>> when needed.
>>
>> And even if during the rebuild the system lost its power, we are still
>> fine as we didn't set FREE_SPACE_TREE_VALID flag, thus on next RW mount
>> we will still rebuild the tree, without utilizing the half built one.
> 
> What about if a crash happens and we already processed some block
> groups and the transaction got committed?
> 
> On the next mount, when we call populate_free_space_tree() for the
> same block groups, because we always start from the first one, won't
> we get an -EEXIST and fail the mount?
> For example, add_new_free_space_info() doesn't ignore an -EEXIST when
> it calls btrfs_insert_empty_item(), so we will fail the mount when
> trying to build the tree.

We are still fine:

btrfs_start_pre_rw_mount()
|- rebuild_free_space_tree = true;
|  This is because our fs only has FREE_SPACE_TREE, but no
|  FREE_SPACE_TREE_VALID compat_ro flag.
|
|- btrfs_rebuild_free_space_tree()
    |- clear_free_space_tree()
       Which deletes all the free space tree items.

Thanks,
Qu

> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/free-space-tree.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
>> index 7ba50e133921..d8f334724092 100644
>> --- a/fs/btrfs/free-space-tree.c
>> +++ b/fs/btrfs/free-space-tree.c
>> @@ -1312,6 +1312,8 @@ int btrfs_delete_free_space_tree(struct btrfs_fs_info *fs_info)
>>          return btrfs_commit_transaction(trans);
>>   }
>>
>> +/* How many block groups can be handled in one transaction. */
>> +#define FREE_SPACE_TREE_REBUILD_BATCH  (32)
>>   int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
> 
> Please put a blank line after the macro declaration and place the
> macro at the top of the file before the C code.
> 
>>   {
>>          struct btrfs_trans_handle *trans;
>> @@ -1322,6 +1324,7 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
>>          };
>>          struct btrfs_root *free_space_root = btrfs_global_root(fs_info, &key);
>>          struct rb_node *node;
>> +       unsigned int handled = 0;
>>          int ret;
>>
>>          trans = btrfs_start_transaction(free_space_root, 1);
>> @@ -1350,6 +1353,15 @@ int btrfs_rebuild_free_space_tree(struct btrfs_fs_info *fs_info)
>>                          btrfs_end_transaction(trans);
>>                          return ret;
>>                  }
>> +               handled++;
>> +               handled %= FREE_SPACE_TREE_REBUILD_BATCH;
>> +               if (!handled) {
>> +                       btrfs_end_transaction(trans);
>> +                       trans = btrfs_start_transaction(free_space_root,
>> +                                       FREE_SPACE_TREE_REBUILD_BATCH);
> 
> This is a fundamental change here, we are no longer reserving 1 unit
> but 32 instead.
> Plus the first call to btrfs_start_transaction(), before entering the
> loop, uses 1.
> For consistency, both places should reserve the same amount.
> 
> But I think that changing the amount of reserved space should be a
> separate change with its own changelog,
> providing a rationale for it.
> 
> It's odd indeed that only 1 item is being reserved, but on the other
> hand the block reserve associated with the free space tree root is the
> delayed refs reserve (see btrfs_init_root_block_rsv()),
> so changing the number of units passed to btrfs_start_transaction()
> shouldn't make much difference because the space reserved by a
> transaction goes to the transaction block reserve
> (fs_info->trans_block_rsv).
> 
> And given that free space tree build/rebuild only touches the free
> space tree root, I don't see how that makes any difference, or at
> least it's not trivial, hence the separate change only for the space
> reservation
> amount and an explanation about why we are doing it.
> 
> Thanks.
> 
> 
>> +                       if (IS_ERR(trans))
>> +                               return PTR_ERR(trans);
>> +               }
>>                  node = rb_next(node);
>>          }
>>
>> --
>> 2.47.1
>>
>>


