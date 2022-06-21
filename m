Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F2552B16
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345490AbiFUGkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUGkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:40:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6918B23
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:40:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1996A68AA6; Tue, 21 Jun 2022 08:40:11 +0200 (CEST)
Date:   Tue, 21 Jun 2022 08:40:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
Message-ID: <20220621064010.GA893@lst.de>
References: <20220621062627.2637632-1-hch@lst.de> <221407c5-0aec-6ab0-4f7f-e74a5873e4e0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221407c5-0aec-6ab0-4f7f-e74a5873e4e0@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 02:35:55PM +0800, Qu Wenruo wrote:
> In fact, one bio vector can point to multiple pages, as its bv_len can
> be larger than PAGE_SIZE.

Yes, it can.  But it usually doesn't, as that requires contigous memory.
Without the large folio support now merges for xfs/iomap that is very
unusual and tends to happen only soon after booting.  At which point
allocating the larger csums array is also not a problem as we can
find contigous memory for that easily as well.  For direct I/O on the
other hand the destination could be THPs or hugetlbs even when memory
is badly fragmented.
