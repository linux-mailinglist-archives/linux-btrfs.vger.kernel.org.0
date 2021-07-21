Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B353D15F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGURdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhGURdx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 13:33:53 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D1C061575
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 11:14:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r80so3750819oie.13
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 11:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BPUGLDGmne1oVoXaqqGKxuVfKgvE5xz4i0qcEnAZt1U=;
        b=mOqmWA5J7Onoe6jcdAqQNRZHUEMj8KEn59lJV2pDnkxIWW6DJObAv94MNJKxTrQ/im
         ZcqdG81FpgOpxXbpjfPtjDJLJYfsSPRaDoujy7ldwtv66ZjxHoVgcg/BCOfR7D0VO21r
         QvqRCww91IDfGwsItM/Aggxg1hkmXA+tOMYIkESRm4d3sCkZJW8KLbhhBfLykabL2klW
         RpT4njpUSIdD6EpmztM190EwlNlDREmpqQWDfrJcEIDEfXPyNw63I+N+bL06PY8f9hQz
         iuM/3r70CKi4YjWuAWQbWJxkh72pX2D/ND5xHlEvz5pQ4Ac3FjLd9tzc36TG3HRBOty2
         BcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BPUGLDGmne1oVoXaqqGKxuVfKgvE5xz4i0qcEnAZt1U=;
        b=tgWcl4JTUeJcA/Z1KMqp7UHZkBVBTrEOb6eQYagNWZJ+tSkcjIiAqoXfh+vl785PRc
         txnWd+bdt9nXp0gQ08GbyJxtcBPa9wI1O1mS5HYeHQHwPTrepDerJmn+6PGB6otlWxHu
         /2Ai3f+yPhdlH87zedti/koEdgbK8NFhnMFmYvTLX5+K3q16P5X/7iV8bO2G/Q0KAN5T
         CTU535ExVfBIGyLvjOUaJL4T2OTZP3TawiDqUex51ZNm57uYLK/eWldrvDanhUVDB0hq
         EZWRXWwxN7+oQRc38OdqIFOaTFl3DVn8Z8T2ogeGnLgIvkEuB1Mm/aMdKBKahy7sa32r
         0Kpw==
X-Gm-Message-State: AOAM531Ea7vYeCQ8sTd1r64jqhSbQu9sqR4Fx+TWXzEkLedIkffa550X
        y8tPxON6jL6gCKinFKU+ZAG7/UhdmCFDClDKkH0=
X-Google-Smtp-Source: ABdhPJyb+ctLSyMYKqsTPJPwS7XKRvI8ia969zzc9bk3GGkAZ8xfNhAqvuPqrBB6eat14Wam1M03JX4jvSjTbHC3MXA=
X-Received: by 2002:aca:4406:: with SMTP id r6mr20731587oia.50.1626891268354;
 Wed, 21 Jul 2021 11:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz>
In-Reply-To: <20210721174433.GO19710@twin.jikos.cz>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Wed, 21 Jul 2021 19:14:17 +0100
Message-ID: <CAHzMYBQnP=rqa_mf9TXAEK3Yrpjezff0cE=pBsunbBT63wHeSQ@mail.gmail.com>
Subject: Re: "bad tree block start, want 419774464 have 0" after a clean
 shutdown, could it be a disk firmware issue?
To:     dsterba@suse.cz, Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 6:47 PM David Sterba <dsterba@suse.cz> wrote:
>
> For the record summing up the discussion from IRC with Zygo, this
> particular firmware 80.00A80 on WD Green is known to have problematic
> firmware and would explain the observed errors.
>
> Recommendation is not to use WD Green or periodically disable the write
> cache by 'hdparm -W0'.
>

Thank you for the reply, yes, from now on I intend to disable write
cache on those disks, since I still have a lot of them in use.

Jorge
