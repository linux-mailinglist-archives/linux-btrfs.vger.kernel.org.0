Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAE66DB7AE
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDHAKn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDHAKY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3B912851;
        Fri,  7 Apr 2023 17:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6302664D4F;
        Sat,  8 Apr 2023 00:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6365FC4339C;
        Sat,  8 Apr 2023 00:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912622;
        bh=nPPJKoXoUDUyf2kVRAhGsCxgWLcp4kLpuj6wa6/Qr/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2bFZsZQsdk0J2F99z8mRARYtyBZ4J35WIXonbBeBI/HVs0WBc4rjteQsgv6nYPRN
         ccXqfuJQl+2xsaizeMorppAdC1QWJOSMvXiGAdKMvFawvJOzhQjHE3alFD4FiMPwT/
         QaBLzOQTT1XmEt8t+mvz1N8/o01fOc8Go5IZwFEsZpXfhKv8t9N2C5tYHwylNC804l
         /jY8suzff/3WiJ4Ej+1GHD/PMXDXDKpq/3Ho+d8p3/B7nf12jMe78hspXI2xe3ZNsS
         9IAdJQsdOA3utdmErpBNWQ1DDGaSocRhjaORS9J85QpCaa+L9yBhjhJZJiibxVFc/m
         JyM6lkaQBameg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 09/11] objtool: Include weak functions in global_noreturns check
Date:   Fri,  7 Apr 2023 17:10:02 -0700
Message-Id: <c5939160ab44a078b00adfb55966cb8fe4fb065b.1680912057.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680912057.git.jpoimboe@kernel.org>
References: <cover.1680912057.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a global function doesn't return, and its prototype has the
__noreturn attribute, its weak counterpart must also not return so that
it matches the prototype and meets call site expectations.

To properly follow the compiled control flow at the call sites, change
the global_noreturns check to include both global and weak functions.

On the other hand, if a weak function isn't in global_noreturns, assume
the prototype doesn't have __noreturn.  Even if the weak function
doesn't return, call sites treat it like a returnable function.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a926da218c01..a42a2af99ea2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -239,14 +239,14 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	if (!func)
 		return false;
 
-	if (func->bind == STB_WEAK)
-		return false;
-
-	if (func->bind == STB_GLOBAL)
+	if (func->bind == STB_GLOBAL || func->bind == STB_WEAK)
 		for (i = 0; i < ARRAY_SIZE(global_noreturns); i++)
 			if (!strcmp(func->name, global_noreturns[i]))
 				return true;
 
+	if (func->bind == STB_WEAK)
+		return false;
+
 	if (!func->len)
 		return false;
 
-- 
2.39.2

