Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53675699EE
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiGGFgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGGFgx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:36:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7F3139A
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=scSomIQQQy8ta6pwDgGLHRldVZ9oR8ue+1ORDnMiwjs=; b=wsEWVWPKekqYgTqWqsTteYC4hD
        OtTcwRP/1jq7oLy+wmTVivG34DsupBpK7k2OnJEFGrTNMRMKZrD+aIvz+gPX4mccncu79r+a2J+jh
        JbqWwfw4mZ84BkyxQ1X8K/8q91FkSY8AJXA8bDO0f/qw1hZssp9nYSxEAgMOD7fRhqlZ98FUTVtXj
        XnoMAFqhIMwBNRVxbVbh2MGMBaKggi0NK/CqGq/uSfnxziUEYZbl+1Fnl7qioPALjFAmodXZLwh8G
        hVnlxnMJR6cHAZJt0z1U9JxgQ9/Y6v0b+UD0NdTxy6w8zX7VypPtQdHdCkpm432wL9zArHh8lBnOM
        9oDnFfOQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9KC4-00Dm5R-NG; Thu, 07 Jul 2022 05:36:52 +0000
Date:   Wed, 6 Jul 2022 22:36:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
Message-ID: <YsZw9O8fRMYbuLHq@infradead.org>
References: <cover.1657171615.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657171615.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just a high level comment from someone who has no direct stake in this:

The pain point of classic parity RAID is the read-modify-write cycles,
and this series is a bandaid to work around the write holes caused by
them, but does not help with the performane problems associated with
them.

But btrfs is a file system fundamentally designed to write out of place
and thus can get around these problems by writing data in a way that
fundamentally never does a read-modify-write for a set of parity RAID
stripes.

Wouldn't it be a better idea to use the raid stripe tree that Johannes
suggest and apply that to parity writes instead of beating the dead
horse of classic RAID?
