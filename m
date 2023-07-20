Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8462275B07C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGTNyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjGTNyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 09:54:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F26EE6F
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=k4ZaDPgXKoQkkytjtYI2X/AQpqUZ+XidXd3GOYuiGHQ=; b=iikrQVrZ18M/aqWwZq3qACaJrM
        hz738laHVpiQuMyqhO8Gynguh89XJquz8QmwdQDvi0hXotW/VERNvkhjYoHo+U2RgMu2sKHkE4Kjd
        ECWd2DxSXpfxCxbn/1I6JZkcJIGN4vqmACQBg+rjkkAyAdFVoKp8Y6MlJx3+Hp5nk3kcQGsGfMsSf
        7A75fWNTdVTQLXnJnvmXtyFaufUChYJZVy/YICGT3AdNs+Fq5IwTYwZNhzprtbjZ2tTLOPnqOzYcE
        RH6aE999+MSu2ClKgPEsnhjTZ7tCAWtTFOz8bySwjnVA8TfvVXHTDEXzqqOo/i4LHOIBBjE2ND+e8
        Fflklsew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMU6T-00BIdv-15
        for linux-btrfs@vger.kernel.org;
        Thu, 20 Jul 2023 13:54:01 +0000
Date:   Thu, 20 Jul 2023 06:54:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     linux-btrfs@vger.kernel.org
Subject: flapping scrub tests?
Message-ID: <ZLk8ef3pGp1ZjByN@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

in my tests it seems almost random if the btrfs/06? scrub tests
fail or pass.  Is anyone else seing this unstable behavior?
