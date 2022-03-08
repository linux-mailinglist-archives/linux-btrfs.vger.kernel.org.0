Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0349D4D2380
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 22:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbiCHVou (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 16:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346294AbiCHVos (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 16:44:48 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF88419B9
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 13:43:52 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so624343ooc.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Mar 2022 13:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wPJldldEbXANoyWfP9hqRJNgXDI4DT66xJoIM4uC5Po=;
        b=ZSp/a7n23bCvOvPxeKuy2InDO5H/vP61ffytJcG6SpqNGhtENFO2vzqDcftXXcQcHP
         VRGgO+T+wt3SGt6O7aAqSfC2LCCvYXsBwq/h1VoPEAv6V8GTcbRL0KNL69H+yP1tIJGk
         6xsBcor7sGOESHyZ7CXUpD5RpuBvdUZoGiNDkdB2HnD167DY/tDROKm8x+OzJ0ef2GWo
         tAL76Dui0r/NZunoUXzOl4sVkfvN3dO4xV4PJuI34V/MD6CCI1Tti5bfrrmkeqEAlYY1
         WqT+qW9TNYLT/F5Ce8Vxt1goYdFibNWRXebrWQoCCYf6bRrTUjzSe7hrKG8hYd1zx8t1
         ooGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPJldldEbXANoyWfP9hqRJNgXDI4DT66xJoIM4uC5Po=;
        b=ZojFwdDDBFXYWsjnPv03+rlZFaQ+2gzngMKRMPlLkOSEk8QpY0ngK4zkfeaptdm2yN
         gxfoYGrpaA6tgBDKwDGM6Q4ay8Ts8ezLDc23UqbumQFYY3wTYuz0rf+qtfM1PMcMLQdQ
         rvdN9Hit05wns3RA+80d/N0yo8WA5LIbZ8l65+tZQo+2CDF3nm3qP1eFx1jfuIunrcsi
         4iF49QDr5KzXcv9LZLMVs/lZobaCwiE03Uy7WTxkWQ6OABHW0XQwOgKhhrIAH/53xFhz
         kvUsDxMOlM71QDCO+AhedDS3h9VJxhyJjXsrxkYWevyR7j+PtlnafzKHECU57gCvaLGv
         Vgow==
X-Gm-Message-State: AOAM531j12u4KETCRaGxVQ+Z04qAey6HTY5FDcFe4nCvr8p64CtqjjB8
        TcIqDSkINklJ3cfgfc5Of/THsk+cQAe8IMi0ugRDiGr9GUQ=
X-Google-Smtp-Source: ABdhPJwiTYDdNUMVWq5lfWuXdWKeyLzy19H8wuVJprzBwWfu7Lp5OKrNgLvc1duN1tojhANefSwMZ6IUG74xZwzFLN8=
X-Received: by 2002:a4a:dcd6:0:b0:321:2728:d4cd with SMTP id
 h22-20020a4adcd6000000b003212728d4cdmr1838282oou.33.1646775831390; Tue, 08
 Mar 2022 13:43:51 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
In-Reply-To: <87tuc9q1fc.fsf@vps.thesusis.net>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Tue, 8 Mar 2022 22:43:15 +0100
Message-ID: <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Phillip Susi <phill@thesusis.net>
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

On Mon, Mar 7, 2022 at 3:31 PM Phillip Susi <phill@thesusis.net> wrote:
> Jan Ziak <0xe2.0x9a.0x9b@gmail.com> writes:
> > Manual defragmentation decreased the file's size by 7 GB:
> Eh?  How does defragging change a file's size?

I noticed this inaccurate wording in my email as well, but that was
(unfortunately) after I already sent the email. I was hoping that
after examining the compsize logs present in the email, readers would
understand what the term "file size" means in this particular case.

Sincerely
Jan
