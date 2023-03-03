Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4306A9936
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjCCOP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCCOP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:15:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BA252B9
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6FKdptO6Xv+RfAa+4hjr36YhJ5sxbEscrC0iMENWEV4=; b=dmLmno7eFLg7QtC/cYmqRlvCl6
        E+dkOL9j8bIYk6nDP+c3PIl3CWlWwgRxvoa2428tBgtLEpiGS1Fax5mROb2s0d/8OWcm166h1k3qE
        bGp5a7MOP+4IC9Kvf9tU5TkdLYSEBZxr7th0lQKYmYAYktfMQlB01+TqHfIgaZq4W2hCpGediNqfZ
        xGiCA5ms9aj1vthUDxYPFwySiPA71N3Btn198qyHIaNzNU19Lp5tg4o3ZWtPt50sak3BcgMXPCXIb
        8Km3Eyo5KX5Bdn7VhkSDtz6Ky/0pZ+yKgDX6TVyY4Nb4r4nUemVA9TnWVHQqEBTVcZeiiMtZ7JTCE
        d8bQa3QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY6CJ-006aGJ-6g; Fri, 03 Mar 2023 14:15:47 +0000
Date:   Fri, 3 Mar 2023 06:15:47 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZAIBE17TiLk75+pr@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 03:31:51PM +0000, Johannes Thumshirn wrote:
> If it's all running from the same end I/O worker then we can make sure
> the race Qu suspects can be eliminated, can't we? 

Yes.
