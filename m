Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923D35B5BF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiILOLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 10:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiILOLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 10:11:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD432018E
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=EmMESJHi3hlZ6aRAjD+wJz5cnpN6HnIFKoRRSabIaIY=; b=wVpoWGmEms8JBdclO05XZf2NAd
        BS9qZAHC4LYP46ZJ/GZeOv/iRpZzxqwC+wB7pAADGjsE9dC8huVVlJ0zf9TAH1KmbxWttHJwvi0Dx
        soydVvM98rN13fpgPjnS7f4T39+MKpmRL4xzywLGWBAUNVbGbr2xuz2C5nrbOoCLmRS1rVKKksX6g
        FFy3tw14wK06elXGVhO+jUiMGSqZ/WPrvnTNSZgNnrsqIPcvSXlc5aUzKAoLVjn8FzTrztxC1i55y
        ujjoojdzViJ9F5FnmIOylKUmv1mL+jExOICR0iV1QIsURdpUSz55oFiWx5UO2n9edJbfEEflHw2i5
        WiMPNBpQ==;
Received: from [2001:4bb8:198:a30e:bb46:613c:209e:f1ad] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXk9r-00AWOw-2x; Mon, 12 Sep 2022 14:11:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: move the low-level btrfs_bio code into a separate file (resent)
Date:   Mon, 12 Sep 2022 16:11:19 +0200
Message-Id: <20220912141121.3744931-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[resending because I forgot to Cc the btrfs list, sorry]

Hi all,

this small series creates a new bio.c file (and a bio.h header for it)
to contain all the "storage" layer code below btrfs_submit_bio.  The
amount of code sitting below btrfs_submit_bio will grow a lot with
the "consolidate btrfs checksumming, repair and bio splitting" series,
so this pure code move series triest to prepare for that by making
sure we have a neat file to add it to.
