Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3341CC1F7
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEIN7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 09:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726942AbgEIN7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 09:59:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37059C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  9 May 2020 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jlsd1RU8Rv807WHz42h2pIi4EP4s09WYUVAs1sizdpo=; b=d9zRGmw8i5EAKcCbKYtr0mWSoi
        ZBAiRbrutOHtyYxYhMrF/A7NG5Zu86S7gU1raMI1foi9URjywpBuDLlGi5mbFHcNsxS/ULIj+ywXg
        JuJvoK0OYKZKycGx0YOcq8bCxYxtwnkX/HvsGAydf0am8bhXC2W8tO4Ao8GIIThq1ghGMzfup+4OE
        4/BaQtqxtR2NTPRBlLIlmdYHn2qKEcJdOfswa1Vi+3N8FIVkWAuPkaib0WFPLRK8UWVVlnppT/et7
        +xClbqEKaiJFDhPSauhL4h1DpUF1cyzuz+8hL7Gv5IZpVJ4rUahSnroMfbKB9uN2FD8jyQOmWC0k7
        9c+uSH7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXQ0Y-0006Iz-4a; Sat, 09 May 2020 13:59:14 +0000
Date:   Sat, 9 May 2020 06:59:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200509135914.GA4962@infradead.org>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
 <20200327081024.GA24827@infradead.org>
 <20200327161348.to4upflzczkbbpfo@fiona>
 <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
 <20200508031405.br4dcibcyuoluxum@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508031405.br4dcibcyuoluxum@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 07, 2020 at 10:14:05PM -0500, Goldwyn Rodrigues wrote:
> geenric/475 fails because there are reservations left in the inode's
> block reservations system which are not cleared out. So the system
> triggers WARN_ON() while performing destroy_inode.
> 
> The problem is similar to described in:
> 50745b0a7f46 ("Btrfs: Direct I/O: Fix space accounting")
> 
> To test the theory, I framed an ugly patch of using an extra field
> in current-> task_struct to store a number which carries the reservation
> currently remaining like the patch does and it works. So what we need is
> a way to carry reservation information from btrfs_direct_write() to
> iomap's direct ops ->submit_io() where the reservations are consumed.
> 
> We cannot use a similar solution of using current->journal_info
> because fdatawrite sequence in iomap_dio_rw() uses
> current->journal_info.
> 
> We cannot perform data reservations and release in iomap_begin() and
> iomap_end() for performance and accounting issues.

So just drop "btrfs: Use ->iomap_end() instead of btrfs_dio_data"
from the series and be done with it?
