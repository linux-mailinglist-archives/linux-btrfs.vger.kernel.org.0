Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAA22E8B42
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Jan 2021 08:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbhACHNr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Jan 2021 02:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbhACHNr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Jan 2021 02:13:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10833C061573
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Jan 2021 23:13:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t6so12787280plq.1
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Jan 2021 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sHJhpzTPF37q1kyZxgMzb7fIapvE3V9wvxky7cZNxFg=;
        b=YjKiGbcV9+MUXeY4vemkyJjYtLHdmK3q2Om56clPnp2Ets9IjHUYOothkorcmCznfr
         31MKVk7XqEs7s/E2jHtp5JYYP1ELQzoXcYYwKRMSjypLBZY7LLGJUrp1M9Ex2/4DhngC
         WNroiAhQHbp2+Oto+FW2N1Ts0ZUqczdL65tti7chThZBGDhoXkdY3NPfT4wtjdQ0Kl+i
         s5Pb5s+HiwmpX76xy3XIA8Z01+h9oEHruKdqHzPAA6nY7vGTHMiTyP8/eLa2JTCD71Co
         /i3Mv+X+w0z3OSCBsLw1Pm7KhyQ1AB5NTF1uflbfDWnEkeh/byixsSWAny0sRpEqEC22
         +y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sHJhpzTPF37q1kyZxgMzb7fIapvE3V9wvxky7cZNxFg=;
        b=CbGt08x+MgC8R6yuyVrPdCgfI7KT7xTCeRQyX0mTmzoGh50i5Q5ZeAzitZRxXXW+PX
         edX1UYGwguaXBKNdMtL63Zz7NpWQlCY6SqrKY6UVYehB6Gd3Pxyn5vBKIBZ29OJMumTq
         YjSKJkFGZI+rZvw57Pt/Tzn0mZ5RL55naB+3WDEAJClPbf7D4KAfmF9Z0w81Ye3DheYl
         r/nq2IC8c4b3KXBbqWlxhpFmtr6dIcKLQXEy7OCarhnYdTvTvRwtaciZgKLnh9mYcYvs
         ahENtRLhS61f03FEep3M9Gracp/1RnTgqjvq66VqWrORSFGb5pOpAam7RUkchngwOBIl
         ETGA==
X-Gm-Message-State: AOAM532+rZDXyM0JhRRQT78yPQfxSoc9gp43BVur8ZbqyCgGI1wk+jYN
        bp0xemh87jRXOyxos/wCDaJSuwf4UD1jmZzd0Rw=
X-Google-Smtp-Source: ABdhPJzQH93HqAYj+MBCXbunSfNUByOB1mUc6I4tcTJxDIWZUxxjZNv4K/mlhHGqtNnhQKC7QBsUjLKrwZb+eoL7bkM=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr25028505pjb.129.1609657986498;
 Sat, 02 Jan 2021 23:13:06 -0800 (PST)
MIME-Version: 1.0
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
 <be4e5508-b8dd-148c-33d1-366b73f22d98@gmx.com>
In-Reply-To: <be4e5508-b8dd-148c-33d1-366b73f22d98@gmx.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Sat, 2 Jan 2021 23:12:55 -0800
Message-ID: <CAKxU2N8tHnnnOO9AeTTSJdPNmZonQ+Gx90xLGRpAB7GWGQRKUg@mail.gmail.com>
Subject: Re: Question about btrfs and XOR offloading
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 2, 2021 at 10:53 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/1/3 =E4=B8=8A=E5=8D=8811:50, Rosen Penev wrote:
> > I've noticed that internally, btrfs' XOR code is CPU only. Does anyone
> > know if there is a performance advantage to using a hardware
> > accelerated path? I ask as I use BTRFS on a Marvelll ARM platform with
> > XOR offload capability.
> >
> AFAIK XOR is only utilized by RAID56, while RAID56 is not considered
> safe due to write-hole, thus I don't believe whether btrfs supports
> hardware XOR would make any difference for now.
Right the question is about performance. I don't know if XOR being
async would make any difference.
>
> Thanks,
> Qu
