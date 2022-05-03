Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E58F5187DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 17:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiECPJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 11:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiECPJw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 11:09:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8DF37A8D
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UI5jIB8Yj/fBrhxAmwaevGHb7oM2XWQwknxwUM26WbE=; b=g2cMXQJ2W0dQMrYbniIR9bj/Fm
        6s//7KX0IcjQrSIb48WWpH4YmyTSpD7xLOQ4GKVv8CtFLYPKmEUDfev6mdfoSs67BvjQvDs658f7x
        MYNktuMKCubauXjpYNEyKnor8/qXiYh7xr/MYwYVVLRmax5Znlhjo0nJ8LmVPSC0qwNrLytKDNr8L
        JNMEmuBQGu4tKYmB0U0KHcc0kYfUeHFi0pery2g8fXqNitYC6cDs04hqKgVyyBsij0ocKs5XmvrRf
        hf+c5Th5UIYSFbeRVYrUSNLT8D5zIjo6vZiVvDnLdbHmHaXRIN/KyfXimZBXXyeHQp319fQD9UEQ/
        CyWByE7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlu6V-006PAs-J3; Tue, 03 May 2022 15:06:19 +0000
Date:   Tue, 3 May 2022 08:06:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <YnFE62oGR5C/8UN2@infradead.org>
References: <cover.1651559986.git.wqu@suse.com>
 <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
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

On Tue, May 03, 2022 at 02:49:49PM +0800, Qu Wenruo wrote:
> - For the extra bitmaps
>   We use btrfs_bio::read_repair_{cur|prev}_bitmap.
>   This will add extra 16 bytes to btrfs_bio.
> 
>   This is unavoidable, or we need to allocate extra memory at endio
>   function which can be dead lock prone.
> 
>   Furthermore, pre-allocating bitmap has a hidden benefit, if we're
>   submitting a large read and failed to allocated enough memory for
>   bitmap, we fail the bio, and VFS layer will automatically retry
>   with smaller read range, giving us a higher chance to succeed in
>   next try.

This is a really bad idea.  Now every read needs to pay the quite
large price for corner case of a read repair.  As I mentioned last time
I think a mempool with a few entries that any read repair can dip into
is a much better choice here.
