Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE8059326E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Aug 2022 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiHOPtX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Aug 2022 11:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHOPtV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Aug 2022 11:49:21 -0400
Received: from out20-193.mail.aliyun.com (out20-193.mail.aliyun.com [115.124.20.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE65813F79
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 08:49:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1288328|-1;BR=01201311R741S27rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.110228-0.000202809-0.88957;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Ou.rOgS_1660578553;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ou.rOgS_1660578553)
          by smtp.aliyun-inc.com;
          Mon, 15 Aug 2022 23:49:13 +0800
Date:   Mon, 15 Aug 2022 23:49:14 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org, shr@fb.com
Subject: Re: regression of f6fca3917b4d (btrfs: store chunk size in space-info struct)
In-Reply-To: <20220815234541.C3F1.409509F4@e16-tech.com>
References: <20220815234541.C3F1.409509F4@e16-tech.com>
Message-Id: <20220815234914.ACE9.409509F4@e16-tech.com>
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

Sorry, a fix.

> In f6fca3917b4d (btrfs: store chunk size in space-info struct),
> chunk size/stripe size of RAID56/RAID0/RAID10 is regressed.
> 
>             chunk/stripe(orig)  chunk/stripe(now)
> RAID6/10disk    10G/1G          1G/0.1G
> RAID1/2disk     2G/1G           1G/0.5G

It should be 
RAID0/2disk     2G/1G           1G/0.5G

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/15


