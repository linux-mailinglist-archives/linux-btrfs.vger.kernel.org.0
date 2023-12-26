Return-Path: <linux-btrfs+bounces-1135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5B81E4EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Dec 2023 05:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A8E1F2259E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Dec 2023 04:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114604AF9F;
	Tue, 26 Dec 2023 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLJa0QZ/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6E4AF7D;
	Tue, 26 Dec 2023 04:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703566501; x=1735102501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rVjjpUZY1sKnK3tAGZgtTZ0TtVqzYzrm2ixcq964Igc=;
  b=NLJa0QZ/PM++3xtK6XXNodE7M/ecN+iX9izDe5EW4SI0hk50wzwRIz1G
   9F64OSLrmAtYtKQVyhTO6GP3je2bYFB7/IlmRcPAiFu5uGsjbC0b8kVbs
   +GWzVpgAaEO4Ht8Ft7228Rw2Lll8SXsCWBfpuySS+Ob196OD671PCn4J3
   w+vXdbxT9nvWpRa3O1H8UpgiMTpJRfyl99vmMcbScEjtb7SIg+664iMJr
   OAZnfFDWg5KnPhvwE2xY4aq76nUAS/4OLEgX3NHM2MQsOYfUEpYBlSKPs
   c87gqmwqsdbL/hhStRG3FPOa33Luup5JZKQ4hiPXt7x6NwNxfbNE4A/pv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3405031"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3405031"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 20:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="843791206"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="843791206"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 25 Dec 2023 20:54:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHzSx-000E0t-0i;
	Tue, 26 Dec 2023 04:54:55 +0000
Date: Tue, 26 Dec 2023 12:53:58 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr, andriy.shevchenko@linux.intel.com,
	David.Laight@aculab.com, ddiss@suse.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 3/3] btrfs: migrate to the newer memparse_safe() helper
Message-ID: <202312261215.eFf9J1xV-lkp@intel.com>
References: <6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on next-20231222]
[cannot apply to akpm-mm/mm-nonmm-unstable akpm-mm/mm-everything linus/master v6.7-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/kstrtox-introduce-a-safer-version-of-memparse/20231225-151921
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/6dfa53ded887caa2269c1beeaedcff086342339a.1703324146.git.wqu%40suse.com
patch subject: [PATCH 3/3] btrfs: migrate to the newer memparse_safe() helper
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231226/202312261215.eFf9J1xV-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d3ef86708241a3bee902615c190dead1638c4e09)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261215.eFf9J1xV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261215.eFf9J1xV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/super.c:403:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     403 |                 int ret;
         |                 ^
   1 warning generated.


vim +403 fs/btrfs/super.c

   261	
   262	static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
   263	{
   264		struct btrfs_fs_context *ctx = fc->fs_private;
   265		struct fs_parse_result result;
   266		int opt;
   267	
   268		opt = fs_parse(fc, btrfs_fs_parameters, param, &result);
   269		if (opt < 0)
   270			return opt;
   271	
   272		switch (opt) {
   273		case Opt_degraded:
   274			btrfs_set_opt(ctx->mount_opt, DEGRADED);
   275			break;
   276		case Opt_subvol_empty:
   277			/*
   278			 * This exists because we used to allow it on accident, so we're
   279			 * keeping it to maintain ABI.  See 37becec95ac3 ("Btrfs: allow
   280			 * empty subvol= again").
   281			 */
   282			break;
   283		case Opt_subvol:
   284			kfree(ctx->subvol_name);
   285			ctx->subvol_name = kstrdup(param->string, GFP_KERNEL);
   286			if (!ctx->subvol_name)
   287				return -ENOMEM;
   288			break;
   289		case Opt_subvolid:
   290			ctx->subvol_objectid = result.uint_64;
   291	
   292			/* subvolid=0 means give me the original fs_tree. */
   293			if (!ctx->subvol_objectid)
   294				ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
   295			break;
   296		case Opt_device: {
   297			struct btrfs_device *device;
   298			blk_mode_t mode = sb_open_mode(fc->sb_flags);
   299	
   300			mutex_lock(&uuid_mutex);
   301			device = btrfs_scan_one_device(param->string, mode, false);
   302			mutex_unlock(&uuid_mutex);
   303			if (IS_ERR(device))
   304				return PTR_ERR(device);
   305			break;
   306		}
   307		case Opt_datasum:
   308			if (result.negated) {
   309				btrfs_set_opt(ctx->mount_opt, NODATASUM);
   310			} else {
   311				btrfs_clear_opt(ctx->mount_opt, NODATACOW);
   312				btrfs_clear_opt(ctx->mount_opt, NODATASUM);
   313			}
   314			break;
   315		case Opt_datacow:
   316			if (result.negated) {
   317				btrfs_clear_opt(ctx->mount_opt, COMPRESS);
   318				btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
   319				btrfs_set_opt(ctx->mount_opt, NODATACOW);
   320				btrfs_set_opt(ctx->mount_opt, NODATASUM);
   321			} else {
   322				btrfs_clear_opt(ctx->mount_opt, NODATACOW);
   323			}
   324			break;
   325		case Opt_compress_force:
   326		case Opt_compress_force_type:
   327			btrfs_set_opt(ctx->mount_opt, FORCE_COMPRESS);
   328			fallthrough;
   329		case Opt_compress:
   330		case Opt_compress_type:
   331			if (opt == Opt_compress || opt == Opt_compress_force) {
   332				ctx->compress_type = BTRFS_COMPRESS_ZLIB;
   333				ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
   334				btrfs_set_opt(ctx->mount_opt, COMPRESS);
   335				btrfs_clear_opt(ctx->mount_opt, NODATACOW);
   336				btrfs_clear_opt(ctx->mount_opt, NODATASUM);
   337			} else if (strncmp(param->string, "zlib", 4) == 0) {
   338				ctx->compress_type = BTRFS_COMPRESS_ZLIB;
   339				ctx->compress_level =
   340					btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
   341								 param->string + 4);
   342				btrfs_set_opt(ctx->mount_opt, COMPRESS);
   343				btrfs_clear_opt(ctx->mount_opt, NODATACOW);
   344				btrfs_clear_opt(ctx->mount_opt, NODATASUM);
   345			} else if (strncmp(param->string, "lzo", 3) == 0) {
   346				ctx->compress_type = BTRFS_COMPRESS_LZO;
   347				ctx->compress_level = 0;
   348				btrfs_set_opt(ctx->mount_opt, COMPRESS);
   349				btrfs_clear_opt(ctx->mount_opt, NODATACOW);
   350				btrfs_clear_opt(ctx->mount_opt, NODATASUM);
   351			} else if (strncmp(param->string, "zstd", 4) == 0) {
   352				ctx->compress_type = BTRFS_COMPRESS_ZSTD;
   353				ctx->compress_level =
   354					btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
   355								 param->string + 4);
   356				btrfs_set_opt(ctx->mount_opt, COMPRESS);
   357				btrfs_clear_opt(ctx->mount_opt, NODATACOW);
   358				btrfs_clear_opt(ctx->mount_opt, NODATASUM);
   359			} else if (strncmp(param->string, "no", 2) == 0) {
   360				ctx->compress_level = 0;
   361				ctx->compress_type = 0;
   362				btrfs_clear_opt(ctx->mount_opt, COMPRESS);
   363				btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
   364			} else {
   365				btrfs_err(NULL, "unrecognized compression value %s",
   366					  param->string);
   367				return -EINVAL;
   368			}
   369			break;
   370		case Opt_ssd:
   371			if (result.negated) {
   372				btrfs_set_opt(ctx->mount_opt, NOSSD);
   373				btrfs_clear_opt(ctx->mount_opt, SSD);
   374				btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
   375			} else {
   376				btrfs_set_opt(ctx->mount_opt, SSD);
   377				btrfs_clear_opt(ctx->mount_opt, NOSSD);
   378			}
   379			break;
   380		case Opt_ssd_spread:
   381			if (result.negated) {
   382				btrfs_clear_opt(ctx->mount_opt, SSD_SPREAD);
   383			} else {
   384				btrfs_set_opt(ctx->mount_opt, SSD);
   385				btrfs_set_opt(ctx->mount_opt, SSD_SPREAD);
   386				btrfs_clear_opt(ctx->mount_opt, NOSSD);
   387			}
   388			break;
   389		case Opt_barrier:
   390			if (result.negated)
   391				btrfs_set_opt(ctx->mount_opt, NOBARRIER);
   392			else
   393				btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
   394			break;
   395		case Opt_thread_pool:
   396			if (result.uint_32 == 0) {
   397				btrfs_err(NULL, "invalid value 0 for thread_pool");
   398				return -EINVAL;
   399			}
   400			ctx->thread_pool_size = result.uint_32;
   401			break;
   402		case Opt_max_inline:
 > 403			int ret;
   404	
   405			ret = memparse_safe(param->string, MEMPARSE_SUFFIXES_DEFAULT,
   406					    &ctx->max_inline, NULL);
   407			if (ret < 0) {
   408				btrfs_err(NULL, "invalid string \"%s\"", param->string);
   409				return ret;
   410			}
   411			ctx->max_inline = memparse(param->string, NULL);
   412			break;
   413		case Opt_acl:
   414			if (result.negated) {
   415				fc->sb_flags &= ~SB_POSIXACL;
   416			} else {
   417	#ifdef CONFIG_BTRFS_FS_POSIX_ACL
   418				fc->sb_flags |= SB_POSIXACL;
   419	#else
   420				btrfs_err(NULL, "support for ACL not compiled in");
   421				return -EINVAL;
   422	#endif
   423			}
   424			/*
   425			 * VFS limits the ability to toggle ACL on and off via remount,
   426			 * despite every file system allowing this.  This seems to be
   427			 * an oversight since we all do, but it'll fail if we're
   428			 * remounting.  So don't set the mask here, we'll check it in
   429			 * btrfs_reconfigure and do the toggling ourselves.
   430			 */
   431			if (fc->purpose != FS_CONTEXT_FOR_RECONFIGURE)
   432				fc->sb_flags_mask |= SB_POSIXACL;
   433			break;
   434		case Opt_treelog:
   435			if (result.negated)
   436				btrfs_set_opt(ctx->mount_opt, NOTREELOG);
   437			else
   438				btrfs_clear_opt(ctx->mount_opt, NOTREELOG);
   439			break;
   440		case Opt_nologreplay:
   441			btrfs_warn(NULL,
   442			"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
   443			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
   444			break;
   445		case Opt_flushoncommit:
   446			if (result.negated)
   447				btrfs_clear_opt(ctx->mount_opt, FLUSHONCOMMIT);
   448			else
   449				btrfs_set_opt(ctx->mount_opt, FLUSHONCOMMIT);
   450			break;
   451		case Opt_ratio:
   452			ctx->metadata_ratio = result.uint_32;
   453			break;
   454		case Opt_discard:
   455			if (result.negated) {
   456				btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
   457				btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
   458				btrfs_set_opt(ctx->mount_opt, NODISCARD);
   459			} else {
   460				btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
   461				btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
   462			}
   463			break;
   464		case Opt_discard_mode:
   465			switch (result.uint_32) {
   466			case Opt_discard_sync:
   467				btrfs_clear_opt(ctx->mount_opt, DISCARD_ASYNC);
   468				btrfs_set_opt(ctx->mount_opt, DISCARD_SYNC);
   469				break;
   470			case Opt_discard_async:
   471				btrfs_clear_opt(ctx->mount_opt, DISCARD_SYNC);
   472				btrfs_set_opt(ctx->mount_opt, DISCARD_ASYNC);
   473				break;
   474			default:
   475				btrfs_err(NULL, "unrecognized discard mode value %s",
   476					  param->key);
   477				return -EINVAL;
   478			}
   479			btrfs_clear_opt(ctx->mount_opt, NODISCARD);
   480			break;
   481		case Opt_space_cache:
   482			if (result.negated) {
   483				btrfs_set_opt(ctx->mount_opt, NOSPACECACHE);
   484				btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
   485				btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
   486			} else {
   487				btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
   488				btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
   489			}
   490			break;
   491		case Opt_space_cache_version:
   492			switch (result.uint_32) {
   493			case Opt_space_cache_v1:
   494				btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
   495				btrfs_clear_opt(ctx->mount_opt, FREE_SPACE_TREE);
   496				break;
   497			case Opt_space_cache_v2:
   498				btrfs_clear_opt(ctx->mount_opt, SPACE_CACHE);
   499				btrfs_set_opt(ctx->mount_opt, FREE_SPACE_TREE);
   500				break;
   501			default:
   502				btrfs_err(NULL, "unrecognized space_cache value %s",
   503					  param->key);
   504				return -EINVAL;
   505			}
   506			break;
   507		case Opt_rescan_uuid_tree:
   508			btrfs_set_opt(ctx->mount_opt, RESCAN_UUID_TREE);
   509			break;
   510		case Opt_clear_cache:
   511			btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
   512			break;
   513		case Opt_user_subvol_rm_allowed:
   514			btrfs_set_opt(ctx->mount_opt, USER_SUBVOL_RM_ALLOWED);
   515			break;
   516		case Opt_enospc_debug:
   517			if (result.negated)
   518				btrfs_clear_opt(ctx->mount_opt, ENOSPC_DEBUG);
   519			else
   520				btrfs_set_opt(ctx->mount_opt, ENOSPC_DEBUG);
   521			break;
   522		case Opt_defrag:
   523			if (result.negated)
   524				btrfs_clear_opt(ctx->mount_opt, AUTO_DEFRAG);
   525			else
   526				btrfs_set_opt(ctx->mount_opt, AUTO_DEFRAG);
   527			break;
   528		case Opt_usebackuproot:
   529			btrfs_warn(NULL,
   530				   "'usebackuproot' is deprecated, use 'rescue=usebackuproot' instead");
   531			btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
   532	
   533			/* If we're loading the backup roots we can't trust the space cache. */
   534			btrfs_set_opt(ctx->mount_opt, CLEAR_CACHE);
   535			break;
   536		case Opt_skip_balance:
   537			btrfs_set_opt(ctx->mount_opt, SKIP_BALANCE);
   538			break;
   539		case Opt_fatal_errors:
   540			switch (result.uint_32) {
   541			case Opt_fatal_errors_panic:
   542				btrfs_set_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
   543				break;
   544			case Opt_fatal_errors_bug:
   545				btrfs_clear_opt(ctx->mount_opt, PANIC_ON_FATAL_ERROR);
   546				break;
   547			default:
   548				btrfs_err(NULL, "unrecognized fatal_errors value %s",
   549					  param->key);
   550				return -EINVAL;
   551			}
   552			break;
   553		case Opt_commit_interval:
   554			ctx->commit_interval = result.uint_32;
   555			if (ctx->commit_interval == 0)
   556				ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
   557			break;
   558		case Opt_rescue:
   559			switch (result.uint_32) {
   560			case Opt_rescue_usebackuproot:
   561				btrfs_set_opt(ctx->mount_opt, USEBACKUPROOT);
   562				break;
   563			case Opt_rescue_nologreplay:
   564				btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
   565				break;
   566			case Opt_rescue_ignorebadroots:
   567				btrfs_set_opt(ctx->mount_opt, IGNOREBADROOTS);
   568				break;
   569			case Opt_rescue_ignoredatacsums:
   570				btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
   571				break;
   572			case Opt_rescue_parameter_all:
   573				btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
   574				btrfs_set_opt(ctx->mount_opt, IGNOREBADROOTS);
   575				btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
   576				break;
   577			default:
   578				btrfs_info(NULL, "unrecognized rescue option '%s'",
   579					   param->key);
   580				return -EINVAL;
   581			}
   582			break;
   583	#ifdef CONFIG_BTRFS_DEBUG
   584		case Opt_fragment:
   585			switch (result.uint_32) {
   586			case Opt_fragment_parameter_all:
   587				btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
   588				btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
   589				break;
   590			case Opt_fragment_parameter_metadata:
   591				btrfs_set_opt(ctx->mount_opt, FRAGMENT_METADATA);
   592				break;
   593			case Opt_fragment_parameter_data:
   594				btrfs_set_opt(ctx->mount_opt, FRAGMENT_DATA);
   595				break;
   596			default:
   597				btrfs_info(NULL, "unrecognized fragment option '%s'",
   598					   param->key);
   599				return -EINVAL;
   600			}
   601			break;
   602	#endif
   603	#ifdef CONFIG_BTRFS_FS_REF_VERIFY
   604		case Opt_ref_verify:
   605			btrfs_set_opt(ctx->mount_opt, REF_VERIFY);
   606			break;
   607	#endif
   608		default:
   609			btrfs_err(NULL, "unrecognized mount option '%s'", param->key);
   610			return -EINVAL;
   611		}
   612	
   613		return 0;
   614	}
   615	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

