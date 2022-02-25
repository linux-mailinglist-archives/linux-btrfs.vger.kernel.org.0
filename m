Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115384C4F71
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Feb 2022 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiBYUTH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Feb 2022 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiBYUTG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Feb 2022 15:19:06 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD3D793A0
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Feb 2022 12:18:31 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B408F5C0245;
        Fri, 25 Feb 2022 15:18:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 25 Feb 2022 15:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=/x7zzoR6sF6YsptuZHxC2Wholko6d3k1iROmvW
        2SReI=; b=jOg0cf4jnYM1vBfCROvQdSM1M7Opb997eFRzhEdgBPemfjBvv0RQAM
        i/W7TyIZFDZ4kz/KYsNMd5h9fGBGzEduPxTc2eAP7BbywCZpZ9JtX62AUxLuGNUF
        AJCcUlj+Ho7Sns1hmliWZQa49BOSayVoBE8H2yi1Q6EYj/PEXTwiZxHn7Thzizoi
        VYrDDscdSWSk6bbfyVMDOVQL2Vd54juBVAb7rfMm4yCWdNSBUUt70VEQQuMM0cwQ
        Mhn+GEOYcZIKQpCt7M55nclE2SGflUd0jqQzCHIN0azGS9RkAeztldWO7I2zj7TB
        2VmC+25dG1DgpcEdUauzlpZGaI27+M+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/x7zzoR6sF6YsptuZ
        HxC2Wholko6d3k1iROmvW2SReI=; b=iKZIpzUoqq1nscFygsVfjjA55HW52F5iS
        nsLePLkAmCJm8RiM1p/NXBuLqY5mKgq1Q+grNcU6/uTd2baXDymvq/SlYvzBH7x9
        8WJDV9lDAp64hzkfkdI98PUjroExwCqaazckVrooaOY0BIEfVSNZvcnLuo1v3Oud
        QhjFl90rBozNZTesIYnh81R7YTt7aJ8OUrCHws+35Pgo5BTBV3JRJhpS1wQun+2J
        DzsM5e2IEZsat++CAom4LJPdSdkZCrj9xT8ACqFNCZr5ff7F43rZZI/hH07bUNwW
        fpcKXXeeV9kGms5oBysq/9NEqM4Wd5NpxDHEIFFNbEIulzpRdVNPA==
X-ME-Sender: <xms:lTkZYqFIkcZdJ8aPdQtxIxkMABZbK-uIVixZDRvBrAY6pSENCEDkuQ>
    <xme:lTkZYrWufu2U6sSmRS3BfhhJQScZ-KJoIk2ZE5FtCa0Moj8988Xtt0Oa5WD6QFQLO
    KLZ-4yQUWJcz8r06ZE>
X-ME-Received: <xmr:lTkZYkJZI-werED02RfnH8f8TAX2pbJRW0_fQqIjGHhofWYoKns6AUQOFiCA_Q_HlUxwcMovc_D0vh5zbe10lRbr9OLtCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleeggddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    duveelkeeiteelveeiuefhudehtdeigfehkeeffeegledvueevgefgudeuveefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:lTkZYkG5-Rangm-X6HiSnPbkJh2CBYfR_e_sYz0TVvhLMaFYDLMb7g>
    <xmx:lTkZYgUL9IZadj6bU_RZLMj3pVKl0AcdBbIDazRo-RkRjAyQcqRPbA>
    <xmx:lTkZYnPLUbeWRsQgqerC-CcrOtH4lEe2kwXx04XJNcSiq5P_4nSyGQ>
    <xmx:ljkZYiIY1oE_yUkG7nmDIIlojlj9dSmjhidIr-81ZO6k3muMdResyQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Feb 2022 15:18:28 -0500 (EST)
Date:   Fri, 25 Feb 2022 12:18:27 -0800
From:   Boris Burkov <boris@bur.io>
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "kreijack@inwind.it" <kreijack@inwind.it>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <Yhk5kyZL1J8hoQvX@zen>
References: <cover.1643228177.git.kreijack@inwind.it>
 <7e5e75ed-86b4-a629-09c9-29202f93b4b6@inwind.it>
 <c43c5945-3c3a-0dee-a998-9e76c3eb0289@gmx.com>
 <YgxvUC86zumH3OF1@hungrycats.org>
 <SYXPR01MB191845786070C7B5E9A67F8D9E359@SYXPR01MB1918.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYXPR01MB191845786070C7B5E9A67F8D9E359@SYXPR01MB1918.ausprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 16, 2022 at 04:43:43AM +0000, Paul Jones wrote:
> > -----Original Message-----
> > From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> > Sent: Wednesday, 16 February 2022 2:28 PM
> > To: Qu Wenruo <quwenruo.btrfs@gmx.com>
> > Cc: kreijack@inwind.it; Josef Bacik <josef@toxicpanda.com>; David Sterba
> > <dsterba@suse.cz>; Sinnamohideen Shafeeq <shafeeqs@panasas.com>;
> > Paul Jones <paul@pauljones.id.au>; Boris Burkov <boris@bur.io>; linux-
> > btrfs@vger.kernel.org
> > Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
> > 
> > On Wed, Feb 16, 2022 at 08:22:55AM +0800, Qu Wenruo wrote:
> > >
> > >
> > > On 2022/2/16 02:49, Goffredo Baroncelli wrote:
> > > > Hi Josef,
> > > >
> > > > gentle ping...
> > > >
> > > > few months ago you showed some interest in this patches set. Few of
> > > > the cc-ed person use this patch set.
> > > >
> > > > I know that David showed some interest in the Anand approach (i.e.
> > > > no knobs, but an automatic behavior looking at the speed of the devices).
> > > >
> > > > At the time when I tried this approach in the first attempts, I got
> > > > the complain that the kernel may not know the performance
> > > > differences of the disk (HDD vs SSD vs NVME vs ZONED disk...).
> > >
> > > Sorry I didn't check the patches in details.
> > >
> > > But I'm a little concerned about how to accurately determine the
> > > performance of a device.
> > >
> > > If doing it automatically, there must be some (commonly very short)
> > > time spent to do the test.
> > >
> > > In the very short time, I doubt we can even accurately got a full
> > > picture of a device (from sequential read/write speed to IOPS values)
> > >
> > > For spinning disks, the sequential read/write speed even change based
> > > on their LBA address (as their physical location inside the plate can
> > > change their linear velocity, since the angular velocity is fixed).
> > >
> > > And even for SSD, IOPS can var dramatically due to cache/controller
> > > difference.
> > >
> > >
> > > For a proper performance aware setup, I guess the only correct way to
> > > fetch performance characteristics is from the (advanced) user.
> > >
> > > Or we may need to spent at least tens of minutes to do proper tests to
> > > get the result.
> > >
> > > For regular end users, the difference between SSD and HDD is huge
> > > enough and simply preferring SSD for metadata is good enough.
> > >
> > > But for more complex setup, like btrfs over LUKS over LVM (even
> > > crosses several physical devices), I doubt if it's even possible to
> > > fetch the correct performance characteristics automatically.
> > 
> > I agree with all of the above.
> > 
> > An automatic performance detection/configuration daemon can easily set
> > the metadata/data preference bits during mkfs, or monitor the system's
> > iostats and change preferences over time if this is really useful and desired.
> > It doesn't have to run in the kernel.
> 
> At the moment it's all manual anyway so a bit of a moot point until something is merged.
> I've been using this patchset since the beginning and imho it's killer feature is being able to split data and metadata onto different speed devices. It massively speeds up large filesystems that are metadata heavy.
> 
> Paul.

I've also been using it for about a month and it has been great for
manually splitting metadata and data to separate devices for testing
some of the work I've been doing. Works as advertised on the tin, as far
as I'm concerned, and feels like a good addition.

Boris
