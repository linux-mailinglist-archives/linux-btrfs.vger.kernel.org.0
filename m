Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98DB36FDFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 17:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhD3PoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 11:44:13 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:60033 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhD3PoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 11:44:12 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2869392|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0256064-0.00301873-0.971375;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.K6lRZUR_1619797397;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.K6lRZUR_1619797397)
          by smtp.aliyun-inc.com(10.147.42.16);
          Fri, 30 Apr 2021 23:43:17 +0800
Date:   Fri, 30 Apr 2021 23:43:21 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/7] Preemptive flushing improvements
In-Reply-To: <20210430152847.GE7604@twin.jikos.cz>
References: <20210430062307.0CEE.409509F4@e16-tech.com> <20210430152847.GE7604@twin.jikos.cz>
Message-Id: <20210430234320.7492.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On Fri, Apr 30, 2021 at 06:23:08AM +0800, Wang Yugui wrote:
> > > > > This is the file 562.out.bad.
> 
> Can you please post again the error?

This is the head part of the file of 562.out.bad(whole file is 2.55M).

QA output created by 562
XFS_IOC_CLONE: No space left on device
File foo data after cloning and remount:
0000000 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7 c7
*
25509888 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
25513984 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5
*
25518080 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
25522176 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5 e5
<repeat of 00 00.../e5 e5...>

> > By the way, We enable '-O no-holes -R free-space-tree' default for
> > mkfs.btrfs.
> 
> The fstests cases are not robust enough to catch differences in the
> output when various features are enabled so it depends on the exact
> error.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/30


