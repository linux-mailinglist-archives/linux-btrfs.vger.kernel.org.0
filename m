Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFAF319D1DE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 10:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390453AbgDCILo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 04:11:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCILo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Apr 2020 04:11:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03388xkn013294;
        Fri, 3 Apr 2020 08:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=u968l2Em+r6GuiKpi6wiM3+ZUFqrxHHSMRytsW+IVKg=;
 b=kfctrsyZv5dMvFCJ2q7h3GioVV5nyA7mc7J0tK7wpQuzcIy/MEyPO/ZxAJWaHosF1pyR
 ErwMLmcFeLg0CdHt+yhDpk48VWs3IfR/xoI3q7e2mV2yMx5wahOlsk6uaZJXvf24MUD0
 mDk0JRb3ogJnNN3+sX3RQu7BcxnUourQj5nv/3BHmQqg+3bEwnqWXgV6xHarOE9KNQ7U
 zZfIhXsobhPz3bCsZzRgjtQPj833Q0sYmfflUFgR7+6jMT8FJOfDluJMZj01OCEVy+zy
 0qisic3ozNsOGexsYjkl8CWEMvufQMXiuPxDFcMuzfZJObDQ+Yzii3iNCRTCi8d3XUAg 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqj03cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 08:11:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0338789X039940;
        Fri, 3 Apr 2020 08:11:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2mbukp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 08:11:38 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0338BbVp031622;
        Fri, 3 Apr 2020 08:11:37 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Apr 2020 01:11:37 -0700
Date:   Fri, 3 Apr 2020 11:11:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Qu Wenruo <wqu@suse.com>
Cc:     kbuild-all@lists.01.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Only require sector size alignment for parent
 eb bytenr
Message-ID: <20200403081131.GV2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326055403.22748-1-wqu@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030069
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-Only-require-sector-size-alignment-for-parent-eb-bytenr/20200327-034045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs.git next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/btrfs/extent-tree.c:1178 btrfs_get_extent_inline_ref_type() warn: '0x' prefix is confusing together with '%lu' specifier
fs/btrfs/extent-tree.c:1178 btrfs_get_extent_inline_ref_type() warn: argument 4 to %lu specifier is cast from pointer

Old smatch warnings:
fs/btrfs/extent-tree.c:6343 update_block_group() warn: inconsistent indenting
fs/btrfs/extent-tree.c:7620 find_free_extent() warn: inconsistent indenting

# https://github.com/0day-ci/linux/commit/8a07080e7e5051c75e67e30bf635fc230b2ab720
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 8a07080e7e5051c75e67e30bf635fc230b2ab720
vim +1178 fs/btrfs/extent-tree.c

64ecdb647ddb83 Liu Bo    2017-08-18  1166  				 */
64ecdb647ddb83 Liu Bo    2017-08-18  1167  				if (offset &&
8a07080e7e5051 Qu Wenruo 2020-03-26  1168  				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
64ecdb647ddb83 Liu Bo    2017-08-18  1169  					return type;
64ecdb647ddb83 Liu Bo    2017-08-18  1170  			}
167ce953ca55bd Liu Bo    2017-08-18  1171  		} else {
167ce953ca55bd Liu Bo    2017-08-18  1172  			ASSERT(is_data == BTRFS_REF_TYPE_ANY);
167ce953ca55bd Liu Bo    2017-08-18  1173  			return type;
167ce953ca55bd Liu Bo    2017-08-18  1174  		}
167ce953ca55bd Liu Bo    2017-08-18  1175  	}
167ce953ca55bd Liu Bo    2017-08-18  1176  
167ce953ca55bd Liu Bo    2017-08-18  1177  	btrfs_print_leaf((struct extent_buffer *)eb);
8a07080e7e5051 Qu Wenruo 2020-03-26 @1178  	btrfs_err(eb->fs_info,
8a07080e7e5051 Qu Wenruo 2020-03-26  1179  		  "eb %llu iref 0x%lu invalid extent inline ref type %d",
                                                                        ^^^^^

8a07080e7e5051 Qu Wenruo 2020-03-26  1180  		  eb->start, (unsigned long)iref, type);
                                                                     ^^^^^^^^^^^^^^^^^^^
0x indicates hex, but this is decimal.  But use %p for pointers so that
the can be hidden to people without enough privilege.  #kernelHardenning

167ce953ca55bd Liu Bo    2017-08-18  1181  	WARN_ON(1);
167ce953ca55bd Liu Bo    2017-08-18  1182  
167ce953ca55bd Liu Bo    2017-08-18  1183  	return BTRFS_REF_TYPE_INVALID;
167ce953ca55bd Liu Bo    2017-08-18  1184  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
