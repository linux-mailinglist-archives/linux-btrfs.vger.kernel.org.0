Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B45339E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiEYJ06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 05:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiEYJ04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 05:26:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0E7B9C1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Nl8nhcN7CkhuQSEhJeJBuqim9EKg5sfFVPS38DnRoNU=; b=IYPJ6yMKOsaXt4Q4g8NhKi5qBG
        NskIKsMyD32eXjh07fuIodt5WKXSaMS9V9SJ9eIgvwFJaBhPGFOUp9OpGmLHUXHl/iWQJdjta/IoY
        rquAk5VC0XPCLMHtSj45gOnbcrReV0M2NprLHkJ+CMw3L0CidwZNSrD9j/87n6euICM8SiQoPcE2i
        avoRGLWvxddKwEqzZBrXx96tI1eAt2oM7th3eUl4Fqo2c1WaaGt8m1eEz29J4j8buYgLYOEQwTH8m
        zlLjf+cNx6PieUr29p3nQMRdacdHP3W/vsUsG+V8FFQhtSkhavz3eAp2LaESmYvPESEGe7EQ/0TVw
        EC4cz1qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntnHx-00Aa6A-Vh; Wed, 25 May 2022 09:26:46 +0000
Date:   Wed, 25 May 2022 02:26:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <Yo32VXWO81PlccWH@infradead.org>
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz>
 <Yo3wRJO/h+Cx47bw@infradead.org>
 <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 25, 2022 at 05:13:11PM +0800, Qu Wenruo wrote:
> The problem is, we can have partial write for RAID56, no matter if we
> use NODATACOW or not.
> 
> For example, we have a very typical 3 disks RAID5:
> 
> 	0	32K	64K
> Disk 1  |DDDDDDD|       |
> Disk 2  |ddddddd|ddddddd|
> Disk 3  |PPPPPPP|PPPPPPP|
> 
> 
> D = old data, it's there for a while.
> d = new data, we want to write.

Oh.  I keep forgetting that the striping is entirely on the physіcal
block basis and not logic block basis.  Which makes the whole idea
of btrfs integrated raid5/6 not all that useful compared to just using
mdraid :(
