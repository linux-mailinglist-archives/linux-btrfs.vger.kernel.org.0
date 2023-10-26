Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778D27D83A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 15:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbjJZNer convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 26 Oct 2023 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Oct 2023 09:34:46 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021E518F;
        Thu, 26 Oct 2023 06:34:43 -0700 (PDT)
User-agent: mu4e 1.10.7; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     gregkh@linuxfoundation.org, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.com, patches@lists.linux.dev, stable@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6.5 211/285] btrfs: scrub: fix grouping of read IO
In-Reply-To: <20230917191058.870881178@linuxfoundation.org>
Date:   Thu, 26 Oct 2023 14:31:39 +0100
Organization: Gentoo
Message-ID: <87fs1x1p93.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

'btrfs: scrub: fix grouping of read IO' seems to intorduce a
-Wmaybe-uninitialized warning (which becomes fatal with the kernel's
passed -Werror=...) with 6.5.9:

```
# CC      fs/btrfs/scrub.o
  x86_64-pc-linux-gnu-gcc -Wp,-MMD,fs/btrfs/.scrub.o.d -nostdinc -I/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/arch/x86/include -I./arch/x86/include/generated -I/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/include -I./include -I/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/include/uapi -I./include/generated/uapi -include /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/include/linux/compiler-version.h -include /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/include/linux/kconfig.h -include /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/include/linux/compiler_types.h -D__KERNEL__ -Werror -fmacro-prefix-map=/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/= -std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -Wall -Wundef -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Werror=strict-prototypes -Wno-format-security -Wno-trigraphs -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -fcf-protection=branch -fno-jump-tables -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -march=core2 -mno-red-zone -mcmodel=kernel -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunction-return=thunk-extern -fno-jump-tables -mharden-sls=all -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncation -Wno-format-overflow -Wno-address-of-packed-member -O2 -fno-allow-store-data-races -Wframe-larger-than=2048 -fstack-protector-strong -Wno-main -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-dangling-pointer -fomit-frame-pointer -ftrivial-auto-var-init=zero -fno-stack-clash-protection -fzero-call-used-regs=used-gpr -falign-functions=16 -Wvla -Wno-pointer-sign -Wcast-function-type -fstrict-flex-arrays=3 -Wno-stringop-truncation -Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized -Wno-array-bounds -Wno-alloc-size-larger-than -Wimplicit-fallthrough=5 -fno-strict-overflow -fno-stack-check -fconserve-stack -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wno-packed-not-aligned -DRANDSTRUCT -fplugin=./scripts/gcc-plugins/randomize_layout_plugin.so -fplugin-arg-randomize_layout_plugin-performance-mode -fplugin=./scripts/gcc-plugins/latent_entropy_plugin.so -fplugin=./scripts/gcc-plugins/structleak_plugin.so -fplugin=./scripts/gcc-plugins/stackleak_plugin.so -DLATENT_ENTROPY_PLUGIN -DSTRUCTLEAK_PLUGIN -DSTACKLEAK_PLUGIN -fplugin-arg-stackleak_plugin-track-min-size=100 -fplugin-arg-stackleak_plugin-arch=x86 -Wextra -Wunused -Wno-unused-parameter -Wmissing-declarations -Wmissing-format-attribute -Wmissing-prototypes -Wold-style-definition -Wmissing-include-dirs -Wunused-but-set-variable -Wunused-const-variable -Wpacked-not-aligned -Wstringop-truncation -Wmaybe-uninitialized -Wno-missing-field-initializers -Wno-sign-compare -Wno-type-limits -Wno-shift-negative-value -I /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs -I ./fs/btrfs    -DKBUILD_MODFILE='"fs/btrfs/btrfs"' -DKBUILD_BASENAME='"scrub"' -DKBUILD_MODNAME='"btrfs"' -D__KBUILD_MODNAME=kmod_btrfs -c -o fs/btrfs/scrub.o /var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c: In function ‘scrub_simple_mirror.isra’:
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2075:29: error: ‘found_logical’ may be used uninitialized [-Werror=maybe-uninitialized[https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wmaybe-uninitialized]]
 2075 |                 cur_logical = found_logical + BTRFS_STRIPE_LEN;
/var/tmp/portage/sys-kernel/gentoo-kernel-6.5.9/work/linux-6.5/fs/btrfs/scrub.c:2040:21: note: ‘found_logical’ was declared here
 2040 |                 u64 found_logical;
      |                     ^~~~~~~~~~~~~
```
