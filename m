Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70C67636D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 14:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjGZMye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjGZMyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 08:54:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A1B1FC4
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vv5yxAvAUjDjuek4TfRE+42QM0032xy5gJGzT6pE1Vo=; b=rIQZfdzEqXy0WiOSMfmLmQ8YnD
        yhNnoPaimXPu4G+ZdNbuX2xjW3cXMCvxw6M6Ya2/y0iC1ff7lH5ed8mNPWrpXMrZwoj9p2qRKyOs/
        Ikz5TmhIP6f/5Rmonz9oB4pBM62ipddVKbc0meqlZCnQ7VUGF97q/JBlyVDkz5aEz21Wh9uxcrb9/
        m+Ex9XC18lPLMHrWj9UFAZHg0OVzV/CMlZUIQIbNvgZ5yOr/y61jpn+1oJjw3ofZbU5PsBknduLyt
        wopmaiHEMP5b8wHwoMni3UP+XwFZv2sVlKwUC/6iMOSRaTGw6xl4svkIIuA1+d3C1Kd64MxEFx4lO
        KKYoJcow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOe29-00ARwx-11;
        Wed, 26 Jul 2023 12:54:29 +0000
Date:   Wed, 26 Jul 2023 05:54:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dimitrios Apostolou <jimis@gmx.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: (PING) btrfs sequential 8K read()s from compressed files are not
 merging
Message-ID: <ZMEXhfDG2BinQEOy@infradead.org>
References: <0db91235-810e-1c6e-7192-48f698c55c59@gmx.net>
 <4b16bd02-a446-8000-b10e-4b24aaede854@gmx.net>
 <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd0bbbc3-4a42-3472-dc6e-5a1cb51df10e@gmx.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

FYI, I can reproduce similar findings to yours.  I'm somewhere between
dealing with regressions and travel and don't actually have time to
fully root cause it.

The most likely scenario is probably some interaction between the read
ahead window that is based around the actual I/O size, and the btrfs
compressed extent design that always compressed a fixed sized chunk
of data.

