Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7B75FA5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 17:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjGXPEM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjGXPEL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 11:04:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4012E
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ARYc+vn4vbY+rKRqmbBfppIO9StBmK5teSJ9hMWUR2Y=; b=kzt6jsiI18uCVXL8i8+27V63ae
        6sfdRgD8oAi7s7g49cQNkHsCvCZ2xJ2jFU5LFMpXIyTYsmvau6N1XQN8Ka7ZN887vXA/fXOhZMCue
        r2lp8Z2k3V3aketGXnQYl27eUXCK/HbWURs5zbknI6AMgrnwVCl3JlG2s5m0x9pqnpPs+nZ0hcwsz
        9oRmqs55JIf6o80n6IE13qbFWAwf+toytABN3nt/Y9siJef8REbnevSsMFZwlIFGZKhedJoGWoh1q
        BIUxvIRbfpUpZq+39ol+T2fqbg3tzeFKMS+iptmJ/hLCNfqcGvNyvSdXLiDrQwpbajgVdmQXU2N0Q
        A0e/4I7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNx6Y-004g1I-1k;
        Mon, 24 Jul 2023 15:04:10 +0000
Date:   Mon, 24 Jul 2023 08:04:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/8] btrfs: zoned: defer advancing meta_write_pointer
Message-ID: <ZL6S6mGdlgQCswQz@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <0c1e65736a8263e514ffb6f7ce8dd1047fbb916a.1690171333.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1e65736a8263e514ffb6f7ce8dd1047fbb916a.1690171333.git.naohiro.aota@wdc.com>
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

> @@ -1773,23 +1773,15 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
>  		*cache_ret = cache;
>  	}
>  
> +	/* Someone already start writing this eb. */
> +	if (cache->meta_write_pointer > eb->start)
> +		return true;

This is actually a behavior change and not mentioned in the commit log.
How is this supposed to work?  If eb->start is before the write pointer
we're going to get a write reordering problem.

The other bits in the patch look like a very nice improvement, though.

