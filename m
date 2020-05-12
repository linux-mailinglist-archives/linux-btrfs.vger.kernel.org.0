Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047351CFA7F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgELQWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 12:22:45 -0400
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:45734 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELQWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 12:22:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09756994|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.120746-0.00217786-0.877076;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=guan@eryu.me;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.HXUvbOt_1589300561;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HXUvbOt_1589300561)
          by smtp.aliyun-inc.com(10.147.42.22);
          Wed, 13 May 2020 00:22:41 +0800
Date:   Wed, 13 May 2020 00:22:41 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH fstests] btrfs/14{2,3}: use dm-dust instead of
 fail_make_request
Message-ID: <20200512162241.GC9345@desktop>
References: <d992390752c612acd0893ee3db929e77affded2b.1586983958.git.osandov@fb.com>
 <47d3f830-bd55-c4f1-78d5-7648bc0cd44c@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47d3f830-bd55-c4f1-78d5-7648bc0cd44c@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 12, 2020 at 09:15:50AM +0300, Nikolay Borisov wrote:
> 
> 
> On 15.04.20 г. 23:54 ч., Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > These two tests test direct I/O and buffered read repair, respectively,
> > with fail_make_request. However, by using "fail_make_request/times",
> > they rely on repair having a specific I/O pattern. My pending Btrfs
> > direct I/O refactoring patch series changes this I/O pattern and thus
> > breaks this test.
> > 
> > The dm-dust target (added in v5.2) emulates a device with bad blocks
> > that are fixed when written to (like a device that remaps bad blocks).
> > This is exactly what we want for testing repair. Add some common dm-dust
> > helpers and update the tests to use dm-dust.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> Eryu, are you going to merge this patch ?

The dmdust part seems fine to me, could you or other btrfs folks help
review the btrfs change? That'd be appreciated!

Thanks,
Eryu
