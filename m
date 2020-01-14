Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3F139F8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 03:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgANCkH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jan 2020 21:40:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42179 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgANCkH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jan 2020 21:40:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so5825021pfz.9
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2020 18:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=baeNMzBfRZnv0iXxrFUydwibqSLYFbIKLHwZYh9xG3o=;
        b=Kp0GI20MroCon/XozIzwcl8RETSedl1kPDRgJFy3+fsrYoofzn/X5Q6KAFmqU5Qsb/
         tU5OheNWcR2SS5p9n9QFzNjsN7mg6ZDpvwksAXhS99KtfDhrUuzNNU0CuhH+i+VhxseY
         RY07Z+AQplHS6LB/Eaw4b5EkK01LCXnTfXhlqNd2DokGH0rx1vk8NUUJOEzwzCN37hoO
         j43m0vgM1NEBKnK9IvnO4sjUhyy5G/sV4Eo8KitIhJZFaoImwfJkByevIrEDqtvLKWhL
         ViyLVsyhi0eLXzWWqwwpXrpT1/IWV5ne3JfnWbds3SNFp0Gy25eRzax903V6VnIJEty1
         ek6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=baeNMzBfRZnv0iXxrFUydwibqSLYFbIKLHwZYh9xG3o=;
        b=tfEXQJjyOghabNxdIwQEUp7oZC42zndPEc6pRSyocAhykfRjEsJm/DEaGbJadyCslB
         BgMrwszR3OFIpczFMV6iCpop4TTAFZpKsCZjOPlMVBTefG5lp+zWSohdtspYiETswVQZ
         aOzYPeqHQQdhkQXuXkS6KsUfTysuuXFTzWenWwRajo61FwaytH4fOc0sgyq/HK8FUkbT
         L6S5BVKK6W+gWFHBxZQkSM79BakHex33TdFjURCO9XbaEU5ReP94wGM7VlS7/iQGI7hP
         /6B1TsUJOeDQS13cnoYta4sNONkinMJP7QFfAUvbit215OGPeXS6GLvr601SJ3/KZod3
         e7ig==
X-Gm-Message-State: APjAAAXZUGFy4+dJyJ25DVFcitj23KfKopmGiP3aB9uo+xB6mnjYgIQY
        PHun/McRT1HKlAOpOZv8QLV8ow==
X-Google-Smtp-Source: APXvYqwClUXuNEWAqeBLas+wcPX5mVaahTAf65sNiQhKwDkzNl32lXy7h70KxOFbwzM2pufxpWa85w==
X-Received: by 2002:a63:201d:: with SMTP id g29mr25116073pgg.427.1578969606225;
        Mon, 13 Jan 2020 18:40:06 -0800 (PST)
Received: from [10.11.6.52] ([96.68.148.21])
        by smtp.gmail.com with ESMTPSA id w11sm16082784pfi.77.2020.01.13.18.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 18:40:05 -0800 (PST)
Subject: Re: [PATCH 2/2] btrfs: Introduce new BTRFS_IOC_SNAP_DESTROY_V2 ioctl
To:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        Chris Mason <clm@fb.com>
References: <20200111043942.15366-1-marcos.souza.org@gmail.com>
 <20200111043942.15366-3-marcos.souza.org@gmail.com>
 <18611492-2f20-4c09-1208-c39251a54200@toxicpanda.com>
 <20b606bcb0efb2defb5ef79cafc6d5b471e9cf28.camel@suse.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d510f8b5-9791-85b9-1e02-9970a3f37f64@toxicpanda.com>
Date:   Mon, 13 Jan 2020 18:40:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20b606bcb0efb2defb5ef79cafc6d5b471e9cf28.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/13/20 6:31 PM, Marcos Paulo de Souza wrote:
> On Mon, 2020-01-13 at 09:37 -0800, Josef Bacik wrote:
>> On 1/10/20 8:39 PM, Marcos Paulo de Souza wrote:
>>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>
>>> This ioctl will be responsible for deleting a subvolume using it's
>> id.
>>> This can be used when a system has a file system mounted from a
>>> subvolume, rather than the root file system, like below:
>>>
>>> /
>>> |- @subvol1
>>> |- @subvol2
>>> \- @subvol_default
>>> If only @subvol_default is mounted, we have no path to reach
>>> @subvol1 and @subvol2, thus no way to delete them.
>>> This patch introduces a new flag to allow BTRFS_IOC_SNAP_DESTORY_V2
>>> to delete subvolume using subvolid.
>>>
>>> Also in this patch, add BTRFS_SUBVOL_DELETE_BY_ID flag and add
>> subvolid
>>> as a union member of fd in struct btrfs_ioctl_vol_args_v2.
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>> ---
>>>    fs/btrfs/ctree.h           |  8 ++++++
>>>    fs/btrfs/export.c          |  4 +--
>>>    fs/btrfs/ioctl.c           | 53
>> ++++++++++++++++++++++++++++++++++++++
>>>    fs/btrfs/super.c           |  2 +-
>>>    include/uapi/linux/btrfs.h | 12 +++++++--
>>>    5 files changed, 74 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>> index 569931dd0ce5..421a2f57f9ec 100644
>>> --- a/fs/btrfs/ctree.h
>>> +++ b/fs/btrfs/ctree.h
>>> @@ -3010,6 +3010,8 @@ int btrfs_defrag_leaves(struct
>> btrfs_trans_handle *trans,
>>>    int btrfs_parse_options(struct btrfs_fs_info *info, char
>> *options,
>>>    			unsigned long new_flags);
>>>    int btrfs_sync_fs(struct super_block *sb, int wait);
>>> +char *get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
>>> +					   u64 subvol_objectid);
>>>    
>>>    static inline __printf(2, 3) __cold
>>>    void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const
>> char *fmt, ...)
>>> @@ -3442,6 +3444,12 @@ int btrfs_reada_wait(void *handle);
>>>    void btrfs_reada_detach(void *handle);
>>>    int btree_readahead_hook(struct extent_buffer *eb, int err);
>>>    
>>> +/* export.c */
>>> +struct dentry *btrfs_get_dentry(struct super_block *sb, u64
>> objectid,
>>> +				       u64 root_objectid, u32
>> generation,
>>> +				       int check_generation);
>>> +struct dentry *btrfs_get_parent(struct dentry *child);
>>> +
>>>    static inline int is_fstree(u64 rootid)
>>>    {
>>>    	if (rootid == BTRFS_FS_TREE_OBJECTID ||
>>> diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
>>> index 72e312cae69d..027411cdbae7 100644
>>> --- a/fs/btrfs/export.c
>>> +++ b/fs/btrfs/export.c
>>> @@ -57,7 +57,7 @@ static int btrfs_encode_fh(struct inode *inode,
>> u32 *fh, int *max_len,
>>>    	return type;
>>>    }
>>>    
>>> -static struct dentry *btrfs_get_dentry(struct super_block *sb, u64
>> objectid,
>>> +struct dentry *btrfs_get_dentry(struct super_block *sb, u64
>> objectid,
>>>    				       u64 root_objectid, u32
>> generation,
>>>    				       int check_generation)
>>>    {
>>> @@ -152,7 +152,7 @@ static struct dentry *btrfs_fh_to_dentry(struct
>> super_block *sb, struct fid *fh,
>>>    	return btrfs_get_dentry(sb, objectid, root_objectid,
>> generation, 1);
>>>    }
>>>    
>>> -static struct dentry *btrfs_get_parent(struct dentry *child)
>>> +struct dentry *btrfs_get_parent(struct dentry *child)
>>>    {
>>>    	struct inode *dir = d_inode(child);
>>>    	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
>>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>>> index dcceae4c5d28..68da45ad4904 100644
>>> --- a/fs/btrfs/ioctl.c
>>> +++ b/fs/btrfs/ioctl.c
>>> @@ -2960,6 +2960,57 @@ static noinline int
>> btrfs_ioctl_snap_destroy(struct file *file,
>>>    	return err;
>>>    }
>>>    
>>> +static noinline int btrfs_ioctl_snap_destroy_v2(struct file *file,
>>> +					     void __user *arg)
>>> +{
>>> +	struct btrfs_fs_info *fs_info = btrfs_sb(file->f_path.dentry-
>>> d_sb);
>>> +	struct dentry *dentry, *pdentry;
>>> +	struct btrfs_ioctl_vol_args_v2 *vol_args;
>>> +	char *name, *p;
>>> +	size_t namelen;
>>> +	int err = 0;
>>> +
>>> +	vol_args = memdup_user(arg, sizeof(*vol_args));
>>> +	if (IS_ERR(vol_args))
>>> +		return PTR_ERR(vol_args);
>>> +
>>> +	if (vol_args->subvolid == 0)
>>> +		return -EINVAL;
>>> +
>>> +	if (!(vol_args->flags & BTRFS_SUBVOL_DELETE_BY_ID))
>>> +		return -EINVAL;
>>> +
>>> +	dentry = btrfs_get_dentry(fs_info->sb,
>> BTRFS_FIRST_FREE_OBJECTID,
>>> +				vol_args->subvolid, 0, 0);
>>> +	if (IS_ERR(dentry)) {
>>> +		err = PTR_ERR(dentry);
>>> +		return err;
>>> +	}
>>> +
>>> +	pdentry = btrfs_get_parent(dentry);
>>> +	if (IS_ERR(pdentry)) {
>>> +		err = PTR_ERR(pdentry);
>>> +		goto out_dentry;
>>> +	}
>>
>> What happens if we have something like
>>
>> /subvol
>> /subvol2
>> /subvol3/subvol4
>> /subvol5
>>
>> and we mount /subvol5, and then we try to delete subvol4?  We aren't
>> going to be
>> able to find the parent dentry for subvol3 right?  Cause that thing
>> isn't linked
>> into our currently mounted tree, and things will go wonky right?  I'm
>> only
>> working on like 4 hours of sleep so I could be missing something
>> obvious here.
> 
> It works because we don't account the dentry based in the filp pointer,
> but rather we go through the fs tree by the subvolid and get the dentry
> from there. Using that dentry we then access the tree again to grab the
> parent. Am I missing something? It worked in my tests :)
> 

Idk, I guess if it works it works and I'll not question it.

>>
>>> +
>>> +	name = get_subvol_name_from_objectid(fs_info, vol_args-
>>> subvolid);
>>> +	if (IS_ERR(name)) {
>>> +		err = PTR_ERR(name);
>>> +		goto out_pdentry;
>>> +	}
>>> +	p = (char *)kbasename(name);
>>> +	namelen = strlen(p);
>>> +
>>> +	err = btrfs_subvolume_deleter(file, pdentry, p, namelen);
>>
>> We looked up the dentry to send the name into
>> btrfs_subvolume_deleter(), which
>> just takes the name and looks up the dentry again?  Have the common
>> function
>> just take both dentries and have v1 and v2 do their lookup
>> shenanigans.  Thanks,
> 
> So, this part is only necessary in the deletion by subvolid, since we
> cannot trust the file pointer of the current subvol delete ioctl
> because of the possible differented mounted tree, but I think it's
> doable to have the same function and only check for the SUBVOL_DELETE
> flag and the subvolid vol_args_v2 member.

Right but what I'm saying is we do the work to lookup the dentry here, so we 
might as well not duplicate that lookup in btrfs_subvolume_deleter.  Instead 
refactor the btrfs_subvolume_deleter to take both the parent and target 
dentries, and pass in the dentry you looked up here, and rework the v1 to do the 
dentry lookup by name.

Also I'd like to see btrfs-progs and xfstests patches along with this.  Thanks,

Josef
