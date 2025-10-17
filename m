Return-Path: <linux-btrfs+bounces-17912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB42BE6136
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 03:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF54487DBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05323B63E;
	Fri, 17 Oct 2025 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Ct1YmX6J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D843BB5A
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666287; cv=none; b=L4somGm/5J3H/7HFZoyaY532TzcXVpI5ypKNZ5EOipzFBAcgdUtCso8WxGRPzYe8B+MBN4eUYqE8X8Ab7quNZUej58a7HgQBAsIdiReowpkSUWokUFnJgPZQFGf/szryznHvgwVGovRxm/sHul3tcvNPDmBFbK9C4RDvEdO3azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666287; c=relaxed/simple;
	bh=nXwFQFnzBdJUGjLgKBgKY1G6F7hzDTfgyRxjBSE1Qsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6n5OgrMvD0i3N9VzGKz4qtBwRlZwBJDzoCwm0QRC0RD9UI4ITVQYONH66Fv+LRxuTZAH6TQK5Zp3xksLfFvk3lJRnEWVU1rcHdjAsbkYFUxCN/25br8HSrpYPL843VCiCaPIm/1pvqyPmBPWQSHqlD9cbBALtUIEAMAosBXT+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Ct1YmX6J; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Message-ID: <a8be12f9-32fe-4cf6-9782-d27a86ea02b0@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1760666281; bh=nXwFQFnzBdJUGjLgKBgKY1G6F7hzDTfgyRxjBSE1Qsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ct1YmX6J2ZJbHtLjzj/cc2FEvIbnyE/1FtShLe53yHKmn2xY0+fxAEOm6FwB2At5c
	 uPveuyLEV0CpkscuRmfjCd7FtdYGgynvGlxdfW23cXeA7iwv2h8nT1VWXo0MPD5vBN
	 B2L2H9M9e2p7/6VIuXcrCH9SbOtuXAWbfybx/1b4=
Date: Fri, 17 Oct 2025 09:58:00 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: send: don't send rmdir for same target multiple
 times with multi hardlink situation
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20251016075351.3369720-1-tchou@synology.com>
 <CAL3q7H4OjcSJzPy=f=JhJMzYMxM2UQT994JbdmFdtNKi5Pb3UA@mail.gmail.com>
Content-Language: en-US
From: tchou <tchou@synology.com>
In-Reply-To: <CAL3q7H4OjcSJzPy=f=JhJMzYMxM2UQT994JbdmFdtNKi5Pb3UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no



Filipe Manana 於 2025/10/16 23:14 寫道:
> On Thu, Oct 16, 2025 at 8:55 AM tchou <tchou@synology.com> wrote:
>>
>> From: Ting-Chang Hou <tchou@synology.com>
>>
>> In commit 29d6d30f5c8a("Btrfs: send, don't send rmdir for same target
> 
> Please leave a space before the opening parenthesis, that's the right syntax.
> 
>> multiple times") has fixed the issue that btrfs send rmdir for same
>> target multiple times by keep the last_dir_ino_rm and compare with
>> it before sending rmdir. But there have a corner case that if the
>> instructions that rm same dir not in a row, the fix will not work.
>>
>> Hardlinks of file are store in the same INODE_REF item, and if the
> 
> They are if they are in the same parent directory, that's an important detail.
> 
>> number of hardlinks is too large and exceed the size of one metadata
>> node can store, it will use INODE_EXTREF to store. The key of
>> INODE_EXTREF is (inode_id, INODE_EXTREF, hash of name), so if there are
> 
> hash of name and parent inode number
> 
>> two dir have hardlinks to the same file, the INODE_EXTREF items will
>> have cross sequence with two dir like below:
> 
> Suggestion: add a blank line to separate text from tree-dump output.
> It makes things more readable and easier to the eyes.
> 
>>      item 0 key (404 INODE_EXTREF 111512) itemoff 16239 itemsize 44
>>          inode extref index 4825 parent 403 namelen 4 name: 4824
>>          inode extref index 5825 parent 402 namelen 4 name: 5824
>>      item 1 key (404 INODE_EXTREF 398645) itemoff 16195 itemsize 44
>>          inode extref index 4569 parent 403 namelen 4 name: 4568
>>          inode extref index 5569 parent 402 namelen 4 name: 5568
>>
>> So when doing btrfs send, the instructions that rmdir for the two dir
>> are not in a row, and the previous fix will not work.
>>
>> We use rbtree to keep all the dirs that already add into `check_dirs`,
> 
> Just say that the fix of this patch does that.
> When you say "We use..." it gives the idea that's the code we
> currently have before this patch.
> 
>> and compare with it before add a new dir into it.
>>
>> The reproduce steps are as below:
> 
> Same here, blank line.
> 
>>      $ mkfs.btrfs -f /dev/sdb3
>>      $ mount /dev/sdb3 /mnt/
>>      $ mkdir /mnt/a /mnt/b
>>      $ echo 123 > /mnt/a/foo
>>      $ for i in $(seq 1 10000); do ln /mnt/a/foo /mnt/a/foo.$i; ln /mnt/a/foo /mnt/b/foo.$i; done
>>      $ btrfs subvolume snapshot -r /mnt/ /mnt/snap1
>>      $ btrfs send /mnt/snap1 -f /tmp/base.send
>>      $ rm -r /mnt/a /mnt/b
>>      $ btrfs subvolume snapshot -r /mnt/ /mnt/snap2
>>      $ btrfs send -p /mnt/snap1 /mnt/snap2 -f /tmp/incremental.send
>>
>>      $ umount /mnt
>>      $ mkfs.btrfs -f /dev/sdb3
>>      $ mount /dev/sdb3 /mnt
>>      $ btrfs receive /mnt -f /tmp/base.send
>>      $ btrfs receive /mnt -f /tmp/incremental.send
> 
> Suggestion: instead of pasting those lines with the $ and hardcoded
> mount points and device paths, turn it into a configurable script and
> paste it.
> Like this:
> 
> #!/bin/bash
> 
> DEV=/dev/sdi
> MNT=/mnt/sdi
> 
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> 
> mkdir $MNT/a $MNT/b
> 
> echo 123 > $MNT/a/foo
> for ((i = 1; i <= 1000; i++)); do
>     ln $MNT/a/foo $MNT/a/foo.$i
>     ln $MNT/a/foo $MNT/b/foo.$i
> done
> 
> btrfs subvolume snapshot -r $MNT $MNT/snap1
> btrfs send $MNT/snap1 -f /tmp/base.send
> 
> rm -r $MNT/a $MNT/b
> 
> btrfs subvolume snapshot -r $MNT $MNT/snap2
> btrfs send -p $MNT/snap1 $MNT/snap2 -f /tmp/incremental.send
> 
> umount $MNT
> mkfs.btrfs -f $DEV
> mount $DEV $MNT
> 
> btrfs receive $MNT -f /tmp/base.send
> btrfs receive $MNT -f /tmp/incremental.send
> 
> rm -f /tmp/base.send /tmp/incremental.send
> 
> umount $MNT
> 
> See, much easier to read, with more spaces and logical grouping, and
> variables to define device and mount paths, so like this anyone can
> copy paste this into a script, change the variables and immediately
> test.
> 1000 iterations for the loop is also more than enough to trigger the
> bug and it's a lot quicker than 10 000.
> 
>>
>> The second btrfs receive command failed with:
>>      ERROR: rmdir o4205145-4190-0 failed: No such file or directory
>>
>> Fixes: 29d6d30f5c8a("Btrfs: send, don't send rmdir for same target multiple times")
> 
> A Fixes tag is meant to be used to identify commits that introduce a bug.
> In this case, as you said in the first paragraph, that commit did not
> introduce the bug.
> It fixed cases of duplicated rmdir for the same directory as long as
> we don't have extrefs, but it didn't introduce the bug for when there
> are extrefs, it simply missed that case that already existed before.
> In other words, the reproducer fails both before and after that commit.
> 
> Also, that's a very long and confusing subject:
> 
> btrfs: send: don't send rmdir for same target multiple times with
> multi hardlink situation
> 
> I'm changing it to:
> 
> btrfs: send: fix duplicated rmdir operations when using extrefs
> 
>> Signed-off-by: Ting-Chang Hou <tchou@synology.com>
>> ---
>>   fs/btrfs/send.c | 56 ++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 48 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index 9230e5066fc6..c1b596e5f145 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -4100,6 +4100,48 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
>>          return ret;
>>   }
>>
>> +static int rbtree_check_dir_ref_comp(const void *k, const struct rb_node *node)
>> +{
>> +       const struct recorded_ref *data = k;
>> +       const struct recorded_ref *ref = rb_entry(node, struct recorded_ref, node);
>> +
>> +       if (data->dir > ref->dir)
>> +               return 1;
>> +       if (data->dir < ref->dir)
>> +               return -1;
>> +       if (data->dir_gen > ref->dir_gen)
>> +               return 1;
>> +       if (data->dir_gen < ref->dir_gen)
>> +               return -1;
>> +       return 0;
>> +}
>> +
>> +static bool rbtree_check_dir_ref_less(struct rb_node *node, const struct rb_node *parent)
>> +{
>> +       const struct recorded_ref *entry = rb_entry(node, struct recorded_ref, node);
>> +
>> +       return rbtree_check_dir_ref_comp(entry, parent) < 0;
>> +}
>> +
>> +static int record_check_dir_ref_in_tree(struct rb_root *root,
>> +                       struct recorded_ref *ref, struct list_head *list)
>> +{
>> +       int ret = 0;
>> +       struct recorded_ref *tmp_ref = NULL;
> 
> There's no need to initialize these variables.
> It's not about being pedantic here, but unnecessary initializations
> often trigger warnings from static analysis tools.
> For example see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=966de47ff0c9e64d74e1719e4480b7c34f6190fa
> 
>> +
>> +       if (rb_find(ref, root, rbtree_check_dir_ref_comp))
>> +               return 0;
>> +
>> +       ret = dup_ref(ref, list);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       tmp_ref = list_last_entry(list, struct recorded_ref, list);
>> +       rb_add(&tmp_ref->node, root, rbtree_check_dir_ref_less);
>> +       tmp_ref->root = root;
>> +       return 0;
>> +}
>> +
>>   static int rename_current_inode(struct send_ctx *sctx,
>>                                  struct fs_path *current_path,
>>                                  struct fs_path *new_path)
>> @@ -4131,7 +4173,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>          u64 ow_inode = 0;
>>          u64 ow_gen;
>>          u64 ow_mode;
>> -       u64 last_dir_ino_rm = 0;
>> +       struct rb_root rbtree_check_dirs = RB_ROOT;
> 
> I'm moving this declaration to be right below the checks_dirs list
> declaration, because these members are closely related and therefore
> it makes more sense to have them close to each other.
> 
> You don't need to send another patch version.
> I did those changes and rewrote sentences to fix grammar and make it
> less confusing and more detailed and pushed the patch to for-next [1].
> 
> Also, do you plan to send a test case for fstests?
> 
> Thanks.
Thank you for reviewing and rewriting. And I will try to figure out how 
to write a test case and send it to xfstests.

> 
> [1] https://github.com/btrfs/linux/commits/for-next/
> 
> 
>>          bool did_overwrite = false;
>>          bool is_orphan = false;
>>          bool can_rename = true;
>> @@ -4435,7 +4477,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>                                          goto out;
>>                          }
>>                  }
>> -               ret = dup_ref(cur, &check_dirs);
>> +               ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
>>                  if (ret < 0)
>>                          goto out;
>>          }
>> @@ -4463,7 +4505,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>                  }
>>
>>                  list_for_each_entry(cur, &sctx->deleted_refs, list) {
>> -                       ret = dup_ref(cur, &check_dirs);
>> +                       ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
>>                          if (ret < 0)
>>                                  goto out;
>>                  }
>> @@ -4473,7 +4515,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>                   * We have a moved dir. Add the old parent to check_dirs
>>                   */
>>                  cur = list_first_entry(&sctx->deleted_refs, struct recorded_ref, list);
>> -               ret = dup_ref(cur, &check_dirs);
>> +               ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
>>                  if (ret < 0)
>>                          goto out;
>>          } else if (!S_ISDIR(sctx->cur_inode_mode)) {
>> @@ -4507,7 +4549,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>                                  if (is_current_inode_path(sctx, cur->full_path))
>>                                          fs_path_reset(&sctx->cur_inode_path);
>>                          }
>> -                       ret = dup_ref(cur, &check_dirs);
>> +                       ret = record_check_dir_ref_in_tree(&rbtree_check_dirs, cur, &check_dirs);
>>                          if (ret < 0)
>>                                  goto out;
>>                  }
>> @@ -4550,8 +4592,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>                          ret = cache_dir_utimes(sctx, cur->dir, cur->dir_gen);
>>                          if (ret < 0)
>>                                  goto out;
>> -               } else if (ret == inode_state_did_delete &&
>> -                          cur->dir != last_dir_ino_rm) {
>> +               } else if (ret == inode_state_did_delete) {
>>                          ret = can_rmdir(sctx, cur->dir, cur->dir_gen);
>>                          if (ret < 0)
>>                                  goto out;
>> @@ -4563,7 +4604,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
>>                                  ret = send_rmdir(sctx, valid_path);
>>                                  if (ret < 0)
>>                                          goto out;
>> -                               last_dir_ino_rm = cur->dir;
>>                          }
>>                  }
>>          }
>> --
>> 2.34.1
>>
>>
>> Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.
>>

Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

