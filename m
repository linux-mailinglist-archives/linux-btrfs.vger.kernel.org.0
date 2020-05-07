Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB181C824D
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgEGGOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 02:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGGOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 02:14:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F43C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 23:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zltrTeGujhb7a9QnVzfgLb9hLo7KrfvU55P1x4c0EXY=; b=jqD/y7OYr34A7hiKMmyXXwf95w
        mNmdjhrWG3VYLiO9A1qUAz2K3DCVpzJX3oouLokdgrbcW8gSuaSEUTwXUIcgHqQ4sVsjwP5uQw2rM
        GJTkG0jwgd9+TB/yXz2U2e9TZxt45gjN2NBo8eRtYcSeL9BMYKnb2P2dpfF9t+ytPuFd+8TmrP548
        BjeTUIC+bln7HFOxq3JYVfICLLMmj5Gb5gu6WunonDQiVBsiQy1aWTsSh47RLDZ2Z8CFXoF6Swb6Z
        iSpJ65xXPLS3x+5Wf/h2xSmZb42GTn2zhN5ueW+E5Vu5iWgPeyKBd9zb4Rs1LYy2XJEuQeol90znk
        CuQUVW5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWZni-0002e4-1g; Thu, 07 May 2020 06:14:31 +0000
Date:   Wed, 6 May 2020 23:14:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200507061430.GA8939@infradead.org>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
 <20200327081024.GA24827@infradead.org>
 <20200327161348.to4upflzczkbbpfo@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327161348.to4upflzczkbbpfo@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

What is the status of this series?  I haven't really seen it posted
any time recently, and it would be sad to miss 5.8..
