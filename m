Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BC5B4FBA
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Sep 2022 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIKPir convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 11 Sep 2022 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIKPi0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 11:38:26 -0400
Received: from out20-229.mail.aliyun.com (out20-229.mail.aliyun.com [115.124.20.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419B1248D3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 08:38:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2426287|-1;BR=01201311R131S06rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.040623-0.00409522-0.955282;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.PDAiN4D_1662910687;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PDAiN4D_1662910687)
          by smtp.aliyun-inc.com;
          Sun, 11 Sep 2022 23:38:07 +0800
Date:   Sun, 11 Sep 2022 23:38:15 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE mismatch in kernel/btrfs-devel and btrfs-progs
Message-Id: <20220911233812.FFEF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE mismatch in kernel/btrfs-devel and btrfs-progs	

kernel/btrfs-devel	misc-next
include/uapi/linux/btrfs.h:297:#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE (1ULL << 3)

btrfs-progs
./kernel-shared/ctree.h:497:#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE    (1ULL << 5)

we need fix the version of btrfs-progs.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/11


