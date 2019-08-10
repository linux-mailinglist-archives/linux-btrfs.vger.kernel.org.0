Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67B7888C9
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2019 08:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfHJGMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Aug 2019 02:12:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbfHJGMP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Aug 2019 02:12:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35326ADE0;
        Sat, 10 Aug 2019 06:12:14 +0000 (UTC)
Subject: Re: [PATCH 1/3] btrfs-progs: check/lowmem: Check and repair root
 generation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190809065320.22702-1-wqu@suse.com>
 <20190809065320.22702-2-wqu@suse.com>
 <4e94c953-2ecb-8941-1b1c-d1a2dd6a080e@suse.com>
 <f7d26a1d-1f16-64c1-1f08-dc4494c27b8c@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d5d32957-5328-9886-c491-c57c2dcc1846@suse.com>
Date:   Sat, 10 Aug 2019 09:12:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f7d26a1d-1f16-64c1-1f08-dc4494c27b8c@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.08.19 г. 3:30 ч., Qu Wenruo wrote:
> 
> 
> On 2019/8/10 上午12:10, Nikolay Borisov wrote:
>>
>>
>> On 9.08.19 г. 9:53 ч., Qu Wenruo wrote:
>>> Since kernel is going to reject any root item which is newer than super
>>> block generation, we need to provide a way to fix such problem in
>>> btrfs-check.
>>>
>>> This patch addes the ability to report and repair root generation in
>>> lowmem mode.
>>>
>>> This is done by cowing the root node, so we will update the root
>>> generation along with the root node generation at commit transaction
>>> time.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>  check/mode-common.c | 29 +++++++++++++++++++++++++++++
>>>  check/mode-common.h |  1 +
>>>  check/mode-lowmem.c | 16 ++++++++++++++++
>>>  check/mode-lowmem.h |  1 +
>>>  4 files changed, 47 insertions(+)
>>>
>>> diff --git a/check/mode-common.c b/check/mode-common.c
>>> index d5f6c8ef97b1..a5b86a0ac32a 100644
>>> --- a/check/mode-common.c
>>> +++ b/check/mode-common.c
>>> @@ -924,3 +924,32 @@ int check_repair_free_space_inode(struct btrfs_fs_info *fs_info,
>>>  	}
>>>  	return ret;
>>>  }
>>> +
>>> +int repair_root_generation(struct btrfs_root *root)
>>> +{
>>> +	struct btrfs_trans_handle *trans;
>>> +	struct btrfs_path path;
>>> +	struct btrfs_key key;
>>> +	int ret;
>>> +
>>> +	trans = btrfs_start_transaction(root, 1);
>>> +	if (IS_ERR(trans))
>>> +		return PTR_ERR(trans);
>>> +
>>> +	key.objectid = 0;
>>> +	key.type = 0;
>>> +	key.offset = 0;
>>> +	btrfs_init_path(&path);
>>> +
>>> +	/* Here we only CoW the tree root to update the geneartion */
>>> +	path.lowest_level = btrfs_header_level(root->node);
>>> +	root->node->flags |= EXTENT_BAD_TRANSID;
>>
>> Why do you set EXTENT_BAD_TRANSID? This flag is currently used only in
>> read_tree_block to link blocks which have failed ordinary validation to
>> the recow_ebs list, and this only happens in case we have a single copy
>> for this eb. This list is then processed in the main check logic.
> 
> Because we have extra transid check in
> btrfs_search_slot()/btrfs_cow_block().
> 
> EXTENT_BAD_TRANSID is to suppress such warning.

nod

> 
>>
>> So repair_root_generation could possibly be as simple as just linking
>> root->node to the fs_info->recow_ebs and leave the rest to the existing
>> logic?
> 
> It doesn't change the root generation.

recow_extent_buffer seems to be doing exactly the same thing
repair_root_generation does - findw the root item and commits the
transaction. What am I missing?

> 
>>
>>> +
>>> +	ret = btrfs_search_slot(trans, root, &key, &path, 0, 1);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	btrfs_release_path(&path);
>>> +	ret = btrfs_commit_transaction(trans, root);
>>> +	return ret;
>>> +}
>>> diff --git a/check/mode-common.h b/check/mode-common.h
>>> index 4c169c6e3b29..4a3abeb02c81 100644
>>> --- a/check/mode-common.h
>>> +++ b/check/mode-common.h
>>> @@ -155,4 +155,5 @@ static inline bool is_valid_imode(u32 imode)
>>>  	return true;
>>>  }
>>>
>>> +int repair_root_generation(struct btrfs_root *root);
>>>  #endif
>>> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
>>> index a2be0e6d7034..bf3b57f5ad2d 100644
>>> --- a/check/mode-lowmem.c
>>> +++ b/check/mode-lowmem.c
>>> @@ -4957,6 +4957,7 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
>>>  	struct btrfs_path path;
>>>  	struct node_refs nrefs;
>>>  	struct btrfs_root_item *root_item = &root->root_item;
>>> +	u64 super_generation = btrfs_super_generation(root->fs_info->super_copy);
>>>  	int ret;
>>>  	int level;
>>>  	int err = 0;
>>> @@ -4978,6 +4979,21 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
>>>  	level = btrfs_header_level(root->node);
>>>  	btrfs_init_path(&path);
>>>
>>> +	if (btrfs_root_generation(root_item) > super_generation + 1) {
>>> +		error(
>>> +	"invalid root generation for root %llu, have %llu expect (0, %llu)",
>>> +		      root->root_key.objectid, btrfs_root_generation(root_item),
>>> +		      super_generation + 1);
>>> +		err |= INVALID_GENERATION;
>>> +		if (repair) {
>>> +			ret = repair_root_generation(root);
>>> +			if (!ret) {
>>> +				err &= ~INVALID_GENERATION;
>>> +				printf("Reset generation for root %llu\n",
>>> +					root->root_key.objectid);
>>> +			}
>>> +		}
>>> +	}
>>>  	if (btrfs_root_refs(root_item) > 0 ||
>>>  	    btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
>>>  		path.nodes[level] = root->node;
>>> diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
>>> index d2983fd12eb4..0361fb3382b1 100644
>>> --- a/check/mode-lowmem.h
>>> +++ b/check/mode-lowmem.h
>>> @@ -47,6 +47,7 @@
>>>  #define INODE_FLAGS_ERROR	(1<<23) /* Invalid inode flags */
>>>  #define DIR_ITEM_HASH_MISMATCH	(1<<24) /* Dir item hash mismatch */
>>>  #define INODE_MODE_ERROR	(1<<25) /* Bad inode mode */
>>> +#define INVALID_GENERATION	(1<<26)	/* Generation is too new */
>>>
>>>  /*
>>>   * Error bit for low memory mode check.
>>>
> 
