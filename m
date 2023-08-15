Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA2D77CAF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Aug 2023 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjHOKIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Aug 2023 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbjHOKHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Aug 2023 06:07:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6EE63
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Aug 2023 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692094065; x=1723630065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gc9puqD2F1HUuJoyLg7BUB5aQ4HdhGmWeC5cCMZa39I=;
  b=KBHofa5fPL6028IHsBo2L9J2mZSkeWrS9MTD2+PkNw9s6d89t68mxWH5
   u0ZcUr4NTSxgy1ag2wxJfkc1xgcgQXMrVU4HpZCyjsq8qxhzdvN5vrTXF
   dk2ubUqNEWh3zF/YTmB0j+OM2NcRJqFVCmoQKUWrPeBhq31QhcpCY+N8M
   rt5hRYI/QnQx+OC7B/eLVvkgICW+pkELJ7QlqS+kLHtUELk5bskKenBVj
   hJURqWrH2yQl6rK/YLJ1MP1pmg/uFhjIir9jgfeR+WXTNsKK95NOL5rCj
   JV5kbIWnuGEeVJ40cEnvExXExS5MlqfwBAHLFwYCw/vHCygIHpSF1jkHY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="362395528"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362395528"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733792542"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733792542"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 03:07:43 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVqxe-0000rg-2F;
        Tue, 15 Aug 2023 10:07:40 +0000
Date:   Tue, 15 Aug 2023 18:06:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for
 striped profiles
Message-ID: <202308151705.NQScDZfJ-lkp@intel.com>
References: <88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

kernel test robot noticed the following build errors:

[auto build test ERROR on kdave/for-next]
[cannot apply to linus/master v6.5-rc6 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/btrfs-scrub-avoid-unnecessary-extent-tree-search-for-striped-profiles/20230815-151842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/88abe1beac119b714a62f5e622c673f418afede2.1692083778.git.wqu%40suse.com
patch subject: [PATCH] btrfs: scrub: avoid unnecessary extent tree search for striped profiles
config: riscv-randconfig-r021-20230815 (https://download.01.org/0day-ci/archive/20230815/202308151705.NQScDZfJ-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308151705.NQScDZfJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308151705.NQScDZfJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv32-linux-ld: fs/btrfs/scrub.o: in function `.L0 ':
>> fs/btrfs/scrub.c:2186: undefined reference to `__udivdi3'
>> riscv32-linux-ld: fs/btrfs/scrub.c:2354: undefined reference to `__umoddi3'


vim +2186 fs/btrfs/scrub.c

8557635ed2b04b Qu Wenruo       2022-03-11  2172  
d9d181c1ba7aa0 Stefan Behrens  2012-11-02  2173  static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2174  					   struct btrfs_block_group *bg,
bc88b486d54b2a Qu Wenruo       2022-05-13  2175  					   struct extent_map *em,
a36cf8b8933e4a Stefan Behrens  2012-11-02  2176  					   struct btrfs_device *scrub_dev,
bc88b486d54b2a Qu Wenruo       2022-05-13  2177  					   int stripe_index)
a2de733c78fa7a Arne Jansen     2011-03-08  2178  {
fb456252d3d9c0 Jeff Mahoney    2016-06-22  2179  	struct btrfs_fs_info *fs_info = sctx->fs_info;
bc88b486d54b2a Qu Wenruo       2022-05-13  2180  	struct map_lookup *map = em->map_lookup;
09022b14fafc86 Qu Wenruo       2022-03-11  2181  	const u64 profile = map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK;
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2182  	const u64 chunk_logical = bg->start;
a2de733c78fa7a Arne Jansen     2011-03-08  2183  	int ret;
8eb3dd17eadd21 Qu Wenruo       2023-04-06  2184  	int ret2;
1194a82481d8f3 Qu Wenruo       2022-03-11  2185  	u64 physical = map->stripes[stripe_index].physical;
bc88b486d54b2a Qu Wenruo       2022-05-13 @2186  	const u64 dev_stripe_len = btrfs_calc_stripe_length(em);
bc88b486d54b2a Qu Wenruo       2022-05-13  2187  	const u64 physical_end = physical + dev_stripe_len;
a2de733c78fa7a Arne Jansen     2011-03-08  2188  	u64 logical;
625f1c8dc66d77 Liu Bo          2013-04-27  2189  	u64 logic_end;
18d30ab961497f Qu Wenruo       2022-03-11  2190  	/* The logical increment after finishing one stripe */
5c07c53f2d273b Jiapeng Chong   2022-01-21  2191  	u64 increment;
18d30ab961497f Qu Wenruo       2022-03-11  2192  	/* Offset inside the chunk */
a2de733c78fa7a Arne Jansen     2011-03-08  2193  	u64 offset;
5a6ac9eacb4914 Miao Xie        2014-11-06  2194  	u64 stripe_logical;
3b080b2564287b Wang Shilong    2014-04-01  2195  	int stop_loop = 0;
53b381b3abeb86 David Woodhouse 2013-01-29  2196  
303c4c1391fc98 Qu Wenruo       2023-08-03  2197  	/* Extent_path should be probably released. */
303c4c1391fc98 Qu Wenruo       2023-08-03  2198  	ASSERT(sctx->extent_path.nodes[0] == NULL);
a64bd62aaf1157 Qu Wenruo       2023-08-15  2199  	sctx->found_next = chunk_logical;
303c4c1391fc98 Qu Wenruo       2023-08-03  2200  
cb7ab02156e4ba Wang Shilong    2013-12-04  2201  	scrub_blocked_if_needed(fs_info);
a2de733c78fa7a Arne Jansen     2011-03-08  2202  
de17addce7a20d Naohiro Aota    2021-02-04  2203  	if (sctx->is_dev_replace &&
de17addce7a20d Naohiro Aota    2021-02-04  2204  	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
de17addce7a20d Naohiro Aota    2021-02-04  2205  		mutex_lock(&sctx->wr_lock);
de17addce7a20d Naohiro Aota    2021-02-04  2206  		sctx->write_pointer = physical;
de17addce7a20d Naohiro Aota    2021-02-04  2207  		mutex_unlock(&sctx->wr_lock);
de17addce7a20d Naohiro Aota    2021-02-04  2208  	}
de17addce7a20d Naohiro Aota    2021-02-04  2209  
1009254bf22a3f Qu Wenruo       2023-03-28  2210  	/* Prepare the extra data stripes used by RAID56. */
1009254bf22a3f Qu Wenruo       2023-03-28  2211  	if (profile & BTRFS_BLOCK_GROUP_RAID56_MASK) {
1009254bf22a3f Qu Wenruo       2023-03-28  2212  		ASSERT(sctx->raid56_data_stripes == NULL);
1009254bf22a3f Qu Wenruo       2023-03-28  2213  
1009254bf22a3f Qu Wenruo       2023-03-28  2214  		sctx->raid56_data_stripes = kcalloc(nr_data_stripes(map),
1009254bf22a3f Qu Wenruo       2023-03-28  2215  						    sizeof(struct scrub_stripe),
1009254bf22a3f Qu Wenruo       2023-03-28  2216  						    GFP_KERNEL);
1009254bf22a3f Qu Wenruo       2023-03-28  2217  		if (!sctx->raid56_data_stripes) {
1009254bf22a3f Qu Wenruo       2023-03-28  2218  			ret = -ENOMEM;
1009254bf22a3f Qu Wenruo       2023-03-28  2219  			goto out;
1009254bf22a3f Qu Wenruo       2023-03-28  2220  		}
1009254bf22a3f Qu Wenruo       2023-03-28  2221  		for (int i = 0; i < nr_data_stripes(map); i++) {
1009254bf22a3f Qu Wenruo       2023-03-28  2222  			ret = init_scrub_stripe(fs_info,
1009254bf22a3f Qu Wenruo       2023-03-28  2223  						&sctx->raid56_data_stripes[i]);
1009254bf22a3f Qu Wenruo       2023-03-28  2224  			if (ret < 0)
1009254bf22a3f Qu Wenruo       2023-03-28  2225  				goto out;
1009254bf22a3f Qu Wenruo       2023-03-28  2226  			sctx->raid56_data_stripes[i].bg = bg;
1009254bf22a3f Qu Wenruo       2023-03-28  2227  			sctx->raid56_data_stripes[i].sctx = sctx;
1009254bf22a3f Qu Wenruo       2023-03-28  2228  		}
1009254bf22a3f Qu Wenruo       2023-03-28  2229  	}
09022b14fafc86 Qu Wenruo       2022-03-11  2230  	/*
09022b14fafc86 Qu Wenruo       2022-03-11  2231  	 * There used to be a big double loop to handle all profiles using the
09022b14fafc86 Qu Wenruo       2022-03-11  2232  	 * same routine, which grows larger and more gross over time.
09022b14fafc86 Qu Wenruo       2022-03-11  2233  	 *
09022b14fafc86 Qu Wenruo       2022-03-11  2234  	 * So here we handle each profile differently, so simpler profiles
09022b14fafc86 Qu Wenruo       2022-03-11  2235  	 * have simpler scrubbing function.
09022b14fafc86 Qu Wenruo       2022-03-11  2236  	 */
09022b14fafc86 Qu Wenruo       2022-03-11  2237  	if (!(profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10 |
09022b14fafc86 Qu Wenruo       2022-03-11  2238  			 BTRFS_BLOCK_GROUP_RAID56_MASK))) {
09022b14fafc86 Qu Wenruo       2022-03-11  2239  		/*
09022b14fafc86 Qu Wenruo       2022-03-11  2240  		 * Above check rules out all complex profile, the remaining
09022b14fafc86 Qu Wenruo       2022-03-11  2241  		 * profiles are SINGLE|DUP|RAID1|RAID1C*, which is simple
09022b14fafc86 Qu Wenruo       2022-03-11  2242  		 * mirrored duplication without stripe.
09022b14fafc86 Qu Wenruo       2022-03-11  2243  		 *
09022b14fafc86 Qu Wenruo       2022-03-11  2244  		 * Only @physical and @mirror_num needs to calculated using
09022b14fafc86 Qu Wenruo       2022-03-11  2245  		 * @stripe_index.
09022b14fafc86 Qu Wenruo       2022-03-11  2246  		 */
6b4d375a81551b Qu Wenruo       2023-01-16  2247  		ret = scrub_simple_mirror(sctx, bg, map, bg->start, bg->length,
6b4d375a81551b Qu Wenruo       2023-01-16  2248  				scrub_dev, map->stripes[stripe_index].physical,
09022b14fafc86 Qu Wenruo       2022-03-11  2249  				stripe_index + 1);
e430c4287ebdaf Qu Wenruo       2022-03-11  2250  		offset = 0;
09022b14fafc86 Qu Wenruo       2022-03-11  2251  		goto out;
09022b14fafc86 Qu Wenruo       2022-03-11  2252  	}
8557635ed2b04b Qu Wenruo       2022-03-11  2253  	if (profile & (BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID10)) {
6b4d375a81551b Qu Wenruo       2023-01-16  2254  		ret = scrub_simple_stripe(sctx, bg, map, scrub_dev, stripe_index);
cb091225a53800 Qu Wenruo       2023-06-22  2255  		offset = btrfs_stripe_nr_to_offset(stripe_index / map->sub_stripes);
8557635ed2b04b Qu Wenruo       2022-03-11  2256  		goto out;
8557635ed2b04b Qu Wenruo       2022-03-11  2257  	}
8557635ed2b04b Qu Wenruo       2022-03-11  2258  
8557635ed2b04b Qu Wenruo       2022-03-11  2259  	/* Only RAID56 goes through the old code */
8557635ed2b04b Qu Wenruo       2022-03-11  2260  	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);
a2de733c78fa7a Arne Jansen     2011-03-08  2261  	ret = 0;
e430c4287ebdaf Qu Wenruo       2022-03-11  2262  
e430c4287ebdaf Qu Wenruo       2022-03-11  2263  	/* Calculate the logical end of the stripe */
e430c4287ebdaf Qu Wenruo       2022-03-11  2264  	get_raid56_logic_offset(physical_end, stripe_index,
e430c4287ebdaf Qu Wenruo       2022-03-11  2265  				map, &logic_end, NULL);
e430c4287ebdaf Qu Wenruo       2022-03-11  2266  	logic_end += chunk_logical;
e430c4287ebdaf Qu Wenruo       2022-03-11  2267  
e430c4287ebdaf Qu Wenruo       2022-03-11  2268  	/* Initialize @offset in case we need to go to out: label */
e430c4287ebdaf Qu Wenruo       2022-03-11  2269  	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
cb091225a53800 Qu Wenruo       2023-06-22  2270  	increment = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
e430c4287ebdaf Qu Wenruo       2022-03-11  2271  
a2de733c78fa7a Arne Jansen     2011-03-08  2272  	/*
18d30ab961497f Qu Wenruo       2022-03-11  2273  	 * Due to the rotation, for RAID56 it's better to iterate each stripe
18d30ab961497f Qu Wenruo       2022-03-11  2274  	 * using their physical offset.
a2de733c78fa7a Arne Jansen     2011-03-08  2275  	 */
18d30ab961497f Qu Wenruo       2022-03-11  2276  	while (physical < physical_end) {
a64bd62aaf1157 Qu Wenruo       2023-08-15  2277  		u64 full_stripe_start;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2278  		u32 full_stripe_len = increment;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2279  
18d30ab961497f Qu Wenruo       2022-03-11  2280  		ret = get_raid56_logic_offset(physical, stripe_index, map,
18d30ab961497f Qu Wenruo       2022-03-11  2281  					      &logical, &stripe_logical);
a64bd62aaf1157 Qu Wenruo       2023-08-15  2282  		full_stripe_start = rounddown(logical, full_stripe_len) +
a64bd62aaf1157 Qu Wenruo       2023-08-15  2283  				    chunk_logical;
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2284  		logical += chunk_logical;
f2f66a2f886383 Zhao Lei        2015-07-21  2285  		if (ret) {
7955323bdcab30 Zhao Lei        2015-08-18  2286  			/* it is parity strip */
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2287  			stripe_logical += chunk_logical;
1009254bf22a3f Qu Wenruo       2023-03-28  2288  			ret = scrub_raid56_parity_stripe(sctx, scrub_dev, bg,
1009254bf22a3f Qu Wenruo       2023-03-28  2289  							 map, stripe_logical);
f2f66a2f886383 Zhao Lei        2015-07-21  2290  			if (ret)
f2f66a2f886383 Zhao Lei        2015-07-21  2291  				goto out;
d7cad2389560f3 Zhao Lei        2015-07-22  2292  			goto next;
89490303a42942 Filipe Manana   2020-05-08  2293  		}
625f1c8dc66d77 Liu Bo          2013-04-27  2294  
3b080b2564287b Wang Shilong    2014-04-01  2295  		/*
18d30ab961497f Qu Wenruo       2022-03-11  2296  		 * Now we're at a data stripe, scrub each extents in the range.
18d30ab961497f Qu Wenruo       2022-03-11  2297  		 *
18d30ab961497f Qu Wenruo       2022-03-11  2298  		 * At this stage, if we ignore the repair part, inside each data
18d30ab961497f Qu Wenruo       2022-03-11  2299  		 * stripe it is no different than SINGLE profile.
18d30ab961497f Qu Wenruo       2022-03-11  2300  		 * We can reuse scrub_simple_mirror() here, as the repair part
18d30ab961497f Qu Wenruo       2022-03-11  2301  		 * is still based on @mirror_num.
3b080b2564287b Wang Shilong    2014-04-01  2302  		 */
6b4d375a81551b Qu Wenruo       2023-01-16  2303  		ret = scrub_simple_mirror(sctx, bg, map, logical, BTRFS_STRIPE_LEN,
18d30ab961497f Qu Wenruo       2022-03-11  2304  					  scrub_dev, physical, 1);
18d30ab961497f Qu Wenruo       2022-03-11  2305  		if (ret < 0)
5a6ac9eacb4914 Miao Xie        2014-11-06  2306  			goto out;
a2de733c78fa7a Arne Jansen     2011-03-08  2307  next:
a64bd62aaf1157 Qu Wenruo       2023-08-15  2308  		/* No more extent in the block group. */
a64bd62aaf1157 Qu Wenruo       2023-08-15  2309  		if (sctx->found_next >= bg->start + bg->length) {
a64bd62aaf1157 Qu Wenruo       2023-08-15  2310  			spin_lock(&sctx->stat_lock);
a64bd62aaf1157 Qu Wenruo       2023-08-15  2311  			sctx->stat.last_physical = physical_end;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2312  			spin_unlock(&sctx->stat_lock);
a64bd62aaf1157 Qu Wenruo       2023-08-15  2313  			goto out;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2314  		}
a64bd62aaf1157 Qu Wenruo       2023-08-15  2315  
a64bd62aaf1157 Qu Wenruo       2023-08-15  2316  		if (sctx->found_next >= full_stripe_start + full_stripe_len) {
a64bd62aaf1157 Qu Wenruo       2023-08-15  2317  			unsigned int stripes_skipped;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2318  
a64bd62aaf1157 Qu Wenruo       2023-08-15  2319  			stripes_skipped = div_u64(sctx->found_next - full_stripe_start,
a64bd62aaf1157 Qu Wenruo       2023-08-15  2320  						  full_stripe_len);
a64bd62aaf1157 Qu Wenruo       2023-08-15  2321  			if (stripes_skipped == 0)
a64bd62aaf1157 Qu Wenruo       2023-08-15  2322  				stripes_skipped = 1;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2323  			logical += increment * stripes_skipped;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2324  			physical += BTRFS_STRIPE_LEN * stripes_skipped;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2325  		} else {
a2de733c78fa7a Arne Jansen     2011-03-08  2326  			logical += increment;
a97699d1d61071 Qu Wenruo       2023-02-17  2327  			physical += BTRFS_STRIPE_LEN;
a64bd62aaf1157 Qu Wenruo       2023-08-15  2328  		}
a64bd62aaf1157 Qu Wenruo       2023-08-15  2329  
d9d181c1ba7aa0 Stefan Behrens  2012-11-02  2330  		spin_lock(&sctx->stat_lock);
625f1c8dc66d77 Liu Bo          2013-04-27  2331  		if (stop_loop)
bc88b486d54b2a Qu Wenruo       2022-05-13  2332  			sctx->stat.last_physical =
bc88b486d54b2a Qu Wenruo       2022-05-13  2333  				map->stripes[stripe_index].physical + dev_stripe_len;
625f1c8dc66d77 Liu Bo          2013-04-27  2334  		else
d9d181c1ba7aa0 Stefan Behrens  2012-11-02  2335  			sctx->stat.last_physical = physical;
d9d181c1ba7aa0 Stefan Behrens  2012-11-02  2336  		spin_unlock(&sctx->stat_lock);
625f1c8dc66d77 Liu Bo          2013-04-27  2337  		if (stop_loop)
625f1c8dc66d77 Liu Bo          2013-04-27  2338  			break;
a2de733c78fa7a Arne Jansen     2011-03-08  2339  	}
ff023aac31198e Stefan Behrens  2012-11-06  2340  out:
8eb3dd17eadd21 Qu Wenruo       2023-04-06  2341  	ret2 = flush_scrub_stripes(sctx);
b50f2d048ecf15 Qu Wenruo       2023-06-14  2342  	if (!ret)
8eb3dd17eadd21 Qu Wenruo       2023-04-06  2343  		ret = ret2;
303c4c1391fc98 Qu Wenruo       2023-08-03  2344  	btrfs_release_path(&sctx->extent_path);
5c3d78f9a5e26b Qu Wenruo       2023-08-03  2345  	btrfs_release_path(&sctx->csum_path);
303c4c1391fc98 Qu Wenruo       2023-08-03  2346  
1009254bf22a3f Qu Wenruo       2023-03-28  2347  	if (sctx->raid56_data_stripes) {
1009254bf22a3f Qu Wenruo       2023-03-28  2348  		for (int i = 0; i < nr_data_stripes(map); i++)
1009254bf22a3f Qu Wenruo       2023-03-28  2349  			release_scrub_stripe(&sctx->raid56_data_stripes[i]);
1009254bf22a3f Qu Wenruo       2023-03-28  2350  		kfree(sctx->raid56_data_stripes);
1009254bf22a3f Qu Wenruo       2023-03-28  2351  		sctx->raid56_data_stripes = NULL;
1009254bf22a3f Qu Wenruo       2023-03-28  2352  	}
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2353  
7db1c5d14dcd52 Naohiro Aota    2021-02-04 @2354  	if (sctx->is_dev_replace && ret >= 0) {
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2355  		int ret2;
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2356  
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2357  		ret2 = sync_write_pointer_for_zoned(sctx,
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2358  				chunk_logical + offset,
2ae8ae3d3def4c Qu Wenruo       2021-12-15  2359  				map->stripes[stripe_index].physical,
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2360  				physical_end);
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2361  		if (ret2)
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2362  			ret = ret2;
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2363  	}
7db1c5d14dcd52 Naohiro Aota    2021-02-04  2364  
a2de733c78fa7a Arne Jansen     2011-03-08  2365  	return ret < 0 ? ret : 0;
a2de733c78fa7a Arne Jansen     2011-03-08  2366  }
a2de733c78fa7a Arne Jansen     2011-03-08  2367  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
