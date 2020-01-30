Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC114DC22
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 14:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgA3NlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 08:41:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgA3NlQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 08:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RPBh3XRtOkSXaPiK72uoryO8PEMiMu1MhYdSwyS0NoI=; b=iajJAzQMcSVbvkMAMmnLA6OqN
        vS6oSyj6az9V4QS5vmflZEwrJ2ddWPp0O1+cWzJqWtmXvFvYHPYadirnAUsaILxEe7fO6TcjFCcvJ
        zPZP8lY0yJwFtvs/Z1mvtx0vjq0WrYUpWjkTd9sUukGsmyeausIxTxloRklV8eAXtV/pCjnIFRws9
        o+PL6geDcWKePLASHpMF7cDH7JBYULumCvzf2P/ozH12JOU6j0NRRV8QrmOmaJ85oHrNVahP7Wif/
        v+1OO5RVBgPjvEzDmFcY+/ppZaDNrSs6wASOPWivsOv6c/eH6gQPbrjzxC4r/FVWxDmSXVAOzDe7k
        vYq/O7bUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixA4J-0007fu-Ln; Thu, 30 Jan 2020 13:41:15 +0000
Date:   Thu, 30 Jan 2020 05:41:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Implement DRW lock
Message-ID: <20200130134115.GB21841@infradead.org>
References: <20200130125945.7383-1-nborisov@suse.com>
 <20200130125945.7383-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130125945.7383-2-nborisov@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 02:59:41PM +0200, Nikolay Borisov wrote:
> A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
> to have multiple readers or multiple writers but not multiple readers
> and writers holding it concurrently. The code is factored out from
> the existing open-coded locking scheme used to exclude pending
> snapshots from nocow writers and vice-versa. Current implementation
> actually favors Readers (that is snapshot creaters) to writers (nocow
> writers of the filesystem).

Any reason not to move it to lib/ under a new option so that other
users could reuse it as needed?
