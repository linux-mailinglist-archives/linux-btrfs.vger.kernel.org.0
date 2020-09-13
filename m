Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0BE268051
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Sep 2020 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgIMQtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 12:49:15 -0400
Received: from out20-49.mail.aliyun.com ([115.124.20.49]:47496 "EHLO
        out20-49.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMQtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 12:49:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07913635|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.140231-0.00824471-0.851524;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IWajrog_1600015746;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IWajrog_1600015746)
          by smtp.aliyun-inc.com(10.147.43.230);
          Mon, 14 Sep 2020 00:49:06 +0800
Date:   Mon, 14 Sep 2020 00:49:06 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Boris Burkov <boris@bur.io>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add test for free space tree remounts
Message-ID: <20200913164906.GL3853@desktop>
References: <61d279c1-1e2d-a59d-c14b-339ea859549b@suse.com>
 <d63835858b32cf692993766caa3650eec83d8b32.1599178894.git.boris@bur.io>
 <76d905d1-5686-932f-8745-fd76d2f6019e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d905d1-5686-932f-8745-fd76d2f6019e@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 04, 2020 at 10:51:36AM +0300, Nikolay Borisov wrote:
> 
> 
> On 4.09.20 г. 3:25 ч., Boris Burkov wrote:
> > btrfs/131 covers a solid variety of free space tree scenarios, but it
> > does not cover remount scenarios. We are adding remount support for read
> > only btrfs filesystems to move to the free space tree, so add a few test
> > cases covering that workflow as well. Refactor out some common free
> > space tree code from btrfs/131 into common/btrfs.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Generally LGTM, but I wonder if it would be beneficial to refer the
> series which is supposed to make this test pass. If you look at other
> patches in xfstest that's done in the header of the test i.e "This test
> freespace remount behavior introduced by xxxx" and you refer to the name
> of the patches (or alternatively the commit id if the patch has landed
> upstream).

Yes, mentioning the commit id or patch subject in either commit log or
test description that makes the test pass is preferred.

> 
> In any case:
> 
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks for the review!

Eryu
