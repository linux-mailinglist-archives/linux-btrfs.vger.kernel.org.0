Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1030F269
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 12:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbhBDLhN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 06:37:13 -0500
Received: from out20-13.mail.aliyun.com ([115.124.20.13]:55683 "EHLO
        out20-13.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhBDLfQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 06:35:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08887933|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0213021-0.000905917-0.977792;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JV5qXJM_1612438469;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JV5qXJM_1612438469)
          by smtp.aliyun-inc.com(10.147.41.138);
          Thu, 04 Feb 2021 19:34:29 +0800
Date:   Thu, 04 Feb 2021 19:34:32 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 6/6] btrfs: do not block inode logging for so long during transaction commit
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
In-Reply-To: <cc5841f1-d74c-e211-742b-b9bd2b4bb7af@suse.com>
References: <20210204111706.0AD1.409509F4@e16-tech.com> <cc5841f1-d74c-e211-742b-b9bd2b4bb7af@suse.com>
Message-Id: <20210204193431.68E5.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> On 4.02.21 §Ô. 5:17 §é., Wang Yugui wrote:
> > Hi,
> > 
> > I tried to run btrfs misc-next(5.11-rc6 +81patches) based on linux LTS
> > 5.10.12 with the same other kernel components and the same kernel config.
> > 
> > Better dbench(sync open) result on both Throughput and max_latency.
> > 
> 
> If i understand correctly you rebased current misc-next to 5.10.12, if
> so this means there is something else in the main kernel, that's not
> btrfs related which degrades performance, it seems you've got a 300ms
> win by running on 5.10 as compared on 5.11-rc6-based misc next, is that
> right?

Yes.

maybye some code rather than btrfs in main kernel 5.11.rc6 have degrades
performance.
or maybe just because of different kernel config.
kernel config I used:
https://kojipkgs.fedoraproject.org/packages/kernel/5.11.0/0.rc6.141.eln108/
https://kojipkgs.fedoraproject.org/packages/kernel/5.10.12/200.fc33/

I rebased current misc-next to 5.10.12, so that there is only diff in
btrfs source code.

only 3 minor patch needed for this rebase, there seems no broken kernel API
 change for btrfs between 5.10 and 5.11.
# add-to-5.10  0001-block-add-a-bdev_kobj-helper.patch
# drop-from-btrs-misc-next  0001-block-remove-i_bdev.patch
# fix-to-btrfs-misc-next  	0001-btrfs-bdev_nr_sectors.patch

more patch come into misc-next today, they are yet not rebased/tested.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/02/04

