Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D757636E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 14:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjGZM4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 08:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGZM4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 08:56:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608BE10B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Id7vfTLtTYbi6sE3LMYNU4eSHBy5HQ1GMeGalP28c3Q=; b=uW5Lk4TINCx3M56JzMu1EozgSv
        +YJqgainA/JpUgW4yp0pLG8LMkrXqDfqixD2IffgeatIMouxc4+TNYuiMp8xxMyqWHjfIupU4ME76
        FHB19dIynTbQM34zngpTlhZQDxVBM0S0LaKDQlg0E9rxm2c0OXMlaQklzNNAafuPQP67VBPMfr6De
        NG2knLvhlcpHuQO1RkBybEFg/f7AbrVHU9vTr7h114z7phujZjbuzs4+Sq2SQhq+IEPC3MyPcfn5P
        buUoGjeERxJ8Ch6OjHyglW8mjhFeeF+vpGwB4LxjWPN4o4jE8xFzR7XQ2sBPVTpYW/xpKV/T4PjKr
        hgikBDkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOe4M-00ASpa-0p;
        Wed, 26 Jul 2023 12:56:46 +0000
Date:   Wed, 26 Jul 2023 05:56:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs NOCOW fix and cleanups
Message-ID: <ZMEYDhStXhXLWxvh@infradead.org>
References: <20230724142243.5742-1-hch@lst.de>
 <20230724183033.GB587411@zen>
 <20230724194923.GC30159@lst.de>
 <20230724195824.GA30526@lst.de>
 <20230725214225.GJ20457@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725214225.GJ20457@twin.jikos.cz>
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

On Tue, Jul 25, 2023 at 11:42:25PM +0200, David Sterba wrote:
> On Mon, Jul 24, 2023 at 09:58:24PM +0200, Christoph Hellwig wrote:
> > On Mon, Jul 24, 2023 at 09:49:23PM +0200, Christoph Hellwig wrote:
> > > Yeah, looks like for-next got rebased again today.  I'll rebase and
> > > push it out to the git tree later today and can resend as needed.
> > 
> > Looks like for-next has in fact pulled this series in already.
> 
> Please note that for-next is a preview branch and for early testing.

I know (by now), just wanted to put out the explanation why Boris
saw the reject.

If at some point there is a good time to tweak the btrfs process, it
would be really nice to name the branch that ends up in linux-next
for-next like in every other subsystem, and to not use two different
git trees, which both are things that confused even me as a long time
kernel contributor horribly.
