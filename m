Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CD96E02D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjDLXuV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDLXuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A91F6A4D;
        Wed, 12 Apr 2023 16:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E092763A40;
        Wed, 12 Apr 2023 23:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB37C4339E;
        Wed, 12 Apr 2023 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343404;
        bh=b7H0OJvgITv94oCGcITa5YVvEl/zb04TPx9I9PIgGgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgXvqcgO8S/huUHYkPIWf6A1TYBBpJ6x0TY5qyPabj9iVthVARVRqchnngLYFY7P3
         bxgW0McN7dRrjgj+Ntr8BWHyTCh+bQK1fitf+5OzhURtF5KRMT9c7MEe+GymyI8+mP
         xWHsauWUwTeEyFoa3+FeI6+AbEuOihgeIOeUFtWjAD5ukCjjW3PFGFqrOJIcpLLcIn
         6YwE6d9D+EHHpxyY1hve8Hc1/rxrCirj8g31OLKLLB9SbVX7vAHlgM+4lD5IQEEy1k
         5zh5xeziXrJkvk+L13P0hhi/jaw2jvJ+Mb6ONeeGCXw2sBcCL7xQOs4kBVmA+kj5w5
         ChIH9EexYLsQA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-btrfs@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 10/11] scsi: message: fusion: Mark mpt_halt_firmware() __noreturn
Date:   Wed, 12 Apr 2023 16:49:40 -0700
Message-Id: <d8129817423422355bf30e90dadc6764261b53e0.1681342859.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681342859.git.jpoimboe@kernel.org>
References: <cover.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

mpt_halt_firmware() doesn't return.  Mark it as such.

Fixes the following warnings:

  vmlinux.o: warning: objtool: mptscsih_abort+0x7f4: unreachable instruction
  vmlinux.o: warning: objtool: mptctl_timeout_expired+0x310: unreachable instruction

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302271743.78emit6I-lkp@intel.com/
Reported-by: Mark Rutland <mark.rutland@arm.com>
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/message/fusion/mptbase.c | 2 +-
 drivers/message/fusion/mptbase.h | 2 +-
 tools/objtool/check.c            | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 9b3ba2df71c7..4f0afce8428d 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6935,7 +6935,7 @@ EXPORT_SYMBOL(mpt_clear_taskmgmt_in_progress_flag);
  *	@ioc: Pointer to MPT_ADAPTER structure
  *
  **/
-void
+void __noreturn
 mpt_halt_firmware(MPT_ADAPTER *ioc)
 {
 	u32	 ioc_raw_state;
diff --git a/drivers/message/fusion/mptbase.h b/drivers/message/fusion/mptbase.h
index 4bd0682c65d3..0f226cdad64f 100644
--- a/drivers/message/fusion/mptbase.h
+++ b/drivers/message/fusion/mptbase.h
@@ -945,7 +945,7 @@ extern int	mpt_raid_phys_disk_get_num_paths(MPT_ADAPTER *ioc,
 		u8 phys_disk_num);
 extern int	 mpt_set_taskmgmt_in_progress_flag(MPT_ADAPTER *ioc);
 extern void	 mpt_clear_taskmgmt_in_progress_flag(MPT_ADAPTER *ioc);
-extern void     mpt_halt_firmware(MPT_ADAPTER *ioc);
+extern void __noreturn mpt_halt_firmware(MPT_ADAPTER *ioc);
 
 
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a42a2af99ea2..8586d4c36600 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -219,6 +219,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"lbug_with_loc",
 		"machine_real_restart",
 		"make_task_dead",
+		"mpt_halt_firmware",
 		"nmi_panic_self_stop",
 		"panic",
 		"panic_smp_self_stop",
-- 
2.39.2

