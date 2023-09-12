Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D99679C718
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjILGjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Sep 2023 02:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjILGjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Sep 2023 02:39:44 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64689E78
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Sep 2023 23:39:40 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:a74b:c851:eeda:f0c8])
        by baptiste.telenet-ops.be with bizsmtp
        id kufc2A00g0nS7QV01ufciw; Tue, 12 Sep 2023 08:39:37 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qfx3f-0031t8-Gh;
        Tue, 12 Sep 2023 08:39:35 +0200
Date:   Tue, 12 Sep 2023 08:39:35 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
cc:     Lee Jones <lee@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.6-rc1
In-Reply-To: <20230911083848.1027669-1-geert@linux-m68k.org>
Message-ID: <2f6a64e5-39de-d256-aabe-4e57aa83925@linux-m68k.org>
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com> <20230911083848.1027669-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 11 Sep 2023, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.6-rc1[1] compared to v6.5[2].
>
> Summarized:
>  - build errors: +4/-13
>  - build warnings: +4/-1453
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0bb80ecc33a8fb5a682236443c1e740d5c917d1d/ (all 237 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/2dde18cd1d8fac735875f2e4987f11817cc0bc2c/ (234 out of 237 configs)
>
>
> *** ERRORS ***
>
> 4 error regressions:
>  + /kisskb/src/drivers/mfd/cs42l43.c: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]:  => 1106:12
>  + /kisskb/src/drivers/mfd/cs42l43.c: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]:  => 1138:12
>  + /kisskb/src/drivers/mfd/cs42l43.c: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]:  => 1124:12
>  + /kisskb/src/drivers/mfd/cs42l43.c: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]:  => 1076:12

Various configs
Fix available:
https://lore.kernel.org/r/20230822114914.340359-1-ckeepax@opensource.cirrus.com

> *** WARNINGS ***
>
> 4 warning regressions:
>  + /kisskb/src/fs/btrfs/volumes.c: warning: 'dev_offset' may be used uninitialized [-Wmaybe-uninitialized]:  => 5245:48
>  + /kisskb/src/fs/btrfs/volumes.c: warning: 'dev_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 5245:34
>  + /kisskb/src/fs/btrfs/volumes.c: warning: 'max_avail' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 5246:33

parisc64-gcc13/generic-64bit_defconfig
False positive

>  + modpost: WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text):  => N/A

sh4-gcc1[123]/sh-defconfig
Fix available:
https://lore.kernel.org/r/20230911093850.1517389-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
