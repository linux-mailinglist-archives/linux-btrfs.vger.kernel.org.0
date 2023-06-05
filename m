Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3461A721EF4
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFEHIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 03:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjFEHIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 03:08:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472BE49
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 00:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Q/YWrd+ckXFlPQHCbrIRYLeYphNwaio+X0uwykqNIQ=; b=U9JNvEOoVgvA/m38DMMFg0+H5n
        9/i00RR4DqG5RUvWJSWnL+rjAl0S63ZFXeZGEwmPRIUfCuqaQy39tZRfKx2atwiCORj3QeBv+bxIJ
        WHG9s4OD2QDpBCehz/8uUlqL9dq2zpSsUB/EG5gddx0+dX7vJUjq/MnAM6t/QjY7pvclhNJ/fNfhn
        MAIHLitOh7sbPya/tQh4ZqYlegjWc09Fyvopk0E16xHphOqvM7DvO0wAiYCFGtt3OOg7aTZrtD9Dw
        aYjrJRVExhTjnJplNRUbocu2rLksyCkNVdV0yOyALxSzacGwJZ1svsKruJULj8tKiQblts97oB28w
        2q1oAMSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q64IM-00EUgN-0x;
        Mon, 05 Jun 2023 07:06:26 +0000
Date:   Mon, 5 Jun 2023 00:06:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: fix a crash in metadata repair path
Message-ID: <ZH2JcgAXrtqHSp/+@infradead.org>
References: <cd4159ae5d32fdb87deba4bf6485819614016c11.1685088405.git.wqu@suse.com>
 <f188e0d6-1189-6c3b-28b2-837ac12cb92f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f188e0d6-1189-6c3b-28b2-837ac12cb92f@gmx.com>
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

On Fri, Jun 02, 2023 at 03:15:39PM +0800, Qu Wenruo wrote:
> Hi David,
> 
> I still don't see this fix merged for misc-next, any update on this?

FYI, while I prefer the explicit version, this one definitively fixes
the bug, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
