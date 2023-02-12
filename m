Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F27693775
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Feb 2023 13:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBLMvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Feb 2023 07:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLMvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Feb 2023 07:51:01 -0500
Received: from out28-79.mail.aliyun.com (out28-79.mail.aliyun.com [115.124.28.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EADD4EC6
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 04:50:57 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3747594|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.190267-0.000773072-0.808959;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.RJnIBBe_1676206253;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.RJnIBBe_1676206253)
          by smtp.aliyun-inc.com;
          Sun, 12 Feb 2023 20:50:54 +0800
Date:   Sun, 12 Feb 2023 20:50:55 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs read_ahead_kb 4096 is too big? or any tuning/design guide
Message-Id: <20230212205054.8863.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

btrfs read_ahead_kb 4096 is too big?
or is there any tuning/design guide?

As a compare,
read_ahead_kb of block device is 128
read_ahead_kb of xfs filesystem is 128

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/02/12


