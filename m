Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8AB6DB783
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Apr 2023 02:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDHAKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Apr 2023 20:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHAKT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Apr 2023 20:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B97A1206D;
        Fri,  7 Apr 2023 17:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F50965470;
        Sat,  8 Apr 2023 00:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33220C433EF;
        Sat,  8 Apr 2023 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680912617;
        bh=okAm7dvPQI8Xmx3ABwPMyvuvipeW06J4NsWZJZRNLAU=;
        h=From:To:Cc:Subject:Date:From;
        b=BRBTZBtUo5UTZ02rCI45m2XEEEwvBingYjZrSIRu/KUIvqAhwbdZRTg2iKRa3aF7e
         yv1cLpzMY1bDnV7E5jPaYhI/BHJE1RtMWX8Znm3bLI68x14HfmYizxFg7tsekWWoYL
         oCg2QD6GuS2L5O3X2zyiAkrkBzCuFrHIXPdPoBwRMA7nsmZhOaL5vpfjPHIGNwLSsS
         0ip1OzD6MnRNyK8bXZiqQkCHGB0h2q5jJddi1ZTyHFo88laV/rZt5ELMV4iVlSq+US
         2GaI/jhstL12ha7ecAULffpAUtI6WVGtBz5mw9YsLDASmOhackAmmVqJ9dsExT/XJX
         fTf7BZYZVH+Ew==
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
Subject: [PATCH 00/12] Sprinkle more __noreturn
Date:   Fri,  7 Apr 2023 17:09:53 -0700
Message-Id: <cover.1680912057.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Add some more __noreturn annotations.

Many of these have been flushed out by kernel IBT support which made
objtool vmlinux validation much more common.

These annotations are generally a good thing as they improve readability
and code generation.


Guilherme G. Piccoli (1):
  x86/hyperv: Mark hv_ghcb_terminate() as noreturn

Josh Poimboeuf (10):
  init: Mark [arch_call_]rest_init() __noreturn
  init: Mark start_kernel() __noreturn
  x86/head: Mark *_start_kernel() __noreturn
  btrfs: Mark btrfs_assertfail() __noreturn
  arm64/cpu: Mark cpu_park_loop() and friends __noreturn
  cpu: Mark panic_smp_self_stop() __noreturn
  cpu: Mark nmi_panic_self_stop() __noreturn
  x86/cpu: Mark {hlt,resume}_play_dead() __noreturn
  objtool: Include weak functions in global_noreturns check
  scsi: message: fusion: Mark mpt_halt_firmware() __noreturn

 arch/arm/kernel/smp.c              |  2 +-
 arch/arm64/include/asm/exception.h |  2 +-
 arch/arm64/include/asm/smp.h       |  7 +++----
 arch/arm64/kernel/entry-common.c   |  2 +-
 arch/arm64/kernel/smp.c            | 10 ++++++----
 arch/arm64/kernel/traps.c          |  3 +--
 arch/powerpc/kernel/setup_64.c     |  2 +-
 arch/s390/kernel/setup.c           |  2 +-
 arch/x86/hyperv/ivm.c              |  2 +-
 arch/x86/include/asm/mshyperv.h    |  2 +-
 arch/x86/include/asm/reboot.h      |  1 -
 arch/x86/include/asm/setup.h       |  6 +++---
 arch/x86/include/asm/smp.h         |  2 +-
 arch/x86/kernel/head32.c           |  2 +-
 arch/x86/kernel/head64.c           |  4 ++--
 arch/x86/kernel/reboot.c           |  2 +-
 arch/x86/kernel/smpboot.c          |  2 +-
 arch/x86/power/cpu.c               |  2 +-
 drivers/message/fusion/mptbase.c   |  2 +-
 drivers/message/fusion/mptbase.h   |  2 +-
 fs/btrfs/messages.c                |  2 +-
 fs/btrfs/messages.h                |  2 +-
 include/linux/smp.h                |  4 ++--
 include/linux/start_kernel.h       |  6 +++---
 init/main.c                        |  6 +++---
 kernel/panic.c                     |  4 ++--
 tools/objtool/check.c              | 20 ++++++++++++++++----
 27 files changed, 57 insertions(+), 46 deletions(-)

-- 
2.39.2

