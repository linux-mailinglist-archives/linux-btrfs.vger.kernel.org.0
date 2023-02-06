Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F318568B5AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 07:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBFGiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 01:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFGiY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 01:38:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6B18B14
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 22:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8Mzakosfx6sJtocpA0XyVM7axDuJvrpgq0eLDjBnhwQ=; b=avttX+nuTZQ4mLiwCdkJGqFbBP
        U8TmfdR0rntKq/iFD9GAK6/xhvC8FXEIWCqxFD98dJ6WYdVZ9H55s5b9yera7B9z55TlMcRLYgZ/o
        XA1nlJ7E7OQDzECSoEDpa/XzUPS72nTzCKE9jJjSdLeWBken2QZWuxPXUkV93a6KiPA4NQ+T07iaW
        +3QR97W2t7sJibUqURW1gu5ECNxEL+f678nwAPL646yk0n7cB+NBUFHXi61fqLwASIquym77021Db
        82lapkoiBd4gS7YOz/9+RGs2WzdviIztvu53gYjNB584ocLIC56il5mmRnnyxRF9Qh2vsJAjuGAms
        XLzjRPaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOv8v-007TbV-2W; Mon, 06 Feb 2023 06:38:21 +0000
Date:   Sun, 5 Feb 2023 22:38:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: reduce div64 calls for __btrfs_map_block()
 and its variants
Message-ID: <Y+CgXXV4wRh/PuGA@infradead.org>
References: <cover.1675586554.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1675586554.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 05, 2023 at 04:53:40PM +0800, Qu Wenruo wrote:
> Div64 is much slower than 32 bit division, and only get improved in
> the most recent CPUs, that's why we have dedicated div64* helpers.

I think that's a little too simple.  All 64-bit CPUs can do 64-bit
divisions of course.  32-bit CPUs usually can't do it inside a single
instruction, and the helpers exist to avoid the libgcc calls.

That should not stand against an cleanups and optimizations of course.

