Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8643086C
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Oct 2021 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbhJQLmJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Oct 2021 07:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245539AbhJQLmG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Oct 2021 07:42:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26B4C061765
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Oct 2021 04:39:56 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t127so190213ybf.13
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Oct 2021 04:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oVeQWMwVezP8TwRuUMsdUG10JyKHS6mlTPWWLBXNZLM=;
        b=We7lia2jMv+KG+ztwD1EdJazynbQdl29uTaa7nFWRetUWlDghgA1qIKM3ocYTLxgCt
         aQ4VK+tARMukgEY5kHiYEZqk76rpS5ym+zA29ttA4gQI0VdFdKVIXG4XaXJM1u29aMbk
         TOEk8GNJX1HbHDnqm9mKawsUWMwe00b2duUO1QqXZHBStIjZ2+TkGUvl/gciuraOLms/
         YUMPBDPniacmJhy205pfBhEB2BrvpFBGVNb0++rZrtKr5BX8vXNJ8OvuLJskoOZaL7WB
         f6sunlsWwc0g+FnyuJzjgeQ0s4CrrDv3EVUDbZ6QvEFs0Rx55X3Lg2gP0Y56msTWCyYI
         O3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oVeQWMwVezP8TwRuUMsdUG10JyKHS6mlTPWWLBXNZLM=;
        b=iB1KiSL+5Pnmt1GoFdFaX8ea2Kf4/s5YfJHjghIhufubbJixGYOx4cTqAIXNcojc0Q
         4Vbo0jP/J/EvlLZTDDTVPnoI+re1Inl1pEh0NyRT56sHIwqMQhedNpYuBxovREpLuQwb
         qSyX7+nJ2w7aJrOeyDQ5nmtYHMEO3FQEVXI26IjfxWZMPCHNjX1vV2/q1X5QlzkWaYn0
         ZDshYZR+pTc3qGBPC3I0N0L6x8EMkGVZ4ej3wzxuUM5rbTX7nnm2hmw0HD7RG2XIgJKa
         eoNzxpLmnnnEf+10BM2aKjHDhxICfcIAY5NL9182lz6N6/zzLkS6FrWD1BouF+Vnih3v
         a3JQ==
X-Gm-Message-State: AOAM530GN9JcEA49IH/kUtDunnJkq4g1qJF2Ic/Tzkguilxz1RwMenNm
        B4iD7Z8GYyAQ4VARnD0m8Fp9VsFkSn3SowYdfyE=
X-Google-Smtp-Source: ABdhPJy7n0m6SzxoLkmnkS+2+BfaN+4golChIAXuopL5BcRsPO4EplNsUf4oZAHlgQdJeZpAMxYLTOsBTlqKsqlhvQ4=
X-Received: by 2002:a05:6902:701:: with SMTP id k1mr25808106ybt.298.1634470796085;
 Sun, 17 Oct 2021 04:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
In-Reply-To: <CA+r1ZhgCPB0JYyfC=pRK3mP0_xXGfTW9YpYV0RtYZ_pDMdYCOg@mail.gmail.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 17 Oct 2021 07:39:20 -0400
Message-ID: <CAEg-Je8Ao8VdZsajsuNheysqM=zjwZ+d9MowhEygfV63f6Qy9w@mail.gmail.com>
Subject: Re: Ubuntu 21.10, raid1c3, and grub
To:     Jim Davis <jim.epost@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 17, 2021 at 6:37 AM Jim Davis <jim.epost@gmail.com> wrote:
>
> I've been trying some experiments with raid1c3 on a qemu virtual
> machine running Ubuntu 21.10.  Choosing btrfs initially as the root
> file system during installation works just fine.
>
> Adding a new virtual disk to btrfs root file system and running btrfs
> balance with -mconvert=3Draid1 and -dconvert=3Draid1 works too -- the vm
> reboots with no problems.
>
> Adding another new virtual disk to btrfs root file system and running
> btrfs balance again, with -mconvert=3Draid1c3 and -dconvert=3Draid1c3 and
> then rebooting doesn't work: the vm drops into grub rescue with a
> cryptic
>
> error: unsupported RAID flags 202
>
> message.  Any ideas?
>

Support for the raid1cX modes was added to GRUB in GRUB 2.06. The
Debian family (including Ubuntu) has not upgraded yet, nor have they
backported the support to their custom release of GRUB 2.04 yet. I
would suggest filing a bug with Ubuntu to backport the following
commit: https://git.savannah.gnu.org/cgit/grub.git/commit/grub-core/fs/btrf=
s.c?id=3D495781f5ed1b48bf27f16c53940d6700c181c74c


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
