Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE3B643EE6
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiLFIkx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiLFIkr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:40:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B92655
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CH4rTlQQfCbU2S/r9BIlemVgihNnKIla4UjsfZtyt44=; b=Ox//EJ7CPdwniOzZWcF/Kx8aco
        KX+9YxgPLPRFrJso/PsQOV3TK/Jb64pWmIo7OQ5C/KBB5IY6B9zTj7OQ/pR2160g1a7WgqD9OBhCJ
        SkX3WXNhoDh2DN+RYV7OLC614NX8/+UeRoJ4cftxSuOdzqg/6bf7s6LKvdsGP8GqH8HD1z9w3DApY
        VdMgW1VMxp1AX7boRg1GOYj/sxvqpc1Zgp+GopZ2Tf5zPTq8H+Lls4ECCm1iUQaEGG9F9OVS9AIBl
        BGrq7FjzMjezuA+T4oQNFxrFB0sB3RFSPE2t+dSOL2mvceev2oLQKhqVLWaRZFYWBFHpq8/1l22Xs
        MN9wDQPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2TVM-0052KU-IJ; Tue, 06 Dec 2022 08:40:44 +0000
Date:   Tue, 6 Dec 2022 00:40:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PoC PATCH 00/11] btrfs: scrub: rework to get rid of the complex
 bio formshaping
Message-ID: <Y48ADI5Qa2Wt+/JR@infradead.org>
References: <cover.1670314744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 06, 2022 at 04:23:27PM +0800, Qu Wenruo wrote:
> TL;DR
> The current scrub code is way too complex for future expansion.
> 
> Current scrub code has a complex system to manage its in-flight bios.

From my own ventures into that code I have to agree.

> This behavior is designed to improve scrub performance, but has a lot of
> disadvantage too:

Just curious:  any idea how it was supposed to improve performance?
Because the code does not actually look particularly optimized in terms
of I/O patterns.

> Furthermore, all work will done in a submit-and-wait fashion, reducing
> the delayed calls/jumps to minimal.

I think even with this overall scheme we could do a bit of async
state machine if needed.  But then again scrube is not the main
I/O fast path, so in doubt we can just throw more threads at the
problem if that becomes too complicated.
