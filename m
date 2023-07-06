Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A637749C24
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGFMoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 08:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGFMn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 08:43:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F51FE7
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jul 2023 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F8i1i6P5Wz7KIT5DfTU17FfFZnNvuSI3ByQakj8LavM=; b=oo1XJNtWwpYTY4lXaPl1y+7+x2
        D6/3wBAKDluNM07hAg/bhYo9GUJg4lQk1GztiynmJKVSL+8czmxPE53MyDx+bK3DDDqrKNpzacUSZ
        bn3m+bNPdNODCAGvq3r2cXrffS7/HDYwJ9rkHPlgvmCO2f12BHshYFfsfdKJiasnzkpnrXxeeJyNl
        u1z8bj51PoMhGoAl+rDXW4uHYv/MN2F059RFeYRFt1K86uy0ROVZN4aJ4mjKL6h2URwIYKzxsvfUF
        zaMrkRLwQE5VOR1PwyD7Tw4G82dvPD/CCPjQ3JIBmxkgNon7Zjuqs0ZJ+8SufXhouB7P4itJGM4ho
        4No1uF1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHOKg-001fZi-35;
        Thu, 06 Jul 2023 12:43:38 +0000
Date:   Thu, 6 Jul 2023 05:43:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: zoned: do not enable async discard
Message-ID: <ZKa2+k8L0kn2begH@infradead.org>
References: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22f5f69d881de1ec0e381f1be6bfe61b822c064.1688027756.git.naohiro.aota@wdc.com>
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

Same as Damien PI'd word it as ignoring instad of disabling.
But otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

