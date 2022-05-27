Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566C953647A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 17:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353590AbiE0PDM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 11:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353180AbiE0PDL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 11:03:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2704D1207F4;
        Fri, 27 May 2022 08:03:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC8D968AFE; Fri, 27 May 2022 17:03:06 +0200 (CEST)
Date:   Fri, 27 May 2022 17:03:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
Message-ID: <20220527150306.GA1534@lst.de>
References: <20220527081915.2024853-1-hch@lst.de> <20220527081915.2024853-2-hch@lst.de> <20220527145445.fyrp3anncqdxb7sl@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527145445.fyrp3anncqdxb7sl@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 27, 2022 at 10:54:45PM +0800, Zorro Lang wrote:
> You can send a single fixed patch for this one

I could do that, but I also need to fix up the comments in 266 and 267
to say 64k instead of 4k.
