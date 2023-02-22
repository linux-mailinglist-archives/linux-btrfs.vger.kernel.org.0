Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3666D69F6A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 15:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjBVOgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 09:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBVOgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 09:36:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8AA3B21F
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 06:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KSx6eYejAR7i1ifHyp141b+OrEsqn+jNzXfF5RjwrlY=; b=bP8eCGFMcsKaMW1d7X8xyWIcOV
        cFEQDljjCHDSNNpYqwxF4geidi7hakvY0KbVUfvIWWs3E6TFU1ymQq1tSjwljfdB2abuzF6fxOAR0
        uHEsD3ow2/9SvVaYycZCQqgGdirPJymrJWAIdAmTOY1VVY0rPar4KwoRhjenX/NOJldCyuWntzUqY
        zOT3IOXNvcJ36Yy8KvHKGsWH58zA84Lj4ziXmafeFzQ6s3a58IJf7HgsSs/3yHB5FUMd5NZZS6i/V
        BILCL3VlubBjFk2HBRO6jFzgXH8FvVPUPTQTBNvjwgrusc6TgrYk/o6YtuBn9aMOnCZyyilEY3XEk
        bbHIwSDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUqDj-00ChL3-QO; Wed, 22 Feb 2023 14:35:47 +0000
Date:   Wed, 22 Feb 2023 06:35:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] btrfs: btrfs_alloc_ordered_extent
Message-ID: <Y/YoQ2ZCU6QaQBRG@infradead.org>
References: <cover.1677026757.git.boris@bur.io>
 <70260eb8a1df6ad3b32ff4be62c9799fcc12ebc3.1677026757.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70260eb8a1df6ad3b32ff4be62c9799fcc12ebc3.1677026757.git.boris@bur.io>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 21, 2023 at 04:49:59PM -0800, Boris Burkov wrote:
> Currently, btrfs_add_ordered_extent allocates a new ordered extent, adds
> it to the rb_tree, but doesn't return a referenced pointer to the
> caller. There are cases where it is useful for the creator of a new
> ordered_extent to hang on to such a pointer, so add a new function
> btrfs_alloc_ordered_extent which is the same as
> btrfs_add_ordered_extent, except it takes an additional reference count
> and returns a pointer to the ordered_extent. Implement
> btrfs_add_ordered_extent as btrfs_alloc_ordered_extent followed by
> dropping the new reference and handling the IS_ERR case.

This also changes the existing flags argument to
btrfs_add_ordered_extent to an unsigned long, which needs to be
explained or even better split out into a separate patch.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
