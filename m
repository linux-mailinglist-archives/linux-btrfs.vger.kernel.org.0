Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95179591813
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 03:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiHMBNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 21:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiHMBNa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 21:13:30 -0400
Received: from out20-181.mail.aliyun.com (out20-181.mail.aliyun.com [115.124.20.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E749AA3E2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 18:13:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05135957|-1;BR=01201311R201S44rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00837106-0.000396767-0.991232;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OsJ92I7_1660353198;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OsJ92I7_1660353198)
          by smtp.aliyun-inc.com;
          Sat, 13 Aug 2022 09:13:18 +0800
Date:   Sat, 13 Aug 2022 09:13:24 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Bart Van Assche <bvanassche@acm.org>
Subject: Re: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <60fef86b-2174-e1a9-6d2b-2508fb809f8e@acm.org>
References: <20220813080046.ACB1.409509F4@e16-tech.com> <60fef86b-2174-e1a9-6d2b-2508fb809f8e@acm.org>
Message-Id: <20220813091324.38BB.409509F4@e16-tech.com>
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

> On 8/12/22 17:00, Wang Yugui wrote:
> > Hi, Bart Van Assche
> >
> > A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
> >
> > ./include/trace/events/btrfs.h:2327:1: warning: incorrect type in assignment (different base types)
> > ./include/trace/events/btrfs.h:2327:1:    expected unsigned char [usertype] opf
> > ./include/trace/events/btrfs.h:2327:1:    got restricted blk_opf_t enum req_op
> 
> Hi Wang,
> 
> Please help with verifying whether this patch fixes that warning: "[PATCH] tracing: Suppress sparse warnings triggered by is_signed_type()" (https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).
> 
> Thanks,
> 
> Bart.

This warning is still ON after applied this patch([PATCH] tracing: Suppress sparse warnings triggered by is_signed_type())

Mabye '(different base types)' is a key in this case.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/13

