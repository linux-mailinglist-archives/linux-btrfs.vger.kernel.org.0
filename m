Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744011CC495
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgEIUdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgEIUdy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 May 2020 16:33:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A81C061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  9 May 2020 13:33:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i15so6003407wrx.10
        for <linux-btrfs@vger.kernel.org>; Sat, 09 May 2020 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOWUEOAPO5Kmqio/TP1mGoWrSN3Uc4T6MnMw7BuwdlY=;
        b=Q7R8bXRkKCNlw5tDOVpLtzwnoshhMow6g+DDVGr36jZmnbZxqbCxIQlRqgFA0Uf61c
         IqfVxWKhsRQPeUkedXl+VwUGPe+SddD0U52XIrgCUdXTecNr/5Epk5ydb+f3Tj3SBMpr
         mlyt+cDw+Bg6DpAT4rA6+ZAB3fmfdKHB/bQezVFl5sUNXIkW1HRkSwQyF1HG9s6sN0He
         4zmuxoXvOl+AdSegs7+ROkUfbEtVk6/UU/0x1Qxv2zZ/kjOCN3LMj2+YRG8xli/BX0xh
         6ut2Sw14MzfRZe3qzRIN6p0DypmXPi2JP+7+Wy+acCyv240st00yyfR0xp1dxkJJ7ybP
         qoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOWUEOAPO5Kmqio/TP1mGoWrSN3Uc4T6MnMw7BuwdlY=;
        b=FW7RB73D62K1GrQEdLxJkymAsunQkiu7STsDiGKzfXme0g6lWw3H/mEO8BJYrirtEU
         lFDmfUEjyaGlVHewmk8E5RjSGpOZZ1MjN7PUbCpPvDwelx8rdd9pbpPrErzz8ObasHcA
         xbTICTB9W5BDY7PYBc5uA455W9bWHVM82cuOPOM3SSZLfIaAMjBZNR0Tp8L7f+3kyQu7
         SliRD26KA7sDJd9fDIyYi4TIHpEXahqKM1nqccohjVepOPOnveWz7iKRGdI/fyS1tO6I
         fdceXhaog8ZefjIfj1ZnyKKFqIdeqTuSBkGw0qrrBWo1VhUZuEUjlVG249E/3aRrdIXg
         eL5g==
X-Gm-Message-State: AGi0PuYQLGY8lzKJN/V3YzU2YJjDP/TLvFR3sOuYnjq5Vum+eH9RfaG7
        u3duP7Cjb4MxmEQvO1aoWfg5ebqhT1GgwoNJu4MVtg==
X-Google-Smtp-Source: APiQypKltjCmxYgnXyTdoEwNV+2bokW+Zzg65MziiBcCLtWICYBVL+ScSHi1ERoxX0b4uw0u5FVLwaMWPz3QnTRMKnA=
X-Received: by 2002:adf:f00e:: with SMTP id j14mr3282832wro.252.1589056432615;
 Sat, 09 May 2020 13:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au> <CAJCQCtSq7Ocar4hJM0Z+Y7UeRM6Cfi_uwN=QM77F2Eg+MtnNWw@mail.gmail.com>
 <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
In-Reply-To: <04f481fd-b8e5-7df6-d547-ece9ab6b8154@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 9 May 2020 14:33:36 -0600
Message-ID: <CAJCQCtTdSSX15Y7YX7fAg+iKncZf09ZG6KnHmmo4S77OtGWWXw@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Graham Cobb <g.btrfs@cobb.uk.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 9, 2020 at 4:15 AM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> $ uname -a
> Linux RainbowDash 5.7.0-050700rc4-generic #202005051752 SMP Tue May 5
> 21:56:32 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
>
> After a couple of cancel/resumes here we are again:


OK I didn't previously pick up on the fact that you're cancelling a
scrub. Suspending. Then resuming.

Things to verify:

1. That a scrub started, and allowed to finish without any
interruption, does finish. This is the only experience I have, but I'm
wondering whether you've tried this just to eliminate the possibility
of some weird multiple device scrub bug; or possibly something unique
about your file system state.

2. That a scrub started, then cancelled, then resumed, also does
finish (or not).

3. That a scrub started, then cancelled, then suspend-to-RAM, then
resumed, also does finish (or not).

The distinction between (2) and (3) is system sleep. Is this strictly
a resume scrub bug. Or is there something about suspend that causing
state to be lost?

And a low priority (3b) variation might be suspend-to-disk; but this
is not very well supported anyway, in particular UEFI Secure Boot
enabled systems due to hibernation lockdown policy being common these
days.

-- 
Chris Murphy
