Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55036A993C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCCOQl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCCOQk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:16:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79062252B9
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q7AfUWpOJ1BZrrJSC+g4KF2rusVd4vMeQWELMpGj2P4=; b=q0fRdi7xPeZBkhhnmM/fpHnVUn
        wzMXBGCY0/GO5U6E3egzaUP7IpL6JU3SSgmpvgl8W975mXKrxTOZ3eZpE6gw1iAJ3QaVRFQtWF+Zb
        vvCbn8MPgKKry8V/HzX2xk+9TWSENWibGwRIZgxKT6oABOB1CatnwJ1FbtHvAhMtVL9/9HXkVZqmt
        tGXKR1ULiK2ICLuFv205Cixe1KCwHbiFeAqDebFc/KrM4C/rF46S+KJ1P3+a1NY7Ozw5mKFd6pUFq
        lGmnwSSLfJNbksvRoecNFToykQC0pSH3IKhI4ef8+AGiyiiRLNdlyOJfCJOAg+CFTJjFedJbpvpAY
        +umONNdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY6D5-006aJj-34; Fri, 03 Mar 2023 14:16:35 +0000
Date:   Fri, 3 Mar 2023 06:16:35 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZAIBQ0hzLTjOIYcr@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 03, 2023 at 06:35:30AM +0800, Qu Wenruo wrote:
> Just make the in-memory RST update happen in finish_ordered_io() should be
> good enough.
> Then we can keep the RST tree update in delayed ref.

Independent of the workqueue changes, doing the RST update in
finish_ordered_io feels like the right thing to me, although my
gut feeling migh not be properly adjusted to btrfs yet :)
