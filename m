Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0B41F9860
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 15:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgFON0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730058AbgFON0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 09:26:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDEDC061A0E;
        Mon, 15 Jun 2020 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ksyETq/TLH9AuQNxtfQV+6S3Mb7fK99JQIayoY8bWbY=; b=qGfsSHiNyPTDCAXdQglvTSpwTa
        WvQvaz0qyd+Yy1bKZc5qzVtqRvghyALrT73YoNRo0ytUuCTwv933jNdC6IUJAnNxA3TVFvgE9/w/j
        ifFRrmBV6w+lcrs8yIPRVE4F6CdvWjG38ZkkO0iAVq2gAtjChbTEQwq2DUIq5zf9kmQwAtqzuNPTP
        Kl2KtSW7dhBp29DjA6RLF3ND4wZpHMMMGVX1vxhtEaz0DPGO7bITH7PL8MQq4hJv8pEeU1hkgtvV3
        IsVm5AVysAYB3YfzFN4XAqQRahLYoFjhkego4zaAuMKydQwHcD84iA4eFIZEgg7uaF7Udw2JQfpyp
        pCOD5wFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp8C-0001V3-21; Mon, 15 Jun 2020 13:26:32 +0000
Date:   Mon, 15 Jun 2020 06:26:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.8, part 2
Message-ID: <20200615132632.GA27848@infradead.org>
References: <cover.1592135316.git.dsterba@suse.com>
 <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
 <20200615125701.GY27795@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615125701.GY27795@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 15, 2020 at 02:57:01PM +0200, David Sterba wrote:
> On Sun, Jun 14, 2020 at 09:50:17AM -0700, Linus Torvalds wrote:
> > On Sun, Jun 14, 2020 at 4:56 AM David Sterba <dsterba@suse.com> wrote:
> > >
> > > Reverts are not great, but under current circumstances I don't see
> > > better options.
> > 
> > Pulled. Are people discussing how to make iomap work for everybody?
> > It's a bit sad if we can't have the major filesystems move away from
> > the old buffer head interfaces to a common more modern one..
> 
> Yes, it's fixable and we definitely want to move to iomap. The direct to
> buffered fallback would fix one of the problems, but this would also
> mean that xfs would start doing that. Such change should be treated more
> like a feature development than a bugfix, imposed by another filesystem,
> and xfs people rightfully complained.

We can trivially key that off a flag at least for 5.8.  I suspect the
fallback actually is the right thing for XFS in the long run for that
particular case.
