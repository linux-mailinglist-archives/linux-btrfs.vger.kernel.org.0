Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79198509834
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 09:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385088AbiDUGsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385040AbiDUGrV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65715710
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523433; x=1682059433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IxwthZv67U3Phdmt9bJcErmgnbyb5DyViYXU0zBdAN8=;
  b=EZv9nRUZsE3opgb+2/NPufRpF8g5PrNNBX7QiRJ0KsJtxx6oSsPVhsIN
   Q1EP6351BZUISGWZ+m/UjKs0JjRolxqeFQDyHC1jSFYdXBNQcOFYJ5qRf
   9iwecWfVKbJ5EKO+FjNH5xpxrecQfl8Hpem514iLCKc8va6W7k83wAbJY
   u/MHGnDqrKJJa6Tdj409XGpwSOuBb7HlkFbr1HZ91Y9269nzQb0XYhxJi
   r9Hk2apr38k50fx24eDd9yb1atIbw4FKytKObwXZp0igpj6Lj8cUeKb7X
   mv42XaClCLEadUKxRCe4bazfVO1g25z8Dl9QTsF0VFDCVEXH2UroYJqZk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="289369457"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="289369457"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="510918529"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXe-00080V-Sz;
        Thu, 21 Apr 2022 06:43:50 +0000
Date:   Thu, 21 Apr 2022 14:43:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH] btrfs: Improve error reporting in
 lookup_inline_extent_backref
Message-ID: <202204210801.4G6iUKKd-lkp@intel.com>
References: <20220420115401.186147-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420115401.186147-1-nborisov@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on v5.18-rc3 next-20220420]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikolay-Borisov/btrfs-Improve-error-reporting-in-lookup_inline_extent_backref/20220420-195528
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220421/202204210801.4G6iUKKd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a77df79d2f67b166cb64a21808ec432edcbf5bba
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nikolay-Borisov/btrfs-Improve-error-reporting-in-lookup_inline_extent_backref/20220420-195528
        git checkout a77df79d2f67b166cb64a21808ec432edcbf5bba
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/extent-tree.c:900:61: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected struct extent_buffer *l @@     got int @@
   fs/btrfs/extent-tree.c:900:61: sparse:     expected struct extent_buffer *l
   fs/btrfs/extent-tree.c:900:61: sparse:     got int
   fs/btrfs/extent-tree.c:1784:9: sparse: sparse: context imbalance in 'run_and_cleanup_extent_op' - unexpected unlock
   fs/btrfs/extent-tree.c:1838:28: sparse: sparse: context imbalance in 'cleanup_ref_head' - unexpected unlock
   fs/btrfs/extent-tree.c:1917:36: sparse: sparse: context imbalance in 'btrfs_run_delayed_refs_for_head' - unexpected unlock
   fs/btrfs/extent-tree.c:1982:21: sparse: sparse: context imbalance in '__btrfs_run_delayed_refs' - wrong count at exit

vim +900 fs/btrfs/extent-tree.c

   770	
   771	/*
   772	 * look for inline back ref. if back ref is found, *ref_ret is set
   773	 * to the address of inline back ref, and 0 is returned.
   774	 *
   775	 * if back ref isn't found, *ref_ret is set to the address where it
   776	 * should be inserted, and -ENOENT is returned.
   777	 *
   778	 * if insert is true and there are too many inline back refs, the path
   779	 * points to the extent item, and -EAGAIN is returned.
   780	 *
   781	 * NOTE: inline back refs are ordered in the same way that back ref
   782	 *	 items in the tree are ordered.
   783	 */
   784	static noinline_for_stack
   785	int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
   786					 struct btrfs_path *path,
   787					 struct btrfs_extent_inline_ref **ref_ret,
   788					 u64 bytenr, u64 num_bytes,
   789					 u64 parent, u64 root_objectid,
   790					 u64 owner, u64 offset, int insert)
   791	{
   792		struct btrfs_fs_info *fs_info = trans->fs_info;
   793		struct btrfs_root *root = btrfs_extent_root(fs_info, bytenr);
   794		struct btrfs_key key;
   795		struct extent_buffer *leaf;
   796		struct btrfs_extent_item *ei;
   797		struct btrfs_extent_inline_ref *iref;
   798		u64 flags;
   799		u64 item_size;
   800		unsigned long ptr;
   801		unsigned long end;
   802		int extra_size;
   803		int type;
   804		int want;
   805		int ret;
   806		int err = 0;
   807		bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
   808		int needed;
   809	
   810		key.objectid = bytenr;
   811		key.type = BTRFS_EXTENT_ITEM_KEY;
   812		key.offset = num_bytes;
   813	
   814		want = extent_ref_type(parent, owner);
   815		if (insert) {
   816			extra_size = btrfs_extent_inline_ref_size(want);
   817			path->search_for_extension = 1;
   818			path->keep_locks = 1;
   819		} else
   820			extra_size = -1;
   821	
   822		/*
   823		 * Owner is our level, so we can just add one to get the level for the
   824		 * block we are interested in.
   825		 */
   826		if (skinny_metadata && owner < BTRFS_FIRST_FREE_OBJECTID) {
   827			key.type = BTRFS_METADATA_ITEM_KEY;
   828			key.offset = owner;
   829		}
   830	
   831	again:
   832		ret = btrfs_search_slot(trans, root, &key, path, extra_size, 1);
   833		if (ret < 0) {
   834			err = ret;
   835			goto out;
   836		}
   837	
   838		/*
   839		 * We may be a newly converted file system which still has the old fat
   840		 * extent entries for metadata, so try and see if we have one of those.
   841		 */
   842		if (ret > 0 && skinny_metadata) {
   843			skinny_metadata = false;
   844			if (path->slots[0]) {
   845				path->slots[0]--;
   846				btrfs_item_key_to_cpu(path->nodes[0], &key,
   847						      path->slots[0]);
   848				if (key.objectid == bytenr &&
   849				    key.type == BTRFS_EXTENT_ITEM_KEY &&
   850				    key.offset == num_bytes)
   851					ret = 0;
   852			}
   853			if (ret) {
   854				key.objectid = bytenr;
   855				key.type = BTRFS_EXTENT_ITEM_KEY;
   856				key.offset = num_bytes;
   857				btrfs_release_path(path);
   858				goto again;
   859			}
   860		}
   861	
   862		if (ret && !insert) {
   863			err = -ENOENT;
   864			goto out;
   865		} else if (WARN_ON(ret)) {
   866			err = -EIO;
   867			goto out;
   868		}
   869	
   870		leaf = path->nodes[0];
   871		item_size = btrfs_item_size(leaf, path->slots[0]);
   872		if (unlikely(item_size < sizeof(*ei))) {
   873			err = -EINVAL;
   874			btrfs_print_v0_err(fs_info);
   875			btrfs_abort_transaction(trans, err);
   876			goto out;
   877		}
   878	
   879		ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
   880		flags = btrfs_extent_flags(leaf, ei);
   881	
   882		ptr = (unsigned long)(ei + 1);
   883		end = (unsigned long)ei + item_size;
   884	
   885		if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !skinny_metadata) {
   886			ptr += sizeof(struct btrfs_tree_block_info);
   887			BUG_ON(ptr > end);
   888		}
   889	
   890		if (owner >= BTRFS_FIRST_FREE_OBJECTID)
   891			needed = BTRFS_REF_TYPE_DATA;
   892		else
   893			needed = BTRFS_REF_TYPE_BLOCK;
   894	
   895		err = -ENOENT;
   896		while (1) {
   897			if (ptr >= end) {
   898				if (WARN_ON(ptr > end)) {
   899					err = -EUCLEAN;
 > 900					btrfs_print_leaf(path->slots[0]);
   901				}
   902				break;
   903			}
   904			iref = (struct btrfs_extent_inline_ref *)ptr;
   905			type = btrfs_get_extent_inline_ref_type(leaf, iref, needed);
   906			if (type == BTRFS_REF_TYPE_INVALID) {
   907				err = -EUCLEAN;
   908				goto out;
   909			}
   910	
   911			if (want < type)
   912				break;
   913			if (want > type) {
   914				ptr += btrfs_extent_inline_ref_size(type);
   915				continue;
   916			}
   917	
   918			if (type == BTRFS_EXTENT_DATA_REF_KEY) {
   919				struct btrfs_extent_data_ref *dref;
   920				dref = (struct btrfs_extent_data_ref *)(&iref->offset);
   921				if (match_extent_data_ref(leaf, dref, root_objectid,
   922							  owner, offset)) {
   923					err = 0;
   924					break;
   925				}
   926				if (hash_extent_data_ref_item(leaf, dref) <
   927				    hash_extent_data_ref(root_objectid, owner, offset))
   928					break;
   929			} else {
   930				u64 ref_offset;
   931				ref_offset = btrfs_extent_inline_ref_offset(leaf, iref);
   932				if (parent > 0) {
   933					if (parent == ref_offset) {
   934						err = 0;
   935						break;
   936					}
   937					if (ref_offset < parent)
   938						break;
   939				} else {
   940					if (root_objectid == ref_offset) {
   941						err = 0;
   942						break;
   943					}
   944					if (ref_offset < root_objectid)
   945						break;
   946				}
   947			}
   948			ptr += btrfs_extent_inline_ref_size(type);
   949		}
   950		if (err == -ENOENT && insert) {
   951			if (item_size + extra_size >=
   952			    BTRFS_MAX_EXTENT_ITEM_SIZE(root)) {
   953				err = -EAGAIN;
   954				goto out;
   955			}
   956			/*
   957			 * To add new inline back ref, we have to make sure
   958			 * there is no corresponding back ref item.
   959			 * For simplicity, we just do not add new inline back
   960			 * ref if there is any kind of item for this block
   961			 */
   962			if (find_next_key(path, 0, &key) == 0 &&
   963			    key.objectid == bytenr &&
   964			    key.type < BTRFS_BLOCK_GROUP_ITEM_KEY) {
   965				err = -EAGAIN;
   966				goto out;
   967			}
   968		}
   969		*ref_ret = (struct btrfs_extent_inline_ref *)ptr;
   970	out:
   971		if (insert) {
   972			path->keep_locks = 0;
   973			path->search_for_extension = 0;
   974			btrfs_unlock_up_safe(path, 1);
   975		}
   976		return err;
   977	}
   978	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
