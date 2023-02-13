Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F019693E5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 07:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBMGgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 01:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBMGgx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 01:36:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D96580
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 22:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uBrR1lrhLlgOdOQD4nt1BVIU6V
        t8Flwj65OlrRtNKVOeG2TBHY9LmHPVM4T6ZXTKTxkKNqgPCAZkte3/QZFpUpP7tdQbNpuz/6NNbgY
        VtqCDSVDvM+NQHbCAE0GNlXa4AIB6DqXLduzq5I2/ZSJU2iHTphMgZDg4gA11gsvRbGUZ+OJuPZI2
        5shCnzWvmJEnj14kt6dV+Y+VnGDOYtL+y50e41ZYa61P2mwVPRULqZA6LlZJcWcRkHqWniklMS4Bb
        nBGpH/Bs5AEhV5/NORkrpVdHKSF36QUMZqWcexedwErKjUvcJa9jCjw2UPR4NOMaXK7kLsjOtOEwF
        3ADrdqDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRSSL-00DMLw-05; Mon, 13 Feb 2023 06:36:53 +0000
Date:   Sun, 12 Feb 2023 22:36:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: optimize search_file_offset_in_bio return
 value to bool
Message-ID: <Y+nahNgkX5vaF2Xx@infradead.org>
References: <cover.1676041962.git.anand.jain@oracle.com>
 <5ed6a5476b2be3d9b459db87f8e7d24bfadfe02f.1676041962.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed6a5476b2be3d9b459db87f8e7d24bfadfe02f.1676041962.git.anand.jain@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
