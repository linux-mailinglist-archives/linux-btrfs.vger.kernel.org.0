Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B67175B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 06:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjEaEdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 00:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjEaEdt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 00:33:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A268F
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 21:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=zUrFhRDe2Aek/Ser/Bg4G6M5JPZBycB5szpczeKq3Ls=; b=VQIj6Sfp/5l944/dyDZ/JeqUEe
        y3SAoX3hsfjw1D/dkzRpy1re8Pb1LMs3h9bpLdRamAI5NXxzb4rj3LBKgi+Sb04aP0vQ3/pN0EG7+
        Q4xG38wvlDOZNddQ1F4Yfi5VP5536wiLO/H998bE1XBy71YQBAzN4Q3Z72aCE2FCq6d3HwZD0arFC
        00ojGojpJLgrH40qqzvg6ZEAKbfGw6eu55Py5bcdwV6VkUPxSPBpjdnbTqBQ++fn4icapU6PLZPkt
        PFUv6PuJ1FnA6kv6OWgyW3cbZP4EeqW0qe1Rt2SeBA70T3APB+dzanNpCo4Bx7Fqh6kjK5xBoQbLA
        Vqp+nShQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4DWs-00G3pV-1E;
        Wed, 31 May 2023 04:33:46 +0000
Date:   Tue, 30 May 2023 21:33:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: remove processed_extent infrastructure
Message-ID: <ZHbOKs8dS2ojyTNZ@infradead.org>
References: <cover.1685411033.git.wqu@suse.com>
 <5b3edb0ed26aa790fa92d0319739adfd71b3b2f5.1685411033.git.wqu@suse.com>
 <ZHWM5U754Na8KyCi@infradead.org>
 <8267e2d0-2bb4-36c5-b252-bbba7e18bb0e@gmx.com>
 <b3f0ae3a-5f3d-8525-70e2-ace053350c59@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3f0ae3a-5f3d-8525-70e2-ace053350c59@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 07:35:44AM +0800, Qu Wenruo wrote:
> The objective looks like an optimization, if we submit two btrfs_bio for
> the two ranges, we will read the compressed extents twice, and do
> de-compression twice.
> 
> Although this is anti-instinct, it at least has a valid reason.
> 
> But I can argue that, this only works for holes, as if the range [4K,
> 8K) is not a hole, then we still need to submit two different btrfs_bio
> for [0, 4K) and [8K, 32K).
> 
> Maybe it's time for us to determine whether the behavior is worthy.

To me this behaviour looks reaѕonable and worthwhile, but a comment
in end_bio_extent_readpage would probably have saved both of us a
fair amount of time..
