Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007975F991
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGXONS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjGXONN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:13:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8CE63;
        Mon, 24 Jul 2023 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QoHRL+6O1bo6UL+IKJkBEoaL8Gbkrd8gM20QpXwI87A=; b=jsJjwvTtwgfDcdXecB/V55ehE8
        +21aNMeFv3JRE0pCREAjc0ZcdF+iuRwcVF6URVeBgyqryvnJxkJYbpWsRfyeIbXleSzZe4nwPZ9Sr
        6NSXnbYIJmI4FS7eEnGuAS49QyRoEL2Ao1WWxLLI+FJ3J4Ef5AgA5/7Yw+sTu0f1oOKn41wWOjEQk
        3McuXSP8zhKdnvePYNa+obkF5DemKvZZbAboFVQQAv30SKSLHopj2NjFHt/j2qa2NoMUWwJIo9wld
        Q6bazMui+hPU33QncNu1P0l1+KhDbv0zCcILc2zB9CVyd++Vy28tOi1fLoWo0LZGrPzjQ2NNCJHDA
        APkjb6ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwJ4-004ZP9-3A;
        Mon, 24 Jul 2023 14:13:02 +0000
Date:   Mon, 24 Jul 2023 07:13:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unused pages_processed variable
Message-ID: <ZL6G7srtjU4IAmVh@infradead.org>
References: <20230724121934.1406807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724121934.1406807-1-arnd@kernel.org>
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

On Mon, Jul 24, 2023 at 02:19:15PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The only user of pages_processed was removed, so it's now a local write-only
> variable that can be eliminated as well:

Hmm, I thought I had fixed this up, but obviously that version didn't
end up in for-next, probably due to a faul on my side..

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

