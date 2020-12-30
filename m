Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5E02E7BA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Dec 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgL3RkG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Dec 2020 12:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgL3RkG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Dec 2020 12:40:06 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146CBC061575
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 09:39:26 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id w3so15971398otp.13
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Dec 2020 09:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJv2yr+w/Zm0BDGuBudb5fciAyi/wSJnpWV41lljAIQ=;
        b=kV3kda7R0/42l1b+7yANLIXzVtemlc91wRA9p0z0l80W87EUuJhQq3fl6Kr25Ctq6P
         EaD0eyafuWqWXXb1uWZPAt0VBkGGVJ7Er+I6ty6HqygFXmXd8HiXsszLg5hO3HLdVtoi
         FB5EfB0iG/yVsIMXzlTi3yDSKbcULscWwwwn6GlvwyKKEzsSvS5GnaxvbkHDpKx8NPK5
         wuhSoLGEjr3dcKrny894LkElTky/lQNBgJ0TP0xc27shbXGLUU6McKctkE7pxBrJh+u2
         of3x4I4YbJxxwVjhS355eZxgdfG3vxnYm39SBG6GVPbFs5MCHMWp28ni5DmHfJl1Qutx
         FgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJv2yr+w/Zm0BDGuBudb5fciAyi/wSJnpWV41lljAIQ=;
        b=DVnywT9a0xYKjZFQv1JPNO9GZbSKZ0qf24FNgv4c9B6LxusVID5PMA/u5ZNGNHS0yd
         tP7ua/jBspeWnnnGjfwyI3R7ZV1a8PAnjPe276Z4dVZEK5BxVP5+nFkXAX27uBwx56r6
         sGu1a2b12pNm0IV3Myo8sD/fSAvqgrfo7PkurwCayQ20AHSBYVyskYHkXiIG2oyVxBV7
         lY5i1FdE/xfajv16X+X7Vl/vNuJHM7qrG6D2o8Gbv40RokN3w+o+ay/1/k0FpBW9QLsj
         0e6eZ0qsMn3/mXxew9yjNWUFuDGZ7uI7/ZM9q/EklLP12Y6QOpHeYIs8lgNK0YaxDd7v
         Shjw==
X-Gm-Message-State: AOAM532aNKqznmXpnIjbNFXOevxwGZMw44MSdGa6qnUMpcOA/HJC1hrh
        99ArjuYs78eYRLkgHCsY+1v2BPF13CHDvZsVeQWp+NZzt0p/bPGS
X-Google-Smtp-Source: ABdhPJxsSINmnO5gNcGRXO8M8yBwU292IuF+SC5OEkOrl2X30QMi7smC6YkDgjcMjEepWmSZ5vezNNDIbC9lu7qWHuo=
X-Received: by 2002:a05:6830:1210:: with SMTP id r16mr39993523otp.343.1609349965538;
 Wed, 30 Dec 2020 09:39:25 -0800 (PST)
MIME-Version: 1.0
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
In-Reply-To: <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
From:   john terragon <jterragon@gmail.com>
Date:   Wed, 30 Dec 2020 18:39:14 +0100
Message-ID: <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
Subject: Re: hierarchical, tree-like structure of snapshots
To:     sys <system@lechevalier.se>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 30, 2020 at 6:24 PM sys <system@lechevalier.se> wrote:
>
>
>
[...]
> You should simply make a 'read-write' snapshot (Y-rw) of the 'read-only'
> snapshot (Y) that is part of your backup/send scheme. Do not modify
> read-only snapshots to be rw.
>

OK, but then could I use Y as parent of the rw snapshot, let's call it
W, in a send?
So I would have this tree where Y is still the root.

Y-W
 \
  Z-X

Can I do a send -p Y W ?
Because I thought it was other way around, that is I do a readonly
snapshot W of Y and that will be the base for incrementally sending
the future modified Y to another  FS (provided of course W is already
there).
