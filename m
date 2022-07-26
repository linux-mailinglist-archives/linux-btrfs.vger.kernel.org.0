Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6792B581B59
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jul 2022 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239973AbiGZUwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 16:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbiGZUws (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 16:52:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285D37FAE
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jul 2022 13:52:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 647C15C00C0;
        Tue, 26 Jul 2022 16:52:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 26 Jul 2022 16:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658868766; x=1658955166; bh=hNebbEr86b
        z0VMPSTLVeWVwjlGf1wK0Odk7fG3JOdn0=; b=bG3397RWnbhCEzablba8y/p+v8
        RwT05m3FLddEygs5an8KIsc/W7flkt+QSMnXymRwTyD+gVFtrgw8ugrmE73lKYEZ
        jE1SQf9SYjoB5JG5dUH2s2ktecPEMLnoQ/6M6DfIgUUysXpk/3Ft1G+lME8CnkQK
        wvG9/qp7rzrnHY5xvRvihJtSIVXoE34Po6X31WXfZzzG4wafFAkpSLCtapSTElnh
        ROokll5vWKjvjCNt2qEJhfhB22/QSlB7SvHxQodvU9bpDTom91fstU8lsAI0DIb+
        bt81A+rcL0Kq7dcHzZ8wf6A2U5m8x1w8uoHaE3pGmXu7wsNJXFOomlZVwttQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658868766; x=1658955166; bh=hNebbEr86bz0VMPSTLVeWVwjlGf1
        wK0Odk7fG3JOdn0=; b=ioYzEynpu+LSToH/bWEudIQz4/g2q3fvXVbSbTa0oQQX
        l4AisSsFItLq/MFm0Pod46sPAOngGXUrWfsLLo29NwSe+QNFTPIIFXeYblpSZKzJ
        j/ZG9iNi9UI5i1vnubmc0qyKD9V8jN70V9EKG+fnySjAx4bTmijHfXSixCY6HXX/
        B1LmFT3VyPR4MFyNizdZbnB+vxo1HhliGWzIyLaqj/k4lTIvNav0X3fzDj3YKKMs
        TZCXQWBHw4RC1nqBZCjGm5SgJGWa/MrVC7NjlYYx6EPNHxTgsOlNb0JvIk+TYa+y
        WWpQVEIZuLxTkwiE9XsYK0AkctOlrEbFLjy6+EGfoQ==
X-ME-Sender: <xms:HVTgYswZru1SANOWzIWyIR_3VyBPMfunHhryrGUTuvgZvy3NfYB-cA>
    <xme:HVTgYgRgVJYvxD-NwLUbNB4T5pZgK4Es07HSc_JPNLXh_hvHt95phSI3RU9wC8ni1
    MevKKAtrRT1Kgvu68M>
X-ME-Received: <xmr:HVTgYuXRQMN2LMhOBnDlKmI5WUxoiqOIDGlLq_NukWmBG-3dPx35ZRFwiUT-EKb6LaDPRZ9rX9HugkE2SFHhyRji2DsBjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddutddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:HVTgYqiILLkBmRpwD1jJC3N0eje8JNiV0UtF9jQ3ed7XyC0PH5gkeA>
    <xmx:HVTgYuDj4MEFTrokx6tSQG47hQrBEQm07p_nP32zEM_jNEFe6hpqhw>
    <xmx:HVTgYrLi4mzBxxnCVpislBXha7bIotheS4zfZCtsdNxbR2bkeRO3tA>
    <xmx:HlTgYh-sDOS7gStNLcdSdcxORCDHX6fcd6tzO3AXyiLpMfTsMQTPnA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 16:52:45 -0400 (EDT)
Date:   Tue, 26 Jul 2022 13:53:33 -0700
From:   Boris Burkov <boris@bur.io>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Message-ID: <YuBUTX1i63o7Uo1O@zen>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
 <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
 <20220719213804.GT13489@twin.jikos.cz>
 <3cfc9569-ff22-c04d-f7d0-fea1396ba4b5@gmx.com>
 <20220726181353.GJ13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726181353.GJ13489@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 08:13:53PM +0200, David Sterba wrote:
> On Wed, Jul 20, 2022 at 06:58:16AM +0800, Qu Wenruo wrote:
> > >>> +	btrfs_info(fs_info, "  reserved:      %llu", info->bytes_reserved);
> > >>> +	btrfs_info(fs_info, "  may_use:       %llu", info->bytes_may_use);
> > >>> +	btrfs_info(fs_info, "  read_only:     %llu", info->bytes_readonly);
> > >>> +	if (btrfs_is_zoned(fs_info))
> > >>> +		btrfs_info(fs_info,
> > >>> +			    "  zone_unusable: %llu", info->bytes_zone_unusable);
> > >>
> > >> I'm (perhaps needlessly) worried about splitting this up into six/seven
> > >> messages, because of the ratelimiting rolled into btrfs_printk. The
> > >> ratelimit is 100 messages per 5 * HZ, and it seems like it would be
> > >> unfortunate if it kicked in during the middle of this dump and prevented
> > >> later info from being dumped.
> > >>
> > >> Maybe we should add a btrfs_dump_printk() helper that doesn't have a
> > >> ratelimit built in, for exceptional cases like this where we really,
> > >> really don't want anything ratelimited?
> > >
> > > Splitting the message is IMHO wrong thing, there are other subysystems
> > > writing to the log so the lines can become scattered or interleaved with
> > > the same message from other threads.
> > 
> > But that one line output is really hard to read for human beings.
> > 
> > Or do you mean that, as long as it's debug info, we should not care
> > about readability at all?
> 
> Yes we shold care about readability but kernel printk output lines can
> be interleaved, single line is much easier to grep for and all the
> values are from one event. The format where it's a series of "key=value"
> is common and I think we're used to it from tracepoints too. There are
> lines that do not put "=" between keys and values we could unify that
> eventually.

Agreed that a long line is OK, and preferable to full on splitting.

What about making some btrfs printing macros that use KERN_CONT? I think
that would do what Qu wants without splitting the lines or being bad for
ratelimiting.
