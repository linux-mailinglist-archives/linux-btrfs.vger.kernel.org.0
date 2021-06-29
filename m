Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7383B6E87
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 09:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhF2HID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 03:08:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13512 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232097AbhF2HHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 03:07:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T72CLK012173;
        Tue, 29 Jun 2021 07:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=k+jq6WRxQUmqj6a90s5ebmg9ko9D0XZa+yG3hySV8gQ=;
 b=rNiXPTgAR4L2Lu2avLPB8mtKZonc6UIaxgsl4gmSd92xSXm3uhpg85LqQrOuCxf64i3U
 4Aza/nB3UhqFPgL7yyUuuweXV0uqkd+BiDJ3qGML2n04QkKVPjrw3K9iYC+kVklJ94BL
 4tiHs8q+AOO7JZFmJzLiHCniRjx+LtzcKwEa4GGYyNq8YGxAdRTJJeuBHnaSAH8kqEnG
 AOyuQ927B9mU3fHgtOXW/RzkbwEzYDgsI9Y+pxwYUDci3HnlKprp7HGW4BSuJ7nzxmM7
 Azx0xp0snNlFiG3FauC8mWe0mMuTgyXgyQll7YdAOFjhsnPOzaVbs1F2TBWfikusB5hv Yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f7uu2nun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:05:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15T6xqEx161956;
        Tue, 29 Jun 2021 07:05:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee0u4mbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:05:06 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15T755MR182154;
        Tue, 29 Jun 2021 07:05:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 39ee0u4m6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 07:05:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15T752XU029409;
        Tue, 29 Jun 2021 07:05:02 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Jun 2021 07:05:02 +0000
Date:   Tue, 29 Jun 2021 10:04:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org
Subject: [kbuild] Re: [PATCH 3/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to
 remove ghost subvolume
Message-ID: <202106290158.0Vwb1dj2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628101637.349718-4-wqu@suse.com>
Message-ID-Hash: T2BMZ2MI2AJNNDSBBXBIKNNAN5W3CR6X
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: KU47Surjv0C_nqIfN3vI3pBk3o_P2iU2
X-Proofpoint-GUID: KU47Surjv0C_nqIfN3vI3pBk3o_P2iU2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-allow-BTRFS_IOC_SNAP_DESTROY_V2-to-remove-ghost-subvolume/20210628-181747 
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git  for-next
config: i386-randconfig-m021-20210628 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/ioctl.c:2967 remove_ghost_subvol() error: uninitialized symbol 'ret'.

Old smatch warnings:
fs/btrfs/ioctl.c:808 create_snapshot() warn: '&pending_snapshot->list' not removed from list
fs/btrfs/ioctl.c:1568 btrfs_defrag_file() warn: should 'ret << 12' be a 64 bit type?

vim +/ret +2967 fs/btrfs/ioctl.c

391ab0041fef57 Qu Wenruo       2021-06-28  2904  static int __cold remove_ghost_subvol(struct btrfs_fs_info *fs_info,
391ab0041fef57 Qu Wenruo       2021-06-28  2905  				      u64 rootid)
391ab0041fef57 Qu Wenruo       2021-06-28  2906  {
391ab0041fef57 Qu Wenruo       2021-06-28  2907  	struct btrfs_trans_handle *trans;
391ab0041fef57 Qu Wenruo       2021-06-28  2908  	struct btrfs_root *root;
391ab0041fef57 Qu Wenruo       2021-06-28  2909  	struct btrfs_path *path;
391ab0041fef57 Qu Wenruo       2021-06-28  2910  	struct btrfs_key key;
391ab0041fef57 Qu Wenruo       2021-06-28  2911  	int ret;
391ab0041fef57 Qu Wenruo       2021-06-28  2912  
391ab0041fef57 Qu Wenruo       2021-06-28  2913  	root = btrfs_get_fs_root(fs_info, rootid, false);
391ab0041fef57 Qu Wenruo       2021-06-28  2914  	if (IS_ERR(root)) {
391ab0041fef57 Qu Wenruo       2021-06-28  2915  		ret = PTR_ERR(root);
391ab0041fef57 Qu Wenruo       2021-06-28  2916  		return ret;

return PTR_ERR(root);

391ab0041fef57 Qu Wenruo       2021-06-28  2917  	}
391ab0041fef57 Qu Wenruo       2021-06-28  2918  
391ab0041fef57 Qu Wenruo       2021-06-28  2919  	/* A ghost subvolume is already a problem, better to output a warning */
391ab0041fef57 Qu Wenruo       2021-06-28  2920  	btrfs_warn(fs_info, "root %llu has no refs nor orphan item", rootid); 
391ab0041fef57 Qu Wenruo       2021-06-28  2921  	if (btrfs_root_refs(&root->root_item) != 0) {
391ab0041fef57 Qu Wenruo       2021-06-28  2922  		/* We get some strange root */
391ab0041fef57 Qu Wenruo       2021-06-28  2923  		btrfs_warn(fs_info,
391ab0041fef57 Qu Wenruo       2021-06-28  2924  			"root %llu has %u refs, but no proper root backref",
391ab0041fef57 Qu Wenruo       2021-06-28  2925  			rootid, btrfs_root_refs(&root->root_item));
391ab0041fef57 Qu Wenruo       2021-06-28  2926  		ret = -EUCLEAN;
391ab0041fef57 Qu Wenruo       2021-06-28  2927  		goto out;
391ab0041fef57 Qu Wenruo       2021-06-28  2928  	}
391ab0041fef57 Qu Wenruo       2021-06-28  2929  
391ab0041fef57 Qu Wenruo       2021-06-28  2930  	/* Already has orphan inserted */
391ab0041fef57 Qu Wenruo       2021-06-28  2931  	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state))
391ab0041fef57 Qu Wenruo       2021-06-28  2932  		goto out;

ret not intialized on this path.

391ab0041fef57 Qu Wenruo       2021-06-28  2933  
391ab0041fef57 Qu Wenruo       2021-06-28  2934  	path = btrfs_alloc_path();
391ab0041fef57 Qu Wenruo       2021-06-28  2935  	if (!path) {
391ab0041fef57 Qu Wenruo       2021-06-28  2936  		ret = -ENOMEM;
391ab0041fef57 Qu Wenruo       2021-06-28  2937  		goto out;
391ab0041fef57 Qu Wenruo       2021-06-28  2938  	}
391ab0041fef57 Qu Wenruo       2021-06-28  2939  	key.objectid = BTRFS_ORPHAN_OBJECTID;
391ab0041fef57 Qu Wenruo       2021-06-28  2940  	key.type = BTRFS_ORPHAN_ITEM_KEY;
391ab0041fef57 Qu Wenruo       2021-06-28  2941  	key.offset = rootid;
391ab0041fef57 Qu Wenruo       2021-06-28  2942  
391ab0041fef57 Qu Wenruo       2021-06-28  2943  	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
391ab0041fef57 Qu Wenruo       2021-06-28  2944  	btrfs_free_path(path);
391ab0041fef57 Qu Wenruo       2021-06-28  2945  	/* Either error or there is already an orphan item */
391ab0041fef57 Qu Wenruo       2021-06-28  2946  	if (ret <= 0)
391ab0041fef57 Qu Wenruo       2021-06-28  2947  		goto out;
391ab0041fef57 Qu Wenruo       2021-06-28  2948  
391ab0041fef57 Qu Wenruo       2021-06-28  2949  	trans = btrfs_start_transaction(fs_info->tree_root, 1);
391ab0041fef57 Qu Wenruo       2021-06-28  2950  	if (IS_ERR(trans)) {
391ab0041fef57 Qu Wenruo       2021-06-28  2951  		ret = PTR_ERR(trans);
391ab0041fef57 Qu Wenruo       2021-06-28  2952  		goto out;
391ab0041fef57 Qu Wenruo       2021-06-28  2953  	}
391ab0041fef57 Qu Wenruo       2021-06-28  2954  
391ab0041fef57 Qu Wenruo       2021-06-28  2955  	ret = btrfs_insert_orphan_item(trans, fs_info->tree_root, rootid);
391ab0041fef57 Qu Wenruo       2021-06-28  2956  	if (ret < 0 && ret != -EEXIST) {
391ab0041fef57 Qu Wenruo       2021-06-28  2957  		btrfs_abort_transaction(trans, ret);
391ab0041fef57 Qu Wenruo       2021-06-28  2958  		goto end_trans;
391ab0041fef57 Qu Wenruo       2021-06-28  2959  	}
391ab0041fef57 Qu Wenruo       2021-06-28  2960  	ret = 0;
391ab0041fef57 Qu Wenruo       2021-06-28  2961  	btrfs_add_dead_root(root);
391ab0041fef57 Qu Wenruo       2021-06-28  2962  
391ab0041fef57 Qu Wenruo       2021-06-28  2963  end_trans:
391ab0041fef57 Qu Wenruo       2021-06-28  2964  	btrfs_end_transaction(trans);
391ab0041fef57 Qu Wenruo       2021-06-28  2965  out:
391ab0041fef57 Qu Wenruo       2021-06-28  2966  	btrfs_put_root(root);
391ab0041fef57 Qu Wenruo       2021-06-28 @2967  	return ret;
391ab0041fef57 Qu Wenruo       2021-06-28  2968  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

