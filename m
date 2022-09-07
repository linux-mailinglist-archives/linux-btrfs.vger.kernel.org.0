Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236BB5B001C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 11:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIGJNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIGJNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 05:13:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC5B0885
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6eoInaj21QdwMGURUzcmFow6nOEVRNLWO78cqz/RRy8=; b=2M4ksgYQrSRy60FfG/CpulI/5c
        d7GfYNjp7ffN6i4LAnkzO70CsgJQbwisXhuQUEL0SD3ktkVMte/RAgKfJIUznlYb1fkrBbkos8h9J
        dn878R9rKbMz8/2nX2BhIH77MdLKWKw46JaqafwHgpCpznu+lhq4Kr9KyzLJm/upL6SLV0vfl9i7k
        xH+eIOMTFEmYHCEwQQ7hIuMbpzTo2wBo+2ncVPbs0dZ1cQDx6EkN5CS7fIjMzH/bspRl/k+36cyWx
        ajThn6L6FsD2cEYmEiF1iCvPq/ukYDC10t/pMZgWcvKIYBJJeApBene0U0DXGJu104G3HHuzVhVLr
        yFX+It6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVr79-004ihT-MQ; Wed, 07 Sep 2022 09:12:55 +0000
Date:   Wed, 7 Sep 2022 02:12:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/10] btrfs: make lseek and fiemap much more efficient
Message-ID: <Yxhgl/p7xF1UfqHO@infradead.org>
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
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

On a related question:  have you looked into using iomap for fiemap
seek in btrfs?  This won't remove the need for fixing some of the
underlying algorithmic complexity, but it should allow to shed some
boilerplate code and reuse bits used by other disk based file systems.
