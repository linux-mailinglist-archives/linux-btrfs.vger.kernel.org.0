Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7A576370B
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGZNG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGZNG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 09:06:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A61BF2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZuEugufHFPdkbNCgQ1u+npPBUeqWeX0Dxv01FdnlMxg=; b=bJvq8u9snL0uRpK2IoBXqjuOpJ
        SUDmp/XF/zeUUgxD1Dkkqm50kT9oS4UHhlBoLokagj6MxVBaNoKgzN1h7OujT3l1lGcEg/2nxuaef
        EmlflQHtZAXntILuusSXkGXE66j7bT9HjtG5ntoaH0nabEwTHgSXvt0RaGc2zZz5MfMrEcV3yBGwL
        hZbPPdVyvZ4yomIOyZiqqrjxsC3UZFniQgocHkQKFFp6xpX7mRC8inLGDH80OjI0jKlg+T8O44zv1
        RTIIHGW9XnrNZPT3PLvXLuLmX6kdDiWBLxeMM74it6axe865akp5LAqiFZIwuYCO3ZiMpq3EDIjPF
        0MRDKfDw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOeEB-00AUcQ-03;
        Wed, 26 Jul 2023 13:06:55 +0000
Date:   Wed, 26 Jul 2023 06:06:54 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] btrfs: zoned: defer advancing meta_write_pointer
Message-ID: <ZMEabhGG8OGGxOBr@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <0c1e65736a8263e514ffb6f7ce8dd1047fbb916a.1690171333.git.naohiro.aota@wdc.com>
 <ZL6S6mGdlgQCswQz@infradead.org>
 <2m2mi3l5aiiwugv4s5lrxal45eydjhps6hvsegkh4nz7g6qhwy@agymo4iprypn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2m2mi3l5aiiwugv4s5lrxal45eydjhps6hvsegkh4nz7g6qhwy@agymo4iprypn>
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

On Tue, Jul 25, 2023 at 08:59:17AM +0000, Naohiro Aota wrote:
> This won't happen at this point, but can happen after the write-time
> activation patch.

Let's move the check there and very clearly document it in that patch
instead of slipping it in here.

> Returning true itself in this case should be OK, because in the end that eb
> is rejected by the lock_extent_buffer_for_io(). We cannot simply return
> false here, because that may lead to returning -EAGAIN in a certain
> case. For the return value, we can move the wbc check from submit_eb_page()
> to btrfs_check_meta_write_pointer() and return the proper int value e.g,
> returning -EBUSY here and submit_eb_page() convert it to
> free_extent_buffer(eb) and return 0.

That feels like the right thing to do.  What I think would be really
good in the long run is to actually avoid the write_pointer holes
entirely by never cancelling buffers for zoned file systems, but instead
move the zeroing that's currently btrfs_redirty_list_add into
btrfs_clear_buffer_dirty.  I tried this in a naive way and it failed,
but I plan to get back to it eventually.
