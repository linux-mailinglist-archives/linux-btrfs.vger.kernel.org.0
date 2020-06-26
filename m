Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD78220AA3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 03:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgFZBni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jun 2020 21:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgFZBnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jun 2020 21:43:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DBFC08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jun 2020 18:43:37 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id v13so7200245otp.4
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jun 2020 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=klitK3BzvHz4skd0lAZ+nsza0VW7RxaPv4n8ihBxBIU=;
        b=UzAA2F+mTisGiAotpTSiy3QeeGCWke3WM1mjw/AoGmxB6KZ92c1NOKkVGOQLn9/Us7
         3pgnNALTp51KZhJT4DC4kNy8jUCtlCu7dkpn9f+VPTdUuBg86xk6y1vvFVhW4lbL2KYX
         kOO4SgqX/VUM9m6wBF8IWVOMC1ibWmeU7wTKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=klitK3BzvHz4skd0lAZ+nsza0VW7RxaPv4n8ihBxBIU=;
        b=DNRbK085bACmiKZ+7wVH4cE9E8oJunzSp8rcbtfuXaHSHgwkVFjXlk/mgUhukF4PcF
         gcMO9HAdztrZIN7QbXfj9QezsW80LLMdNm2vqRw13wpYLAWitEiZdP5sX4tp5M4Ot2hQ
         c9fqpA+CMad7FmI/QaeMl6BOlus09xL/06OA0xeGj4hd/vxBTROsD3aN+JNdO2W5UyaQ
         m1LnLhsC9k6qTatkAzyuNvtz0M0EYlhV/+CrBxThwTJvgvhheHwlZeN7ELPIcxyBxTuC
         BZDi8UexahvEIRqFAB7WvgA2IGTsludOk2oQ3OSwvmrBjFetD11KM0TX1SNgq/Ju9CcM
         qk+A==
X-Gm-Message-State: AOAM533xgmVhztpA1X0xMYp3D7mxTF36weTJfOtOjU2Ja/aflBB8Brtf
        wX1mim7sKZLX6SOxEV8ytWOBkC7I+wmwcck9Z0XJ5g==
X-Google-Smtp-Source: ABdhPJxO15vA2Fz4ObtNAgHhumkgdT9+m7bNhHgGoKPEswCX1M6vwKYh+wGscLgMeggjuWGberiwk6W1HVvKe+WkyEw=
X-Received: by 2002:a05:6830:1391:: with SMTP id d17mr588868otq.48.1593135815791;
 Thu, 25 Jun 2020 18:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200624160316.5001-1-marek.behun@nic.cz>
In-Reply-To: <20200624160316.5001-1-marek.behun@nic.cz>
From:   Simon Glass <sjg@chromium.org>
Date:   Thu, 25 Jun 2020 19:43:20 -0600
Message-ID: <CAPnjgZ2Pus57k3JS=cqiwwhm1p_bH4E_K4x4=znnD+2ch9cCRg@mail.gmail.com>
Subject: Re: [PATCH U-BOOT v3 00/30] PLEASE TEST fs: btrfs: Re-implement btrfs
 support using code from btrfs-progs
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        =?UTF-8?Q?Alberto_S=C3=A1nchez_Molero?= <alsamolero@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Pierre Bourdon <delroth@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Yevgeny Popovych <yevgenyp@pointgrab.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Marek,

On Wed, 24 Jun 2020 at 10:03, Marek Beh=C3=BAn <marek.behun@nic.cz> wrote:
>
> Hello,
>
> this is a cleaned up version of Qu's patches that reimplements U-Boot's
> btrfs driver with code from btrfs-progs.
>
> I have tested this series, found and corrected one bug (failure when
> accesing files via symlinks), and it looks it is working now, but I
> would like more people to do some testing.
>
> There are a lot of checkpatch warnings and errors left, I shall fix
> this in the future.
>
> Marek

Please can you add a test for this one? See fs-test.sh

Regards,
Simon
