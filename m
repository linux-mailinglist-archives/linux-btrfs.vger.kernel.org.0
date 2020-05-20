Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2314F1DAA63
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETGLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 02:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGLz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 02:11:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE283C061A0E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TloY3Zt+aAlZRXk3d8qYGL/3HjqaB74ylqrhxyxqiTY=; b=Tz4Krj4QGLoXr1B77gMugCWvF6
        Xc2sjWUth+pyfdQKBbXJP0O/Bi9cptwr3G3YQbvh2jOikjQJh9sRyIeyuLztfJMLfin4SDReVNCuQ
        zu0OX7F98camhFmbXquCs2iZsoXQ/7wz7/cBj27BS+2fFGk2eghqDbio4YWLysnFpwADvmpP5hy4s
        iLf3tdDqURoV9V9bLKDLrgzlf8w8lZJCTqqZxja7SKsO12b9drWl7L7wIDp+tTT3N7nvim3lydu6p
        /bRn1Rh9KGd8FOeDsy1CPNlUBlVsxY6X/BnEQwAF2vAyh7RQNxQWUZIjb84qV6q0bgkExhKWjEMYF
        kE2Urknw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbHxG-0004jP-Ec; Wed, 20 May 2020 06:11:50 +0000
Date:   Tue, 19 May 2020 23:11:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200520061150.GA9695@infradead.org>
References: <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
 <20200508031405.br4dcibcyuoluxum@fiona>
 <20200509135914.GA4962@infradead.org>
 <20200510040601.bub3du7g5kepeakw@fiona>
 <20200512145807.GA23409@infradead.org>
 <20200512171927.tk46sbriqvhasvsq@fiona>
 <20200515141305.GA27936@infradead.org>
 <20200519201116.6qyoaxc7g2krxzzx@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201116.6qyoaxc7g2krxzzx@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 19, 2020 at 03:11:16PM -0500, Goldwyn Rodrigues wrote:
> I finally managed to fix the reservation issue and the final tree based
> on Dave's for-next is at:
> https://github.com/goldwynr/linux/tree/dio-merge
> 
> I will test it thoroughly and send another patchset.
> I will still need that iomap->private!

FYI, the reason why I killed ->private is that:

 - it turns out the current pointer one is not used at all
 - the integer one as used in your patch set is maybe a bit cleaner
   handled by a counter maintained in the aio code, as in the version
   of the submit hook patch in my tree.

No a biggie, and we can sort that out later.
