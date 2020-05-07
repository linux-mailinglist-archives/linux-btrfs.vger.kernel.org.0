Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D5A1C8A25
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 14:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGMKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGMKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 08:10:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D2EC05BD43
        for <linux-btrfs@vger.kernel.org>; Thu,  7 May 2020 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y0SL+tPZQSBPs5BEpfENU+Ai38sjODNR+CuZa3ybE4k=; b=BR+pqx25g77aBDsahr9NzgX8sJ
        lPb0asieANT8kQysHZMy0V04VpFkgEqrRmtN4PNg2ncovEITFQOlaY/jfIzb82OtN+aXAc8XKMZg8
        wHm4JH8lJdKhLaHfgRVgsUewpFea8YSu88RabBZGxD1pyvTq8JwDNHDJRqKJM6Koouqf5V4xQLOsu
        yCf/f6300Em/7A/bt3LtBh/nZRD3hdSUYwiTfs/EC6dab+5ZkZBKSCqvoLvo+XwZud1yp0sKJ4y2y
        8HRYVsCwJXXmsLfEEI+1dE6DWGLXt20yI3bebBh1pw8XiqfAGAspufi/BZ6HNeoW0tzKl41Edxv+O
        K1yVBGPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWfML-0000Iz-V0; Thu, 07 May 2020 12:10:37 +0000
Date:   Thu, 7 May 2020 05:10:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200507121037.GA25363@infradead.org>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
 <20200327081024.GA24827@infradead.org>
 <20200327161348.to4upflzczkbbpfo@fiona>
 <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507113741.GJ18421@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 07, 2020 at 01:37:41PM +0200, David Sterba wrote:
> On Wed, May 06, 2020 at 11:14:30PM -0700, Christoph Hellwig wrote:
> > What is the status of this series?  I haven't really seen it posted
> > any time recently, and it would be sad to miss 5.8..
> 
> I've been testing it and reporting to Goldwyn, but there are still
> problems that don't seem to be fixable for 5.8 target.

What are the issues, and how can we help to resolve them?
