Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD72234BEE4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Mar 2021 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhC1U1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Mar 2021 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhC1U1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Mar 2021 16:27:20 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14351C061756;
        Sun, 28 Mar 2021 13:27:20 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a143so11647272ybg.7;
        Sun, 28 Mar 2021 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGgxsKIZ3ZTl676JeHS4fOQwF1EPR3Hj3EDiz1utvk4=;
        b=VS5q4VxiAS87vvfgBnL2SidrpAg/XELlQwKgngDhkEgMRpxGB39RnlEYeY8I7htT/a
         hMrPZobTQbgpX29GLYdNvayQ+u/5sPEV0eCWwm5/pEDHuG6MpZE32jZcGcUOOwcrIT1o
         9XvuWADd2LoVpLMVsJSRTy9SXnxXGV3Smn/hZ/6YBUWEmnMdsm8nxc0MUPOA2dvYf9bD
         ezss+DucD2pifMU8obi+vgXy2JT2m6tjn1x07o1MmzmRSimmgfftTFvin+efdODqMBfN
         ht/DkDR8ADwxGQ8/EvkS+qWY7szaPqsvGZiSUHqYVgVYi3QD/Gl+FVQQd84BU35qZt9n
         uIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGgxsKIZ3ZTl676JeHS4fOQwF1EPR3Hj3EDiz1utvk4=;
        b=QBo2maJM8fi1o5HQOpsha7MO36fgGb+nyk5c6wvEeLamWJst5J0C+mOU1NQG9Sn0do
         /GsmxRsYGWrTwMdtph15mFIowRAx1aq6IyNP9S7sLjhe71nRmAnIbN9LX1uLkSpuZ8DL
         Y3akQPGrHxfVZ8elAOLKImVlIc9H5w2oflD3wwusbICrtOFNXgVgmgAg38Mi48+wP6Jr
         txsiZSUADoLd07s9sdZDHVfuvJ11expYTCX2KWDmxE8aw6Dgza1S6UpB4hLKLNh2nISj
         Iv1lHHKIQHVrg5dKCYw9HlspDCkJ5lTBNLTtRrrMY5iRipsuC1aBwmbSZ4cSdv+moYGc
         vi9A==
X-Gm-Message-State: AOAM5301Yk2LRD4hZRQbkDhXndCZEwkQ9KByhENKWQZWlcG+7hWDn/Wa
        RBmmC61xdYXIUXKsriEa2SIA+7leFLnAi4/0OcA=
X-Google-Smtp-Source: ABdhPJxuAdjTDxc71Oy8C0UVXTHKXzlKnq6zWZH7sSY2imXDYAxH6YgtvPjubmyw3GMWCvW4SZXi9LBHNz2ZwdihP0c=
X-Received: by 2002:a25:2d62:: with SMTP id s34mr30625290ybe.209.1616963239300;
 Sun, 28 Mar 2021 13:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210326191859.1542272-2-nickrterrell@gmail.com>
 <202103271719.VoxPHugN-lkp@intel.com> <20210327214810.ldijpbr2tnkh2gce@spock.localdomain>
In-Reply-To: <20210327214810.ldijpbr2tnkh2gce@spock.localdomain>
From:   Nick Terrell <nickrterrell@gmail.com>
Date:   Sun, 28 Mar 2021 13:27:08 -0700
Message-ID: <CANr2DbeAXeYRMAa1UjP5kNqniWQvt2nM93ZjmWioEuR4qZxf1g@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] lib: zstd: Add kernel-specific API
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Chris Mason <chris.mason@fusionio.com>,
        Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 27, 2021 at 2:48 PM Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> Hello.
>
> On Sat, Mar 27, 2021 at 05:48:01PM +0800, kernel test robot wrote:
> > >> ERROR: modpost: "ZSTD_maxCLevel" [fs/f2fs/f2fs.ko] undefined!
>
> Since f2fs can be built as a module, the following correction seems to
> be needed:

Thanks Oleksandr! Looks like f2fs has been updated to use
ZSTD_maxCLevel() since the first version of these patches. I'll put up
a new version shortly with the fix, and update my test suite to build
f2fs and other users as modules, so it can catch this.

Best,
Nick

> ```
> diff --git a/lib/zstd/compress/zstd_compress.c b/lib/zstd/compress/zstd_compress.c
> index 9c998052a0e5..584c92c51169 100644
> --- a/lib/zstd/compress/zstd_compress.c
> +++ b/lib/zstd/compress/zstd_compress.c
> @@ -4860,6 +4860,7 @@ size_t ZSTD_endStream(ZSTD_CStream* zcs, ZSTD_outBuffer* output)
>
>  #define ZSTD_MAX_CLEVEL     22
>  int ZSTD_maxCLevel(void) { return ZSTD_MAX_CLEVEL; }
> +EXPORT_SYMBOL(ZSTD_maxCLevel);
>  int ZSTD_minCLevel(void) { return (int)-ZSTD_TARGETLENGTH_MAX; }
>
>  static const ZSTD_compressionParameters ZSTD_defaultCParameters[4][ZSTD_MAX_CLEVEL+1] = {
> ```
>
> Not sure if the same should be done for `ZSTD_minCLevel()` since I don't
> see it being used anywhere else.
>
> --
>   Oleksandr Natalenko (post-factum)
