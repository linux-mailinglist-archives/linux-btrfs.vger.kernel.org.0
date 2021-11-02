Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E04426E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 06:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhKBFvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 01:51:51 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:60927 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBFvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Nov 2021 01:51:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1006126|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00270319-0.000340292-0.996957;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Lm55kwj_1635832154;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Lm55kwj_1635832154)
          by smtp.aliyun-inc.com(10.147.40.2);
          Tue, 02 Nov 2021 13:49:14 +0800
Date:   Tue, 02 Nov 2021 13:49:17 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] btrfs: fix CHECK_INTEGRITY warning when !QUEUE_FLAG_WC
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su, kbuild-all@lists.01.org
In-Reply-To: <202111021339.P8Ewzvel-lkp@intel.com>
References: <20211022082637.50880-1-wangyugui@e16-tech.com> <202111021339.P8Ewzvel-lkp@intel.com>
Message-Id: <20211102134916.EC5E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This unused variable warning is already fixed in v2.

and some changelog is updated in this v3 too
https://patchwork.kernel.org/project/linux-btrfs/patch/20211027223254.8095-1-wangyugui@e16-tech.com/

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/11/02

> Hi wangyugui,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on kdave/for-next]
> [also build test ERROR on v5.15 next-20211101]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/wangyugui/btrfs-fix-CHECK_INTEGRITY-warning-when-QUEUE_FLAG_WC/20211022-162718
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/0day-ci/linux/commit/ced40ee717d7e4e8a131b61855a86f0d55aaf817
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review wangyugui/btrfs-fix-CHECK_INTEGRITY-warning-when-QUEUE_FLAG_WC/20211022-162718
>         git checkout ced40ee717d7e4e8a131b61855a86f0d55aaf817
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/btrfs/disk-io.c: In function 'write_dev_flush':
> >> fs/btrfs/disk-io.c:3981:24: error: unused variable 'q' [-Werror=unused-variable]
>     3981 |  struct request_queue *q = bdev_get_queue(device->bdev);
>          |                        ^
>    cc1: all warnings being treated as errors
> 
> 
> vim +/q +3981 fs/btrfs/disk-io.c
> 
> 387125fc722a8e Chris Mason       2011-11-18  3974  
> 387125fc722a8e Chris Mason       2011-11-18  3975  /*
> 4fc6441aac7589 Anand Jain        2017-06-13  3976   * Submit a flush request to the device if it supports it. Error handling is
> 4fc6441aac7589 Anand Jain        2017-06-13  3977   * done in the waiting counterpart.
> 387125fc722a8e Chris Mason       2011-11-18  3978   */
> 4fc6441aac7589 Anand Jain        2017-06-13  3979  static void write_dev_flush(struct btrfs_device *device)
> 387125fc722a8e Chris Mason       2011-11-18  3980  {
> c2a9c7ab475bc3 Anand Jain        2017-04-06 @3981  	struct request_queue *q = bdev_get_queue(device->bdev);
> e0ae999414238a David Sterba      2017-06-06  3982  	struct bio *bio = device->flush_bio;
> 387125fc722a8e Chris Mason       2011-11-18  3983  
> ced40ee717d7e4 wangyugui         2021-10-22  3984  	#ifndef CONFIG_BTRFS_FS_CHECK_INTEGRITY
> ced40ee717d7e4 wangyugui         2021-10-22  3985  	/*
> ced40ee717d7e4 wangyugui         2021-10-22  3986  	* submit_bio(REQ_SYNC | REQ_PREFLUSH) can be skipped when !QUEUE_FLAG_WC.
> ced40ee717d7e4 wangyugui         2021-10-22  3987  	* but btrfsic_submit_bio() != submit_bio() when CONFIG_BTRFS_FS_CHECK_INTEGRITY
> ced40ee717d7e4 wangyugui         2021-10-22  3988  	*/
> c2a9c7ab475bc3 Anand Jain        2017-04-06  3989  	if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags))
> 4fc6441aac7589 Anand Jain        2017-06-13  3990  		return;
> ced40ee717d7e4 wangyugui         2021-10-22  3991  	#endif
> 387125fc722a8e Chris Mason       2011-11-18  3992  
> e0ae999414238a David Sterba      2017-06-06  3993  	bio_reset(bio);
> 387125fc722a8e Chris Mason       2011-11-18  3994  	bio->bi_end_io = btrfs_end_empty_barrier;
> 74d46992e0d9de Christoph Hellwig 2017-08-23  3995  	bio_set_dev(bio, device->bdev);
> 8d91012528b3c9 Jan Kara          2017-05-02  3996  	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
> 387125fc722a8e Chris Mason       2011-11-18  3997  	init_completion(&device->flush_wait);
> 387125fc722a8e Chris Mason       2011-11-18  3998  	bio->bi_private = &device->flush_wait;
> 387125fc722a8e Chris Mason       2011-11-18  3999  
> 43a0111103af2d Lu Fengqi         2017-08-18  4000  	btrfsic_submit_bio(bio);
> 1c3063b6dbfa03 Anand Jain        2017-12-04  4001  	set_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
> 387125fc722a8e Chris Mason       2011-11-18  4002  }
> 387125fc722a8e Chris Mason       2011-11-18  4003  
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


