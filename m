Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDC576C98E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 11:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjHBJgB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 05:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHBJf7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 05:35:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F7F19A
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 02:35:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B79836732D; Wed,  2 Aug 2023 11:35:55 +0200 (CEST)
Date:   Wed, 2 Aug 2023 11:35:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, josef@toxicpanda.com
Subject: Re: [PATCH v2] Btrfs: only subtract from len_to_oe_boundary when
 it is tracking an extent
Message-ID: <20230802093555.GA28141@lst.de>
References: <20230801162828.1396380-1-clm@fb.com> <20230801164242.GA13927@lst.de> <1a01a6ad-5374-a9f6-ee69-df78cae87428@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a01a6ad-5374-a9f6-ee69-df78cae87428@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 01, 2023 at 01:29:51PM -0400, Chris Mason wrote:
> The actual max extent size is limited to one chunk, which right now is
> max 10G and then we round down for various reasons.

Ok.

> For writes, I didn't actually audit the way we're setting
> len_to_oe_boundary vs U32_MAX.  BTRFS_MAX_EXTENT_SIZE should save us
> from any single wild extents.

At leasr in older kernels U32_MAX is the default as we're only
looking up the ordered extent for zoned writes.  This is changing
right now, though.

> Yeah, I'm just using (len_to_oe_boundary == U32_MAX) as the explicit
> flag, but your idea above is basically where I started.  I actually
> started at len_to_oe_boundary = ROUND_DOWN(U32_MAX, PAGE_SIZE), but then
> I realized I'd have to actually think about sub-page blocksizes and went
> to the flag idea.
> 
> Especially since the code is going away, I'd prefer a minimal change and
> a big comment, but I don't actually have strong opinions.

Ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>
