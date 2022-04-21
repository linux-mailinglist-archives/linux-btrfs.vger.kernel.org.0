Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494F5096D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 07:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbiDUFbg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiDUFbf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 01:31:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982010FD0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 22:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qcgad6uU9jZgvR+IwaUmbJFITs1yqOJJsWE91AMaDLY=; b=Xpum9affuFjl+3w61SkC2Go8kY
        to6R5vRsWIvuArTjZ5EUFKbsv10qRB7UcDiKGg/ss8u9/4zY4r92s5VBDrRWCxm3uosgkOz0Q9Q6a
        LlHjoPYI4Qsr9y1c+FXk0btWGL0hvtdW3fNR0BZPQFwY9r02cdIYQEd14qSW7OVLOTpFnsPjGSEGt
        4KGPEO9H0UJRwjdBvFTdlILSDKI2SrT0srKnvndbEUDillOWaViEedvEx+FhW/RSgLXJIF4otmv/6
        4XbfNhYai59e47vB9nuMPejwdX9ZT7MVdGt/PYD4+mkceCvdzmeTDlHrg0EYbEKBtBNrLanHuYLs3
        bEeyx5VQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhPMy-00BZXi-C9; Thu, 21 Apr 2022 05:28:44 +0000
Date:   Wed, 20 Apr 2022 22:28:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Message-ID: <YmDrjFZxqZnPt52Y@infradead.org>
References: <cover.1647248613.git.wqu@suse.com>
 <Yjnu7yWxAforTGQF@infradead.org>
 <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
 <20220420201158.GJ1513@twin.jikos.cz>
 <dd842aee-c0be-9c10-f613-1a24d999c513@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd842aee-c0be-9c10-f613-1a24d999c513@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 07:04:25AM +0800, Qu Wenruo wrote:
> I'll refresh the patchset, still keep the core idea of splitting bio at
> btrfs_map_bio() time, but also take some ideas from Christoph to further
> improve the patchset.

I'll have about two more batches of patches that don't touch this at
all.  I have a bunch of ideas how to deal with the splitting after
that and will contact you about the ideas.
