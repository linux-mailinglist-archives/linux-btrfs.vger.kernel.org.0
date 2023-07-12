Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4474FF92
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjGLGon (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjGLGoj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:44:39 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E7199E
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:44:37 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id A5BDE80600;
        Wed, 12 Jul 2023 02:44:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1689144276; bh=oZ/K7QDrkJ6S8R6jI5UMblcvegn7YCZUrGNMZe/b/ss=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TZiJnGi+He301xWic8vN+WCAzIgyi9398yDskI4eepUx1tzvkWZKPjoOWuG7rZISn
         GCRi7wxUSqrv1fW5Lej/yRCCa8d3f5hdGFp3Vck4TkUnSx1ld+HczXUhevp4EPTo0t
         yOrE2Y+z1M+QbKFwljxWgAij4jJDenyl/Vn52ATQZZdFxMbKabYamQ3aTPrWFUOB7Y
         vVYNzSoy8PuoHHl5Bio48q6FYERADfv1i02qCRnlobrAmrvSuQVxdZk9DGhiG8tFdi
         5IHwJyKVhtCx1++UtqRz8HLtFT8X9STT9SIgXNs2+jnDHpMJPIv7RWYIriwVY4Nq8k
         rqmhE1mgeSCnw==
Message-ID: <08162144-5747-23ec-63d9-a99541fd4348@dorminy.me>
Date:   Wed, 12 Jul 2023 02:44:35 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1689143654.git.wqu@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1689143654.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/12/23 02:37, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Define write_extent_buffer_fsid/chunk_tree_uuid() as inline helpers
> 
> [BACKGROUND]
> 
> Recently I'm checking on the feasibility on converting metadata handling
> to go a folio based solution.
> 
> The best part of using a single folio for metadata is, we can get rid of
> the complexity of cross-page handling, everything would be just a single
> memory operation on a continuous memory range.
> 
> [PITFALLS]
> 
> One of the biggest problem for metadata folio conversion is, we still
> need the current page based solution (or folios with order 0) as a
> fallback solution when we can not get a high order folio.
> 
> In that case, there would be a hell to handle the four different
> combinations (folio/folio, folio/page, page/folio, page/page) for extent
> buffer helpers involving two extent buffers.
> 
> Although there are some new ideas on how to handle metadata memory (e.g.
> go full vmallocated memory), reducing the open-coded memory handling for
> metadata should always be a good start point.
> 
> [OBJECTIVE]
> 
> So this patchset is the preparation to reduce direct page operations for
> metadata.
> 
> The patchset would do this mostly by concentrating the operations to use
> the common helper, write_extent_buffer() and read_extent_buffer().
> 
> For bitmap operations it's much complex, thus this patchset refactor it
> completely to go a 3 part solution:
> 
> - Handle the first byte
> - Handle the byte aligned ranges
> - Handle the last byte
> 
> This needs more complex testing (which I failed several times during
> development) to prevent regression.
> 
> Finally there is only one function which can not be properly migrated,
> memmove_extent_buffer(), which has to use memmove() calls, thus must go
> per-page mapping handling.
> 
> Thankfully if we go folio in the end, the folio based handling would
> just be a single memmove(), thus it won't be too much burden.
> 
> 
> Qu Wenruo (6):
>    btrfs: tests: enhance extent buffer bitmap tests
>    btrfs: refactor extent buffer bitmaps operations
>    btrfs: use write_extent_buffer() to implement
>      write_extent_buffer_*id()
>    btrfs: refactor memcpy_extent_buffer()
>    btrfs: refactor copy_extent_buffer_full()
>    btrfs: call copy_extent_buffer_full() inside
>      btrfs_clone_extent_buffer()
> 
>   fs/btrfs/extent_io.c             | 224 +++++++++++++------------------
>   fs/btrfs/extent_io.h             |  19 ++-
>   fs/btrfs/tests/extent-io-tests.c | 161 ++++++++++++++--------
>   3 files changed, 215 insertions(+), 189 deletions(-)
> 

For the series:
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
