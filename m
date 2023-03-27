Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804036C9A53
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Mar 2023 05:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjC0Doa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Mar 2023 23:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjC0Do3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Mar 2023 23:44:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FDA3C31
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Mar 2023 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+gCj4J2QCgEaOdwNj3wtbfsOqjYcesSqggxwwDbbyeQ=; b=fXRDojyakwmGFKhi8Q7jmX8rFf
        ez1P4CQeiAJ2EItQ1htsmEExpDdp9xOP2O2H7lRdwIThMLUx5WVayJDmEBvClQZU+Cnu3BS/kx8CX
        J01WfJACPgUf98YXk4n9ZYlugseUMbYP7uBOnFVdyt7euwe5RzSt6TozIgtTJJWoPPr9KW8QGIEmS
        MdKGaysusVPXtygcKhogK0R4G1cIgP1zFmP7h+yCpS1hiO8TUecixt4BV1D+zwgGyaCVYV9oxvp2Y
        GYmNmbNGzL+dXaKu+7GDjBjrnWzYT4PWa1k0bbH66gHNcQVdhYliSxtpxW7dM4Zp8vFDtauV6maNQ
        a3VKHJcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgdmW-009gPT-03;
        Mon, 27 Mar 2023 03:44:28 +0000
Date:   Sun, 26 Mar 2023 20:44:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 04/13] btrfs: introduce a new helper to submit write
 bio for scrub
Message-ID: <ZCERG/+o6515r06h@infradead.org>
References: <cover.1679826088.git.wqu@suse.com>
 <72f4fa26c35f2e649bc562a80a40955d745f1118.1679826088.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72f4fa26c35f2e649bc562a80a40955d745f1118.1679826088.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 26, 2023 at 07:06:33PM +0800, Qu Wenruo wrote:
> +	/* Caller should ensure the @bbio doesn't cross stripe boundary. */
> +	ASSERT(map_length >= length);
> +	if (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE && btrfs_is_zoned(fs_info)) {
> +		bbio->bio.bi_opf &= ~REQ_OP_WRITE;
> +		bbio->bio.bi_opf |= REQ_OP_ZONE_APPEND;
> +	}

Not crossing the stripe boundary is not enough, for zone append it
also must not cross the zone append limit, which (at least in theory)
can be arbitrarily small.

> +	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> +		int data_stripes = (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5) ?
> +				    bioc->num_stripes - 1 : bioc->num_stripes - 2;

This calculation feels like it should be in a well document simple
helper.

> +		smap.physical = bioc->stripes[i].physical +
> +				((logical - bioc->full_stripe_logical) &
> +				 BTRFS_STRIPE_LEN_MASK);

This calculation feels like another candidate for a self contained
a well documented helper.


> +		goto submit;
> +	}
> +	ASSERT(mirror_num <= bioc->num_stripes);
> +	smap.dev = bioc->stripes[mirror_num - 1].dev;
> +	smap.physical = bioc->stripes[mirror_num - 1].physical;
> +submit:

Why no else instead of the goto here?  That would read a lot easier.
