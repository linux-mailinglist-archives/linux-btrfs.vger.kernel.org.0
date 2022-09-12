Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF6A5B5BEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiILOJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILOJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 10:09:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AB6540
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RDV2ZAblVta/iVB5ZHiSb0l7zZf6Cr0fnY9L1xyfPek=; b=RA9HSd4IZImZdZzKW/5AyMcwip
        Cf9XvUhQnMD4onlLC71A9U0Ypne9Gz42rzezB2FtLkZIRnBBed5S9CyZk0TFgTBgaUQR19vE86x3L
        MbUvJYFkGFP5zv9uTSw1AYgZSkQQhew7cTY+H8IrrWLGt1jwWZH91Qe+o+MxJtaCTq73rWCOdXBpZ
        H0BlbjdPuHGMRZrSTtPy+iQ8U3iJf2ouqKYMMQOk4rL6318Svd4amtr9zSFcrDAREcz1VDyQNG/lK
        x+33lbEwnEDaeeqaASkWnJvh6lLffT44bNAzmt2eRmlyAFWrZjXbsBScL/N5yGkDXW/RoYMa+IjY5
        Pya6DIvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXk8A-00AViQ-AN; Mon, 12 Sep 2022 14:09:46 +0000
Date:   Mon, 12 Sep 2022 07:09:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 03/36] btrfs: convert the io_failure_tree to a plain
 rb_tree
Message-ID: <Yx89qoyTgymrE6M4@infradead.org>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <c404fb98507c7adb812bb41f00beef47252e0254.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c404fb98507c7adb812bb41f00beef47252e0254.1662760286.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 09, 2022 at 05:53:16PM -0400, Josef Bacik wrote:
> We still have this oddity of stashing the io_failure_record in the
> extent state for the io_failure_tree, which is leftover from when we
> used to stuff private pointers in extent_io_trees.

And the io_failure_tree also goes away entirely in my series..
