Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F95141E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 07:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbiD2Fuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354188AbiD2Fun (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 01:50:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19768B18B6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 22:47:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s21so9297337wrb.8
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 22:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QXa2mSSut+r9qQxd06jwWWtDm32eeZWOe06mSaRISo=;
        b=pax6zKqF5OtkyHCs2Ip/sZ30FhbGRkbMhPRxJGlRBRJUQraL1GUnPhar8V5JK2V3Nz
         WMrajiWARN8ecNCEUvNDnf3nmeTTl7+X7mWWvwLMf09kSz61FvpMuurU1s5xQyQV4fUV
         qjv7OL8FVr4iPcNJk9Bpfofto7qhnHTNS1Zmlp89U7X5K/hAvNg5916i/a9VrurHOHIf
         IvwZrCH+vwpXBJiaUujXIDUvjXF4jHNv4x4QWiax3MsDnCQkZsVRMKRj6OHkwDUypmLR
         tbeINtUEIBp4wxsGAfSDsqzLoSc/IdvqZWWsAKog6t31lyuBSG37IV0T7DcJy5OcutLe
         ClJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QXa2mSSut+r9qQxd06jwWWtDm32eeZWOe06mSaRISo=;
        b=fSGpVCb4miroh514NYPNWUbUcDUKWbgydgcCge6FWFuad1blN7wvPb2Ki6uVEormnS
         CczTjvnl1CqeoN7dQSkok46/WrWP9IHMwYDgQsX0EOUqt9+VIj6UBxiw9ystT731gxuV
         7rrrV8gs+65Q33oAB21rj61XVWflRcMzeqZkUdp4bZD8AJ7RPHNN/J3z6j8alvGtz1ow
         FcFEJkDnnuB2u31E9QIXSdd/m+z6FFrHkjT6i7bFtdSf2GM4Wh5ZV//iC3Czt8H4N/od
         kiYxSXdkk/m95m4OIElMbHIee2yKUYciZ5IpjuyyN3GVowpC0HaPjjUMGWGCKXQevc3f
         5QbA==
X-Gm-Message-State: AOAM531Ua5GjP5So0TWTpHAOS9SVxSv4Oi64Lr0ZThqHWjXacSEoS0Nv
        H7BhwQxrtsXzGboQ//U014hXLMP9gcnFRJRrOZM=
X-Google-Smtp-Source: ABdhPJz1clqvHECdufQxnyNSXQ4CrSVh3xCpIlK2hbBWjA7eWsm0xUK1wlOFhelPNvIEXYLvNfxt1ftwxY0DZ5ka76o=
X-Received: by 2002:a05:6000:718:b0:20a:e310:664f with SMTP id
 bs24-20020a056000071800b0020ae310664fmr14370880wrb.22.1651211243688; Thu, 28
 Apr 2022 22:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB4ndWsZQg13dbp2L5uXQUExtV=L0XmWvTEz61nWGzY=tg@mail.gmail.com>
 <c2bf3e08-efb2-11fb-940a-b2ca5363da00@gmx.com>
In-Reply-To: <c2bf3e08-efb2-11fb-940a-b2ca5363da00@gmx.com>
From:   Dave T <davestechshop@gmail.com>
Date:   Fri, 29 Apr 2022 01:47:12 -0400
Message-ID: <CAGdWbB5Dc0=3YgR+DD=cyK-YHUUcOcUREgVD1-V6eozJXYKBBQ@mail.gmail.com>
Subject: Re: What is the recommended course of action for: Found file extent holes
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 1:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> On 2022/4/29 11:20, Dave T wrote:
> > btrfs check found errors in fs roots. What is the recommended course
> > of action? I don't care much about the data on the volume.
>
> Nothing at all.
>
> File extent discount is not a deal at all, kernel/progs/btrfs-fuse can
> all handle it well without problem.
>
> It's just the schema requires if a hole extent for each hole, for the
> old behavior.
>
> Nowadays, we have no-holes feature enabled for newer created fs, and
> kernel can handle this case very well.
>
> You can even able the feature on the fs by `btrfstune -n <device>`, and
> then btrfs check will never bother you on such file extent discount problem.
>

Thank you Qu. I ran `btrfstune -n <device>` and now btrfs check
doesn't report any issues. All good. I appreciate you taking the time
to reply to me.
