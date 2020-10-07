Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F274D285690
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 04:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJGCII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Oct 2020 22:08:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47510 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGCII (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Oct 2020 22:08:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09724Q5L021521;
        Wed, 7 Oct 2020 02:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dhMVO0+t35MyFcHtyWc/2L7Etotl6+mGq41bLSwuUWI=;
 b=WIl/v1YgjxjPeUho/Ug0veBU8cf+ebGYqVzsEQXXOGwdVScQ+Kv1bzDMy/AN3QhaoX3D
 Hraa48xgiOCdilNz4/aL0mUwujUNyDhiC1hHh6zZHO47f9Lwt0hKrgDi6wyNzvEMuPnV
 8Ek+VjPZp51/J3dKRoqvm9BZreTWBYTtkIWDpiR4HJbiJtF59t9FvjtyDaxa25klpYc9
 RqqMi7xsMEHoJfosGWAf0Xo5Fj69/JiGxMAwKikD48umeYBrp20Ciq7/g0PZGPIIDf/E
 MkBLw9bJebWcfqBvZz9nZ7+Z2NfbVWFOsXHlxPk2NJixgfCr0/hVJl0hqdoPaC3zLj6h LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33xetayexy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 02:08:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097269UA140654;
        Wed, 7 Oct 2020 02:08:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33y37xw1wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 02:08:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 097280WU009871;
        Wed, 7 Oct 2020 02:08:00 GMT
Received: from [192.168.1.102] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 19:08:00 -0700
Subject: Re: [PATCH] btrfs: fix devid 0 without a replace item by failing the
 mount
To:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, josef@toxicpanda.com
References: <944e4246d4cfcb411b2bd09e941931ac7616e961.1601988987.git.anand.jain@oracle.com>
 <202010062208.6rn9cld4-lkp@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <9f78a512-5733-a44b-458e-0453a6a2b479@oracle.com>
Date:   Wed, 7 Oct 2020 10:07:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <202010062208.6rn9cld4-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070011
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/10/20 10:54 pm, kernel test robot wrote:
> Hi Anand,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on v5.9-rc8 next-20201006]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Anand-Jain/btrfs-fix-devid-0-without-a-replace-item-by-failing-the-mount/20201006-210957
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> config: i386-randconfig-s001-20201005 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>          # apt-get install sparse
>          # sparse version: v0.6.2-201-g24bdaac6-dirty
>          # https://github.com/0day-ci/linux/commit/ed4ebb4eb3f213f048ea5f6a2ed80f6bd728c9e1
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Anand-Jain/btrfs-fix-devid-0-without-a-replace-item-by-failing-the-mount/20201006-210957
>          git checkout ed4ebb4eb3f213f048ea5f6a2ed80f6bd728c9e1
>          # save the attached .config to linux build tree
>          make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     fs/btrfs/dev-replace.c: In function 'btrfs_init_dev_replace':
>>> fs/btrfs/dev-replace.c:98:7: error: too few arguments to function 'btrfs_find_device'
>        98 |   if (btrfs_find_device(fs_info->fs_devices,
>           |       ^~~~~~~~~~~~~~~~~
>     In file included from fs/btrfs/dev-replace.c:18:
>     fs/btrfs/volumes.h:455:22: note: declared here
>       455 | struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
>           |                      ^~~~~~~~~~~~~~~~~
>     fs/btrfs/dev-replace.c:161:7: error: too few arguments to function 'btrfs_find_device'
>       161 |   if (btrfs_find_device(fs_info->fs_devices,
>           |       ^~~~~~~~~~~~~~~~~
>     In file included from fs/btrfs/dev-replace.c:18:
>     fs/btrfs/volumes.h:455:22: note: declared here
>       455 | struct btrfs_device *btrfs_find_device(struct btrfs_fs_devices *fs_devices,
>           |                      ^~~~~~~~~~~~~~~~~
> 

  Is there is a way to mention the patch dependencies, so that 0-Day 
tests would understand. As in the patch's changelog, two dependent 
patches [1] aren't in the misc-next yet.

[1]
https://patchwork.kernel.org/patch/11818635
https://patchwork.kernel.org/patch/11796905

Thanks, Anand


> vim +/btrfs_find_device +98 fs/btrfs/dev-replace.c
> 
>      68	
>      69	int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
>      70	{
>      71		struct btrfs_key key;
>      72		struct btrfs_root *dev_root = fs_info->dev_root;
>      73		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
>      74		struct extent_buffer *eb;
>      75		int slot;
>      76		int ret = 0;
>      77		struct btrfs_path *path = NULL;
>      78		int item_size;
>      79		struct btrfs_dev_replace_item *ptr;
>      80		u64 src_devid;
>      81	
>      82		path = btrfs_alloc_path();
>      83		if (!path) {
>      84			ret = -ENOMEM;
>      85			goto out;
>      86		}
>      87	
>      88		key.objectid = 0;
>      89		key.type = BTRFS_DEV_REPLACE_KEY;
>      90		key.offset = 0;
>      91		ret = btrfs_search_slot(NULL, dev_root, &key, path, 0, 0);
>      92		if (ret) {
>      93	no_valid_dev_replace_entry_found:
>      94			/*
>      95			 * We don't have a replace item or it's corrupted.
>      96			 * If there is a replace target, fail the mount.
>      97			 */
>    > 98			if (btrfs_find_device(fs_info->fs_devices,
>      99					      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
>     100				btrfs_err(fs_info,
>     101				"found replace target device without a replace item");
>     102				ret = -EIO;
>     103				goto out;
>     104			}
>     105			ret = 0;
>     106			dev_replace->replace_state =
>     107				BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED;
>     108			dev_replace->cont_reading_from_srcdev_mode =
>     109			    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_ALWAYS;
>     110			dev_replace->time_started = 0;
>     111			dev_replace->time_stopped = 0;
>     112			atomic64_set(&dev_replace->num_write_errors, 0);
>     113			atomic64_set(&dev_replace->num_uncorrectable_read_errors, 0);
>     114			dev_replace->cursor_left = 0;
>     115			dev_replace->committed_cursor_left = 0;
>     116			dev_replace->cursor_left_last_write_of_item = 0;
>     117			dev_replace->cursor_right = 0;
>     118			dev_replace->srcdev = NULL;
>     119			dev_replace->tgtdev = NULL;
>     120			dev_replace->is_valid = 0;
>     121			dev_replace->item_needs_writeback = 0;
>     122			goto out;
>     123		}
>     124		slot = path->slots[0];
>     125		eb = path->nodes[0];
>     126		item_size = btrfs_item_size_nr(eb, slot);
>     127		ptr = btrfs_item_ptr(eb, slot, struct btrfs_dev_replace_item);
>     128	
>     129		if (item_size != sizeof(struct btrfs_dev_replace_item)) {
>     130			btrfs_warn(fs_info,
>     131				"dev_replace entry found has unexpected size, ignore entry");
>     132			goto no_valid_dev_replace_entry_found;
>     133		}
>     134	
>     135		src_devid = btrfs_dev_replace_src_devid(eb, ptr);
>     136		dev_replace->cont_reading_from_srcdev_mode =
>     137			btrfs_dev_replace_cont_reading_from_srcdev_mode(eb, ptr);
>     138		dev_replace->replace_state = btrfs_dev_replace_replace_state(eb, ptr);
>     139		dev_replace->time_started = btrfs_dev_replace_time_started(eb, ptr);
>     140		dev_replace->time_stopped =
>     141			btrfs_dev_replace_time_stopped(eb, ptr);
>     142		atomic64_set(&dev_replace->num_write_errors,
>     143			     btrfs_dev_replace_num_write_errors(eb, ptr));
>     144		atomic64_set(&dev_replace->num_uncorrectable_read_errors,
>     145			     btrfs_dev_replace_num_uncorrectable_read_errors(eb, ptr));
>     146		dev_replace->cursor_left = btrfs_dev_replace_cursor_left(eb, ptr);
>     147		dev_replace->committed_cursor_left = dev_replace->cursor_left;
>     148		dev_replace->cursor_left_last_write_of_item = dev_replace->cursor_left;
>     149		dev_replace->cursor_right = btrfs_dev_replace_cursor_right(eb, ptr);
>     150		dev_replace->is_valid = 1;
>     151	
>     152		dev_replace->item_needs_writeback = 0;
>     153		switch (dev_replace->replace_state) {
>     154		case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
>     155		case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
>     156		case BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED:
>     157			/*
>     158			 * We don't have an active replace item but if there is a
>     159			 * replace target, fail the mount.
>     160			 */
>     161			if (btrfs_find_device(fs_info->fs_devices,
>     162					      BTRFS_DEV_REPLACE_DEVID, NULL, NULL)) {
>     163				btrfs_err(fs_info,
>     164				"replace devid present without an active replace item");
>     165				ret = -EIO;
>     166			} else {
>     167				dev_replace->srcdev = NULL;
>     168				dev_replace->tgtdev = NULL;
>     169			}
>     170			break;
>     171		case BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED:
>     172		case BTRFS_IOCTL_DEV_REPLACE_STATE_SUSPENDED:
>     173			dev_replace->srcdev = btrfs_find_device(fs_info->fs_devices,
>     174							src_devid, NULL, NULL, true);
>     175			dev_replace->tgtdev = btrfs_find_device(fs_info->fs_devices,
>     176								BTRFS_DEV_REPLACE_DEVID,
>     177								NULL, NULL, true);
>     178			/*
>     179			 * allow 'btrfs dev replace_cancel' if src/tgt device is
>     180			 * missing
>     181			 */
>     182			if (!dev_replace->srcdev &&
>     183			    !btrfs_test_opt(fs_info, DEGRADED)) {
>     184				ret = -EIO;
>     185				btrfs_warn(fs_info,
>     186				   "cannot mount because device replace operation is ongoing and");
>     187				btrfs_warn(fs_info,
>     188				   "srcdev (devid %llu) is missing, need to run 'btrfs dev scan'?",
>     189				   src_devid);
>     190			}
>     191			if (!dev_replace->tgtdev &&
>     192			    !btrfs_test_opt(fs_info, DEGRADED)) {
>     193				ret = -EIO;
>     194				btrfs_warn(fs_info,
>     195				   "cannot mount because device replace operation is ongoing and");
>     196				btrfs_warn(fs_info,
>     197				   "tgtdev (devid %llu) is missing, need to run 'btrfs dev scan'?",
>     198					BTRFS_DEV_REPLACE_DEVID);
>     199			}
>     200			if (dev_replace->tgtdev) {
>     201				if (dev_replace->srcdev) {
>     202					dev_replace->tgtdev->total_bytes =
>     203						dev_replace->srcdev->total_bytes;
>     204					dev_replace->tgtdev->disk_total_bytes =
>     205						dev_replace->srcdev->disk_total_bytes;
>     206					dev_replace->tgtdev->commit_total_bytes =
>     207						dev_replace->srcdev->commit_total_bytes;
>     208					dev_replace->tgtdev->bytes_used =
>     209						dev_replace->srcdev->bytes_used;
>     210					dev_replace->tgtdev->commit_bytes_used =
>     211						dev_replace->srcdev->commit_bytes_used;
>     212				}
>     213				set_bit(BTRFS_DEV_STATE_REPLACE_TGT,
>     214					&dev_replace->tgtdev->dev_state);
>     215	
>     216				WARN_ON(fs_info->fs_devices->rw_devices == 0);
>     217				dev_replace->tgtdev->io_width = fs_info->sectorsize;
>     218				dev_replace->tgtdev->io_align = fs_info->sectorsize;
>     219				dev_replace->tgtdev->sector_size = fs_info->sectorsize;
>     220				dev_replace->tgtdev->fs_info = fs_info;
>     221				set_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
>     222					&dev_replace->tgtdev->dev_state);
>     223			}
>     224			break;
>     225		}
>     226	
>     227	out:
>     228		btrfs_free_path(path);
>     229		return ret;
>     230	}
>     231	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

