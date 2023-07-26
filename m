Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDCC763732
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGZNKc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGZNKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 09:10:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDEF1BF2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H7E6IZ31kjZs6QHT8ffnLJUNA8RtiVojga2JyYK7sOc=; b=RbdHiz9p+705mV2NfuXaKEwu/P
        gh589LCUEJILjzdyKtcG2hr9hQp1SZe+Xew+tuC7IBwVdysm2Rsduq51pQ7K767aGGqBioYs+Lbr9
        1E0lNXSD0u1vbi4C//EeX2qR+Yw1VLRfTdYxAfvYJu7oFpl39EGMU/cdQhxf0LcsMWyZcHa+DIKbz
        EHKqCIMzW4YJ7txwVWZQqXIA6z+jkIkY161NBprXDU187rV2BJR+dx4ECkcj77MbtQ8d2CpuSjtF0
        Yk899w9+Ql0z27vHnz1sDFc9Buv+D/7s3KoShLJuwzUvgBIZZyqEDv0r2nKWr74ED7ywA8IfYGFH+
        gInNpn7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOeHe-00AUxD-0n;
        Wed, 26 Jul 2023 13:10:30 +0000
Date:   Wed, 26 Jul 2023 06:10:30 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] btrfs: zoned: activate metadata block group on write
 time
Message-ID: <ZMEbRjKoX7KkXOqu@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <2f8e30f966cfd9e06b0745a691bd1a5566aab780.1690171333.git.naohiro.aota@wdc.com>
 <ZL6U3DYVw9JHLUC6@infradead.org>
 <3bhaod54j3jasck454wbqaovmyaraxbypz3umcd24v6jmx76xp@vh54twyvcpns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bhaod54j3jasck454wbqaovmyaraxbypz3umcd24v6jmx76xp@vh54twyvcpns>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 25, 2023 at 09:28:09AM +0000, Naohiro Aota wrote:
> > > +		bool is_system = cache->flags & BTRFS_BLOCK_GROUP_SYSTEM;
> > > +
> > > +		spin_lock(&cache->lock);
> > > +		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
> > > +			     &cache->runtime_flags)) {
> > > +			spin_unlock(&cache->lock);
> > > +			return true;
> > > +		}
> > > +
> > > +		spin_unlock(&cache->lock);
> > 
> > What is the point of the cache->lock crticial section here?  The
> > information can be out of date as soon as you drop the lock, so it
> > looks superflous to me.
> 
> The block group's activeness starts from non-active, then activated, and
> finally finished. So, if its "ACTIVE" here, the block group is going to be
> still active or finished. It's OK it is active. If it is finished, the IO
> will fail anyway, so it is a bug itself.

Yes, but what I mean is that there is no point in taking cache->lock
here.  The only thing that's done under it is testing a single bit,
and the information from that bit is only used after dropping the
lock.  So there should be no need to take the lock in the first place.

