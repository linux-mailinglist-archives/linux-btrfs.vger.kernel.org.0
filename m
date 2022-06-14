Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6014B54B4B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 17:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiFNPbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 11:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiFNPa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 11:30:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48E38D84
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 08:30:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C62B73200805;
        Tue, 14 Jun 2022 11:30:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 Jun 2022 11:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1655220655; x=1655307055; bh=XxPoXUSyxy
        YCHFWMu3HzPJ578GKZVNiQ5AXlqh/7Pvk=; b=s1IP4PpXTDTx32xhGl8vKCoGGE
        p3kWtOHgJid7W6E0rIFTF7ibxINsd15GcXZs3FKCsjF5C/Ucc3vFNF6FTMPiwmmO
        N0KQVIb/2HzZa5DiRI3SEhHmqPOpmRGTqqEIgQDtZMXU9yY+Rji2TsQ4yoGSUSPR
        Vq6g9KFs2N0+d1sT4J/y3TUck3iGN+M+hfiMGHssWvb3GatFDV2p4wjM7VP2UP8S
        mGCHd1+U3swcLXgOzebmbl0gJA43Ie4Zcz8DkyYB5kXfFxswJC8u+BdQZYRl/k84
        8eSAgfn1MSaOdKckt7WVW5Y6AMxaQJ4p/lwY1gdBE2MYDocieNKYENy7YyxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655220655; x=1655307055; bh=XxPoXUSyxyYCHFWMu3HzPJ578GKZ
        VNiQ5AXlqh/7Pvk=; b=OaXsYS78G1WR/tcl89plo+l7XUawYj9t1+gslbEuUJ5e
        bF1RFOk6yYFPt4QubgPy/b72oxr+ASg6YQTXCU8MWpYuTubQ1BtnxkI+JsHV7m4h
        xB4LJm6tSIkKh0N303Ztsm/oYzpYihWXhfTJmVC8FwkG1hcoSLXeGk6tlS5jyadS
        7I0YIZ8+7Vm0KOGyMM1bYzU5rhQctZr2san1j4+1monmIncVH3enfDAmi90xkGnP
        fKnkf2tLiHqOC4ZYay5gd42Jy7XXHh00G6BsxYZqkdpGeA8zcbqC8Ozp6zgqBRhv
        GNCpJE1T0faxknnVS5y9t1DQNDuEW8PbGhMNq16W8Q==
X-ME-Sender: <xms:rqmoYoE05GCow_m8kllwvyuZ-RaSsjgSwn9wcR-QFo2ZZ6wLTPYABQ>
    <xme:rqmoYhVdONWEfrPqaI83pAU4ZoKBiE5CLYVgmbC5oQxeY3KveCln3G2nfC-lb23iP
    mfyZtKIKb2Gi6BNJbk>
X-ME-Received: <xmr:rqmoYiLYXGlD0kwGnCOQkyOf94cHiaSNjj-oe1D_Rgt1cYBRqvMa_TAx0DWS5AHFKU-AY-By0gaC7D63jGAVw8s9jWQqwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudduledgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:r6moYqH-8UY93vQcdUhk2VsojReqaAh69CUOw5pmBClQeN1IsYi6JA>
    <xmx:r6moYuXUfTZx6I6p1FwOeECHO64tj4h80NdIWoPE4ymL_CPJbs0w8A>
    <xmx:r6moYtP_25qje4tpK9iJP6NxxKE7iSv_WYu_qPNlTSbyxaEbXQYgqg>
    <xmx:r6moYhfd81nh_sY3ORt6v79inDXDm_pgwuCWjbyoRjYAIhfVvuaxFQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jun 2022 11:30:54 -0400 (EDT)
Date:   Tue, 14 Jun 2022 08:30:53 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: warn about dev extents that are inside the
 reserved range
Message-ID: <Yqiprewvw0q6OYza@zen>
References: <cover.1655103954.git.wqu@suse.com>
 <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
 <YqeKZuET4MDe0D5w@zen>
 <7d764668-cb95-f410-4846-9a1a98e3b861@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d764668-cb95-f410-4846-9a1a98e3b861@gmx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 14, 2022 at 03:48:06PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/6/14 03:05, Boris Burkov wrote:
> > On Mon, Jun 13, 2022 at 03:06:35PM +0800, Qu Wenruo wrote:
> > > Btrfs has reserved the first 1MiB for the primary super block (at 64KiB
> > > offset) and legacy programs like older bootloaders.
> > > 
> > > This behavior is only introduced since v4.1 btrfs-progs release,
> > > although kernel can ensure we never touch the reserved range of super
> > > blocks, it's better to inform the end users, and a balance will resolve
> > > the problem.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   fs/btrfs/volumes.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 051d124679d1..b39f4030d2ba 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -7989,6 +7989,16 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
> > >   		goto out;
> > >   	}
> > > 
> > > +	/*
> > > +	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
> > > +	 * space. Although kernel can handle it without problem, better to
> > > +	 * warn the users.
> > > +	 */
> > > +	if (physical_offset < BTRFS_DEFAULT_RESERVED)
> > > +		btrfs_warn(fs_info,
> > > +"devid %llu physical %llu len %llu is inside the reserved space, balance is needed to solve this problem.",
> > 
> > If I saw this warning, I wouldn't know what balance to run, and it's
> > not obvious what to search for online either (if it's even documented).
> > I think a more explicit instruction like "btrfs balance start XXXX"
> > would be helpful.
> 
> Firstly, the balance command needs extra filters, thus the command can
> be pretty long, like:
> 
> # btrfs balance start -mdrange=0..1048576 -ddrange=0..1048576
> -srange0..1048576 <mnt>
> 
> I'm not sure if this is a good idea to put all these into the already
> long message.
> 
> > 
> > If it's something we're ok with in general, then maybe a URL for a wiki
> > page that explains the issue and the workaround would be the most
> > useful.
> 
> URL can be helpful but not always. Imagine a poor sysadmin in a noisy
> server room, seeing a URL in dmesg, and has to type the full URL into
> their phone, if the server has very limited network access.

I don't see how the poor sysadmin would be any better off with "you need
to do a balance" vs "you need to do a balance: <URL>" or "you need to do
a balance using mdrange and ddrange to move the affected extents" etc..

My high level point is that you clearly have something in mind that the
person needs to do in the unlikely event they hit this, but I have no
idea how they are supposed to figure it out. Send a mail to our mailing
list and hope you notice it?

> 
> In fact, this error message for now will be super rare already.
> 
> The main usage of this message is for the incoming feature, which will
> allow btrfs to reserve extra space for its internal usage.
> 
> In that case, we will allow btrfstune to set the reservation (even it's
> already used by some dev extent), and btrfstune would give a commandline
> how to do the balance.
> 
> I guess I'd put all these preparation patches into the incoming on-disk
> format change patchset to make it clear.
> 
> Thanks,
> Qu
> 
> > 
> > > +			   devid, physical_offset, physical_len);
> > > +
> > >   	for (i = 0; i < map->num_stripes; i++) {
> > >   		if (map->stripes[i].dev->devid == devid &&
> > >   		    map->stripes[i].physical == physical_offset) {
> > > --
> > > 2.36.1
> > > 
