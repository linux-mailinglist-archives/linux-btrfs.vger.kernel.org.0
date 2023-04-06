Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BF6D8EC8
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 07:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjDFFXZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 01:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjDFFXY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 01:23:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D824212A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4k1WyDVcmwdvpW1yIlOA7RpcbKcHHAbiyxf0wu98SQ=; b=v3Oc450P2Y6cJNVv17ax9TQ00o
        pSw6QnhwNu4B7AjlaodYBNGtbRYVYKqNSaG/Z6euPfFhexT2uAVEesAle4wciZm/phewGVdhGpQF7
        bkW9sOxR7WzDu4AOnCEqEAXUUDSf+TRtC4/N5WnET9d2KcjDR7xhv6skiJSbR5C2LtFIXLFu+OfrL
        loyKypAEWVQtl/uHejJAdP5tJApG6xOsNWdp3R/VeIROwHLVNcFBzq8xYLOgT95C5nRAQ19LY+y+t
        AaiSQE5zlW6EsIlA5QvN6dt/1IcUKqeVwdzrSy6RoMRswOP8qokr/L15GQczPEEqtGXA71YlMuZ+w
        kmZwlMiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkI5W-006Mwn-1z;
        Thu, 06 Apr 2023 05:23:10 +0000
Date:   Wed, 5 Apr 2023 22:23:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast
Message-ID: <ZC5XPqC9+us0sLPX@infradead.org>
References: <20230329001308.1275299-1-hch@lst.de>
 <20230405231455.GO19619@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405231455.GO19619@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 06, 2023 at 01:14:55AM +0200, David Sterba wrote:
> > This series implements that and also tidies up various lose ends around
> > that.
> 
> I've picked patch 1 as it's a standalone fix and should go to stable
> trees, the rest is in for-next and still queued for 6.4.

So the usual question:

 - should I resend the series with a commit log that you're prefer?
 - or just deliver a new commit log?
 - or are you just going to fix it up?
