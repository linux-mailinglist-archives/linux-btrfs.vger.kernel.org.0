Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB971082D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 May 2023 10:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjEYI7O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 May 2023 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbjEYI7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 May 2023 04:59:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6116E195
        for <linux-btrfs@vger.kernel.org>; Thu, 25 May 2023 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Hmwk1djgE0iQvK7F7oLq+FG37S
        OujS5qJLa4H9UeeQBfwe/We9wwRhjyD5oEYT/3Y5mg41FQASWcqX4VGbAIgvsAcYj0JLRuhBa5NQ4
        PlMuBF8HJjOdqr76RDd7mIHdjPNfgR74pMahhMxkPbTK/ryzzxQ9JzaOrCpv9GWaC9PGVTtoa8IHj
        jfGoXjafWAe1bvtuJC+0f9TxvgyYR/xplkOb7uuL2A7NPrA81QxUuZvQrQICd5sCK2pxh6rzTCjQj
        RJ1FFw4JFXplcEGwRwXIfEMpAtFK5C9lTs8vzoJmpY/EVWF7dmxE3jWpIMhgV6PabsmoZTnI/xuIF
        mg8S/+mQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26oM-00G4cb-01;
        Thu, 25 May 2023 08:59:06 +0000
Date:   Thu, 25 May 2023 01:59:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/9] btrfs: open code set_extent_delalloc
Message-ID: <ZG8jWXpIhVzESz0c@infradead.org>
References: <cover.1684967923.git.dsterba@suse.com>
 <7a0532b77dd6f3571da6b17228bb19501e9b3f26.1684967923.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a0532b77dd6f3571da6b17228bb19501e9b3f26.1684967923.git.dsterba@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
