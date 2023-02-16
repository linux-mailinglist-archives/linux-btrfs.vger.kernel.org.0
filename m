Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C4699CA1
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 19:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBPSt2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 13:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBPSt1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 13:49:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AE83B222
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 10:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ijl42fP8RYVvoifRh+kGXlsg2j+7VgEORZxdms5nVJQ=; b=GkLVazNOFx43ecetbPqBQz5zfQ
        61WL2jv6bzKdzNZsH5jTHLlZ8Lh/t4yCYAh3bILLujpsDT4A2LXE9ABG5+ClnSWtZ2SXGHd+8bMQM
        sQpp157dtOjiGIvp/VUHhyu238SlzKiUrMDO2N9V1qhwu6PcQHCVeswUfJWmRTFjplrEsf9Ml/j9Q
        csWrd2dSwDtSSU8F1ovWSPEkGxCbpeGAO7jcHjhRAzbKVURW4SED9CKtWC1tpUl9MIuJXxo1J8S47
        X9bgXDgZBuBwnmGoOtrS7Boy3aTQ6IdAeSMpOtgWwySdUSsxqz+L7jFSSBuOKLW+oQ1oNP/0pzyj3
        /0zqSppQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSjJo-00BZr8-DB; Thu, 16 Feb 2023 18:49:20 +0000
Date:   Thu, 16 Feb 2023 10:49:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Boris Burkov <boris@bur.io>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+56sPyNHZRVQdnj@infradead.org>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
 <CAL3q7H7n3BG_6B_riK9U=uCO5JKZwefU9DPtmcRZ0W=T+7K0Nw@mail.gmail.com>
 <Y+5kjpZJJxU+vz1X@zen>
 <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4CmQOG6wYBg8Ha0xUJ+QWKEfF8YixJ-DwnJy=fXs9e=Q@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 16, 2023 at 06:00:08PM +0000, Filipe Manana wrote:
> Ok, so the problem is btrfs_dio_iomap_end() detects the submitted
> amount is less than expected, so it marks the ordered extents as not
> up to date, setting the BTRFS_ORDERED_IOERR bit on it.
> That results in having an unexpected hole for the range [8192, 65535],
> and no error returned to btrfs_direct_write().
> 
> My initial thought was to truncate the ordered extent at
> btrfs_dio_iomap_end(), similar to what we do at
> btrfs_invalidate_folio().
> I think that should work, however we would end up with a bookend
> extent (but so does your proposed fix), but I don't see an easy way to
> get around that.

Wouldn't a better way to handle this be to cache the ordered_extent in
the btrfs_dio_data, and just reuse it on the next iteration if present
and covering the range?
