Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE753A4A2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351778AbiFAMO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbiFAMOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 08:14:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D385B8A4
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWYlnHCXMvtR6+GazaADN4X4ovZX4RIptYJyLbCBrdo=; b=wcb+Khtom0whtthrI8j2rdBStS
        g9nwe7o+6u3R3q1byC39DQLoBa2dixaRqC5jWvhYXi0HWo4G/j6wRuqqoWnLWPwsLcG9yPScBvk1g
        gyTTPnDehoBXX3CY7aPnCSJ6ahqU+lsyhaom7yY5lpUslrc0xJygj3eEmAk5GoqS7zwNpIrmyXADN
        XoT7xGmbFjM/087RmGDvXHWh03YiZJ2M6TB/nsazw3ft29i1PaHROXrcBEDm4k1nunP8a9vAdB4VR
        07R+W4B2KswZoQwqf2zVxkAQ1A0TRYcI5I6NrWy2ZVDU0G1sh4m+HpqL0zQvTctvIkF3e+ll1EBCV
        atCLED8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwNEz-00G0Sv-MG; Wed, 01 Jun 2022 12:14:21 +0000
Date:   Wed, 1 Jun 2022 05:14:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove redundant calls to flush_dcache_page
Message-ID: <YpdYHT0tq+zoOG3U@infradead.org>
References: <20220601114754.21771-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601114754.21771-1-dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 01, 2022 at 01:47:54PM +0200, David Sterba wrote:
> memzero_page already calls flush_dcache_page so we can remove the calls
> from btrfs code.

This is for a mix of memcpy_to_page and memzero_page, but the statement
is true for both of them.  So with a slightly fixed commit log:

Reviewed-by: Christoph Hellwig <hch@lst.de>
