Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682604EA7C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 08:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiC2GTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 02:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiC2GTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 02:19:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A322B248785
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 23:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5ThWZktK4IezOUxdfJeExTpN9u9U7UQF8A25Xtos3Xw=; b=AX3b5YMReg+9ECj8fH8sTHKYN7
        nv0lZxyfav0fRZ6mJAQGSZdj+pHnNk2VkrXM+Ky5G8iup0CuNrO/GTVrn1y3N39tHuTftVt97gjbq
        gjX/bcsz+e/33dKJq6oOV/JhP50E9Uc+BfPJyj2WQHjEXYoqmqld6J47YEhL0WNsMlcEF6rMKKu9o
        ExY+0+DufWJaLxxLGm8vRdA93sX8UhfbSmmc0FTRrs/NQwEIs1T+sR4IP4hJZcUWXEyq4rVBbpFeq
        obzpeub0gKsRGEbWyFfWtyRLLZhFEZy0r3lDLiSUdGE73rP5ptUpnOWhnwFPVSbTdwQrCogHpkqI0
        rnYdjiJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZ5Au-00BBcU-Sl; Tue, 29 Mar 2022 06:17:52 +0000
Date:   Mon, 28 Mar 2022 23:17:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] btrfs: do data read repair in synchronous mode
Message-ID: <YkKkkPGUqOGIai48@infradead.org>
References: <cover.1648201268.git.wqu@suse.com>
 <1b796a483efa008ba5e2090621161684b3c4109b.1648201268.git.wqu@suse.com>
 <Yj2ZALUKtblRSaxP@infradead.org>
 <dd03a779-f996-4e45-e06e-f75acea97ff7@gmx.com>
 <ba5e64e0-8761-3cc3-e3e6-c78f02ab4788@dorminy.me>
 <84178851-8c88-dea1-1d0e-844b6ba7bb7c@gmx.com>
 <7225af7b-eec3-b5a4-fa4c-6333fae5ac4d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7225af7b-eec3-b5a4-fa4c-6333fae5ac4d@gmx.com>
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

On Sat, Mar 26, 2022 at 09:10:51AM +0800, Qu Wenruo wrote:
> Thanks for your hint on this, the more correct term is, btrfs always
> iterate the bvec using single page helper, bio_for_each_segment_all().
> 
> Thus even if the bvec has multiple pages in it, we still treat it as
> single page using bvec_iter.

Yes, like most file systems.
