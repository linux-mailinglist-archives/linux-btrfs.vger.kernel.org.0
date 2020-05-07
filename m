Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C771C7FD2
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 03:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgEGBbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 21:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728294AbgEGBbJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 May 2020 21:31:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB68EC061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 18:31:08 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x73so3031444lfa.2
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kdn07VXRZm356GJisA5223vmH8mt6Hum5mLPbDhPNSQ=;
        b=oYT9XSaigfpsd6zcILdoC15dtl+afkLqEjvVhN1Sd2CCFR70ypc1AHsEcx8ocGXwWH
         bw5BnVaCGqOcl/IvdjZcCb/aqaVmMgv+Y3NaHBYZXdbBQr6yjhiaQwdn1X5rEKHlYm79
         hwiT4RHveZ23jXmxwAiawgLTG2y2dIvq/fcJCc/T3OxreGRK4dfwT+xv5B2CWMYLRzY9
         wc6V36gYNlPtf6sH67HFE9CUK4GDIa37K+m3zyxbOA3u/gfOOqjlEfYOwt1B88ofNKVl
         9bPYrtWIaFTLEmtxDqhl8J/oFkmD7e164gHlNN7zV75XpBZDgIdhEhA+VlXXyJEIW2bJ
         cqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kdn07VXRZm356GJisA5223vmH8mt6Hum5mLPbDhPNSQ=;
        b=czWV21Ga/CDf/x8ffuNf7zKGt6qmc70T1Up7+c8ZKQ5lCewLhPKT8kST90S/Dh75/W
         lVvRvuxRXduaf0WWVEl94X+fZ2oIA1IrjsRyak5tx6Lwrm8o0740h7bU3ssa8KBuOWRf
         fCII0iv9zVL7xplCyL50nyOjBkI2uZzXY9ZUTwu6KvmYEjGyGnP7SIVtBhIVqawl1Uf0
         kShlpKxQQJssLigQV1LfEnGTNmtm1Mv09sKeaqIPBwurhz8B0AA2WNy/E1+q+U4ry+Zw
         o8CuqX5T651C9bbCKSJYDK/obhkQJLBOPLvqRup5d3pVaU80YMUoX5oECsVrf/zNqP12
         fKiw==
X-Gm-Message-State: AGi0PubO21QZWMZJGCMr5Jt+pgf+DcHb75cxdasEUsBgfd7POsAbsmy5
        RYJL9/dJ4k+v+AY5Mtgl2l4CfdGQdSOGA3dBYa7Q7w==
X-Google-Smtp-Source: APiQypK2Gx1iwpE8GsxiBCF2T9gcdoTYFxDQzBoV5cPbSTWU3qoYGecSXOJedaY4LY+woaH0CBRl4f3UpJ94yDHSsaE=
X-Received: by 2002:a05:6512:3187:: with SMTP id i7mr7120467lfe.101.1588815066792;
 Wed, 06 May 2020 18:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com> <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
In-Reply-To: <a89afb42-facf-3e11-db53-c394cf8db2ce@gmx.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Wed, 6 May 2020 21:30:55 -0400
Message-ID: <CAJheHN26GYa7ezw-Jw_y5voFicoywwEJ2pJ4KKx96x-WA2h1eA@mail.gmail.com>
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, lists@colorremedies.com
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris, I had used the correct mountpoint in the command. I just edited
it in the email to be /mountpoint for consistency.

Qu, I'll try the repair. Fingers crossed!

On Wed, May 6, 2020 at 9:13 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/5/7 =E4=B8=8A=E5=8D=885:54, Tyler Richmond wrote:
> > Hello,
> >
> > I looked up this error and it basically says ask a developer to
> > determine if it's a false error or not. I just started getting some
> > slow response times, and looked at the dmesg log to find a ton of
> > these errors.
> >
> > [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=3D5
> > block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generatio=
n:
> > has 18446744073709551492 expect [0, 6875827]
> > [192088.449823] BTRFS error (device sdh): block=3D203510940835840 read
> > time tree block corruption detected
> > [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=3D5
> > block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generatio=
n:
> > has 18446744073709551492 expect [0, 6875827]
> > [192088.462773] BTRFS error (device sdh): block=3D203510940835840 read
> > time tree block corruption detected
> > [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=3D5
> > block=3D203510940835840 slot=3D4 ino=3D1311670, invalid inode generatio=
n:
> > has 18446744073709551492 expect [0, 6875827]
> > [192088.468457] BTRFS error (device sdh): block=3D203510940835840 read
> > time tree block corruption detected
> >
> > btrfs device stats, however, doesn't show any errors.
> >
> > Is there anything I should do about this, or should I just continue
> > using my array as normal?
>
> This is caused by older kernel underflow inode generation.
>
> Latest btrfs-progs can fix it, using btrfs check --repair.
>
> Or you can go safer, by manually locating the inode using its inode
> number (1311670), and copy it to some new location using previous
> working kernel, then delete the old file, copy the new one back to fix it=
.
>
> Thanks,
> Qu
>
> >
> > Thank you!
> >
>
