Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17BF17526E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 04:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCBD7c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 22:59:32 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42466 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBD7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 22:59:32 -0500
Received: by mail-wr1-f43.google.com with SMTP id z11so1939092wro.9
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 19:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JaxD2bAgFAp3sTDZs+VU3dG94W1lhFPFmDf7d1FDJEc=;
        b=M2jqWrnQ5UUxLyfabEBbAi5AOg+u/9UnWWne3S9tecYvlt7O4+lAM91ShlgipRTPON
         sEqjWFjgGtr5SzY5ayf3Q/nrHsZ893doG5FFeyAMEJP1IfzPW8bVHeEqRrxktSLJ0PBp
         8niQ1fG/pCCiYGJdsuV59Z8zg/ystkp/ofhaFIrNJw8CPQ+q/5vS34AzYc67qIsO/dCK
         ly4pBotmK+1Tw34z294wItT4ROZcMWwEEdDC5KDbVACb4sXwcBDIjXVRTPNhEsRcKG2I
         j0NausZXFUxzALZ+tB3JPxFs1qzpoiGT3zwgwBptx4y1wp/BEtplz9QqIYcb91iNF1y4
         GU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JaxD2bAgFAp3sTDZs+VU3dG94W1lhFPFmDf7d1FDJEc=;
        b=OhzMyb6T8M3p4eeGB2otl2g+3kr49X2s6SmW9D5VdZ2GaDTaBUg7fy8LvcXp5GPr0Y
         j8PeVMR0VbESw1cALDwgMvda2LtnvCv7T99gPQgAg7MyiCjEuqeeJDA8ZFM9k2sC8jIM
         w4JVofWJyGc6Auh0960srjOIkWE+zYJEJj8Jq5Oq3kL4PqAHGTi405wpz3t8kJ8ls5ls
         MXoYN1norQu8fuwXFoNQMSLq8YKc/ys7nzMZ6XN5qgyW6/dqkQGDitGBMW8ig5YjtLKw
         SrcyeWVA5qrK3dfZQ1maeWXk2VJMCUNV/o84gTTD1dieH2Dpx4ZGXu66FZCVokbrLSLF
         V5Ng==
X-Gm-Message-State: APjAAAXYFYaCc+gphVMTxJEnAl4KID8/ModXnZsdxY9xYi0XLG/+8eck
        9kbHIWcnXg47mtTOYRJxWOJemV+HHO7hRZXKsXA6JeIv
X-Google-Smtp-Source: APXvYqzvrYfLcEb8bdtlEJH5wD/5HmvI08MoPDwikeiYzELN4eyhEw6He0nqrzDBXqsSCK07AAV0d0Ry71yyKV4vEEg=
X-Received: by 2002:a5d:5303:: with SMTP id e3mr19315454wrv.274.1583121570573;
 Sun, 01 Mar 2020 19:59:30 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
 <CAG+QAKUzqdVf88G9ZdLKLa3YUQRcvJMS47qQkhLsgiQ46R19Bw@mail.gmail.com>
 <CAJCQCtQvEOX--M5pXN=2fSmfPDM2ADK3JhStTWiTdXTCV_XBXQ@mail.gmail.com> <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com>
In-Reply-To: <CAG+QAKXf9JuRgUU1+shTmTNe=UZNQCLHqomUMiQm+zfqFak3tQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 1 Mar 2020 20:59:14 -0700
Message-ID: <CAJCQCtTN6zKHiUop1Kh3T0WVEgH+1D9zudpMVK9Qd+OJ+HdwVg@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Rich Rauenzahn <rrauenza@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 1, 2020 at 7:38 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
>
> On Sun, Mar 1, 2020 at 5:57 PM Chris Murphy <lists@colorremedies.com> wrote:
> >  >But I still don't get why it wouldn't move blocks from the full drives...
> >
> > To where? There's only one drive with unallocated space.
>
> ...but that's what I'd expect the balance to do?  If Block (Chunk?) A
> is on, say device 1 (4TB) and device 2 (2TB), why wouldn't it move
> Block A to the new drive from device 1 or 2 in order to free up space
> and balance/spread out usage across the drives?

That isn't how balance works on Btrfs. To do a balance on raid1 it
means reading a 1GiB chunk, and writing 1GiB *into empty space* on
drive X and 1GiB *into empty space* on drive Y. And then only after
that succeeds is the original 1GiB chunk (1GiB each on two devices)
freed.

No such thing as move. Everything is a copy.

> OH!  Just checked -- the balance finally cancelled after freeing up the 150GB.

OK good. At this point it should have the head room to do the balance.
It still might be slower than it would be if it had say 25% free space
on the original three drives.

-- 
Chris Murphy
