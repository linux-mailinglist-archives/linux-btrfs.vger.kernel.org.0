Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F56A9955
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 15:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCCOV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 09:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCCOV1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 09:21:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AD15FEA4
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dI1FyCrTEsT6umqxXG9hWk+k+hSTgxxO2gDwwyPjwIQ=; b=C0XBEfQjWE5asKjY+stIhPPzFO
        rW89qtUNssnH0SV81YcScnC+M3YbmFtl2r6wLDzJGHmg5AYuF7/Issf3fbMTTtKBlFV3a3qSlDgoe
        Abh42e85cLuHDxQrVqfAWOY+IvK4fUDFgE0eNY3n+fBODuYvIfqv3QbbAOoY//2N1Rv63pFeMrQrg
        QjVok3aCxyOS/aKINA29bZA+J5p6tYRVr/muMGXhOZqG59GvqL+YDE2PiApS3L8glhDrYDXAzc0u0
        I9xGwfR2kWfHjgdMgT7wLzY9gzqq43TLDhXK3Nk+qItwI0BrxEwd3tSpI8ZhQ5XuLmzdPNnooZ95y
        +aa+C2NA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pY6Hj-006ayi-Hy; Fri, 03 Mar 2023 14:21:23 +0000
Date:   Fri, 3 Mar 2023 06:21:23 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZAICY3zay3LLjovf@infradead.org>
References: <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <b538f61d-fda6-2ed0-9a17-216506ab2692@wdc.com>
 <839ea665-7fc0-334c-e289-deceb417c0fc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839ea665-7fc0-334c-e289-deceb417c0fc@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 03, 2023 at 07:42:00PM +0800, Qu Wenruo wrote:
> From my understanding, HCH's proposal is a super set of 2), not only do the
> ordered IO thing in the same workqueue, but also all the other endio works,
> thus if done properly can easily handle all the complex dependency.

I've pushed my current WIP out, some of the commit logs aren't there
yet, and it still does some superflous offloads for RAID5 reads:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-io_end-work
