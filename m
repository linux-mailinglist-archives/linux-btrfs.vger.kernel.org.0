Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45B6C8CA0
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 09:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCYIbt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCYIbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 04:31:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F401018156
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2IG6NNBm2XMz3pHc4KRttKqCAgXAJxU1IebDuHDQFcg=; b=rVFsbOhbk3H7pZdvwhPz4pQrXE
        DA0fU2AL3ZZfoFZZXG5xexp2r0KoyRZUI6zZjwrwvJSOCuOBnJ6HYLFbp6d16hHdgbbweV8f1jqBz
        m+L/YiZIYSwzxVeb0iPL2B0B6nh3dfwKCvLgtyhrKMCr4/fz+gWNDVLMdUaPXVp9sFFDzxnZQgkUc
        dGxrTdpO6MbivdohMShBHMqqAprpi/LAY7QmDzpMjTvq6JYT87TE05b3466YSHssiU3DLl26KlTmS
        AZ2T4QtM7H+1FwtinnfaApB3GwqsR7+jfnkMiO9aPRPT+6a57uo6158X16sLqetkgOufvycfS0uWU
        4+fIzBfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfzJS-006SAD-0X;
        Sat, 25 Mar 2023 08:31:46 +0000
Date:   Sat, 25 Mar 2023 01:31:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Message-ID: <ZB6xcqST8tCA7zxK@infradead.org>
References: <cover.1679278088.git.wqu@suse.com>
 <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
 <ZBmc3ZqDVzb/hVDD@infradead.org>
 <0ee1de5c-9cb2-cecf-c4be-02cc16bd505c@gmx.com>
 <ZB6sQGoP9dbsgvX7@infradead.org>
 <9581646d-380f-2b55-07ac-2abd37822577@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9581646d-380f-2b55-07ac-2abd37822577@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 25, 2023 at 04:21:41PM +0800, Qu Wenruo wrote:
> No big deal, I can go with the extra fs_info parameter for btrfs_bio_init()
> and btrfs_bio_alloc().

I'd be tempted to just initialize it in the callers given that it's
an optional field now.  I wonder if the same might also make sense
for ->file_offset.

> The main reason I go with the duplicated allocate is to remove the need for
> nr_vecs, but that's pretty minor, thus not a critical one.

Passing nr_vecs might actually make sense.  There is no need to always
allocated all of them for existing callers either, so we can do
additional optimizations based on that later.
