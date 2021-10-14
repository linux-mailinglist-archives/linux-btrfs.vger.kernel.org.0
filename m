Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A987142D00E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhJNBvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 21:51:51 -0400
Received: from out20-26.mail.aliyun.com ([115.124.20.26]:58936 "EHLO
        out20-26.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJNBvu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 21:51:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.15405|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00470651-0.00011001-0.995183;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.LZ1ni-S_1634176184;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LZ1ni-S_1634176184)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 14 Oct 2021 09:49:45 +0800
Date:   Thu, 14 Oct 2021 09:49:48 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Omar Sandoval <osandov@osandov.com>
Subject: Re: [RFC PATCH] btrfs: fix deadlock when defragging transparent huge pages
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <YWcVUpqe1i+Zibgd@relinquished.localdomain>
References: <20211013114106.74EC.409509F4@e16-tech.com> <YWcVUpqe1i+Zibgd@relinquished.localdomain>
Message-Id: <20211014094947.F197.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Wed, Oct 13, 2021 at 11:41:06AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > I failed to use this reproducer to reproduce this problem.
> > 
> > kernel: 5.15.0-0.rc5
> > kernel config: CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> > mount option: rw,relatime,ssd,space_cache=v2,subvolid=5,subvol=/
> > btrfs souce: 5.15.0-0.rc5, misc-next
> 
> You also need CONFIG_READ_ONLY_THP_FOR_FS=y.

Thanks a lot.

This reproducer works well with CONFIG_READ_ONLY_THP_FOR_FS=y.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/14


