Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B36D7452
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 08:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbjDEGS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEGSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 02:18:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C446E2D6D
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iy+DkM8QopnBWlLUvh2xM4PdmRnRYTADgbqyAMl3R8k=; b=E/6IctnuT7XUMqpi10BFNAo/MS
        HekDrJr5UY/8b9PRaAcb/MpJXMfxIizZlNqKYI0sBSF3+P58heZ2kNs8T/wmLU6tCiQQkWiUEfGIh
        Y4Gb+6Wu8Og1H5wFJYyvELvbNf9qh9VSa5gkVShoWr1YNdnBmjVL7HPvimGNSsS0tXD3PcrS42QX0
        Q8iUbtKwXhpnf5iYS/x8TWb28jBMiKHh7xzBVrpz6QBEbZWksIgXfHQmP9c9sKiq6/8BzodfocZfC
        Kg9M2Q9RzUJnvxTzYmJ5p9CL2KWfk1rUNNO/Gmh+jj13SWgCnhBbNkGxFqH6fG8+7GeuyBySz+GKU
        xhWVGwEA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pjwTo-003UdU-3B;
        Wed, 05 Apr 2023 06:18:48 +0000
Date:   Tue, 4 Apr 2023 23:18:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Message-ID: <ZC0SyJbFJuS2ZEOY@infradead.org>
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org>
 <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 04, 2023 at 02:15:38PM -0400, Chris Mason wrote:
> It seems like a good time to talk through a variations of discard usage
> in fb data centers.  We run a pretty wide variety of hardware from
> consumer grade ssds to enterprise ssds, and we've run these on
> ext4/btrfs/xfs.

Remember what you guys call consumer grade is the top of the shelve
consumer grade SSDs, or in fact low-end enterprise ones that are based
on the latest and greatest top shelve SSDs with firmware specifically
tweaked for you.  That is a whole differnet level from random crappy
no-name SSD from 5 years ago.

