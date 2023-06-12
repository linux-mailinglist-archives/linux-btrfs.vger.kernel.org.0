Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C972C55C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjFLNDJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 09:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFLNDI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 09:03:08 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5819D
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 06:03:07 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a693718ffbso685638fac.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574986; x=1689166986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h9HMR/bodwlP9kRq1qHxC7L5/BEuSlLQfqo8AVIprQc=;
        b=Ty1zR4E1+e/MS59u0wWMxK4KW2/L/lxFaBw2LFjYLzvnEWZWZrEFvbFVWn1ZcI2H/w
         XC3h5xbNnBoJf2zAK1SmPMEYhIyrziQGs+8tBf7MSaRPreHkHEz8QH5ugbobYb4zd2Zv
         rHGMd7tQqgBAphONsXhuFMLOsQJAoq9x528aDyK+fUmHSFEzEeDSHAU+ShHTdyBw7w+I
         bdL8ehQUErfhnuHb3UKseSVJJqo+AU7sRSB+JlGUzfSBMvjB0OnR8uAByckCjtmoNg/5
         mtE256np/ve4o3lW+BzzdAK9+F9omfiF5zhApy/ZwrgVdrsKT6So+J8CWucJDPW77ww/
         megQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574986; x=1689166986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h9HMR/bodwlP9kRq1qHxC7L5/BEuSlLQfqo8AVIprQc=;
        b=KTIr7e+D/WXKlgJgndz673uy1zpwXIGunQw5/huKRztddTjzjdF8h0mFNg9+QnFyxy
         0zm889/wrVjzym0xPPyzXdFFnjOAWWk39IFNiQIsaOiwbeC4SCDs37E07SaodtWvh0aL
         x2bkOPSCYMM+3Tc+grBRUGLWhPWQo8XU4zdFtqS7+/W46mUP+UUbdn3jjX6KtN+N6psk
         7kUj92m46q2e9WpO14Hncc6SJCb35cs3BOOHs/oZ0SUrorYKNgHBAcz7eoixtrCO3eXP
         zNtjoIZB6ho9xQ/DXITl7ckgJHqvyHSy8VpcI4DnH1/y69thwjSNpx40B1SkJ/sfO9K+
         l9Sg==
X-Gm-Message-State: AC+VfDwhzi6plqwuRqn2h6jXhSxDsXeyo7WXmN/+EEwyqysctqS1VdmF
        CPG+vS0vjCldetjo5G0PqHQTyOKOuHe1hGVb1Jc=
X-Google-Smtp-Source: ACHHUZ4mAb+LLnYeSXS5KpGEu5bq1t/HvLoUFR6R5FnilneZq6PbkQHkZl7zcnEl4yZdv9J3WhTnub5pXLw8ek7sVm0=
X-Received: by 2002:a05:6870:e350:b0:19e:d289:f5cb with SMTP id
 a16-20020a056870e35000b0019ed289f5cbmr5119382oae.33.1686574981387; Mon, 12
 Jun 2023 06:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com> <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com>
In-Reply-To: <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com>
From:   Stefan N <stefannnau@gmail.com>
Date:   Mon, 12 Jun 2023 22:32:49 +0930
Message-ID: <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
Subject: Re: Out of space loop: skip_balance not working
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 12 Jun 2023 at 20:16, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > I've tried using the latest ubuntu livecd which has btrfs-progs v6.2
> > on kernel 6.20.0-20
>
> I guess you mean 6.2?

Sorry yes kernel 6.2.0-20 (Ubuntu)

> In v6.2 kernel Josef introduced a new mechanism called FLUSH_EMERGENCY
> to try our best to squish out any extra metadata space.
>
> If that doesn't work, I'm running out of ideas.

How do I go about forcing this to engage? Currently the array never
stays in write mode long enough to do anything, so I'd need to trigger
something immediately after mount to have a chance that it syncs
before it goes into read only mode.

> > BTRFS info (device sdi: state A): space_info total=83530612736,
> > used=82789154816, pinned=245710848, reserved=495747072,
> > may_use=130809856, readonly=0 zone_unusable=0
>
> The big concern here is, we have hundreds of MiBs for
> pinned/reserved/may_use.
>
> Which looks too large.
>
> My concern is either free space tree or extent tree updates are taking
> too much space.
>
> Have you tried to cancel the balance and sync? That doesn't work either?

The balance cancels ok, and there's no sync running except the auto
UUID tree check on mount.

> Considering you have quite some data space left, you may want to migrate
> to space cache v1.
> Unlike v2 cache, v1 cache only takes data space, thus may squish out
> some precious metadata space.

From the 'disk space caching is enabled' in the log it must still be
using space cache v1, and forcing it as a flag doesn't appear to
change anything.

With many remount cycles, the best I've been able to achieve has been
to rm some small files, but they never synced and were back in btrfs
on remount.

I'm running out of ideas, and given the size I really don't want to
have to replace/rebuild if I can help it!

Any other ideas would be greatly appreciated
