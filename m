Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E3875F9BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjGXOWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjGXOWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FFFC6
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QXlco0u5nq7+fEpX8GDO2I2YOd1D3wi1RZKUPJVnd38=; b=kv9Wh1kRAgdV5DqSy6DNjMKdUT
        LTlgP8UC1MWTrWz0fomnYzk+DY5GnQ4sFiLhiDKOE4gF8msgQx9i6HQOAnOOEDuT+mLuU/GaQ1qn+
        mfW3IWgcfU4+MGH2OxsZbxraZK5QcTKdJ1ttODhlfl9I4SlMVqd+YimGYrpkoKihGHgxJi+eybt1t
        358BEWWy8EI3OUNErXaUtS8+UlSrWt5dEiSgh0aWe3WjVSfDBEajH90gNcqYKArv0uHHpCXnawOTh
        IegCyACMMjxbeWp4H15EtRalYTUXp49j8s67sRc+Y42fn/QGyOhyE0jvNaX45amFisIRuqdBA0EGa
        tDfT3pGA==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSR-004b9Q-1l;
        Mon, 24 Jul 2023 14:22:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: btrfs NOCOW fix and cleanups
Date:   Mon, 24 Jul 2023 07:22:37 -0700
Message-Id: <20230724142243.5742-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

this series fixes a (found by code inspection) bug in the error handling
in btrfs_run_delalloc_nocow, and then cleans up a bunch of things in
btrfs_run_delalloc_nocow to allow me to actually undestand the logic
there, and in case of the last patch signigicantly simplifies it.

The series is on top of the for-next branch as that includes previous
work not in misc-next yet that the series relies on.

A git tree is also available here:

    git://git.infradead.org/users/hch/misc.git btrfs-nocow-cleanups

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-nocow-cleanups

Diffstat:
 inode.c        |  143 +++++++++++++++++----------------------------------------
 ordered-data.c |   24 ++++++++-
 2 files changed, 67 insertions(+), 100 deletions(-)
