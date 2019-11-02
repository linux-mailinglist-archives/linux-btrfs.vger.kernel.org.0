Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40271ED086
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Nov 2019 21:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKBUQi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Nov 2019 16:16:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36131 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfKBUQh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Nov 2019 16:16:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id f7so7092906edq.3
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Nov 2019 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ5Es+SMGrPsS2aVVlk8MSzzE4lvdIXpBcCjPx9khg4=;
        b=EEkWZ0qOlaWY+vCbxlDYy8qCdRu9ZVgi4Y1JiXpd//f+VqcUC877Px/hzxd1STCfuD
         k9wCwCtBwD+DdDn3H9LbotQdcQSCPXxOYAl7a4nu5XNBmoMJ3EkDOe9NH276B7eBfYRt
         uhNbHRQcZoAE0f76zPKBGbc9c6G3UlARwEX20QUdfF2CuVSgG3yEgHgTpLO2/z98P3/p
         KsdQuSnNhAPm4D+3j294WFhWLN6RZmgIHTWUMNeTfK1U4a5jtuHyfYG4q2x+Rbh5J2pf
         5jJ74SRGLyWnspTBdrO9O/RrvyeCRtmyLwZeMjavwH2W1RQDJcRRV1OiJO1ib2656+kY
         0t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ5Es+SMGrPsS2aVVlk8MSzzE4lvdIXpBcCjPx9khg4=;
        b=QnEyTp3bY8muA/rnRQr17+s027ligsmQPd6Ke0Wrjqc2LGzVdT3hs+Pq32QoQC/vQG
         tk5wRr0Jt+zJdxEDz/LmRb+Q2LS3VCauCNPZa6fFMoU7RwTQxbWMUGgMJYR4j7wU96UI
         lpszXzkZvErO0ID11xj8BlT/W0HU/Wc/MMJ0u+O9/Uy0ZGuqM2KL2sgWiFaPqLHBMLx3
         WIGjRTtrS+aWM8EQoFsR45WDjcg9Lu26vqdYtqxmoJmQ5kxee9jzO24p0/EGQlTnn4gN
         uj75NjLerwyZjOp9/Q9HXcvBPv0o9iVJSgs/Fig4KeIZ5dDUhDkohVpf/+uc677glyk8
         bQrw==
X-Gm-Message-State: APjAAAW62ku8ucSR6dDB0UGxd3EtZtFz/WWUF3hoVZvG1ImQ0r1+6Rfd
        z8fxstOFXGtIitWlMQt6iQ5ujChZWb+PV/ydYA/Lm/K+jbA=
X-Google-Smtp-Source: APXvYqwerVPK27B87tL1GPmVAoZoweafwJEDbDBIAzr24FelXxIZS62Qmkt/kKU0dvvSYcc0wPvGmO2uEErcF9TqwN0=
X-Received: by 2002:aa7:c5c5:: with SMTP id h5mr20411900eds.87.1572725795575;
 Sat, 02 Nov 2019 13:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAMiuOHXH1ic6Mcz+o1uWLNMCK+iCinhR+nnZ8N1wTHQoEms-7Q@mail.gmail.com>
 <20191102193624.3411de0d@natsu> <CAMiuOHWtjJdeKmkEV-kx+GRk_VskXEKMZoJWD5z7acapqeDE-A@mail.gmail.com>
 <20191102202433.1ca92ea5@natsu>
In-Reply-To: <20191102202433.1ca92ea5@natsu>
From:   Brian Hansen <dulanic@gmail.com>
Date:   Sat, 2 Nov 2019 15:15:58 -0500
Message-ID: <CAMiuOHUMgBNA69n+cJCHcmGVO3YysSH_TEjnDzvWtsuUkA+12w@mail.gmail.com>
Subject: Re: reflink copy now works with nocow?
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I updated kernel to 5.0.0-32-generic and the same issue occurs. Not sure.

https://pastebin.com/LikPgNMt

On Sat, Nov 2, 2019 at 10:24 AM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Sat, 2 Nov 2019 10:09:27 -0500
> Brian Hansen <dulanic@gmail.com> wrote:
>
> > So I'll need to setup a script to remove C when moving
> > directories.
>
> The only way to un-nocow a +C file is to physically rewrite it into a new
> copy. The +C attribute can be removed on existing files only if they are 0
> bytes in size.
>
> > Unless there is a easier way to deal with this?
>
> Try a different/newer kernel version, as noted in my message all of this
> doesn't seem to matter anymore, and nocow files can now be reflinked (or +C is
> not working anymore and they aren't actually nocow).
>
> --
> With respect,
> Roman
