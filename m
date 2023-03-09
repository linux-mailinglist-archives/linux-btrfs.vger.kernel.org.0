Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4945B6B1F9C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCIJOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCIJOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:14:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31A1259C
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l8LVn1jVK3zsgAZV2Unj+xgHolvB3KzrxiVBrZiebWw=; b=wuSPAy1VIXVxZN5jk2L95UVCkD
        g1ohHtRLOYNOAWHfUREMqrRPCdmLWP0EPtsYA0LCSGb3FC1fdUg6qILqIvJ63mz4AXOin9LK8zPSY
        h0fg1rynu9yxoHj8jVJE+zKHigGWh2ptYnZcb19A5KkBdHmLeD+pFw4/MMdi3CeBXm9F0i/Z93h6O
        r7//dDfj8fqRh/f2/xF8tWWqABAFnaIAGRSHK4FbT7uMJGVz+8/g+NUv7N/09uTIJB6ZqA7t9vV06
        i7RhaN87IcGkzuSdQ2Fa0Z6AQAB0Xwf6YTVO2tdOZ67BI2cc4rXHpsQJfB8iQIgI1XJFObHoK2Qvc
        i7h/PIOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCLb-008jcl-2p; Thu, 09 Mar 2023 09:14:03 +0000
Date:   Thu, 9 Mar 2023 01:14:03 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 20/21] btrfs: Add inode->i_count instead of calling
 ihold()
Message-ID: <ZAmjWyq4QvBzuACf@infradead.org>
References: <cover.1677793433.git.rgoldwyn@suse.com>
 <c201e92c0a69df45a8f1c4651028ccfb30aebdd2.1677793433.git.rgoldwyn@suse.com>
 <ZAdu+C8AMlcUOBhH@infradead.org>
 <20230308230357.nk2nqojk5te5eb7d@kora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308230357.nk2nqojk5te5eb7d@kora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 08, 2023 at 05:03:57PM -0600, Goldwyn Rodrigues wrote:
> Without this patch, performing a writeback with async writeback
> (mount option compress) will trigger this warning.

What is the trace in the warning?
