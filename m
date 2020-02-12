Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C80115A1F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgBLH1x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:27:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgBLH1x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3UW/bGWQzOr1Gy8yqOxpbUKRETDT3uoXIW6J+WwctV0=; b=RH7VrXwkSZHZ+zCGpwZCC47Ppo
        e7ATrmRY9LoD15Pm0DZjg8JzvDDCU6QVOWHS+qlHQhbHnrWRADcM5WZPGAm9g5qgJW3ChhM5zFQw9
        h2XUhLk/B/hWDBoZeLyIppse9MtMYFbE9ERgIzRtSF7l14l1yE/E8+m4gVbjSu02v0Wedxiq/z0b6
        jcbUN0zGSFVa2hcx58a7cogGwN10RTy9pxVvyMoxjMhxAUIELeJy4gJVtQfic2mx+A3u0HEIpAT1f
        c33v2W1kr00t4U6hVROGZR4SPDSa613of6smyL8WNAE71WjIed/D96BL05BtRHEHB7Vcqh7MJmyHg
        vxUknoXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mR5-0001Jj-PL; Wed, 12 Feb 2020 07:27:51 +0000
Date:   Tue, 11 Feb 2020 23:27:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 3/8] btrfs: unexport btrfs_scratch_superblocks
Message-ID: <20200212072751.GB30977@infradead.org>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-4-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212071704.17505-4-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 04:16:59PM +0900, Johannes Thumshirn wrote:
> btrfs_scratch_superblocks() isn't used anywhere outside volumes.c so
> remove it from the header file and mark it as static.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

It wasn't exported to start with, just global scope while you
mark it static now.
