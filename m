Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1BC68DEE7
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Feb 2023 18:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjBGR3x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Feb 2023 12:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjBGR3w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Feb 2023 12:29:52 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF17EC2
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Feb 2023 09:29:50 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8A5365C020A;
        Tue,  7 Feb 2023 12:29:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Feb 2023 12:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675790987; x=1675877387; bh=uxyFSm8+Cj
        zTm2BGmryf1a/Nh1mDdUpMZauduD0RpQ0=; b=HLBhivqAkXHr7SveuvXgkHj22R
        mYScOTzFqDqq5UjTM+/5AW8P3Yd5ZOQQry1yGunqbg2kQnKanvt/pXZHBxfUBbPM
        rsqVli/DuayVlu2jUH1cPYSJD/BsHwJ44PAjnYCV+SlS4Nvf72ZfJjt8i7vQ0Plt
        sdIuHMmve+YjIyEhDx4v8zqdbw+v2udeDcssG3l0FiNNsxdAKA+K8BUmkcGqXZBa
        dW4PHZlMTkE07otTn9GkhD0Yh/iQRgRkHTQDwzbuO3hA6HgFRLnrnpn74z+Bokef
        aqY7A7lgINpzh89MpC/Wo7mXc4Mz9IbXuLa9TXgjOfapFWOseNGvVIVgiMEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675790987; x=1675877387; bh=uxyFSm8+CjzTm2BGmryf1a/Nh1mD
        dUpMZauduD0RpQ0=; b=QXTOrnPutHyuJ+XJycxK/E8gX4lmMNPzPhYHEiidxO+V
        9hGmRrLFp/1o1FD0j+Q2t4usVBKtvAMXJ1pCdSmcJT55IP0Ox8WDp0yJOUN9O94/
        iJsghs5ONiWuPbRq400ABY4yvIBR1WQ/skcqbWcECIJAo1aQhjn02NfT4gN9THkP
        YUI+sN9Ws34ds4wRa5Xtl2ak+Cjsv+bFVeVgLBx+SztzIIzKskNPIzWTwIl62uMr
        Iie5TagHlvsj/pIB+K+aOwKPE4sgvVC64SF4X7VAGKXQyUu6e7JImLxOlGm37YTr
        D5UBq3vUIbJxa2dKPQH5O1sWSmT2FyQMVWv6ZKMySA==
X-ME-Sender: <xms:i4riY0r1UzgLWaP0hAeqJLdQHoJICyE0Ty9qCaFdfF-CPNkwS4jsoQ>
    <xme:i4riY6oITv7_h4VhSZXIXvdaDHGaHzCAO7NMUXLjQopxhOvbKdAhCFC9bHaOoSY26
    EUBzuCfD_aAa9eeSqU>
X-ME-Received: <xmr:i4riY5PEGsMZ82rb1U-W2nrqLuvNO-Ze5FfZv_BcC9p_TPbBB9IfQLAl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:i4riY74waRXwBrEBky3eYReL0Eewqzfx9O__pZSKnHpNMSORHZOqpw>
    <xmx:i4riYz45AI-ANVAgmyru-pl4BiRhw4QX6toYRwZxKTQNsrmKx-Me3Q>
    <xmx:i4riY7ivlCCLWaCVQxJgfKeJiXfnIbZmytWkj1E-f2aNwZ6ARaYB4A>
    <xmx:i4riY9RVokD5TGgNAwlpKpuv-0zf_Nbu0HM0XpDkJwaIWCWRkoOcNA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 12:29:46 -0500 (EST)
Date:   Tue, 7 Feb 2023 09:29:45 -0800
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: add size class stats to sysfs
Message-ID: <Y+KKiTzAulpdDgc/@zen>
References: <5c4fcf99c1486e6c2c2c45f11ade73d40f153021.1674856476.git.boris@bur.io>
 <20230207155101.GH28288@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207155101.GH28288@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 07, 2023 at 04:51:01PM +0100, David Sterba wrote:
> On Fri, Jan 27, 2023 at 01:56:50PM -0800, Boris Burkov wrote:
> > Make it possible to see the distribution of size classes for block
> > groups. Helpful for testing and debugging the allocator w.r.t. to size
> > classes.
> > 
> > The new stats can be found at the path:
> > /sys/fs/btrfs/<uid>/allocation/<bg-type>/size_class
> > but they will only be non-zero for bg-type = data.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v2:
> > - add sysfs path to commit message
> > - unsigned counter types
> > - labeled stat-per-line output format
> > 
> >  fs/btrfs/sysfs.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 108aa3876186..639f3842f99d 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/spinlock.h>
> >  #include <linux/completion.h>
> >  #include <linux/bug.h>
> > +#include <linux/list.h>
> >  #include <crypto/hash.h>
> >  #include "messages.h"
> >  #include "ctree.h"
> > @@ -778,6 +779,40 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
> >  	return len;
> >  }
> >  
> > +static ssize_t btrfs_size_classes_show(struct kobject *kobj,
> > +				       struct kobj_attribute *a, char *buf)
> > +{
> > +	struct btrfs_space_info *sinfo = to_space_info(kobj);
> > +	struct btrfs_block_group *bg;
> > +	u32 none = 0;
> > +	u32 small = 0;
> > +	u32 medium = 0;
> > +	u32 large = 0;
> > +
> > +	for (int i = 0; i < BTRFS_NR_RAID_TYPES; ++i) {
> > +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> 
> Some locking is needed, you can eventually lock only iteration of one
> sinfo and not the whole for cycle. Otherwise looks good.

That sounds like a good way to go to me, as well. Thanks for the review.

> 
> > +			if (!btrfs_block_group_should_use_size_class(bg))
> > +				continue;
> > +			switch (bg->size_class) {
> > +			case BTRFS_BG_SZ_NONE:
> > +				none++;
> > +				break;
> > +			case BTRFS_BG_SZ_SMALL:
> > +				small++;
> > +				break;
> > +			case BTRFS_BG_SZ_MEDIUM:
> > +				medium++;
> > +				break;
> > +			case BTRFS_BG_SZ_LARGE:
> > +				large++;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +	return sysfs_emit(buf, "none %u\nsmall %u\nmedium %u\nlarge %u\n",
> > +			  none, small, medium, large);
> > +}
> > +
> >  #ifdef CONFIG_BTRFS_DEBUG
> >  /*
> >   * Request chunk allocation with current chunk size.
> > @@ -835,6 +870,7 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
> >  SPACE_INFO_ATTR(disk_used);
> >  SPACE_INFO_ATTR(disk_total);
> >  BTRFS_ATTR_RW(space_info, chunk_size, btrfs_chunk_size_show, btrfs_chunk_size_store);
> > +BTRFS_ATTR(space_info, size_classes, btrfs_size_classes_show);
> >  
> >  static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
> >  						     struct kobj_attribute *a,
> > @@ -887,6 +923,7 @@ static struct attribute *space_info_attrs[] = {
> >  	BTRFS_ATTR_PTR(space_info, disk_total),
> >  	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
> >  	BTRFS_ATTR_PTR(space_info, chunk_size),
> > +	BTRFS_ATTR_PTR(space_info, size_classes),
> >  #ifdef CONFIG_BTRFS_DEBUG
> >  	BTRFS_ATTR_PTR(space_info, force_chunk_alloc),
> >  #endif
> > -- 
> > 2.38.1
