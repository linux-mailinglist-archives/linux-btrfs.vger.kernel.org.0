Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370FE31F53E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Feb 2021 07:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBSGzJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 01:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBSGzJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 01:55:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9193BC061574;
        Thu, 18 Feb 2021 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1mfFJhjbGRTGxljzOUB7yrAH7F+AvN4xjV2BD7KJnJo=; b=2/VIk3XYD2RP1fNnYRtlCtxCDo
        e3aOPBNo5OaKC2aFpRl/6GmdqiftjCEjsfraBJE+2qmbdL0LlztGvOKDw0vPwJJR7g1T8juNAID4N
        ORvZMYx17m/v2qM53/8PDL/+UQ1HWgzrfKP9GzgUQkEBBVQD+7ZsAFJ3iYixZmZAICRsH1sVscWM5
        UDgToZNVcAKn9SaLy3V40uuf0/69G0ITfLTBWSmGHIeGooC7PCnuH27EpiCqBKQ6YZb1V6o3v6dzZ
        R742DNmpPtfdVT+6JC+wdcW9iqFRn6ZVlGwv07qY71pAwa0+juLQr/I66t60PpG/eQYvWmvmP7fN6
        zBZ7sNsQ==;
Received: from [2601:1c0:6280:3f0::d05b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lCzgH-0002Cl-2k; Fri, 19 Feb 2021 06:54:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Josef Bacik <jbacik@fb.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] btrfs: ref-verify: use 'inline void' keyword ordering
Date:   Thu, 18 Feb 2021 22:54:17 -0800
Message-Id: <20210219065417.1834-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix build warnings of function signature when CONFIG_STACKTRACE is not
enabled by reordering the 'inline' and 'void' keywords.

../fs/btrfs/ref-verify.c:221:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static void inline __save_stack_trace(struct ref_action *ra)
../fs/btrfs/ref-verify.c:225:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
 static void inline __print_stack_trace(struct btrfs_fs_info *fs_info,

Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Josef Bacik <jbacik@fb.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: linux-btrfs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Found in mmotm; applies to mainline.

Apparently we are doing more '-W' checking than when this change was
made in 2017.

 fs/btrfs/ref-verify.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- mmotm-2021-0218-1829.orig/fs/btrfs/ref-verify.c
+++ mmotm-2021-0218-1829/fs/btrfs/ref-verify.c
@@ -218,11 +218,11 @@ static void __print_stack_trace(struct b
 	stack_trace_print(ra->trace, ra->trace_len, 2);
 }
 #else
-static void inline __save_stack_trace(struct ref_action *ra)
+static inline void __save_stack_trace(struct ref_action *ra)
 {
 }
 
-static void inline __print_stack_trace(struct btrfs_fs_info *fs_info,
+static inline void __print_stack_trace(struct btrfs_fs_info *fs_info,
 				       struct ref_action *ra)
 {
 	btrfs_err(fs_info, "  ref-verify: no stacktrace support");
