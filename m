Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07AC321564
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhBVLsN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 22 Feb 2021 06:48:13 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38507 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhBVLr6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 06:47:58 -0500
Received: by mail-oi1-f172.google.com with SMTP id h17so13641742oih.5;
        Mon, 22 Feb 2021 03:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QlRAo98CEFZQCRMmvelMsodp72v9s50sbgzKV8vA1BA=;
        b=s4Wp74jJShsEbW9Bk1W7UEHgpzAhggZd/vaDpDvaibZfrjhOOzE6NYVgkzJuSzs0d+
         q/Ho/MBY4slWMNo/Mh5NEWrnzm+aeMvhQ9dlm2wI3C5DhnN1WdFQl4CU/5yjy35L0cku
         tkyz6nGMAS+uDIznqD46DGylgsZvkAfzNIuD1R6Ysiakk8VNbA2aPQ2KNZqYOZlhmtOV
         K4uBbU+Nf6jL9Rze4goZMg4bupgIo1fRpZK0iJGq595XWrvS2fYpGVipfNGDnHfv+EWF
         nVr16LCn4m8bgksULK6u1o9iiKWzlbVohKdmnOFej5Jr6Mj7eEpxTcI2WRFLZ4K4IYmj
         COAw==
X-Gm-Message-State: AOAM5307SzUnsy7tO8zlpSicpvku/N7nwgdsB9scLU4p78+yl+czvgRu
        /ESRgVe8Pv3Ba8mr8xDB9e5spD4dxpil4HTA84s=
X-Google-Smtp-Source: ABdhPJz8AKnZ0MM8u7ar6hE0bvbxPxID9Ks9pF/YaVYkT/Efoc9kPTh/xhqrQgMFiyMUuGs3RQrsxZzG3IzPhbqo7PM=
X-Received: by 2002:aca:744:: with SMTP id 65mr15128930oih.153.1613994437678;
 Mon, 22 Feb 2021 03:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20210219065417.1834-1-rdunlap@infradead.org>
In-Reply-To: <20210219065417.1834-1-rdunlap@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Feb 2021 12:47:06 +0100
Message-ID: <CAMuHMdUjgGgHtzKkPjWrDXAuP4LU5mJ2ng9KkMwh3Fj=2bf65A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: ref-verify: use 'inline void' keyword ordering
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 19, 2021 at 7:57 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> Fix build warnings of function signature when CONFIG_STACKTRACE is not
> enabled by reordering the 'inline' and 'void' keywords.
>
> ../fs/btrfs/ref-verify.c:221:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static void inline __save_stack_trace(struct ref_action *ra)
> ../fs/btrfs/ref-verify.c:225:1: warning: ‘inline’ is not at beginning of declaration [-Wold-style-declaration]
>  static void inline __print_stack_trace(struct btrfs_fs_info *fs_info,
>
> Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Josef Bacik <jbacik@fb.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Chris Mason <clm@fb.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Found in mmotm; applies to mainline.

Thanks, fixes the warning in mainline for me.
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
