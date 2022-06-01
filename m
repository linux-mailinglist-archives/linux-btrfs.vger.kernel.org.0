Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB0539B45
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 04:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiFACZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiFACZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 22:25:35 -0400
Received: from out20-26.mail.aliyun.com (out20-26.mail.aliyun.com [115.124.20.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DC0814BA
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 19:25:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4100785|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.423523-0.201013-0.375464;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Nwu6xmY_1654050331;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Nwu6xmY_1654050331)
          by smtp.aliyun-inc.com(11.95.168.178);
          Wed, 01 Jun 2022 10:25:31 +0800
Date:   Wed, 01 Jun 2022 10:25:33 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <1bcadb40-e478-1c56-27fc-ca87e7fae715@suse.com>
References: <20220601100645.6500.409509F4@e16-tech.com> <1bcadb40-e478-1c56-27fc-ca87e7fae715@suse.com>
Message-Id: <20220601102532.D262.409509F4@e16-tech.com>
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

> On 2022/6/1 10:06, Wang Yugui wrote:
> > Hi,
> >
> >> This is the draft version of the on-disk format for RAID56J journal.
> >>
> >> The overall idea is, we have the following elements:
> >>
> >> 1) A fixed header
> >>     Recording things like if the journal is clean or dirty, and how many
> >>     entries it has.
> >>
> >> 2) One or at most 127 entries
> >>     Each entry will point to a range of data in the per-device reserved
> >>     range.
> >
> > Can we put this journal in a device just like 'mke2fs -O journal_dev'
> > or 'mkfs.xfs -l logdev'?
> >
> > A fast & small journal device may help the performance.
> 
> Then that lacks the ability to lose one device.
> 
> The journal device must be there no matter what.
> 
> Furthermore, this will still need a on-disk format change for a special type of device.

If we save journal on every RAID56 HDD, it will always be very slow, 
because journal data is in a different place than normal data, so HDD
seek is always happen?

If we save journal on a device just like 'mke2fs -O journal_dev' or 'mkfs.xfs
-l logdev', then this device just works like NVDIMM?  We may not need
RAID56/RAID1 for journal data.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/06/01


