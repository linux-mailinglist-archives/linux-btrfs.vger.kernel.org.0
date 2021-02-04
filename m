Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC430F05E
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Feb 2021 11:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbhBDKSc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Feb 2021 05:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbhBDKSa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Feb 2021 05:18:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A43C061573
        for <linux-btrfs@vger.kernel.org>; Thu,  4 Feb 2021 02:17:50 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w20so1984357qta.0
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Feb 2021 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TA188DblOI9eGBXwRqXmHf4jxNiuF1nfuqXX8JVF8n4=;
        b=Nvx16xiUDb9RrRAKvCP9e1PO4RHDzneJvDktG90Kfw2oEM9tqTMtycU27NrtwsIbc2
         mQhjEgigoheBU7vUPzjns+plHuNUmf9trpcztZBeZwB/oVzuvfSb0R8BREN/gGuKSi1V
         usvnZ0MLtxlCrffqO8I2u7YhxnpbfHzrJX/IjQ/wP+3xLYMXf3ulCLxIESLi8lZxTgVb
         C+GemSrTB54T2B56oATAi2ccVybYlUYPp+/lhlD4hVev0NVKcifAe82Uetno7/M7gzi9
         iunpQ5nXNI9rE9Fg5yWD8/gaJS4679zKa6zSyvTyRSu8rEjN2D0O9fjUjYZ5Nv4hOgY6
         A08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TA188DblOI9eGBXwRqXmHf4jxNiuF1nfuqXX8JVF8n4=;
        b=DFg075JQjFkhnnWmSYbjySdJbXuJfHYBsz+DsYpZ1Ws92JpsrM93xuHEoIFD1ddWMj
         waLNMGSZgSgOIGczJMjWEX9ognWs7QEpweeEbAPhbin0RwmQ6xHqKqELFvBAMsBznvSP
         78zh3BfI1rWPKdrqsxkGsnMMjYWD0th7nLII3mvbK7arQtImOuAXWeg90j0B265Yc/6I
         MfOBR5Av9XVZO/bf9Uf5SD6fzU4xhEp5mQDdyDIldnMdswt3/H0Qfr+E6bZ6Yu3Dcm9F
         CEpQXEemyGRoox32HUTVYl7YI/NMRnUobcb+2nalgI2p4nsBGHJCQGYqXCZmNY/UF68f
         wxYw==
X-Gm-Message-State: AOAM533VrHlpJisp+Ej3T7Kt/ksZQRXNJnil46Z1HfN1cxiS2AG06z0l
        ysiqP1nm+Nd7QVTS/dh1NAn5u5fmEFwkPOTQKQouN6QJN9o=
X-Google-Smtp-Source: ABdhPJyHrPQc2eWqmUUnkPLU+he2oNovOavYVV3V6bf0XJG5qSpHEhM0V4+BgGlnWYadHNLIvOWg7xuTLW7p6AaVwdc=
X-Received: by 2002:ac8:4755:: with SMTP id k21mr6465390qtp.376.1612433869574;
 Thu, 04 Feb 2021 02:17:49 -0800 (PST)
MIME-Version: 1.0
References: <0102017769efc912-ebdc0106-e400-4a3c-8209-f6abb4ac0e4f-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102017769efc912-ebdc0106-e400-4a3c-8209-f6abb4ac0e4f-000000@eu-west-1.amazonses.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 4 Feb 2021 10:17:38 +0000
Message-ID: <CAL3q7H5X-ytLKnPNYKdj3OtV8EaN_4ZH7RemM9rnqgan=Xjjgg@mail.gmail.com>
Subject: Re: Space cache
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 3, 2021 at 10:15 PM Martin Raiber <martin@urbackup.org> wrote:
>
> Hi,
>
> I've been looking a bit into the btrfs space cache and came to following =
conclusions. Please correct me if I'm wrong:
>
> 1. The space cache mount option only modifies how the space cache is pers=
isted and not the in-memory structures (hence why I have 2,3 GiB btrfs_free=
_space_bitmap slab with a file system mounted with space_cache=3Dv2)
> 2. In-memory it is mostly kept as bitmap. Space_cache=3Dv1 persists those=
 bitmaps directly to disk
> 3. If it's mounted with nospace_cache it still gets all the benefits of "=
space cache" _after_ those in-memory bitmaps have been filled, it just isn'=
t persisted
> 4. In-memory space cache doesn't react to memory pressure/is unevictable

You got it right.

>
> This leads me to:
>
> If one can live with slow startup/initial performance, mounting with nosp=
ace_cache has the highest performance.

Yes, there will be less IO during transaction commits since the space
caches are not persisted (metadata only for the space_cache=3Dv2 and
data + metadata for space_cache=3Dv1).
However keep in mind it's not just startup/initial performance - a
block group will be cached when we attempt to allocate space from it,
so it can happen at any time.

>
> Especially if I have a 1TB NVMe in a long-running server, I don't really =
care if it has to iterate over all block group metadata after mount for a f=
ew seconds, if that means it has less write IOs for every write. The calcul=
us obivously changes for a hard disk where reading this metadata would talk=
e forever due to low IOPS.
>
> Regards,
> Martin Raiber
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
