Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4D2757B94
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jul 2023 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjGRMNf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jul 2023 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGRMNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jul 2023 08:13:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77010E6
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 05:13:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D51B31FDB9;
        Tue, 18 Jul 2023 12:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689682409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7V1Gk1CCJqh0dNW8XHWWrUBKt1IAvKRdX/waiBZUtI=;
        b=RKJfjTff+s/yLjUQ/TGGaaMRwWyCxjDiC4Fe9SLIIKM8kngaMVUXcCr41qftAqROtWT89c
        Okl/XWV7yACtjjUsQtvfnRJN5uzg8LPbi9V/vUAukjVA7habINQ4lSiNx4tUJZsDNB9/hi
        p16K30wBlj+rtLnyAJFhrFKHhBLIUmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689682409;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7V1Gk1CCJqh0dNW8XHWWrUBKt1IAvKRdX/waiBZUtI=;
        b=gIadNgKQITF55y3CnEkXOM8hUdFA7uMfVI201Rv5urpkXDT6mKKYK56IT+q1Q4F+yBM3U8
        6fURzaA2rl7MpPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB9DF134B0;
        Tue, 18 Jul 2023 12:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNAZKemBtmSPPgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Jul 2023 12:13:29 +0000
Date:   Tue, 18 Jul 2023 14:06:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [ANNOUNCE] New GitHub CI workflow
Message-ID: <20230718120650.GP20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230717185715.GA757715@perftesting>
 <CAEg-Je_HLAvZrSnUm6EWJkLD9Ewe3ZRvJH6TgdnS_rN-3j-pBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEg-Je_HLAvZrSnUm6EWJkLD9Ewe3ZRvJH6TgdnS_rN-3j-pBA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 17, 2023 at 05:14:36PM -0400, Neal Gompa wrote:
> On Mon, Jul 17, 2023 at 3:17 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > you don't have to, this is simply a convenience offered to those of us who do
> > this for our job.
> >
> > # I'm not in the GH Btrfs org/don't have a GH account and want to use the CI?
> >
> > If you have a sufficiently large patchset you would like run against the CI for
> > you all you have to do is ask one of the Btrfs developers and we'd be happy to
> > push a PR for you so you can get your patches tested.
> >
> > If you would like to be added to the GH Btrfs Org and aren't a current member
> > please email myself or Dave Sterba and we can decide if you can be added as a
> > member, but this will be limited to consistent contributors.  We are always
> > happy to submit PR's on your behalf if you're just looking for some extra
> > validation of a large contribution.
> >
> 
> Will we move btrfs-progs to this GitHub organization?

Why?  I can create a repository and push the releases there, but for
development a lot of things would have to be changed to make everything
work, scripts, integration, permissions, etc.
