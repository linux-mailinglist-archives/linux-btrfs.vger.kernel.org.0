Return-Path: <linux-btrfs+bounces-6820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF993F13F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 11:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C01F22F1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12196140363;
	Mon, 29 Jul 2024 09:35:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4B78C89
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245752; cv=none; b=CZGJ2p9+5mw9SdIrPt9DCx/yS9B6mp7iooTAlvpcgHL8FaUbrs+mKUBvrodILx+yTIe2OHOSv+2lvSCuYxMGI5tLHUTtvS+izq3/i5ooWIIEDiBQuEBMiT5a6vh9VYmQGDy/WJMLK4gJHc54xmGRXGcHSvObAUcuOZLgVlHz7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245752; c=relaxed/simple;
	bh=u8fssbfHLReHgwFcYSSHWp/ORzdxoBuiW/cGlV/ryAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cVUHFZRnv5lHVWGOf0k2AJIYb69EiaiaRbkMoOlowrLrpdfcTdDIXB1dLPHdfV+wngAvML1x/n9T++KOAZ8zcdFhgFh1GJHUikcxLKI/1DX8nz6bogDts8U8+O/7WvAG9CWMPKlcimEYrbfChp4zUx4W/+wDzXSfObEUp9rW0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:4441:3808:f850:4280])
	by andre.telenet-ops.be with bizsmtp
	id tMbo2C0080ZURL201MboMp; Mon, 29 Jul 2024 11:35:49 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sYMnE-003sYs-9i;
	Mon, 29 Jul 2024 11:35:48 +0200
Date: Mon, 29 Jul 2024 11:35:48 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-mips@vger.kernel.org, dm-devel@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org, 
    intel-xe@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, 
    linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.11-rc1
In-Reply-To: <20240729092807.2235937-1-geert@linux-m68k.org>
Message-ID: <bd4e9928-17b3-9257-8ba7-6b7f9bbb639a@linux-m68k.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com> <20240729092807.2235937-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Jul 2024, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.11-rc1[1] compared to v6.10[2].
>
> Summarized:
>  - build errors: +7/-22

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8400291e289ee6b2bf9779ff1c83a291501f017b/ (all 132 configs)

> 7 error regressions:
>  + /kisskb/src/arch/mips/sgi-ip22/ip22-gio.c: error: initialization of 'int (*)(struct device *, const struct device_driver *)' from incompatible pointer type 'int (*)(struct device *, struct device_driver *)' [-Werror=incompatible-pointer-types]:  => 384:14

mips-gcc8/ip22_defconfig

>  + /kisskb/src/drivers/md/dm-integrity.c: error: logical not is only applied to the left hand side of comparison [-Werror=logical-not-parentheses]:  => 4718:45

powerpc-gcc5/powerpc-all{mod,yes}config
powerpc-gcc5/ppc64le_allmodconfig

>  + /kisskb/src/fs/btrfs/inode.c: error: 'location.objectid' may be used uninitialized in this function [-Werror=maybe-uninitialized]:  => 5603:9
>  + /kisskb/src/fs/btrfs/inode.c: error: 'location.type' may be used uninitialized in this function [-Werror=maybe-uninitialized]:  => 5674:5

m68k-gcc8/m68k-allmodconfig
mips-gcc8/mips-allmodconfig
powerpc-gcc5/powerpc-all{mod,yes}config
powerpc-gcc5/ppc64_defconfig

>  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_933' declared with attribute error: FIELD_GET: mask is not constant:  => 510:38
>  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_934' declared with attribute error: FIELD_GET: mask is not constant:  => 510:38

     inlined from 'xe_oa_set_prop_oa_format' at /kisskb/src/drivers/gpu/drm/xe/xe_oa.c:1664:6:

powerpc-gcc5/powerpc-all{yes,mod}config
powerpc-gcc5/powerpc-allmodconfig
powerpc-gcc5/ppc64le_allmodconfig

(fix sent)

>  + /kisskb/src/kernel/fork.c: error: #warning clone3() entry point is missing, please fix [-Werror=cpp]:  => 3072:2

sh4-gcc13/se{7619,7750}_defconfig
sh4-gcc13/sh-all{mod,no,yes}config
sh4-gcc13/sh-defconfig
sparc64-gcc5/sparc-allnoconfig
sparc64-gcc{5,13}/sparc32_defconfig
sparc64-gcc{5,13}/sparc64-{allno,def}config
sparc64-gcc13/sparc-all{mod,no}config
sparc64-gcc13/sparc64-allmodconfig

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

