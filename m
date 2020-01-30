Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5AA14DC33
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 14:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgA3NnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 08:43:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbgA3NnL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 08:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=chKeSS29fWQvQj8LeMAcDzI+vQkwvo8p6dhHjzDVSbA=; b=tMqT4ZUBTm4g9DB9tJpGSedDRl
        5N5/1UQPdXKVMwXPo4mwQw6GUD6aR32D5uw+RklNT4rEdGGK88Sv4nLqxL21HQCcnZvjIL5M2KRXH
        yUHhyIeCdqvJgd0OR/LzqUEc1jFZZ6HZxls77dh1nAYET+F7yqY9ljxay+pyvziXJcyU1PTd4l6m3
        NSxcAhCBe7FOOPLpwkgG83NwvT/w7WwKZPqeu94Q90LXESvuYASrhJRnIzw/meJ/Qfen7qQyMp0Jj
        Gs7du6gfhmuC0hhrCrDU92dacgqaApYOIwjKPNHTffFqA3u6JAcyytpfFj2j99usgukFV6QnwJkEs
        reBFtHCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixA6A-0007qH-LL; Thu, 30 Jan 2020 13:43:10 +0000
Date:   Thu, 30 Jan 2020 05:43:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
Message-ID: <20200130134310.GA29879@infradead.org>
References: <20200130125945.7383-1-nborisov@suse.com>
 <20200130125945.7383-2-nborisov@suse.com>
 <20200130134115.GB21841@infradead.org>
 <58590063-9d21-a261-03a1-84319727ed94@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58590063-9d21-a261-03a1-84319727ed94@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 03:42:27PM +0200, Nikolay Borisov wrote:
> 
> 
> On 30.01.20 г. 15:41 ч., Christoph Hellwig wrote:
> > On Thu, Jan 30, 2020 at 02:59:41PM +0200, Nikolay Borisov wrote:
> >> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> >> to have multiple readers or multiple writers but not multiple readers
> >> and writers holding it concurrently. The code is factored out from
> >> the existing open-coded locking scheme used to exclude pending
> >> snapshots from nocow writers and vice-versa. Current implementation
> >> actually favors Readers (that is snapshot creaters) to writers (nocow
> >> writers of the filesystem).
> > 
> > Any reason not to move it to lib/ under a new option so that other
> > users could reuse it as needed?
> > 
> 
> Yes, I think it's rather specific to btrfs. I don't care honestly if
> there is demand I wouldn't mind.

Ok, just keep it in btrfs for now, we can always move it later.
It just looks like very generic code.
