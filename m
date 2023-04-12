Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66D6E02B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Apr 2023 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLXuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Apr 2023 19:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLXuA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Apr 2023 19:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FD35BB1;
        Wed, 12 Apr 2023 16:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B6F63960;
        Wed, 12 Apr 2023 23:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CB0C433D2;
        Wed, 12 Apr 2023 23:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681343398;
        bh=etFLsyG8PVeKyRqsFsAJuWcitukhr35OF8YfzA/B/uU=;
        h=From:To:Cc:Subject:Date:From;
        b=Fle6YnhfkktHgpS1y/dn4mT0ZAM5p33qQSEQi8QbgGPAm5fG6uKAY9FFEC/IbmCN7
         CIHA5LAjdfY655R7Mynd7XzgmreQYEmtA8nVP+gvFqh6QK2BFwc1JBiAfxPTIu5jUT
         50lIYsq0OsimWrwVt9821nkP3of+FNJeXqOK+2+jFPNBmMySdzEIkC7dubciRcoIgx
         yl8XltKZ/hP7o+OX353n0LXv3kf7rvVqSIkSxrALCazSJ22WoWHEiynHy3qwNntzCs
         RYtXqHd5Vh+gzpL6xRtpJcab70ksIiTcyD2y+ZfRk6eDl9vbwIydwtiB73dqxh6lR3
         Hj3ShvQ2ZMU7w==
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
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 00/11] Sprinkle more __noreturn
Date:   Wed, 12 Apr 2023 16:49:30 -0700
Message-Id: <cover.1681342859.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
- improve commit logs
- reorder patches: patches 1-6 are prereqs for patch 7

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
  arm64/cpu: Mark cpu_park_loop() and friends __noreturn
  cpu: Mark panic_smp_self_stop() __noreturn
  cpu: Mark nmi_panic_self_stop() __noreturn
  objtool: Include weak functions in global_noreturns check
  btrfs: Mark btrfs_assertfail() __noreturn
  x86/cpu: Mark {hlt,resume}_play_dead() __noreturn
  scsi: message: fusion: Mark mpt_halt_firmware() __noreturn

 arch/arm/kernel/smp.c              |  2 +-
 arch/arm64/include/asm/exception.h |  4 ++--
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
 27 files changed, 58 insertions(+), 47 deletions(-)

-- 
2.39.2

