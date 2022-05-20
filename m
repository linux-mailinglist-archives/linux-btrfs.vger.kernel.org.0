Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B703A52F111
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 18:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiETQsN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 May 2022 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351873AbiETQru (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 May 2022 12:47:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C1D9D044;
        Fri, 20 May 2022 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tzeHBzQL18zHn3XiIUInOZ12nWLTJ7Dl/D4iolFFe98=; b=PbonZS9sArwJ/ZTGPu4HBOZlkk
        ZstqxgWWHUPuv7gpycoDWYJvIBv2vSYwoT+gSKCHWaA5sQ98tLWDLV+HjkDhtJ0JL6pgb/R8AGlJf
        fdoJMBbGmyRAtH9k1I7rwbIm8Qcj2SYtFu1pARoeoPi5Mzs94Aia5lBrnHpa3aF27g+LrORewS7jV
        +XzMTfquZg/u9goMkyd/l0Y06nYw+ZjOTLlOUGDLny4t31QgeGcUH2fDS5hAFpIcDgSMvKtOACDDU
        fK9zBIuX4CJ5reqqB+yT+fx4kIhLxiSTX/DFvTC0keAaRuGttZLhF50xTlhSNDhdz1W5wGWOO123u
        HbtmLVyQ==;
Received: from 213-147-165-123.nat.highway.webapn.at ([213.147.165.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns5n1-00DoAr-JL; Fri, 20 May 2022 16:47:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: two more btrfs read repair tests
Date:   Fri, 20 May 2022 18:47:41 +0200
Message-Id: <20220520164743.4023665-1-hch@lst.de>
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

Hi all,

this series adds two more tests for the btrfs read-repair code
that exercise the raid1c3 profile.
