Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94926C60F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Mar 2023 08:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCWHmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCWHmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 03:42:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7968617CF7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kwTr3eHUofX46KeUFaR/iLqXtzhB71YKaLYzGNPjBLs=; b=wz0Jn4/J8UnLUxW8rJdZgLwzx9
        UWq7r/gJnaXZZCFtzC6owa1XsLl2R2GgKLKRRM0tHPWxE2sHDLf7xbe2RC6TnX5nRK9os5In/zL0i
        RjsEdrBkg8Wyya3AGHa5nmqKBtC4T7Gd1YL6vslR0KjzT6JpEBxEMHo0Z2nWw1w5WkDIrn/sSiv6O
        dsq5/gqyzQJzWFbDyOz5rl7uZHhzyWyjr4NwhZw2+2T7iQ+gI8HJSVbpGySepvM5rY2HafILAJviA
        /JTv1+DUaHJ+MD7+ElZJ5SHo4z8VvRhBxFec4PZAqikUd07hAHv9q6RvRTx9ghrGbrcnwKGj4YP1j
        O9wum/fQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfFao-0018CN-17;
        Thu, 23 Mar 2023 07:42:38 +0000
Date:   Thu, 23 Mar 2023 00:42:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Ryskalczyk <david@rysk.us>, linux-btrfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
Message-ID: <ZBwC7n9crUsk4Pfi@infradead.org>
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 02:41:53PM +0800, Qu Wenruo wrote:
> > [  252.806147] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 2 wanted 0 found 1
> > [  252.848313] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 3 wanted 0 found 1
> > [  252.898989] BTRFS error (device sdh): level verify failed on logical 27258408435712 mirror 4 wanted 0 found 1
> > ** Above four lines repeated an additional 24 times
> 
> It's the data repair path, and the involved bad tree block seems to be the
> csum tree block.
> 
> CC Christoph, as he did quite some updates on the newer read repair path.

Well, the above is the metadata verifiatiom, which I haven't really
touched (yet).

What is interesting above is that it tries to recover from 4 mirrors,
which seems very unusual.  I wonder if something went wrong
in btrfs_read_extent_buffer or btrfs_num_copies.
