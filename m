Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8728E19D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgJNNsI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 09:48:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44147 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbgJNNsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 09:48:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id e20so3426611otj.11;
        Wed, 14 Oct 2020 06:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCcrvv05spG628FR3qi+rwMkg+PNDU/9M4ZzaARaVPY=;
        b=GC4kXpG8MlHedG+TBspFLsg2i6kzpWO9CWbBRYpcvW66T/O8KBHNasQ45zLJr1B2c6
         OpW9aeHrqyAVspXce8mP79ZuZSTmcWFLknXoJ5a9AeKyiNbPMQBU1i/6QiVpC6jy9t7m
         K3wPi97MlRQfV2oM0Ws9T1+hxBm1O9e31WcguJTft35CypioPIg/z/DTc4vh/gtq8Hxp
         0vTgL4/+QiBpUgkdMl50CLTye6eRkJYE/2yR3RTc8G9uA9v53ASocYGzm0GkqDnu6b9V
         7hZsaW98iEye+QHTN/KdhDh774C1sS29EpzpBJxqgpDv1PI/eYOTsnfT06CfuUAW6xaH
         cRHA==
X-Gm-Message-State: AOAM530GpQPM71jk8zTkBmbS3gdInPvbTNz45uYULTSKkUVxjzhMvhcg
        D78V+EKv34YC/IqFKmzcLLyrgTK2DiIw/lZkRGY=
X-Google-Smtp-Source: ABdhPJxyDuijTzpz93NI8FemP/mZsCuRf9XLrpU9nvOrHX45RVFiRFl5Th5e2l7IUuU7aUhmksTOGfnKFdCIdx+6mKU=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr3500011otc.145.1602683286818;
 Wed, 14 Oct 2020 06:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201014032419.1268-1-shipujin.t@gmail.com>
In-Reply-To: <20201014032419.1268-1-shipujin.t@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Oct 2020 15:47:55 +0200
Message-ID: <CAMuHMdWEg=xBgi+gMNtPb9Ct1POVLO1nU=WsGuLA=C3exqpXXQ@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: Fix incorrect printf qualifier
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 14, 2020 at 11:24 AM Pujin Shi <shipujin.t@gmail.com> wrote:
> This patch addresses a compile warning:
> fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
> fs/btrfs/extent-tree.c:3187:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=]
>
> Fixes: 3b7b6ffa4f8f ("btrfs: extent-tree: kill BUG_ON() in __btrfs_free_extent()")
> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
