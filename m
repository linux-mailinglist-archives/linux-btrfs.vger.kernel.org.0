Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3024858B8E0
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Aug 2022 03:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiHGBUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiHGBUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 21:20:00 -0400
Received: from out20-158.mail.aliyun.com (out20-158.mail.aliyun.com [115.124.20.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C6BF6A
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 18:19:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1570292|-1;BR=01201311R161S64rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.110111-0.00392793-0.885961;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.Onl6Dhs_1659835194;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Onl6Dhs_1659835194)
          by smtp.aliyun-inc.com;
          Sun, 07 Aug 2022 09:19:55 +0800
Date:   Sun, 07 Aug 2022 09:19:58 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: the 1st data chunk(8M) allocated by mkfs.btrfs can not be allocated again after full balance?
Message-Id: <20220807091957.17D7.409509F4@e16-tech.com>
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

The 1st data chunk allocated by mkfs.btrfs is 8M. After full balance,
this 8M chunk is freed, and new allocated chunk size
is changed to 1G.

Then this 8M space can't be allocated again?
Or we should allocate 1G for 1st data chunk in mkfs.btrfs?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/07

