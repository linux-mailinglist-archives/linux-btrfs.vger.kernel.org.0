Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5DB5EC8F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Sep 2022 18:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiI0QEq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Sep 2022 12:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiI0QET (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Sep 2022 12:04:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED4B1C770F
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Sep 2022 09:02:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1CFDC3200684;
        Tue, 27 Sep 2022 12:02:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Sep 2022 12:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664294557; x=1664380957; bh=bhRlenrwIG
        6v5b/EmPwBixgu1KTVImJ+WpArhNpIzVY=; b=F7S5bKM2nfTjaU5QYD/1vZcELT
        aMg+l0yjdYiVV7Uko++cqc4xzeyba1JGZu52LfLMOduTzKfV1WTE3aSgYCCZ/WtV
        8LiOPhylhVW475yTPvZ/a2kN0Nhoz3E6bgCnUXgDCBkC1cktYUxzC4b50RwaRNg2
        5vqvcO9oL7y12HJBmkS0fHZfoO9V3Pn0JotwreJKpKXpOtqNz/SObbesceh5t8SG
        iU1u6dv67tpomguCZUpJtZUOUX8sv+tud+ZUr6wzCukoA0dJOSwYVGpNMNvuXFkW
        GN1MkYPY+aQ0vOp85kE9bcM22pyF8axHPfJSffN5Wz7f1hyS7KZF9kZBH+6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664294557; x=1664380957; bh=bhRlenrwIG6v5b/EmPwBixgu1KTV
        ImJ+WpArhNpIzVY=; b=I/u1fEGPKsaixQj12DiuriRwzUOP/EGPT8ZNuxAB3eiD
        ydAQtRVrzL/RvhBN+kjFxvwBc7qEWdkxlYfOqlGsxDwPNM2yVPI1ii3+JiR+JYw7
        BTMajcxplAh6uLQDKaBMZBoVkYsKG4UtN3iJUcoVMAKGpQ4eCqntHor6Nmsx/IkE
        wd9ieCBLnwvN9+ArhRn/aLuJmO7p8qC9eyD8ywEnoYVAL5+bDO+Cn74t207uvc3y
        Cx9djhnq7mvrwnQjnpx7ds34ODqEYk4TPtzse40VMTJrYl5TzQrPj4nAl5AGp/j2
        TNcboVTnVE6sZqyu4d0DlsBEIAHqDVt885a6FrMdOQ==
X-ME-Sender: <xms:nB4zY9BNdOZwfjKIz5IzykrB1c19_jUyBDYyvtYQO5va_Yy0uuIv2w>
    <xme:nB4zY7gdJAHjVm5ljjjkZxr0uDg5n9XIudY5lfu7FCxefMJKkEEFvBblCVv4SAmXB
    qqykIRFUGdFbkMvwzI>
X-ME-Received: <xmr:nB4zY4lPFNxqDk3G0PMe8_bw92-crWu_7dXEiQVU8hQVfn7MlizXKcAj85i4NF88O3W96BoXA1dOkWuiL6c0I22StjibMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:nB4zY3xfSlmmKTFOxAiU8Zcc9ZPawZu3KdjYj4T0-TBEh6CcsUODeA>
    <xmx:nB4zYyTUB6H3B5RvOrYgqGSaBVylJgJMlu0tpLbvs8AuYvNzo7yeOQ>
    <xmx:nB4zY6ZHBOMeTLzNiZXgY0cudi0cQXJSB1K6ncK-XMYRvulJGVMEIQ>
    <xmx:nR4zY1JeJ6DC-cPWjeoJyApG26uk1R1akEDXoOc8ObwmS-K3vP1y2Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Sep 2022 12:02:36 -0400 (EDT)
Date:   Tue, 27 Sep 2022 09:02:34 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: send: gate SEND_A_MAX and SEND_C_MAX V3
Message-ID: <YzMemuUrL/kn3CN0@zen>
References: <6c87faf8a6ff6172019faed9988adb9fb99689b4.1664216021.git.boris@bur.io>
 <20220927122412.GC13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927122412.GC13389@twin.jikos.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 27, 2022 at 02:24:12PM +0200, David Sterba wrote:
> On Mon, Sep 26, 2022 at 11:15:22AM -0700, Boris Burkov wrote:
> > We haven't finalized send stream v3 yet, so gate setting the max command
> > values behind CONFIG_BTRFS_DEBUG.
> > 
> > In my testing, and judging from the code, this is a cosmetic change;
> > verity send commands are still produced (and processed by a compatible
> > btrfs-progs), even with CONFIG_BTRFS_DEBUG=n set.
> 
> There must be some misunderstanding and what you implemented is not what
> I had in mind. The debug protection should have been for
> BTRFS_SEND_STREAM_VERSION so we have v3 available for debug builds and
> not otherwise. The version support is not determined by the command
> definitions but by the BTRFS_SEND_STREAM_VERSION macro exported to
> sysfs.

This makes way more sense, thanks! Working on fixing it. I will also
block sending verity based on the proto being >= 3. Sorry for
misunderstanding you in the first place.
