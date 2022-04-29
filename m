Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE03514EBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377647AbiD2PMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354942AbiD2PMr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 11:12:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA683D3DBB
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QcozVtJhLKEclF6rZeCRQPZlemJNZAbzTsoqZiHGFxg=; b=SMyA9fhLfL1g2eY1JPIrZ79Gut
        6Gvy5nzzjpjqX3qubFwGc5hXC9E/IQ0IKJ/qnKQVPukSkRFphF5vjkaitc2wBk0GXDufT3EIULY/k
        Jqqmlqy/K646fdT+iVjeUBkx1Y00smWKDiH31Svfi81MKlUiRfaI4lEv9H08JESWyFLXuZdM2QjJC
        StQ8laiWYxPeq0S7DdzMqKlaEJHEl5CXds670oyWRieSw9QlyEhV2upDyehukfjhbr5+RJ5igbp+N
        VDH1bjDpEJzvMVkkb1FlPId78LvjH2mMHAs2BKZWAX69ZeYOQUaPr9Ylm1QQW3S1yv7upYO91al/r
        N6w1eJ2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkSFK-00Bibl-MV; Fri, 29 Apr 2022 15:09:26 +0000
Date:   Fri, 29 Apr 2022 08:09:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 02/12] btrfs: always save bio::bi_iter into
 btrfs_bio::iter before submitting
Message-ID: <Ymv/pv3Z9x1TGMGv@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <b11499d578ab90258d83ec9be6d46df78c1056bf.1651043617.git.wqu@suse.com>
 <YmqXZ1Oa8UX3n2ZP@infradead.org>
 <82eb8269-bf14-1396-7452-a8671ed24511@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82eb8269-bf14-1396-7452-a8671ed24511@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 06:41:15AM +0800, Qu Wenruo wrote:
> The problem here is, if any endio function needs to grab the original
> bio, and btrfs submit bio hooks failed before btrfs_map_bio(), like some
> failure from btrfs_bio_wq_end_io(), then we will call bio_endio(), and
> the endio just got an empty iter.

True.  But the only places that uses it is direct I/O read repair (and
with this seris buffered I/O read repair), and those should not run
when we fail to even submit the bio.  We currently do, but maybe we
need to fix that first?  In fact with my pending bio cleanup series
we should be more or less there.
