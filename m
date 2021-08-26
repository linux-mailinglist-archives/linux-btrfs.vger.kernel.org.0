Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75D73F84C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 11:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbhHZJtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 05:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbhHZJtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 05:49:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32502C061757
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 02:48:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t190so2628952qke.7
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Aug 2021 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=I8xGH2sRZaj0k0dkpjYZtqnGjVbFR1p/k3rgsQ1BalY=;
        b=nhZ4NvttE1QfmR+5hx2APfTiAYau7EnikOUk+hnuEsns8RneJtaKY21/qrUGc8s1Wf
         12E+VxjT3jkMgivrHaxMPQf79u8W/MXKBH5aOgwc5Mpm9V08IIxwiypvaKsUeOTCx7Xn
         1fkIR61g3Kj0XoTQYL9EUkBb+gCnTWpkPJB2v7TrvB89mxGdnSsYtrCpmD7KqRGvrDWu
         yjTPOreCrk+6QO8GypLglxBn9MRRpoeDQ2lGN9lpgyaBzsk4zDxyFgqii2Qgo/qCViIq
         GdTrDOLhXZ4Ay95S7FLhnurQRnRfC23bANVO6mWXYFyRqS1wZ1h+XgAvyH6OOzU/mLop
         yzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=I8xGH2sRZaj0k0dkpjYZtqnGjVbFR1p/k3rgsQ1BalY=;
        b=Ak6+l5Gaw8u7JOl9u+ymLwlGd0xUP9aR/IBAMni/qOhuoQ4oJSAPrpxocVB8vYP9/G
         9O79/9BQLfagSTOGd7d/tmmxJ3webVV/dhr9d014nRp26gTg/mY3oEkm9OsIyQPecDMy
         5Gj8v+zUncP0/gskEPPD+q+tDhPOpG0SlByK+U4TNxoHoGuNRYhp2tpVgKhd7QIPofGc
         AwqVuzJ5i2JNQEgJwpG8Jq+CQWv5Lx+1F5DO5jVbd17YsFtafRYg5Nu4FsWSssZdxS5O
         m60xRKgF8AyxN7sJa04//dnOqfN10reInUFuEQdjRh0n6xGhObMDQlrhTk1solClyaIL
         +IOw==
X-Gm-Message-State: AOAM532U94nSh+fugoI/+DEREJls3h4i+qQWX2FU4oK5YqSIi1Gl1UyF
        wipjQKweDldoxJgDmPMTLPdrdHMwayVo5dN3BQe2YyDL
X-Google-Smtp-Source: ABdhPJz5UJcHPB1qX15jh7auC2Xa858hQ1ZvEX/VqHXHtCyvL5h+0fCdGEUIo49JzakbXwppgBtZN5jMKIqx+R/DWlQ=
X-Received: by 2002:a05:620a:916:: with SMTP id v22mr2672009qkv.338.1629971304386;
 Thu, 26 Aug 2021 02:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
In-Reply-To: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 26 Aug 2021 10:48:13 +0100
Message-ID: <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 26, 2021 at 12:25 AM Darrell Enns <darrell@darrellenns.com> wro=
te:
>
> I'm seeing a similar issue to the one previously posted by Matt
> Huszagh. btrfs send gives errors like this:
> ERROR: failed to clone extents to <some file>: Invalid argument

Do you know if it's an attempt to clone from a file to itself, or
cloning between different files?

If you pass '-vvv' to the 'btrfs receive' command, it will help to
identify that.

>
> This mostly seems to occur with sqlite files (such as the ones in
> firefox profiles).
>
> This was supposed to be fixed by
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D9722b10148504c4153a74a9c89725af271e490fc
> (included in 5.5.3+). However, I'm still seeing the error with 5.3.12.

By 5.3.12, you mean 5.13.12, right?

> The test case provided in the previous fix does not trigger the error
> for me, so perhaps it's a slightly different issue?

Perhaps. It will help to know if it's a clone within the same file or
between different files, and offset and length arguments.

Have you generated the send stream with 5.13.12, or any other kernel
release with the fix, or with a kernel version without that fix (which
was the last regarding extent cloning)?
What matters here is the kernel version used to generate the send
stream, not the kernel version of the destination (where you do the
'receive' operation).

Thanks.

>
> Please CC me on replies.
>
> Thanks,
> Darrell



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
