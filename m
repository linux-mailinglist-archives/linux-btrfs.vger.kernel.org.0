Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0C69F6BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjBVOjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjBVOjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 09:39:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B5434F58
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5qYYj3R++UTH/LIXl5f8G4boIMW4J5zVgj/HdKAkWo0=; b=lrwoq4fwvCO4Xkddm9vWp+PQXy
        hhskRie+gEJzNyhC0e9j2rwjRCREyvzpsVwDyxCLXIWVGwkjH3e2cK60+yuAHXVkcU/48Gi+RjOoa
        Dg1CwSJm31XGnN10G4Zys15DjqofGlqpr6OsdVSZQnsH/jgnyobfg9g7SlkZV5l41+F5GjxiYMVHN
        6ITkKWbs8TX/Hp5qtIKzQBBPdjEFK2X+6Om2+fKH3RULkctsKhib2roZyZmzWA/2nziGD+hWQEITf
        I03N5fxsqis2oUiF0DVAbzLDDZxEsOCaQ0Y2Ep5kKzXISZD/l81bvXfhRj7p+PHBqWQ9Lrv8WNyD9
        60UqpbkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUqH9-00ChsI-LM; Wed, 22 Feb 2023 14:39:19 +0000
Date:   Wed, 22 Feb 2023 06:39:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] btrfs: fix dio continue after short write due to
 buffer page fault
Message-ID: <Y/YpF/CKp+/hUBVL@infradead.org>
References: <cover.1677026757.git.boris@bur.io>
 <b064d09d94fb2a15ad72427962df400e37788d0c.1677026757.git.boris@bur.io>
 <CAL3q7H5rq9c2yXR6YqUCxoi1LQq-vTYAz0Eoxe1MxULsKKZ_bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5rq9c2yXR6YqUCxoi1LQq-vTYAz0Eoxe1MxULsKKZ_bw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 11:51:44AM +0000, Filipe Manana wrote:
> >  ssize_t btrfs_dio_read(struct kiocb *iocb, struct iov_iter *iter, size_t done_before)
> >  {
> > -       struct btrfs_dio_data data;
> > +       struct btrfs_dio_data data = { };
> 
> Btw, everywhere else we use the { 0 } style, so we should, ideally, be
> consistent and use it here too.

The empty initializer is just a newer C feature that hasn't caught on
everywhere yet.  It has the advantage of not creating a compile failure
when a new first member gets added that can't be assigned to (or
a sparse warning when it is a pointer).  It has not downsides over
the 0 initializer and should be used everywhere eventually.

