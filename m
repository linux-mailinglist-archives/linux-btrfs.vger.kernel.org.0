Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D67338628
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 07:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhCLGoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 01:44:05 -0500
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:38633 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhCLGnp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 01:43:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07455471|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0509842-0.000238033-0.948778;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JjuYN1N_1615531421;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JjuYN1N_1615531421)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 12 Mar 2021 14:43:41 +0800
Date:   Fri, 12 Mar 2021 14:43:41 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: add test for cases when a dio write has to
 fallback to a buffered write
Message-ID: <YEsNnaCvFPWdbdjm@desktop>
References: <20210211170118.12551-1-fdmanana@kernel.org>
 <YETkzeWJTB2C88ON@desktop>
 <CAL3q7H7=M-OZqF9rbHKZKSdSOjic+=4X70aVeOPpLxGV9nKWZQ@mail.gmail.com>
 <YETvBOahTAtKvr7U@desktop>
 <CAL3q7H5WrDkHwQBYGP-1XYY=9r1Vk0MD8HDsGsQJ9tZOxOY5aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5WrDkHwQBYGP-1XYY=9r1Vk0MD8HDsGsQJ9tZOxOY5aw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 10:48:35AM +0000, Filipe Manana wrote:
> On Sun, Mar 7, 2021 at 3:24 PM Eryu Guan <guan@eryu.me> wrote:
> >
> > On Sun, Mar 07, 2021 at 03:07:43PM +0000, Filipe Manana wrote:
> > > On Sun, Mar 7, 2021 at 2:41 PM Eryu Guan <guan@eryu.me> wrote:
> > > >
> > > > On Thu, Feb 11, 2021 at 05:01:18PM +0000, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > >
> > > > > Test cases where a direct IO write, with O_DSYNC, can not be done and has
> > > > > to fallback to a buffered write.
> > > > >
> > > > > This is motivated by a regression that was introduced in kernel 5.10 by
> > > > > commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")) and was
> > > > > fixed in kernel 5.11 by commit ecfdc08b8cc65d ("btrfs: remove dio iomap
> > > > > DSYNC workaround").
> > > > >
> > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Sorry for the late review..
> > > >
> > > > So this is supposed to fail with v5.10 kernel, right? But I got it
> > > > passed
> > >
> > > Because either you are testing with a patched 5.10.x kernel, or you
> > > don't have CONFIG_BTRFS_ASSERT=y in your config.
> > > The fix landed in 5.10.18:
> >
> > You're right, I don't have CONFIG_BTRFS_ASSERT=y. As the test dumps the
> > od output of the file content, so I thought the failure would be a data
> > corruption, and expected a od output diff failure.
> 
> I see the test was not merged yet, do you expect me to update anything
> in the patch?

Sorry, it was lost in my to-review queue.. But I'd be great if you could
add more descriptions about the CONFIG_BTRFS_ASSERT and the compress
case either in commit log or in test description.

Thanks,
Eryu
