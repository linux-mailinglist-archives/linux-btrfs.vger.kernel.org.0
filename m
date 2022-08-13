Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133EC5917B4
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 02:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbiHMAAr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 12 Aug 2022 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMAAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 20:00:46 -0400
Received: from out20-147.mail.aliyun.com (out20-147.mail.aliyun.com [115.124.20.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96C2873E
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 17:00:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08054753|-1;BR=01201311R181S42rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.21181-0.00111126-0.787079;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OsHdeth_1660348840;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OsHdeth_1660348840)
          by smtp.aliyun-inc.com;
          Sat, 13 Aug 2022 08:00:40 +0800
Date:   Sat, 13 Aug 2022 08:00:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org, bvanassche@acm.org
Subject: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Message-Id: <20220813080046.ACB1.409509F4@e16-tech.com>
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

Hi, Bart Van Assche

A sparse(make C=1) warning in btrfs about the 'blk_opf_t'

./include/trace/events/btrfs.h:2327:1: warning: incorrect type in assignment (different base types)
./include/trace/events/btrfs.h:2327:1:    expected unsigned char [usertype] opf
./include/trace/events/btrfs.h:2327:1:    got restricted blk_opf_t enum req_op

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/13


