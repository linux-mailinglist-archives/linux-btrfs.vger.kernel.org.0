Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03D169E926
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 21:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBUUxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 15:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBUUxO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 15:53:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDAE302AD
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 12:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EWyZNsmikiZWn7QCaSQt+306YgJru8VDPCUnII9oFBE=; b=WkXeXf4iWuCTwj6PciNe3nmMnu
        mD2xL9dfOMafmNYH7vMPJzyL5ImvEIlu7HkNWYi4p01q0E0GKSAnkE4kkIKQY9yXwSswP8yRjTdVX
        Qr3pFmzkJzl35p+FA+LD1puKCSBGL53HL2Gzdc3BiuNrFuWILPR/PcEI+1Wj2n7Z2zi/V5Rxg6Pah
        AiuygGSh8ZYbK8Dk185FZCo/MTqs8FbGcHS9hjDYRdPfFBfSJ1a9YirbhuuwxwwqxFqFR3c+x7B4t
        y5SZGHE6B8WCIm2m4E8d0JCeT5aNrC2ljkOOvcxbPXFInW3CKX9KGBNvTfb45ytGMqdYODIMRcSmJ
        1fLjwUZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUZdK-009ktU-ND
        for linux-btrfs@vger.kernel.org; Tue, 21 Feb 2023 20:53:06 +0000
Date:   Tue, 21 Feb 2023 12:53:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     linux-btrfs@vger.kernel.org
Subject: something in the last misc-next update made btrfs/261 fail
Message-ID: <Y/UvMqKqO1Wpy39l@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--- tests/btrfs/261.out	2022-08-23 16:09:54.526648628 +0000
+++ results/btrfs/261.out.bad	2023-02-21 20:50:17.796750095 +0000
@@ -1,2 +1,6 @@
 QA output created by 261
+ERROR: there are uncorrectable errors
+scrub failed to fix the fs for profile -m raid5 -d raid5
+ERROR: there are uncorrectable errors
+scrub failed to fix the fs for profile -m raid6 -d raid6
 Silence is golden

