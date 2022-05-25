Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD475338F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiEYJA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 05:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiEYJA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 05:00:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F1470350
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rq3oAyBXrOpACtdx/apZGp0h1vfSvFc7IP7LnmTkpQY=; b=aXDj4Rpf6eipoqz3kkXNDVVJ9L
        q/pak4lxnInvLfinBMyUb2W13z+6y+P8bIXdo3LWjAkOsF5n2oY6Wk6U2fLFhCMPAj99pXDCwAwIO
        2Wome6k58z10G9JPZobgywh3tc/0gNvhlkH+KXQDlLTiiuJ4gW2ecA0LF7KPSjLabBos+wBbclCxM
        NRZtWCbLeLjaH7p2z6FUCWo9Ese2Dt63ibVuYHNZyuDK7/lV2UxYz+XIfiHpsUGjDS7NYX6B+3Bt6
        hG3XICvLeW1FTNLNvFjMuj0r9+ZQO0Lt8zL2DHGicDy4wQ9ZvYB8mjd1ocGT2hNBJksNp3FrnI3Hg
        RuaCrufQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntmsu-00AVXQ-PE; Wed, 25 May 2022 09:00:52 +0000
Date:   Wed, 25 May 2022 02:00:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Message-ID: <Yo3wRJO/h+Cx47bw@infradead.org>
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524170234.GW18596@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 24, 2022 at 07:02:34PM +0200, David Sterba wrote:
> Well, that does not sound encouraging. One option discussed in the past
> how to fix the write hole was to always do full RMW cycle. Having a "not
> fast journal at all" would require a format change and have probably a
> comparable performance drop.

So maybe I'm just dumb, but what is the problem with only using
raid56 for data, forbidding nowcow for it and thus avoiding the
problem entirely?
