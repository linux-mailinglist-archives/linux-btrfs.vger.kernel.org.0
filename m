Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE72CB683
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 09:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgLBINS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 03:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgLBINS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 03:13:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986AC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 00:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9JOlwhO0SxpVyzY9OWexG1aZUh/MSNbzlUrH57mFsd4=; b=gK+OTGHzGZeJaRbW8BI6lef4pF
        5OI3ZEVRMi/LC3muVHfZDVRlOIZapNaT2mnHlba/n/myhWIAzuDgpuzwTjQYHEHX0SBC1NwQIPT9u
        Ojl9BJVWvakXD8gWbTOvh6J3HteSV+TF849hY4weRWOUTmukbamSt8JJiHag3TJRGxk9sYOAqJcuE
        T9chESgOrwxoHSK9fVAnnem2bFuX+LNlTCuKVySIXCLEIa8jJK+HfXd0Aw2ttBdAznrpnhT3/Nx1G
        JjAm1yamqFu2+anZVOBgu0QTDAa0s04shsf0P9Abn2dP8Wlu3oO05xgqYN0K8kH3bCYbmZK/IHLOZ
        5VJkEIFw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNFc-0004t6-Hj; Wed, 02 Dec 2020 08:12:36 +0000
Date:   Wed, 2 Dec 2020 08:12:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 01/15] btrfs: rename bio_offset of
 extent_submit_bio_start_t to opt_file_offset
Message-ID: <20201202081236.GA18301@infradead.org>
References: <20201202064811.100688-1-wqu@suse.com>
 <20201202064811.100688-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202064811.100688-2-wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 02, 2020 at 02:47:57PM +0800, Qu Wenruo wrote:
> The parameter bio_offset of extent_submit_bio_start_t is very confusing.
> 
> If it's really bio_offset (offset to bio), then it should be u32.
> 
> But in fact, it's only utilized by dio read, and that member is used as
> file offset, which must be u64.
> 
> Rename it to opt_file_offset since the only user uses it as file offset,
> and add comment for who is using it.

I think dio_file_offset might be a better name.
