Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709C572F537
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjFNGw4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 02:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjFNGwz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 02:52:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DD21711
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=sD+ZdhI/woKU9dvSsCUCJ6JCsi
        E7q22xH2S7/VPQwrJshkUc8TWxCBaA+b9VfXBo1PBWLbf+PKAhqIlP+lnOVobFLX8AyyW+D8X2fxq
        2eC42CwvpnfZoC5pzXiOjt6w0/Y49GU11HlHfzwRbxjapZfzNnC0hH2k2GHhzzDsVtjNiNqM/q88p
        n6ogyyeFOHxnklm3p1WGQnea/1bKwKRFgv0LnBQBKw0Ry8Id1hIYzWLRo6LMhUuq8CM5XzwIxrBTU
        NIO5pDyQfzKAiD/80fvvIiWWK5STyBc4QtPcIVCkryAB+NGtHjeoIVXMtk/5Z+hKj7SidF3Mec2/3
        ADJ7lflA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9KNC-00AXBx-2y;
        Wed, 14 Jun 2023 06:52:54 +0000
Date:   Tue, 13 Jun 2023 23:52:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: remove unused btrfs_path in
 scrub_simple_mirror()
Message-ID: <ZIljxvWEhXnv0sYx@infradead.org>
References: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a09b2850b25de2eb9142d95bcdb1b46ff0207af.1686724789.git.wqu@suse.com>
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
