Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10CC5ABD70
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 08:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiICGaA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICG36 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 02:29:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D02C13E
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662186596; x=1693722596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EpZrrgoONi2r7ZpQwG7pfv5GsJb4n03feP4BLKjmxXc=;
  b=EkoeoGrm/jjdob5QDZ28BoQBHW4U23EsptW5vEeQ7oTrbC3uIEyJ+jrc
   a4z793kQurp2SRVG7IsfzzkA6n6KaxLszWm30ezIgmZtGsfj46G7QqvJw
   /EVfbD8EpYF6b0Z0XU9vVJQEZS82ihMzgRGZjjjeYxoH786Rm0xAK7ztE
   Dw97QMBIEMvl3ptUZzVQ9PwdO6Jj+jlYywksED00TtGPVblWlL1cw/Dil
   HhifidzMxuxYiorSsTLlY2DEiJRBy8aN0KdGNl4tEPDJXAsrB3CTP+VRt
   +nOsjRFHwB4W7GiP9DlqlzOpUHpyEecetRcs+bHz/OaXhhqLMSiJkCIEX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276534384"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="276534384"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 23:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="702366429"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2022 23:29:54 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUMfB-0001Az-1z;
        Sat, 03 Sep 2022 06:29:53 +0000
Date:   Sat, 3 Sep 2022 14:28:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 12/31] btrfs: move the core extent_io_tree code into
 extent-io-tree.c
Message-ID: <202209031411.pvUL5nPj-lkp@intel.com>
References: <c534c12c1dcf0821971b8918abced08aafd27055.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c534c12c1dcf0821971b8918abced08aafd27055.1662149276.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Josef,

I love your patch! Perhaps something to improve:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20220901]
[cannot apply to rostedt-trace/for-next linus/master v6.0-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/btrfs-move-extent_io_tree-code-and-cleanups/20220903-042359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209031411.pvUL5nPj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9fa98f420ce2ac5220d35bedf881d5e6bbd18e9d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josef-Bacik/btrfs-move-extent_io_tree-code-and-cleanups/20220903-042359
        git checkout 9fa98f420ce2ac5220d35bedf881d5e6bbd18e9d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/btrfs/extent-io-tree.c:237: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Search @tree for an entry that contains @offset. Such entry would have
   fs/btrfs/extent-io-tree.c:298: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Search offset in the tree or fill neighbor rbtree node pointers.
   fs/btrfs/extent-io-tree.c:1393: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Find a contiguous area of bits
   fs/btrfs/extent-io-tree.c:1431: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Find the first range that has @bits not set. This range could start before


vim +237 fs/btrfs/extent-io-tree.c

   235	
   236	/**
 > 237	 * Search @tree for an entry that contains @offset. Such entry would have
   238	 * entry->start <= offset && entry->end >= offset.
   239	 *
   240	 * @tree:       the tree to search
   241	 * @offset:     offset that should fall within an entry in @tree
   242	 * @node_ret:   pointer where new node should be anchored (used when inserting an
   243	 *	        entry in the tree)
   244	 * @parent_ret: points to entry which would have been the parent of the entry,
   245	 *               containing @offset
   246	 *
   247	 * Return a pointer to the entry that contains @offset byte address and don't change
   248	 * @node_ret and @parent_ret.
   249	 *
   250	 * If no such entry exists, return pointer to entry that ends before @offset
   251	 * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
   252	 */
   253	static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree,
   254						             u64 offset,
   255							     struct rb_node ***node_ret,
   256							     struct rb_node **parent_ret)
   257	{
   258		struct rb_root *root = &tree->state;
   259		struct rb_node **node = &root->rb_node;
   260		struct rb_node *prev = NULL;
   261		struct tree_entry *entry;
   262	
   263		while (*node) {
   264			prev = *node;
   265			entry = rb_entry(prev, struct tree_entry, rb_node);
   266	
   267			if (offset < entry->start)
   268				node = &(*node)->rb_left;
   269			else if (offset > entry->end)
   270				node = &(*node)->rb_right;
   271			else
   272				return *node;
   273		}
   274	
   275		if (node_ret)
   276			*node_ret = node;
   277		if (parent_ret)
   278			*parent_ret = prev;
   279	
   280		/* Search neighbors until we find the first one past the end */
   281		while (prev && offset > entry->end) {
   282			prev = rb_next(prev);
   283			entry = rb_entry(prev, struct tree_entry, rb_node);
   284		}
   285	
   286		return prev;
   287	}
   288	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
