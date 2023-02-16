Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A585A698C7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 06:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBPF66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 00:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBPF64 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 00:58:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E7457D5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 21:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUNpmDCl2ebHtEWFsoIBnrIsADn2VYmCLiQCYe75r3A=; b=4WvuOaYotnlsAqbAmCFqIfMO/1
        BZwn04IZwu07M4uycMojGwfb8qN6q81xeGDft0+m5tdY/3PfIXcwuxR7Mx9RSL+EjuqIIO4FQzMrL
        uXTE7qzp+9XN2NRmYR6/jrxyoSr23g0DD7oNUwcZCQ0RmE4S5faKi5qM5XnuYzB8JE7AQ5xx1rg0o
        r++bgxhTURhEU2FMd2udHmBgqDOJu2pX0RITJVf/p1M7d8yljwuA8jymzhMZPYCpQ9WwBBjdzRgih
        QR9piJXf21+iGr2Q0B9868CS9Ok/KAko8C3pi1nI8FhthpQW6+5nRfc9o6pQ6ywhejvAQJoYYFkjN
        sUzBVMWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXIE-008dPM-Vn; Thu, 16 Feb 2023 05:58:54 +0000
Date:   Wed, 15 Feb 2023 21:58:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+3GHkKkytelqo3P@infradead.org>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
 <Y+2LCFrD4Qxff89Y@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+2LCFrD4Qxff89Y@zen>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 05:46:48PM -0800, Boris Burkov wrote:
> The following patch causes the problem to stop reproducing by splitting
> the large ordered extent in the case of a short write and leaving it
> alone otherwise. I haven't thoroughly tested it, or even thought it
> through that well yet (e.g. I have no clue where that extract function
> comes from!), but it's a start. I have to sign off for the evening, so
> I will leave my investigation here for now.

The extract version if used for writes to zoned devices, which need
to record a physical location on a per-write basis.  So what you done
definitively works, as we already do it a little later for a subset of
writes.

I also think it fundamentally is the right thing to do and was planning
to do something similar for completely different reasons a little down
the road.

The downside right now is that you pay the price of an extra ordered
extent lookup for every submitted bio, and that an extra queue_work is
required for the completion.  In my WIP work the former will eventually
go away, and I've not found any benchmark impact from the latter.
