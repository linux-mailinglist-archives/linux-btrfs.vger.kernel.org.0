Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6AB75FA3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGXOz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjGXOz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:55:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F910C1
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RWboUVmSWmv9RVJc0Md/DeooAQPYZ3g0INW8wATErwE=; b=IduRIZxYPHF0ogcd5FQCptQqh0
        Scww6QSel8TtnoTx6Gx1+ocWEVQfCDcPF0QBYnnH5wkAbjUVkoZGlTGb3DDy0dlzbmTT37sLxlw0q
        GD8O3boulQdhssZ4tAqzgDmz/OcuRkoYr3NpqXdBtgyuTGuKO28mLsiDT4UClv7EpAl3QCYdlIG7t
        pjKPpWASsHTcKpp/hXC9yHmr9hWvidHsRbzberw3FwH9j0HkY+BrBaX6wr7pRyXYtIbBbcSjeOhUp
        nSE6w+MKdAWEVLraPeA9aYzbK5rjE1W32JQka/ycBqGrXuJ4XD8WYHZq0XwdFvJlTgNX96ZpWBkgo
        B7NiU5Xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwy5-004ec0-0H;
        Mon, 24 Jul 2023 14:55:25 +0000
Date:   Mon, 24 Jul 2023 07:55:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2] btrfs: zoned: do not zone finish data relocation
 block group
Message-ID: <ZL6Q3Udz4vdbgEY+@infradead.org>
References: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a57f943e28a5bd86cddcf9d0839b124880f2f6c7.1689924624.git.naohiro.aota@wdc.com>
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

Not an expert on the area, but with the new commit log I can at
least understand and verify the logic.  So a very cautious:

Reviewed-by: Christoph Hellwig <hch@lst.de>
