Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842EE6D9BE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 17:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbjDFPNW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbjDFPNV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 11:13:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5154136;
        Thu,  6 Apr 2023 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mzTxus67G+HqHPbdQ1mLqZIyacXwzsFPjZE5/prUKD4=; b=XZMTRD+ZgQX+86RhozNq1WLVIC
        cIUrP0ZzxTXoQrkl+SWxEbgup0ATEgXFT6m6xVDOwYqoBJ4JsiyNaIEA5iPhc3KGosKh0lTcyLg1E
        qVCq7m78Eck7elbOQFm620lxaegCQ6iHfCSDrg0+PnhEV7B7IbINzWhhXLLLgq22dPNp8/T9SXhrC
        W0mZxRUuLnVegx+8EdKI0Fb/UealRNhvBe2x3ZPx5nn448wME7HZzHAEvvYNCGgqwjn3yMq4G0iaY
        Uii7HUd4sAvunSnCbJSjVADtyuddSI12GF29qAvVUNSnwHg6L+2dmIUJjy7OPLX+TtMut/NPBhpHU
        zF+F0JOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pkRIb-007llL-2K;
        Thu, 06 Apr 2023 15:13:17 +0000
Date:   Thu, 6 Apr 2023 08:13:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: use safer allocation function in
 init_scrub_stripe()
Message-ID: <ZC7hjYQOR7owkzmH@infradead.org>
References: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174f3bc-f83f-4009-b062-45eadb5c73d6@kili.mountain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 06, 2023 at 11:56:44AM +0300, Dan Carpenter wrote:
> It's just always better to use kcalloc() instead of open coding the
> +	stripe->csums = kcalloc((BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits),

The inner braces can and should go away now.
