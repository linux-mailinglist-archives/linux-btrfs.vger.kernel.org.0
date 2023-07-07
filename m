Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4974B048
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 13:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGGLvP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 07:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjGGLvO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 07:51:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1627E72
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/PRbvjdN2gI3orboHG+1QuTsy8Hnl6V7m2Q1qfqt97A=; b=endehuyjFvpYaNBKEm0ZRm8GWb
        wpgW1QIcmX1tovjQ512TyuOz04oYtANg47Csa02e//suGZgqF1vKlwEXNwNQJzoGzY44H9Kx4OgKE
        BKvNuHUZAFma90KcXEb2UGrtA+GeKHMIntVL1JX+r0xlL3LN1EbbGhVCWx9P52Ap9Fl7uNapJIJ7q
        8AKy+so2TqbxboVU3ESJduNShpP+764XL2y47NOD6KacH0UemnB2vT6blg2otcRVtIZy38yJBaQi6
        4i85B9oorm7oj3yRP2x6KCARddQNUWBlMFlWYutti2AU77RvNj2pEeunTafBOEjWaTuoR4DEsWixe
        ejq/SRJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjzR-004YaA-2p;
        Fri, 07 Jul 2023 11:51:09 +0000
Date:   Fri, 7 Jul 2023 04:51:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
Message-ID: <ZKf8Lf0iz2gDSZXg@infradead.org>
References: <20230707084027.91022-1-wqu@suse.com>
 <ZKf5dDGx0S1YAT6/@infradead.org>
 <6ce97a6a-7068-311e-a63e-c6171321101a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce97a6a-7068-311e-a63e-c6171321101a@gmx.com>
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

On Fri, Jul 07, 2023 at 07:45:41PM +0800, Qu Wenruo wrote:
> I mean a multi-page/folios version of find_or_create_page().

__filemap_get_folio with with FGP_CREAT.

