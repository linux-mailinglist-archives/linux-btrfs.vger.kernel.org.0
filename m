Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9E51A1C6
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 16:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbiEDOKG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351112AbiEDOKE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 10:10:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95603419B3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8yycturX+ezYpYXgrtCCEHlbk0WNglLG7ovQulESDNM=; b=n8Yn8Z/Fpzyg37dh4VZyl+2BdC
        w5cY2JTuxZN2CpvAVlJaBCn4TyKhZD8RsScvJ7Xrhv4xsNc1EqBHX6sHVuuRdYwkxzuEApyU9CuRW
        csqZHRmBUfVNQRcZPDhoggRckM0QKQwOp09zdKnQfCXQqHfwGywvBII4TQr87Y0DRKGsF4j4L1314
        8bi+IDSE7MgoLuqzREmKQZoqwjlBOo4co/7tAcHR6Xz/5LCJt2CK/RbqToY+jJvGVltxiRKdIhISt
        EMGxnoAHELJ1bBsO3mxnMuYxvAzYZBh9qNvdQX5108k034Wh0mTTX8+HXVvwTqZz2f79+/+bJq9qy
        Q1psyw9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmFe0-00BDU5-TS; Wed, 04 May 2022 14:06:20 +0000
Date:   Wed, 4 May 2022 07:06:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/13] btrfs: add a helper to queue a corrupted sector
 for read repair
Message-ID: <YnKIXKqBpa7gU/DO@infradead.org>
References: <cover.1651559986.git.wqu@suse.com>
 <2cfd9d2766824ddce727b06068de24d7a4be9637.1651559986.git.wqu@suse.com>
 <YnFFJGbbs4+MgKY1@infradead.org>
 <22700bdb-7606-a00a-5075-574966737793@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22700bdb-7606-a00a-5075-574966737793@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 04, 2022 at 09:13:43AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/5/3 23:07, Christoph Hellwig wrote:
> > This adds an ununused static function and thus doesn't even compile.
> 
> It's just a warning and can pass the compile.
> 
> Or we have to have a patch with over 400 lines.

The latter is the only thing that makes sense.  Patches that are not
self contained also can't be reviewed self contained.  A larger patch
is much better than a random split.
