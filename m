Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E51576AA58
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHAH4a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 03:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAH43 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 03:56:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7DE1BE9
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=IHV3flh/ZMIyyO8gfZBwIoJOx3
        cY/s4qrF0bVnobX+1GsXBtzUU5J0smMwiTOesXUnZl56obu9+xz0FPOQpBZ5p7w3VdwyClTKzTnFu
        ec8V+XInlePca2WtGavDUV0VViOIv1JJxMQy36qqH42jiPJRebCZkXA5+ilRlknEcE6ZFHDvtKmwE
        oQArQrNIm+n8tLDS/DKrQP6+rU292yZJhbc+jy5J3zrPJI20+D84yRFpPIvRxH/rIPixuy9d9wc2E
        m4YmLkOIhfrD9lV4xgB46fUnioVBoZUPumpvTyC0TUOnuvYcYaFsqs1Bq75htcGHDsUJzH80HGxZS
        xeGJqKdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQkF2-000b66-11;
        Tue, 01 Aug 2023 07:56:28 +0000
Date:   Tue, 1 Aug 2023 00:56:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH v2 03/10] btrfs: zoned: return int from
 btrfs_check_meta_write_pointer
Message-ID: <ZMi6rG06ukiZsTPB@infradead.org>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae37ac63b97cdaa01a5fe15cd5b4607620776457.1690823282.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
