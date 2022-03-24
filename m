Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22CD4E669F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Mar 2022 17:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbiCXQIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347390AbiCXQIJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 12:08:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A555C86F
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Gw8lXqn6SJfrBAoSrzEX+3j9z1jO/rKWNe220iQ0S3k=; b=qD7NDYINyXu6MDDaLrHLnU2fk6
        +Gvs0OuFogLuM+JQV5ejsbfsZB5yMHdwypro+aoh+ly7NlVI+lfJmkO4Ngh8AN0OXxOFkt5AWF5dE
        tqytLPjXJ+2l+ic7h+6ZRt00e9TxbH/1V1PYZoNDhBQGi7KE2jhNufsgrgkMU+TYR54cfXMNXEoM2
        81YWZstVT1TkVJowhNrxylMIHrpmr1DIPaBvh8oj8tyzWciQR8H6wm2awMZC+M/wt+UPLSZy0LvmH
        JuvkNlGkupKvuxVAXchZ6mooC2fhp02Jy+lYT79U4mSbWygsPYs+yaWsxeu1Fci9COVITwTQFcaHg
        kulcJGtw==;
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXPyo-00H8ve-M8; Thu, 24 Mar 2022 16:06:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: fixes for handling of split direct I/O bios
Date:   Thu, 24 Mar 2022 17:06:26 +0100
Message-Id: <20220324160628.1572613-1-hch@lst.de>
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

this series fixes two problems in the direct I/O code where the
file_offset field in the dio_private structure is used in a context where
we really need the file_offset for the given low-level bios and not for
the bio submitted by the iomap direct I/O as recorded in the dio_private
structure.  To do so we need a new file_offset in the btrfs_dio
structure.

Found by code inspection as part of my bio cleanups.

Diffstat:
 extent_io.c |    1 +
 inode.c     |   18 ++++++++----------
 volumes.h   |    3 +++
 3 files changed, 12 insertions(+), 10 deletions(-)
