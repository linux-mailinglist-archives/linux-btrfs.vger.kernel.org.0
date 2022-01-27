Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7849E23E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiA0MWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 07:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiA0MWS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 07:22:18 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA49DC061748
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 04:22:17 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id r65so8023312ybc.11
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 04:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=3hB9Pz6IWWJ5e7Q7LJO+f7Hvw0FPQfxvZX3pslGGprg=;
        b=ntq5txrAiaRnnSYQlIbMFX9yyxuv2ySgZhUuXwgFl3VjEENE4TPnfiUcbKWy8UlCJH
         Xv1qCObUn7HIRPtto8YmdaTIigsu2/dBkvzn5zBUCS5Rom0RnrUMLb3Hi/Y53yplNPRb
         iSCil1KGMM17K5x1zt5/gEOx3o3O4a27dS+B20iOxYHrBaDQQYXZ2skDKGiYC8Yd5U+O
         rtuO1yMa2eiiI4Fb9RQvskyNLOQwNSn5ioCb+pyLVAHGAUrqZZaeJxTEX4tyDRjirPMy
         EYuyE+oBQnfwKwtfEK4+pjkM2bct8AFgQJ9DHU8VArEw375D/5uNj8pNWuqBx4OWldmg
         l05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3hB9Pz6IWWJ5e7Q7LJO+f7Hvw0FPQfxvZX3pslGGprg=;
        b=G6pg2ltzxbQ3xMYKkOO2beZMdslGcyWkiJP4Hfsu3txzDkRBmc6iu/mSN3FcrBatya
         uiErm1BcSH4cqygnA3fQ9IvfEeiuqK4NpPg6Tl9OlXy4E0/Eat2s+WT6ABwtb8k4o7R9
         ndqou55WmGHNytp02tCJ4CCLXOlP19JPKlftlYvbSoTJYsfd4WTFZhkyOyqCuTLf8eqg
         YsCt0xhD6jTEO9XFVjZOj6eTp1CSJSh0bCOJTgRO9ajTP4eBM11G4cCb9PduyDVoMdty
         gEtjiVC1UwIxA61XIMNroYF63/i+x1pMlcKEOft00GkIX3jj+JdzIvczqmKu+ONrS3QH
         T32Q==
X-Gm-Message-State: AOAM530jTf+nJE6XvHAkN1i2wee1brqLHAY2sNAN4C3LGszD3MzF//v7
        MVfiWIfq/xHFZVUPtJLwEOc95yeBQoiBXs1/NqVBwQ==
X-Google-Smtp-Source: ABdhPJzytcm5xEDIvl0zeaLFWxg0fZUVG5vboDDlEChIHTA93sE6aZZBgrDRfJIg+aN0+BwPBqgtjUxzA37MsECRi1k=
X-Received: by 2002:a25:b13:: with SMTP id 19mr4857037ybl.684.1643286137004;
 Thu, 27 Jan 2022 04:22:17 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 27 Jan 2022 17:52:05 +0530
Message-ID: <CA+G9fYtGGdxLwkV=VHdDP_d2C0oLd7=wUhF1wcYtndpp-y5BTA@mail.gmail.com>
Subject: [next] i386: ERROR: modpost: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ Please ignore this email if it is already reported ]

Regression detected while building modules Linux next-20220127 on arm and i386
with kselftest (kselftest-merge) configs with gcc-11.

Build errors i386:
------------------
make --silent --keep-going --jobs=8
  ARCH=i386 CROSS_COMPILE=i686-linux-gnu- 'CC=sccache
i686-linux-gnu-gcc' 'HOSTCC=sccache gcc'

ERROR: modpost: "__umoddi3" [fs/btrfs/btrfs.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
modules-only.symvers] Error 1
make[2]: *** Deleting file 'modules-only.symvers'

Build errors arm:
------------------
make --silent --keep-going --jobs=8
  ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'

ERROR: modpost: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
modules-only.symvers] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


meta data:
-----------
    git describe: next-20220127
    git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
    git_sha: 0eb96e2c58c03e79fc2ee833ba88bf9226986564
    git_short_log: 0eb96e2c58c0 (\"Add linux-next specific files for 20220127\")
    target_arch: arm / i386
    toolchain: gcc-11

Build log:
-------------
https://builds.tuxbuild.com/24GSTOD7EpxnncxTZgHJzXw97t5/
https://builds.tuxbuild.com/24A38knX5TuIfIPU54KLcUReDcN/


steps to reproduce:
-------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch i386 --toolchain gcc-11 \
 --kconfig https://builds.tuxbuild.com/24GSQgCAtqXT6UgGf37kLxUHlYX/config \
   cpupower headers kernel kselftest kselftest-merge modules


--
Linaro LKFT
https://lkft.linaro.org
