Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8C74CC31
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jul 2023 07:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGJF3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Jul 2023 01:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJF3A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Jul 2023 01:29:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F60A8
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Jul 2023 22:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NwfwhgGcYt1NPNMnai3w13waFo+eOo4lfPEw1qxigmU=; b=ZDaqIYMHNdpTQ6p7tBf8R3mmXf
        xhPDrFpl42XFkgMoGg4pclYgP2O8WAn/1UF94CB2caMe7Lsr4Yfy+MiXdU9pmYP7JSRNOZY6fsJD5
        iXAjjVd9et/eSTPBTnANeh9rKZypMyqVhSF7lGXg8ezTo6/qkKpi2PgqE91tmB9h3rH6/TayTe2Y3
        ck+jOrv+DHgBtfhkn6li73RGVMckCp0iLWscdKiHPYwSciKVSF9JnsRruHAyMvgTPX3YODEXEoOPR
        nEc8OmM0KE7jpAtsCRryqzOjYLVujp+ECvjmWbKByhrk7R2Mr3EK+l8Mi5fTt0wtLS6MnVipBgc6v
        p8KztFMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIjSD-00ATVr-27;
        Mon, 10 Jul 2023 05:28:57 +0000
Date:   Sun, 9 Jul 2023 22:28:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add a debug accounting for eb pages contiguousness
Message-ID: <ZKuXGdWdMlgrmgE4@infradead.org>
References: <20230707084027.91022-1-wqu@suse.com>
 <ZKf5dDGx0S1YAT6/@infradead.org>
 <6ce97a6a-7068-311e-a63e-c6171321101a@gmx.com>
 <ZKf8Lf0iz2gDSZXg@infradead.org>
 <11964cc8-3415-74d6-a099-23ac80e34932@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11964cc8-3415-74d6-a099-23ac80e34932@gmx.com>
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

On Sun, Jul 09, 2023 at 12:44:33PM +0800, Qu Wenruo wrote:
> Unfortunately __filemap_get_folio() is still only creating folios using
> order 0, under the no_page tag:
> 
> 	folio = filemap_alloc_folio(gfp, 0);
> 
> So in that case, it's really no difference than find_or_create_page()
> for new pages/folios.

You're right, willys patches to pass the order haven't actually
made it to mainline yet, and I assumed they did.  So you'll have
to wait another merge window.
