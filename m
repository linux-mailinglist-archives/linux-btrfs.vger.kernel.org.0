Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E866076AB7D
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 10:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHAI5Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAI5X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 04:57:23 -0400
Received: from out28-65.mail.aliyun.com (out28-65.mail.aliyun.com [115.124.28.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F82108
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 01:57:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2156001|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0114828-0.000765547-0.987752;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.U5om-Ft_1690880212;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.U5om-Ft_1690880212)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 16:56:57 +0800
Date:   Tue, 01 Aug 2023 16:56:58 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20230801083556.GA24287@lst.de>
References: <20230801102253.1AF4.409509F4@e16-tech.com> <20230801083556.GA24287@lst.de>
Message-Id: <20230801165652.760D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Tue, Aug 01, 2023 at 10:22:58AM +0800, Wang Yugui wrote:
> > 'git bisect' show that this patch is the root cause of performance
> > regression.
> > 
> > e917ff56c8e7 :Christoph Hellwig: btrfs: determine synchronous writers from bio
> > or writeback control
> 
> Odd.  What CPU are you using to test?  It seems like it doesn't set
> BTRFS_FS_CSUM_IMPL_FAST as that is the only way to even hit a potential
> difference.  Or are you using a non-standard checksum type?

The CPU is E5 2680 v2.
and I used the default checksum type of mkfs.btrfs v6.1

dd(conv=fsync)(single threads) works well.
fio(multiple jobs) does NO work well.

so maybe some problem of lock?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/08/01


