Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3336B9D61
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 18:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCNRs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCNRsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 13:48:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65FACC2B
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 10:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=guY/G49iK/p9es6X/yyVKBLfwP4JwACTVbWCSI4aE5k=; b=ufKRAToil7jqoxaN9As5JS4ntz
        UBcedEE5aVM3TcRlhDwgNjy6zWNiI4gbsJfLAQQMtaC04EtYuKG/uy5p5TvDdTnw5MdQSb12SfoJt
        o/gjCbax4dg4rN80ryGipONk09XseyTgROw5qojnsjL840lBj2YYqlm2qeeJGbfWXlxHUX4KKsaRM
        eqRWcT050cHWUdxTc/dQ+zXU3kqAYypD6d3xV/dUChTc2POKScIa73jY8e5w+xqMDROamXLFoZVTC
        dWUmX74+F5Ixb+A1flBcoMFeCnFTLOmfxXYu8zOlx9jRdd2FB3aJ3Sd6uFPAOVBkO1DopDTCpEj6R
        3rCzZ4lQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pc8l2-00B40c-0W;
        Tue, 14 Mar 2023 17:48:20 +0000
Date:   Tue, 14 Mar 2023 10:48:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     4censord <mail@4censord.de>, linux-btrfs@vger.kernel.org
Subject: Re: Corruption with hibernation and other file system access.
Message-ID: <ZBCzZH7Lq2K1jS/M@infradead.org>
References: <ba9fb1c9-ccbc-4b93-92f9-a8c17ffab7f6@business-insulting.de>
 <87mt4f9qrn.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt4f9qrn.fsf@vps.thesusis.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 14, 2023 at 01:36:32PM -0400, Phillip Susi wrote:
> You must never boot into a different kernel while one is hibernated, at
> least if there is any possibility that the other one will try to mount a
> filesystem that is mounted by the one in hibernation.  If you do, you
> MUST NOT attempt to resume the hibernated system or there will be fire,
> exposions, and death.

I'm not a hibernation user because it's generally been rather
flakey, but last time I checked hibernation was doing a file system
freeze, which implies the file system should always be consistent.
