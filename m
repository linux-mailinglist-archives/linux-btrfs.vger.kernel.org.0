Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5349B383D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 07:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfFGFoN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 01:44:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49162 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfFGFoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jun 2019 01:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FhEEcMcR2jAVllW++W9tBLdo7QnhO0RygKH5md+XfdI=; b=ne1l66gyBbTMvX7V2LMgMXi7E
        qdX7P6G+1EM1tNbhEzjkV7lu7JdUTjUO2SjTH/44d0H+PvtpECsg/2efyp5LzujXn3B/gUq16JCZ1
        9Qt3AA7trjemJlwkkTPJRNbkq4yNvNta6wDRT4KFZn/96NNiPg/TbGvZ3PzMMMxnmAnQxAHVf2AtD
        eEvHu8sMci62CdhW2YJg3GRJiXahd4Tg2Ha+ta3dg4ZVtEk19bKBv0wSakXYgdii5rg89X+tpMD89
        giXyiDv9oJlhisYA6VaASifuRYddqm5rKM2k66H/mMDtWJMHp7E2wtXru2E6rLKTwa1hhssr3vhLo
        Zk3o8ChMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZ7fg-0003xw-PF; Fri, 07 Jun 2019 05:44:12 +0000
Date:   Thu, 6 Jun 2019 22:44:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/260: Make it handle btrfs more
 gracefully
Message-ID: <20190607054412.GA15161@infradead.org>
References: <20190603064009.9891-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603064009.9891-1-wqu@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 03, 2019 at 02:40:09PM +0800, Qu Wenruo wrote:
> If a filesystem doesn't map its logical address space (normally the
> bytenr/blocknr returned by fiemap) directly to its devices(s), the
> following assumptions used in the test case is no longer true:
> - trim range start beyond the end of fs should fail
> - trim range start beyond the end of fs with len set should fail

All these assumptions seem generally bogus.  I don't think we can just
run this as a generic test.
