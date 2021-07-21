Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069653D1232
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhGUOkw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGUOkv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:40:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8402DC061575;
        Wed, 21 Jul 2021 08:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=u8Ql9nCb1o9gD8DaSAUMouJoXk
        XHvZT7Nc1kEWdw313V3RXmg3NixxIPSujEIWggrBPyazXUFWukeTW95E7K9tMSi1VjXtvCEMIz0Bn
        8C6hwnPbzBBCAiU5c8HDpFCUR2aURXpqNn2GCT7/MGpCogbnEuoydI2bZSMY3yDVI75EL5485DFnz
        VO8Q/oWxoGSc4t11vA8ifqEq5aY7F+rOmkgffOeYY1GfTr5yDzG9esrE7fn1LfPosVQ5fRM7F9UO0
        wX4P37GwKLOeCLBmh1CsLTh/dCbdpN54bEMD/rZqmDEh3l4qLcuixaqNAqIwTFAqGE60yMEVeBvSH
        /7xw6Dng==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6E22-009KNv-S2; Wed, 21 Jul 2021 15:21:15 +0000
Date:   Wed, 21 Jul 2021 16:21:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH v3 1/3] block: fix arg type of bio_trim()
Message-ID: <YPg7ZojhmJFX2+Bl@infradead.org>
References: <cover.1626871138.git.naohiro.aota@wdc.com>
 <4fc8537f6dbe0c27489a3431b3a3240013268031.1626871138.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc8537f6dbe0c27489a3431b3a3240013268031.1626871138.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
