Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C3764B191
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 09:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiLMIy1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 03:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiLMIyZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 03:54:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F6F4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnwbQNMcuHg9wlxGLMsUjOQHurKohnh1FdWJZMTJfqM=; b=dQtKA9oAWZbHdQdFm9eXzAt2wz
        AVRENB6XbmPNEizIg8Q/0k4CI0q8DZVE9BbG0w9PqfoF17HBt0pmTxujLbAf3e4HkyjnFHOQhLJQ/
        IgouiDgFPjvAjBoG9B5O7fpBY4BTDWRnJPkTa/XGJCjSrwAE6UO3bVFl2SEegboU+FFbP/xmbJVhQ
        OAL3WuxF0iiLhAthriaHExo1yJ7wP6lpa0LxVeout05E7MF05XeQ1Z1A4L8vfo99cVEAt+v0Tg+hZ
        zQevXqlnfDAxZp5mhtRWovx9t28iCr0AWb1Q/0t0mxk0nbttm1u+ndx4DjCMcANDRwEe6dy49vkjB
        60eBYY7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p513Q-00E6oE-RC; Tue, 13 Dec 2022 08:54:24 +0000
Date:   Tue, 13 Dec 2022 00:54:24 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v4 3/9] btrfs: add support for inserting raid stripe
 extents
Message-ID: <Y5g9wL8CwGTkD8y7@infradead.org>
References: <cover.1670422590.git.johannes.thumshirn@wdc.com>
 <238cc419b3cbc18c4a93ad7827d33961fafd4196.1670422590.git.johannes.thumshirn@wdc.com>
 <Y5bWt7ENo2OkKK+v@infradead.org>
 <e69f2a95-3802-d8f7-2415-5320903a876e@wdc.com>
 <Y5g5q1O4dj9e04E4@infradead.org>
 <008a8c15-6ebf-d5f3-f64c-8e53d8bfa889@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008a8c15-6ebf-d5f3-f64c-8e53d8bfa889@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 08:47:48AM +0000, Johannes Thumshirn wrote:
> The reasoning behind this is possibly lower write amplification, as
> we can exploit the merging of delayed_refs. See this hunk for example:

I'm curious how much of that merging happens, and how much would also
be handled by not splitting the ordered_extent to start with as
suggested in my previous mail.  I'll have do defer to the people
more familiar with btrfs again, but if you need to delay the tree
update to reduce the write amp, shouldn't it use it's own set of
delayed refs instead of piggy backing on the rather unrelated file
to logical mapping ones?
