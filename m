Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2395B52BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 05:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiILDBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Sep 2022 23:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiILDBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Sep 2022 23:01:46 -0400
Received: from out20-135.mail.aliyun.com (out20-135.mail.aliyun.com [115.124.20.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C1A20F6D
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Sep 2022 20:01:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1751624|-1;BR=01201311R811S76rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0534447-0.00105865-0.945497;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.PDTQEQQ_1662951698;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PDTQEQQ_1662951698)
          by smtp.aliyun-inc.com;
          Mon, 12 Sep 2022 11:01:38 +0800
Date:   Mon, 12 Sep 2022 11:01:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: how to disable block-group-tree feature?
Message-Id: <20220912110144.A85A.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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

Is there any way to disable block-group-tree since it is a runtime
feature?

I tried to 'mount -o clear_cache,space_cache=v2'
to disable both block-group-tree and fres-space-tree,
it failed with the flowing dmesg output.

[ 1400.647031] BTRFS error (device sda1): block-group-tree feature requires fres-space-tree and no-holes
[ 1400.656251] BTRFS error (device sda1): super block corruption detected before writing it to disk
[ 1400.665044] BTRFS: error (device sda1) in write_all_supers:4305: errno=-117 Filesystem corrupted (unexpected superblock corruption detected)
[ 1400.677643] BTRFS warning (device sda1: state E): Skipping commit of aborted transaction.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/09/12


