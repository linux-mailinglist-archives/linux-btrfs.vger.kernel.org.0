Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098914B3468
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Feb 2022 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiBLLHf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Feb 2022 06:07:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiBLLHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Feb 2022 06:07:34 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356E22654C
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 03:07:30 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 09B119BCB6; Sat, 12 Feb 2022 11:07:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644664048;
        bh=Cq4q4MNup5923omIG8SEHuihL4lrgYxfrqYUg04ikFo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=SZBnnfLTstntlY2YY3VaC25tEOcam6narRUggVYrHtudaCXjK/r//hXXuOT6zaF7y
         D7lBP3WFdRKjzzbjDKRSF/n0GZ5QsqtS2ppNIEiShyagyP4dbk31rLL8/LpCbx2TsQ
         hhjGGDfLlUKXVtLBIfQax7ul/Avrnoj65nY+0m7rJL72BMnPetf6sBwJ04i3MZLbfZ
         KdZi0r/Cq+dyaInq36xk0eofVE2dTFqPzYMkRkPtOaxW4xD+k6c/hSuurzNKz/AIPa
         nicMbKz05GV0USm4ImteIfsXAvQfAgJk/4q0w0NmHKdD0ab+SERlmNobStp023vQwP
         BSHczpIaSfIRg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id D5A8B9B89E;
        Sat, 12 Feb 2022 11:06:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1644664016;
        bh=Cq4q4MNup5923omIG8SEHuihL4lrgYxfrqYUg04ikFo=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=rQ1EFdfe6EttrzU3QzUxZ0sktdH6WTRylrNsN3Z7fZvQL62UfzCCyvvg6puELDCZP
         fImivVyMI4YUTLl66OxHsRThHSRI4Lsa395adIvajFOBdLRpEI6Q0WcT1kY/5go4Hn
         nLdVzU2HCTcnNTTNmYgbQSXG3xhG9iIgn4CIIXB60i2/QHolpS30HiF1ILRBT8Yg1w
         nqjRxidDBOG0QfGrtaeR1rTE1YUska2gk9ah13Jl3JbfQwoFYw+J7qqXMw/AGtw+Nf
         U/XboboFtYWq3sV5j694NdQFFcFEQ043Udb0mAq84G058VOPQDJhI2MCL9HnVSZ2IJ
         hzl06VONgRraw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id A8E50120196;
        Sat, 12 Feb 2022 11:06:56 +0000 (GMT)
Message-ID: <7234174a-0d05-3f5a-11e4-3108f51a1744@cobb.uk.net>
Date:   Sat, 12 Feb 2022 11:06:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [PATCH v2] btrfs: Fix subvol turns RO if root is remounted RO
Content-Language: en-US
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org
References: <20220211140918.c6wpmh3pgzjuytve@fiona>
 <3c5b83dc-86f5-bedf-d1ba-71b05d0f19fa@cobb.uk.net>
 <20220211194451.oioy4xl3dr5ebmhr@fiona>
In-Reply-To: <20220211194451.oioy4xl3dr5ebmhr@fiona>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/02/2022 19:44, Goldwyn Rodrigues wrote:
> On 16:42 11/02, Graham Cobb wrote:
>>
>> On 11/02/2022 14:09, Goldwyn Rodrigues wrote:
>>> If a read-write root mount is remounted as read-only, the subvolume
>>> is also set to read-only.
>>>
>>> Use a rw_mounts counter to check the number of read-write mounts, and change
>>> superblock to read-only only in case there are no read-write subvol mounts.
>>> Disable SB_RDONLY in flags passed so superblock does not change
>>> read-only.
>>>
>>>
>>> Test case:
>>> DEV=/dev/vdb
>>> mkfs.btrfs -f $DEV
>>> mount $DEV /mnt
>>> btrfs subvol create /mnt/sv
>>> mount -o remount,ro /mnt
>>> mount -o subvol=/sv $DEV /mnt/sv
>>> findmnt # /mnt is RO, /mnt/sv RW
>>> mount -o remount,ro /mnt
>>> findmnt # /mnt is RO, /mnt/sv RO as well
>>> umount /mnt{/sv,}
>>>
>>>
>>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index a2991971c6b5..2bb6869f15af 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
>>>  	spinlock_t zone_active_bgs_lock;
>>>  	struct list_head zone_active_bgs;
>>>  
>>> +	/* Count of subvol mounts read-write */
>>> +	int rw_mounts;
>>> +
>>>  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>>>  	spinlock_t ref_verify_lock;
>>>  	struct rb_root block_tree;
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 33cfc9e27451..2072759d5f22 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
>>>  	/* mount_subvol() will free subvol_name and mnt_root */
>>>  	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
>>>  
>>> +	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
>>> +		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
>>> +		fs_info->rw_mounts++;
>>> +	}
>>> +
>>>  out:
>>>  	return root;
>>>  }
>>> @@ -1958,6 +1963,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>>>  		goto out;
>>>  
>>>  	if (*flags & SB_RDONLY) {
>>> +
>>> +		if (--fs_info->rw_mounts > 0) {
>>> +			*flags &= ~SB_RDONLY;
>>> +			goto out;
>>> +		}
>>>  		/*
>>>  		 * this also happens on 'umount -rf' or on shutdown, when
>>>  		 * the filesystem is busy.
>>> @@ -2057,6 +2067,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
>>>  		if (ret)
>>>  			goto restore;
>>>  
>>> +		fs_info->rw_mounts++;
>>> +
>>>  		btrfs_clear_sb_rdonly(sb);
>>>  
>>>  		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
>>>
>>
>> I'm sorry my earlier email wasn't clear. I still believe this is an
>> unacceptable change in behaviour, unless I am misunderstanding.
>>
>> Let me provide a short testcase to clarify my understanding and my
>> objection:
>>
>> Assume we have a device /dev/test.
>>
>> Current behaviour:
>>
>>   mkfs.btrfs /dev/test
>>   mkdir /mnt /mnt/1 /mnt/2
>>   mount /dev/test /mnt/1
>>   btrfs subv create /mnt/1/a
>>   btrfs subv create /mnt/1/b
>>   btrfs subv create /mnt/1/a/aa
>>   mount -o subvol=a /dev/test /mnt/2
>>
>>   touch /mnt/1/a/x /mnt/1/b/x /mnt/1/a/aa/x /mnt/2/xx /mnt/2/aa/xx
>>
>> All 5 files can be created. I can create files in all three subvolumes
>> accessed as /mnt/1/a, /mnt/1/b, /mnt/1/a/aa, /mnt/2 or /mnt/2/aa.
>>
>>   mount -o remount,ro /mnt/1
>> (or "mount -o remount,ro /mnt/2" the result is the same)
>>
>>   touch /mnt/1/a/x /mnt/1/b/x /mnt/1/a/aa/x /mnt/2/xx /mnt/2/aa/xx
>>
>> I cannot now create files in any of the three subvolumes accessed as
>> /mnt/1/a, /mnt/1/b, /mnt/1/a/aa, /mnt/2 or /mnt/2/aa.
>>
>> New behaviour:
>>
>> It is not immediately clear to me what your proposed change will do.
>> Will it result in all access via /mnt/1 (for example to /mnt/1/a/x)
>> being read-only but access via /mnt/2 to the same file (for example
>> /mnt/2/x) being read-write?
> 
> Yes.

Thanks for explaining that. So your change is really nothing to do with
subvolumes - it is mountpoints which count? You want to separate the
ro/rw status of each mountpoint of the same filesystem? If this
incompatible change is made, it will need very clear explanation of
*exactly* what the impact is to system managers. And I suggest changing
the patch title and description to make this clear.

> 
>>
>> Or will it result in access to the directory /mnt/1 itself being
>> read-only but access to the (subvolume) directories /mnt/1/a,
>> /mnt/1/a/aa and /mnt/1/b will be read-write? Please explain. [I think
>> this point is worth clarifying in the patch if it goes ahead - it is not
>> obvious whether the counter is a count of mount points or subvolumes]
> 
> Yes, but note that this situation can also be arrived at by (without
> this patch):
> 
> umount /mnt/1 /mnt/2
> mount -o ro /dev/vdb /mnt/1
> mount -o subvol=/a /dev/vdb /mnt/2

Yes. And it can be **immediately** undone (today) by:

mount -o remount,ro /dev/vdb /mnt/1

[note remounting the *already* ro mountpoint!]

I see that as a feature, not a bug. On many systems (including any I set
up, for example) I have one mountpoint which mounts subvolid=5 for each
btrfs filesystem (it is usually called something like /mnt/rootdisk or
/mnt/backups). That mp is always mounted and is the mp I use for any
filesystem maintenance operations. I also, of course, mount various
subvolumes into various places in the filesystem hierarchy (for example,
on one system I mount a subvol /cobb into /home/cobb). If I want to
quickly turn a whole disk ro I remount the /mnt/whatever whole disk
mountpoint to ro. I don't even have a script which searches for every
mountpoint of a particular disk and turns them all ro (and I still don't
know how such a script would handle namespaces).

> 
>>
>> I think either would be unacceptable changes - existing systems, scripts
>> and procedures have been created around the assumption that changing
>> *any* mount point to readonly makes the whole volume readonly. This may
>> not be ideal but it is existing behaviour, and is very simple to understand.
> 
> If the subvolumes are independent, shouldn't their access be too?
> 
>>
>> I would also like to understand how the system manager would make the
>> whole volume go readonly with your patch. Taking into account that there
>> may have also been mounts in other namespaces, associated with
>> containers and not directly visible.
>>
> 
> Would a subvolume remount,ro in one privileged namespace make a
> subvolume in another namespace read-only? Yes, perhaps sysadmins
> shouldn't give privileges to containers, but controlling one
> subvolume from another subvolume sounds like lack of control rather than
> being in control.
> 
> Ideally, setting subvolumes readonly should be done by btrfs property
> and not through mount flags.

That I agree with. If you want to turn an individual subvol ro there
should be a btrfs subvolume command to do it (it would, presumably,
survive reboots).

Similarly, if you want to be able to turn a btrfs mountpoint ro without
affecting the rest of the filesystem, there could be a new mount option
to do so. But it is **much** too late to change the behaviour of the
"readonly" mount option.

