Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B12A80B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfIDKxt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 06:53:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbfIDKxt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 06:53:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9433FAD20;
        Wed,  4 Sep 2019 10:53:47 +0000 (UTC)
Subject: Re: [PATCH 1/4] btrfs-progs: check/common: Make repair_imode_common()
 to handle inodes in subvolume trees
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190903082407.13927-1-wqu@suse.com>
 <20190903082407.13927-2-wqu@suse.com>
 <7cfbd72b-d8e9-695b-0576-d9dda1010228@suse.com>
 <2bd09938-f462-6e2f-1dbd-a326e0c6f159@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <dfe9c29f-2f6a-6b56-cad6-ddd1133b54eb@suse.com>
Date:   Wed, 4 Sep 2019 13:53:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2bd09938-f462-6e2f-1dbd-a326e0c6f159@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 4.09.19 г. 11:30 ч., Qu Wenruo wrote:
> 
> 
> On 2019/9/4 下午3:37, Nikolay Borisov wrote:
>>
>>
>> On 3.09.19 г. 11:24 ч., Qu Wenruo wrote:
>>> Before this patch, repair_imode_common() can only handle two types of
>>> inodes:
>>> - Free space cache inodes
>>> - ROOT DIR inodes
>>>
>>> For inodes in subvolume trees, the problem is how to determine the
>>> correct imode, thus it was not implemented.
>>>
>>> However there are more reports of incorrect imode in subvolume trees, we
>>> need to support such fix.
>>>
>>> So this patch adds a new function, detect_imode(), to detect (or call it
>>> educated guess) imode for inodes in subvolume trees.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  check/mode-common.c | 96 +++++++++++++++++++++++++++++++++++++++------
>>>  1 file changed, 83 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/check/mode-common.c b/check/mode-common.c
>>> index 195b6efaa7aa..807d7daf98a6 100644
>>> --- a/check/mode-common.c
>>> +++ b/check/mode-common.c
>>> @@ -836,6 +836,80 @@ int reset_imode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>>>  	return ret;
>>>  }
>>>
>>> +static int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
>>> +			u32 *imode_ret)
>>> +{
>>> +	struct btrfs_key key;
>>> +	struct btrfs_inode_item *iitem;
>>> +	const u32 priv = 0700;
>>> +	u64 ino;
>>> +	u32 imode = S_IFREG;
>>> +	int ret = 0;
>>> +
>>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>>> +	ino = key.objectid;
>>> +	iitem = btrfs_item_ptr(path->nodes[0], path->slots[0],
>>> +			       struct btrfs_inode_item);
>>> +
>>> +	/*
>>> +	 * Both CHR and BLK uses rdev, no way to distinguish them, so fall back
>>> +	 * to BLK.
>>> +	 */
>>> +	if (btrfs_inode_rdev(path->nodes[0], iitem) != 0) {
>>> +		imode = S_IFBLK;
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* root inode */
>>> +	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
>>> +		imode = S_IFDIR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	while (1) {
>>> +		ret = btrfs_next_item(root, path);
>>> +		if (ret > 0) {
>>> +			/* No determining result found, falls back to REG */
>>> +			ret = 0;
>>> +			goto out;
>>> +		}
>>> +		if (ret < 0)
>>> +			goto out;
>>> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>>> +		if (key.objectid != ino)
>>> +			goto out;
>>> +
>>> +		/*
>>> +		 * We ignore some types to make life easier:
>>> +		 * - INODE_REF
>>> +		 *   We need to do a full tree search, which can fail for
>>> +		 *   corrupted fs, but not worthy compared to other easier
>>> +		 *   to determine types.
>>> +		 * - XATTR
>>> +		 *   Both REG and DIR can have xattr, so not useful
>>> +		 */
>>> +		switch (key.type) {
>>> +		case BTRFS_DIR_ITEM_KEY:
>>> +		case BTRFS_DIR_INDEX_KEY:
>>> +			imode = S_IFDIR;
>>> +			goto out;
>>> +		case BTRFS_EXTENT_DATA_KEY:
>>> +			/*
>>> +			 * Both REG and LINK could have EXTENT_DATA.
>>> +			 * We just fall back to REG as user can inspect the
>>> +			 * content.
>>> +			 */
>>> +			imode = S_IFREG;
>>> +			goto out;
>>> +		}
>>> +	}
>>> +
>>> +out:
>>> +	/* Set default value even when something wrong happened */
>>> +	*imode_ret = (imode | priv);
>>> +	return ret;
>>> +}
>>> +
>>>  /*
>>>   * Reset the inode mode of the inode specified by @path.
>>>   *
>>> @@ -852,22 +926,18 @@ int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path)
>>>  	u32 imode;
>>>  	int ret;
>>>
>>> -	if (root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID) {
>>> -		error(
>>> -		"repair inode mode outside of root tree is not supported yet");
>>> -		return -ENOTTY;
>>> -	}
>>>  	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>>>  	ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
>>> -	if (key.objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
>>> -	    !is_fstree(key.objectid)) {
>>> -		error("unsupported ino %llu", key.objectid);
>>> -		return -ENOTTY;
>>> +	if (root->objectid == BTRFS_ROOT_TREE_OBJECTID) {
>>> +		/* In root tree we only have two possible imode */
>>> +		if (key.objectid == BTRFS_ROOT_TREE_OBJECTID)
>>> +			imode = S_IFDIR | 0755;
>>> +		else
>>> +			imode = S_IFREG | 0600;
>>> +	} else {
>>> +		detect_imode(root, path, &imode);
>>> +		/* Ignore error returned, just use the default value returned */
>>
>> Is this safe enough though?
> 
> It depends. But I'd say if we failed in detect_imode(), then it doesn't
> matter whatever the type we're putting here.
> 
>> What if due to an error a directory is
>> corrected to be file?
> 
> If a failure happens, it means btrfs-progs fails to read the next leaf.
> Then it really doesn't make much sense whatever the type is.
> 
> But I get your point, indeed we should error out without trying out to
> fix the inode.
> 
> I'll change this behavior in next version.

IMO the goal of btrfs-progs should be to make a broken filesystem better
and not replace one type of breakage with potentially another. In such
cases we ought to break out gracefully.

> 
> Thanks,
> Qu
> 
>> Let's not forget the context we are oprating here
>> - a broken fs so it's possible (if not likely) that any of the search
>> functions inside detect_imode could return negative error value. OTOH
>> I'd expect the transaction commit to fail if that's the case e.g. faulty
>> device.
>>
>>>  	}
>>> -	if (key.objectid == BTRFS_ROOT_TREE_DIR_OBJECTID)
>>> -		imode = 040755;
>>> -	else
>>> -		imode = 0100600;
>>>
>>>  	trans = btrfs_start_transaction(root, 1);
>>>  	if (IS_ERR(trans)) {
>>>
> 
