Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7A539B19
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 04:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349099AbiFACG7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 22:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiFACG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 22:06:56 -0400
Received: from out20-182.mail.aliyun.com (out20-182.mail.aliyun.com [115.124.20.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F76A1B7
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 19:06:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4824699|-1;BR=01201311R101S35rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.274699-0.0562642-0.669037;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.NwriLCc_1654049203;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.NwriLCc_1654049203)
          by smtp.aliyun-inc.com(33.37.73.205);
          Wed, 01 Jun 2022 10:06:44 +0800
Date:   Wed, 01 Jun 2022 10:06:45 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
Message-Id: <20220601100645.6500.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> This is the draft version of the on-disk format for RAID56J journal.
> 
> The overall idea is, we have the following elements:
> 
> 1) A fixed header
>    Recording things like if the journal is clean or dirty, and how many
>    entries it has.
> 
> 2) One or at most 127 entries
>    Each entry will point to a range of data in the per-device reserved
>    range.

Can we put this journal in a device just like ' mke2fs -O journal_dev' 
or 'mkfs.xfs -l logdev'?

A fast & small journal device may help the performance.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/01

