Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6035E5B6728
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 07:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIMFLF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 01:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIMFLB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 01:11:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0944360F
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 22:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oBs1BRt2lhaTJqPZvPu2Z+nzNXlnPVTq8QvCYFAdDHo=; b=vgkGYgdCj89/d0KjD+6VvGbPwd
        W3PtoxhNa5ZGQMxwVY3ClKr0I7WKtw56mgVsHZOj5yJBLBZW4bZoSX0Tz9RWG/HQ2MkwCiTjgbmBE
        RHxNrNe7VrlruyV/g7KV0+ga6wQt0yXrN1xft/XGopBcP8ixe+6b6NJD8X0S/WOY/eB20qKZ1GNHH
        xXQQ1UaZ7sbUmBnbDYIBw20iiUlOZpus3HSP/TGvYL3+KpHoDGaK01BRJ/B8zRh8jL2T3Ly7ohuBO
        25Ve42seayl6TY2E089A5ygFNSwahUDMNs7hjJRIti2HtlnVe8e7o7fH/O2lj8CwqKwjHbiHgZJ9x
        kH1muttw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXyCJ-0029Em-MO; Tue, 13 Sep 2022 05:10:59 +0000
Date:   Mon, 12 Sep 2022 22:10:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 01/36] btrfs: rename clean_io_failure and remove
 extraneous args
Message-ID: <YyAQ48bubxfgipwN@infradead.org>
References: <cover.1662760286.git.josef@toxicpanda.com>
 <f09c896c9cf29af6c9aab11a760fec372f77551e.1662760286.git.josef@toxicpanda.com>
 <Yx89bhyk7wrrmWox@infradead.org>
 <Yx9z3bAkEanf1D5e@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx9z3bAkEanf1D5e@localhost.localdomain>
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

On Mon, Sep 12, 2022 at 02:01:01PM -0400, Josef Bacik wrote:
> Yeah I meant to put a note about this in the cover letter.  I'm leaving these
> initial patches so Dave has options, he can take mine and then take yours at a
> later date which will remove the functionality, otherwise he can take yours and
> just drop my patches related to this code.  I obviously prefer your patches to
> remove the code altogether, but if those don't get merged before mine then this
> is a reasonable thing to bridge the gap.  Thanks,

Yes, it would be good to have some guidance there.  I have a new
version of my series almost ready, just need to look into the one
somewhat comlicated patch split you suggested first.  But if we want
to merge this series first I probably don't need to bother patch
bombing the list before I've done that rebase as well.
