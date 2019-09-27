Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5FC09F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfI0REA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 13:04:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42614 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0REA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 13:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=luT26GNTxTUcZdeTlT1m/AHRsli9wUHXALpOV0Apv2k=; b=DQm/Zr2wfsQpHRPpym7jj0mFj
        tLHhJaLTcRiIgJT0kHBD9TV04EptGBVVLSPvEkuCAlirvBZ2pkjAWWHe+R1cIRiPYJhHB1LESXmFF
        GoZdEnhSy/6q3IMtULWJibWOkyC8O7QCllkPj4Yn85zee6ppkEoIy3BbxSqsEt804Unl4DJKZmmhx
        vVIn/qUksiP0/YDUT8TC9cHLe2E+WOuOhUDisdxt/TR2ulu9mx6N4e9MaL4RGEtPUZQ8jSaMpAPig
        Jj+cMXi6MBlZaff6rDlPEge7LT1/3/7THzWudWSs2MuBJcA+JoLbNcwne4gAP3ZvgK5ycY0xegDyW
        JXzd7rc9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDtex-0003hV-KN; Fri, 27 Sep 2019 17:03:59 +0000
Date:   Fri, 27 Sep 2019 10:03:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs llseek improvement, take 2
Message-ID: <20190927170359.GA13963@infradead.org>
References: <20190927102318.12830-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927102318.12830-1-nborisov@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 01:23:15PM +0300, Nikolay Borisov wrote:
> Here is v2 of the llseek improvements, main changes are: 

Btw, with Goldwyn looking into btrfs iomap support wouldn't it make
sense to try to reuse the iomap lseek code?
