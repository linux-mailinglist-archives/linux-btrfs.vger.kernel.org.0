Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF68275081
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 07:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIWF5U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 01:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIWF5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 01:57:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EBEC061755;
        Tue, 22 Sep 2020 22:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+xPayIM5KsnWTfKDPlxSGNgmE5Ab/DG3SsTYQ0nYWCA=; b=g/f91SGO92fFuYvJtguHCdSROs
        1Kl3jQYtC3DJmj9dFU+X/DxR2smj2rRxEiMVTCdpcVec1wTczcbnjIg4MRK5bGkoL38Dny+RvaB3g
        mdma3P/6FfdNyO8L2AQ1mZMCsPxdzEDJV4mfqL972CHGS7iqYA1ZKxm9Jklkqk2t48cWxc9wbvikZ
        89h2DQQYsF6wQTCjDfLCFb6eo9aX6Ql5xCzzbuZ+KS+SRmmlVEQD1kIF1BeFck/pwuOT8Ism12NW1
        IW033ZHgZHMiPVMGFmIaU7YkHWiPus6SQH2uk+BD2umQQFRbBX/aAyTuaGhJ6KLBgtsXGBf/DjjHX
        gbrdKdlA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKxmG-0002rE-HI; Wed, 23 Sep 2020 05:57:16 +0000
Date:   Wed, 23 Sep 2020 06:57:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH v2 0/9] Update to zstd-1.4.6
Message-ID: <20200923055716.GA10796@infradead.org>
References: <20200922210924.1725-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922210924.1725-1-nickrterrell@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

FYI, as mentioned last time:  clear NAK for letting these bad APIs
slip into the overall kernel code.  Please provide proper kernel style
wrappers to avoid these kinds of updates and in the future just change
APIs on an as-needed basis.
