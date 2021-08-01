Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7068D3DCBB6
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Aug 2021 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhHAMxq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 08:53:46 -0400
Received: from out20-110.mail.aliyun.com ([115.124.20.110]:56935 "EHLO
        out20-110.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHAMxq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 08:53:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07937175|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0220319-0.00110911-0.976859;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KtqKEhT_1627822416;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KtqKEhT_1627822416)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 01 Aug 2021 20:53:36 +0800
Date:   Sun, 1 Aug 2021 20:53:36 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/204: fail if the mkfs fails
Message-ID: <YQaZUK880CRVf6Sn@desktop>
References: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
 <YQaWmtw5/OoXm26Z@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQaWmtw5/OoXm26Z@desktop>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 01, 2021 at 08:42:02PM +0800, Eryu Guan wrote:
> On Thu, Jul 29, 2021 at 04:35:53PM -0400, Josef Bacik wrote:
> > My nightly fstests runs on my Raspberry Pi got stuck trying to run
> > generic/204.  This boiled down to mkfs failing to make the scratch
> > device that small with the subpage blocksize support, and thus trying to
> > fill a 1tib drive with tiny files.  On one hand I'd like to make
> 
> So the underlying disk is 1TB in size, and we ended up using this 1T
> filesystem when _scratch_mkfs_sized failed?
> 
> But we have done _try_wipe_scratch_devs before each test to make sure we
> don't use previous scratch dev accidently (just like this case), and the
> subsesquent _scratch_mount will fail and fail the whole test. So it's
> not clear to me what caused the failure you hit.

Ah, if the previous test _notrun'd, then the scratch dev didn't get
wiped. I think patch "check: don't leave the scratch filesystem mounted
after _notrun" from Darrick should fix the bug for you. Would you please
confirm?

Thanks,
Eryu
