Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C825D25637C
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Aug 2020 01:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgH1X1L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 19:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1X1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 19:27:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C3C061264
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 16:27:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w13so596578wrk.5
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 16:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9jfYGIN4ydv+Xwe/mEeNkmv98ZFm/IG1EmrHYg94GI=;
        b=VRwFF8IzroZZbi6LIOevb9s5VWmwOWzxGcJ76pTWrt7f8axwsEnaC7TNIkUaqe5GIx
         B1x4kvI1c2sRfuX8gJSXQj3Bw2LLVHWqGL9tiYieXxxRatxXlGPNOwDnblJ9nI0pkPAK
         8Ij+DeXVKQo/4mTRNcKskjLUwyhuW28SIVvYHQWHCDvs2mDW8bQEP4R0y8Zy0QST/MVF
         SCMMupdjBKiXWJ/FPI+3+t8XX/G783vDHQKKTZDAqlqqNdVm1AkvaLrlCgj89EMsu398
         e6YUP/VhadUUrXm8YhaXCxr+FKyUd7h8ClUm5DV1jx3lbh+fQXcRitLrXhfFY9GX20/O
         D0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9jfYGIN4ydv+Xwe/mEeNkmv98ZFm/IG1EmrHYg94GI=;
        b=A9hNH9LowcAMroJnPBx6HmumuFustegXabZM2LJs1ZL4FjvvNepUfxZved0xkQpMDG
         LM7FmAFeiTTM2qhyIQkgQ9bqFGo7Rv5DGVJHNQ7fHvP2TxHBBeILB85x+8O4qrT4g5mK
         Rst85/cj+WYhkFoPaAWGDREWJK9z3YbivCIRHvcGqcp7wIf78Den84+4tgICHSVbqR9L
         cDOi2k0V75yVPo+efY1Lq6aS4wQvs7oHzWE+goBK62S2Z3thMvD01j20GkX+wSdyV35M
         eaH3ZUS4IvQWcG4XniyD3IarM9NGYOgFBOm/XtNQX+fN1UoRb1QGQIMhonRM7JWFsFUd
         IVwQ==
X-Gm-Message-State: AOAM531tEG+mRgSt4yMuG3LhxU0z7qt4upicFjGUSohYOqBKCbOBZJ9R
        EE+yQy7wXxtJe65SML/zvyI2eJmEMi3/1Z9HnG7lt11UYlhbLg==
X-Google-Smtp-Source: ABdhPJxBWwXyrdhv73gggTGz1aIJwJlhwKyUOARt6yHcpQOmxjIjJehwZkX6Ojxu1XpnAoeTW17eLukhTUU7rGyIN30=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr1100615wrv.42.1598657225623;
 Fri, 28 Aug 2020 16:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEg-Je_Mhx2QewCvFbwcV5oVHHa9jkdPcpkFZN8YR_fktCHSCQ@mail.gmail.com>
In-Reply-To: <CAEg-Je_Mhx2QewCvFbwcV5oVHHa9jkdPcpkFZN8YR_fktCHSCQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 28 Aug 2020 17:26:19 -0600
Message-ID: <CAJCQCtQrHXLzUM3gGR8ng_cYXfKuQ+jJY=2To=6L6XMeMWWmZA@mail.gmail.com>
Subject: Re: Optional case-insensitivity
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Mark Harmstone <mark@harmstone.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 28, 2020 at 1:44 PM Neal Gompa <ngompa13@gmail.com> wrote:
>
> Hey,
>
> So I saw today on LWN an article about ext4 gaining the ability to do
> per file/folder case-insensitivity[1]. I can see some value in this
> property existing for subvolume/folder/file level for Btrfs for things
> like Wine and Darling, which could take advantage of this to help
> support Windows and macOS applications that expect insensitivity to
> work properly. In particular, I'm looking at how games are glitchy
> with case sensitivity because it's rarely tested (both Windows and
> macOS are case-insensitive by default).
>
> Has anyone looked at what it would take to do this in Btrfs too?
>
> [1]: https://lwn.net/Articles/829737/

It might also make virtiofs on Btrfs more compelling across
virtualized Windows and macOS.


-- 
Chris Murphy
