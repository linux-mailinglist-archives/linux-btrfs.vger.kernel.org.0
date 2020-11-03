Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0572A4FBB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKCTI4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 14:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCTIz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 14:08:55 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29164C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 11:08:55 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id s21so19533726oij.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 11:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Jc63xoOl/7ccjQIuMcqTa+apT5GBLl/EmFlvtMIOr+Q=;
        b=Ff2dI2tabXj7F9W9Dp9fAQrX5AgE2qdsaQDuWp8w/VEJm2c0Z/1R4q9BHBdriGavgU
         V1amF2A0k4YrNW9XYjnsRqp/8UAhE5LEh+ZqUfjsB83oetLje3bvPQFQQFopO0WeBy+d
         YIFyro/n6UFpWfPm6fZeEheGE9l09fUYJegMRyc8tGGwJl5D79Bv43nszxqRF42SPmcs
         TcWNrf0KgF51kmAbje3gmKNcpmifU0Md3CnSDaV5UCTamgrD2kjBLjVW1I1sTj1xCJLL
         IiRrHgVZEhLQDxkdkE1jvojEdqJ4ML+g6+Q/tPcLyo/JFbCYJo3jsreT6ufISNBAXMiN
         utAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Jc63xoOl/7ccjQIuMcqTa+apT5GBLl/EmFlvtMIOr+Q=;
        b=YQ6y0A2WU0ecCxxZgl6JwlPcBnKcaHPSUAWo75hmJ0PEi4PZ6SJggEr5FNRQMYdtXC
         KE6KiSFLiXH2uQPa5arEfV8Owsun965FyiBrRoFzvwAuBmK5nPdxMeQaiUIU/NPKNKtx
         GNNNLYp+GxUG/FEjoxMxrb7/fdY6Z43l6sY+4zUTtXu478w/xY2doam9fPiGcaNaDRtN
         GMlKELsHfF0zKcAs7zDPmWaURlsQ1sJ9lSdzyZWc4pA3vMXhiFD7lHKNBQ5sQQzeJ/oG
         ZEd+43kAqEeFJevm9COJMIT8JQB8Zyp0PlqK6A/ucXHsbmXHWFBJ5XbJSVsRLcQexLnc
         7Eaw==
X-Gm-Message-State: AOAM531z/Lg5dOaGW4H4ze0kOICRNagAWxTMQGxJxdmig5YRlY8krP5G
        UqRc3ir+WAmd5Fu38fOuO3KTZ6KbeKJb6Up4dZA=
X-Google-Smtp-Source: ABdhPJxaqRNKuPDRpe+gUxXufi6S0AYQTKvQpa015gcONOn0X0LDPJdBiusdOy02g5o0ZeE9IVfwNjlBR789H/GbnPk=
X-Received: by 2002:aca:cc08:: with SMTP id c8mr353850oig.161.1604430534614;
 Tue, 03 Nov 2020 11:08:54 -0800 (PST)
MIME-Version: 1.0
References: <33ce2f6df841772666ca1cf3a4876b0ff6612983.1603921124.git.osandov@fb.com>
 <20201103185753.GB6756@twin.jikos.cz>
In-Reply-To: <20201103185753.GB6756@twin.jikos.cz>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 11:08:42 -0800
Message-ID: <CAE1WUT77Dp3fb86TR3T4LFN0-qcXEdZ2sO=RUwRsxpgWoYWWog@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "btrfs: qgroup: return ENOTCONN instead of
 EINVAL when quotas are not enabled"
To:     dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 3, 2020 at 11:02 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Oct 28, 2020 at 02:42:38PM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This reverts commit 8a36e408d40606e21cd4e2dd9601004a67b14868.
> >
> > At Facebook, we have some userspace code that calls
> > BTRFS_IOC_QGROUP_CREATE when qgroups may be disabled and specifically
> > handles EINVAL. When we updated to 5.6, this started failing with the
> > new error code and broke the application. ENOTCONN is indeed better, but
> > this is effectively an ABI breakage.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> > The userspace code in question is actually unit testing code for our
> > container system, so it's trivial for us to update that to handle the
> > new error. However, this may be considered an ABI breakage, so I wanted
> > to throw this out there and see if anyone thinks this is important
> > enough to revert.
>
> Making the errors fine grained is a change but I don't consider it an
> ABI breakage, it's not changing behaviour (like suddenly to succeed). It
> fails and gives a better reason so the application should make use of
> that.

Yep, this could've been avoided by either sticking with 5.4 (it's LTS
after all, bug fixes
get backported) or what *should* have been done is reading the 5.6 changelog
and updating code accordingly. This isn't an ABI breakage, rather an improvement
between kernel versions which should've been accounted for before upgrading.

Best regards,
Amy Parker
(they/them)
