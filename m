Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774F567562F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjATN5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 08:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATN5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 08:57:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A8EBF8B4
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Jan 2023 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBsoRjpx7nrES98YKJZAJpHO0fzc69o9rh50wKsIYtM=; b=dODxkGTK5Y5zcPUAQPnj/EJAb+
        J3Eprt/ucRs2i99xqqwnP27kcZAYOJ6+F3CPel5v8wW2TMvjt/y2eHx0PxZcQ36EklybUD50h5tu/
        iopBsd7fPNPYAiO5Zm48AeC3k0f5Sn/rNJCMawGnnWZqwWnF9QfuBuDbHs6XDBxWm1MSNToA1Rmyg
        G9B2NqeZaW3EnzVAHtiROV98agFLqHzRxZo7FQ2EXaaOP3O9U5ito8B+ZO+fGaEB9IMuNxI6mEExn
        tNivFA2nhfacNW7i1z+W46FTf0aKgokywwFCu4L492ZriA+65gYMCS18iNq8vbqweslum2PSsDR6b
        2B1SEuGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIrtH-00AY4C-Gq; Fri, 20 Jan 2023 13:57:11 +0000
Date:   Fri, 20 Jan 2023 05:57:11 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: raid56: protect error_bitmap update with spinlock
Message-ID: <Y8qdtwcR5q5zxaA/@infradead.org>
References: <e21c9c44b8a88d381744e83dfd3b1505cc35e4e4.1674204981.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21c9c44b8a88d381744e83dfd3b1505cc35e4e4.1674204981.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So the reads of the bitmap only happen after all bios have completed
and the reader side really doesn't need the lock.  Having it only
one side looks odd, and on really weakly ordered architecture might
lack all the barriers.  Should the reads of the bitmap also take
the lock for completeness, or can we get away with a big fat comment?

In a way that alsmost asks for just using a set_bit loop in the
completion handlers as that makes the ordering pretty obvious.
