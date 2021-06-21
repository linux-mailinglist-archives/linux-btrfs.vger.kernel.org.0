Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC903AEC5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFUPbM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhFUPbM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 11:31:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B8C061574;
        Mon, 21 Jun 2021 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BPSqOy9R7ZhzXq2WcgljzsfhNGKk/4xE+MwF10cBkuE=; b=tT8E6A1duztqwtRXVetrHHnkY1
        X44kqRUhp6RC5DQVr2arlQtW/iVdSBpvzDeH3QY2Qur7TMjgdjPph0qWtmgNyORi+x5qReXoUE0el
        UYTphXdthmbv5XpJS5mRikLayzZZGhX9utDJr+8SkdFuDFUh82YKlrFg5zdaFg/S2WnfjiobS4n4g
        aQpxkNDhsHLGIEKSwaYa51cOfOiHln3GUZfECcI5lMVM7qRsbK2nwQcVt//QpjOQq/u7CYZ1SdOJN
        TnBbATaxdujoHjst0+wdNgSCqz5V5NbpFCxgrKL73YkukrZSn+u7H1jP9M++cDWodBXuNBh+xQ24U
        uxE5gp7A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvLqj-00DES8-3r; Mon, 21 Jun 2021 15:28:37 +0000
Date:   Mon, 21 Jun 2021 16:28:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: Please don't waste maintainers' time on your KPI grabbing
 patches (AKA, don't be a KPI jerk)
Message-ID: <YNCwIe33OOW9rxPU@infradead.org>
References: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78add0a-8211-86c3-7032-6d851c30f614@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

WTF is KPI?
