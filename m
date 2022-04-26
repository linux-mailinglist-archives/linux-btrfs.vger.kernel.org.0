Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B27510B6F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 23:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbiDZVjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiDZVjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 17:39:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEA25AECA
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 14:36:39 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g21so204997iom.13
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kbML/8VzPNcsnpyBTp2UryO4XrD9q5LZU+RaN2k92w=;
        b=GAar+ZT+nR04LvitzxLA8dbJYlVGuqc15/Gw5P1FdbIP0PDOwiiGMZtcUTzVHKaRgm
         SLK6wlt6XC71iK7ppqyFeeQd5bYPXy8zrMTEgP2G4GkK2KSfhCzDGLqqSHVncL0pkRJH
         j93MAi2BPuSpJPbGwa9IUm0URSMPIa5yuQAfToXiErAnjNDJhCZdHEWRPXzztlThfT/6
         agzrCIzJEFP9RfN/IWLObyhah/F7lhKo2K7sILp+KoaF6tEIr/zaQKMe105E9fItU05h
         1nM/VuheWaFBfYrotU7jm47NhvYrewpIs7RaL9Aa0H/XH3kTCtQW2AtwcCpZUwF2XgGl
         WWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kbML/8VzPNcsnpyBTp2UryO4XrD9q5LZU+RaN2k92w=;
        b=F6EmKn3nGrXfIClCnivs4qh9lLK2sbZnUwa+Id84s7M+qbYhdtJHe8vYPCY/Mbade1
         Ajvv3l1IugiFzXEUjMI+naPH0Z2wrEFnFQlBWXUsIAw0u2SS7Mr5NuWcWdT26sSc8sKf
         MP2D2Fs4H9gP1XxJu444/s3tMFebM1AmpO3U4RAU5lsXq8W309MIhO0a8O0AhHQ9I6uc
         xsgYqCeus5bVak76irq6UNQcJYLzDdlvCViFrau58cKUqU+B3hD2EVQcS8znV6jgk4YL
         upiOEqVpV/Cq7TL8y1LPZvLKRoseceWx7zmAhN+u0PJEwBUf+hgAblHDQerApw7IT58Y
         8fWQ==
X-Gm-Message-State: AOAM533w0GqywYZl3yh6uTRjzDgXjQJAkrhKwONkavVTG9RYJa932Sji
        AGiI7DNaR5jEcuD+qyrPSunlBCAzl3bHTqjMbT0NwKE7+ao=
X-Google-Smtp-Source: ABdhPJzmPr2Owx3FRoVpDD3wEZPw+aRvfOCEb/mZnthCmi1rax1oVqsHotMMAyuxplPifcOb8FETcJ7EuW5/lqkv9VA=
X-Received: by 2002:a02:6010:0:b0:31a:6d4f:d9ca with SMTP id
 i16-20020a026010000000b0031a6d4fd9camr10640451jac.46.1651008998797; Tue, 26
 Apr 2022 14:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org> <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org> <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org> <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org> <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org> <20220426204326.GK12542@merlins.org> <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
In-Reply-To: <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 26 Apr 2022 17:36:28 -0400
Message-ID: <CAEzrpqdKTrP_USiq9sKTXv1=uY1JVWRD5bVfdU_inGMhboxQdg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 5:20 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Apr 26, 2022 at 4:43 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > Generally would you say we're still on the right path and helping your
> > recovery tools getting better, or is it getting close or to the time
> > where I should restore from backups?
> >
>
> Yup sorry for the radio silence, loads of meetings today, but good
> news is I've reproduced your problem locally, so I'm trying to hammer
> it out.  I hope to have something useful for you today.  Thanks,
>

Sigh I'm dumb as fuck, can you pull and re-run tree-recover just to
make sure any stupidity I've caused is undone, and then run rescue
init-extent-tree and then we can go from there?  Thanks,

Josef
