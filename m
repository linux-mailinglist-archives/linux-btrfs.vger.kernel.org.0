Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2722F6C9A4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 05:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC0Dlu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Mar 2023 23:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjC0Dls (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Mar 2023 23:41:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8624C01
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 20:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ptLXxHakaKD6pP4qZoQzNHjdzwLPfG9dRrpPwSFBto=; b=mtKRrGOOE3WIpefxNcvhVeMcm4
        qpK+HD7AN1aHeQyDNbrEqC20XV9eS8KUEy1tVT6PHZ5MJFHgX37NO4L9YIEwrKp45cbO37YR15L2w
        YNZF1iCjRYaNVPhFqgU5t07Y6qzeR6GM0tnOZgdKiWJoMz4AEPkBWBYth8lRTHmltoI2pfvl8XQSI
        4cmZx3UAGjdAQeQlm5AJiVtzlA616aTf9kKYnUAellgbipvBumtPogYVBNNFgHzzPxmkaliKYlGHz
        HW2oB9GCvvHDQr2BgXi9R5RvKe8iPCGtCj7Ibp4t2kaQyOu1S1MPkEQf/9XwuKDwY7rqKnqITXVoh
        6SKhE+BA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgdjv-009gIU-38;
        Mon, 27 Mar 2023 03:41:47 +0000
Date:   Sun, 26 Mar 2023 20:41:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 02/13] btrfs: introduce a new allocator for scrub
 specific btrfs_bio
Message-ID: <ZCEQe45AMjOkjyxy@infradead.org>
References: <cover.1679826088.git.wqu@suse.com>
 <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1679826088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1679826088.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'd still prefer to just change the btrfs_bio_init / btrfs_bio_alloc
prototype changes we discussed.  But if we need to rush this series
in I can fix it up later.
