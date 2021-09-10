Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4062D40670D
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Sep 2021 08:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhIJGEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 02:04:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34210 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhIJGEx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 02:04:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E9F40223DF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631253821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Leix+PepuCSCV/Yehxv03D1eYN+fdo5tWhvcv7A7EFQ=;
        b=AOsb2aRzU6WRfMIXLFbT7ShHR5Ox6QecLXo0xcUp0yCkN9aebqs3jCdrE1e4jinBCqhcaa
        nmNhT8I11S6CveftCGiKpGlftMR8AHGGFn05cyd48Vd3DLN5GctQTMhq9CMlpKZgEihUiK
        ONHema1sg17OybLTKKF6NHBSDBrjPq0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3312F13D02
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CL2hOTz1OmFMEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 06:03:40 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: doc: add extra note on flipping read-only on received subvolumes
Date:   Fri, 10 Sep 2021 14:03:35 +0800
Message-Id: <20210910060335.38617-3-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210910060335.38617-1-wqu@suse.com>
References: <20210910060335.38617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-property.asciidoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/btrfs-property.asciidoc b/Documentation/btrfs-property.asciidoc
index 4796083378e4..8949ea22edae 100644
--- a/Documentation/btrfs-property.asciidoc
+++ b/Documentation/btrfs-property.asciidoc
@@ -42,6 +42,12 @@ the following:
 
 ro::::
 read-only flag of subvolume: true or false
++
+NOTE: For recevied subvolumes, flipping from read-only to read-write will
+either remove the recevied UUID and prevent future incremental receive
+(on newer kernels), or cause future data corruption and recevie failure
+(on older kernels).
+
 label::::
 label of the filesystem. For an unmounted filesystem, provide a path to a block
 device as object. For a mounted filesystem, specify a mount point.
-- 
2.33.0

