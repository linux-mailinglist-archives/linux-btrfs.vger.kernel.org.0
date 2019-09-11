Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19904AFC96
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfIKM1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 08:27:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:35960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727915AbfIKM1l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 08:27:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D21CB703;
        Wed, 11 Sep 2019 12:27:39 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] btrfs-progs: check/common: Make
 repair_imode_common() to handle inodes in subvolume trees
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-4-wqu@suse.com>
 <d78eb326-5441-94ab-f5ee-01f5526a97e5@suse.com>
 <9ab43823-0649-f277-5b19-224aa66f781e@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7ccda0e-55e4-85be-0c97-b9f80fad4862@suse.com>
Date:   Wed, 11 Sep 2019 15:27:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ab43823-0649-f277-5b19-224aa66f781e@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.09.19 г. 3:39 ч., Qu Wenruo wrote:
> [...]
>>> - Search for DIR_INDEX/DIR_ITEM
>>>   If above search fails, we falls back to locate the DIR_INDEX/DIR_ITEM
>>>   just after the INODE_ITEM.
>>>   If any can be found, it's definitely a directory.
>>
>> This needs an explicit satement that it will only work for non-empty files and directories
> 
> Indeed.
> 
>>>
>>> - Search for EXTENT_DATA
>>>   If EXTENT_DATA can be found, it's either REG or LNK.
>>>   For this case, we default to REG, as user can inspect the file to
>>>   determine if it's a file or just a path.
>>>
>>> - Use rdev to detect BLK/CHR
>>>   If all above fails, but INODE_ITEM has non-zero rdev, then it's either
>>>   a BLK or CHR file. Then we default to BLK.
>>>
>>> - Fail out if none of above methods succeeded
>>>   No educated guess to make things worse.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  check/mode-common.c | 130 +++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 117 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/check/mode-common.c b/check/mode-common.c
>>> index c0ddc50a1dd0..abea2ceda4c4 100644
>>> --- a/check/mode-common.c
>>> +++ b/check/mode-common.c
>>> @@ -935,6 +935,113 @@ out:
>>>  	return ret;
>>>  }
>>>
>>> +static int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
>>> +			u32 *imode_ret)
>>> +{
>>> +	struct btrfs_key key;
>>> +	struct btrfs_inode_item iitem;
>>> +	const u32 priv = 0700;
>>> +	bool found = false;
>>> +	u64 ino;
>>> +	u32 imode;
>>> +	int ret = 0;
>>> +
>>> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
>>> +	ino = key.objectid;
>>> +	read_extent_buffer(path->nodes[0], &iitem,
>>> +			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
>>> +			sizeof(iitem));
>>> +	/* root inode */
>>> +	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
>>> +		imode = S_IFDIR;
>>> +		found = true;
>>> +		goto out;
>>> +	}
>>> +
>>> +	while (1) {
>>> +		struct btrfs_inode_ref *iref;
>>> +		struct extent_buffer *leaf;
>>> +		unsigned long cur;
>>> +		unsigned long end;
>>> +		char namebuf[BTRFS_NAME_LEN] = {0};
>>> +		u64 index;
>>> +		u32 namelen;
>>> +		int slot;
>>> +
>>> +		ret = btrfs_next_item(root, path);
>>> +		if (ret > 0) {
>>> +			/* falls back to rdev check */
>>> +			ret = 0;
>>> +			goto out;
>>> +		}
>>
>> In my testing if an inode is the last one in the leaf and it doesn't have
>> an INODE_REF item then it won't be repaired. But e.g. it can have perfectly
>> valid DIR_ITEM/DIR_INDEX entries which describe this inode as being a file. E.g.
>>
>> 	item 2 key (256 DIR_ITEM 388586943) itemoff 16076 itemsize 35
>> 		location key (260 INODE_ITEM 0) type FILE
>> 		transid 7 data_len 0 name_len 5
>> 		name: file3
>>
>> 	.....
>> 	item 15 key (260 INODE_ITEM 0) itemoff 15184 itemsize 160
>> 		generation 7 transid 7 size 0 nbytes 0
>> 		block group 0 mode 26772225102 links 1 uid 0 gid 0 rdev 0
>> 		sequence 1 flags 0x0(none)
>> 		atime 1568127261.284993602 (2019-09-10 14:54:21)
>> 		ctime 1568127261.284993602 (2019-09-10 14:54:21)
>> 		mtime 1568127261.284993602 (2019-09-10 14:54:21)
>> 		otime 1568127261.284993602 (2019-09-10 14:54:21)
>>
>> I have intentionally deleted INODE_REF too see what's happening. Is this intended?
> 
> Yes, completely intended.
> 
> For this case, you need to iterate through the whole tree to locate the
> DIR_INDEX to fix, which is not really possible with current code base,
> which only search based on the INODE, not the DIR_INDEX/DIR_ITEM from
> its parent dir.
> 
> Furthermore, didn't you mention that if we don't have confident about
> the imode, then we should fail out instead of using REG as default?

I did, what I supposed could happen here is if we can't find an
INODE_REF then do a search for DIR_INDEX/DIR_ITEM since those items also
contain the type of the inode they are pointing to. Fixing really boils
down to exploiting redundancy in the on-disk metadata to repair existing
items. Here comes the question, of course, what to do if we don't have
an INODE_REF and DIR_INDEX/DIR_ITEM are broken. I guess it's a judgement
call, currently you decided that inode_ref will be the source of
information. I'm fine with that I was merely pointing there is more we
can do. Of course we need to weigh the pros/cons between code complexity
and the returns we get.

Just that I will advise to make it explicit in the changelog that you
made a judgement call to utilize INODE_REF as the starting point of
doing imode repair but not necessarily the only one.


<snip>
