Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8527968B5AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 07:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBFGjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 01:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBFGjI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 01:39:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A1618B14
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 22:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vnTFgz07+9VsnlJ0102/kW5sMp
        0Jmhc0DJ3hmUwRWCptGWDxPScrS14yfLpw87KmCpPiG4czgdkM7HR0go/EHjx7/oJELMZPhd1pKWg
        1FofyN7NvOFMpcCsJHjYWGOoUfSB70QOvqX/U9zurhaOo5AmQyenm4xzfTp/U+2zQ+bIay2oos5lq
        ZHrvZ6TWY9dsQEYR0OlzkmHFp3FmxeIq06cqLUZwSevzVdzLHiTNzrkP5cru5x+tM9cNAgF+yf7hE
        YVYJkeMqJOjOI+T6WANjSCiEPAYAURzJi6Ep8K7w4BSA8zwsTen+qGCE163sarEF0cOl1pO+BLTO0
        Sr0AFvwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOv9f-007Ted-Iq; Mon, 06 Feb 2023 06:39:07 +0000
Date:   Sun, 5 Feb 2023 22:39:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove map_lookup->stripe_len
Message-ID: <Y+Cgi7xrhk5RRZhI@infradead.org>
References: <cover.1675586554.git.wqu@suse.com>
 <0da7fb8df029231aa8f65dc1d0b377e9a91f91f5.1675586554.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da7fb8df029231aa8f65dc1d0b377e9a91f91f5.1675586554.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
