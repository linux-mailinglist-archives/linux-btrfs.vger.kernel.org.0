Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0295852026
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 02:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfFYAxm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 20:53:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35198 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfFYAxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 20:53:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id f15so5917945wrp.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 17:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2lwt6Sx0UTWiuSHDqtmbXq6SAfVksJDWM7fKnSgID3o=;
        b=gWaspVWU1W+r63W/a1UM6SGXjCGype0mbYHWnUPreWNZ8nFjQCDUb0UExwyRm+XfJi
         Nlfeo9l4hsWP58WPJeGIKzNDd3O3qOBY7JPvBb74+lTGOdFQ/aupcOZ9dOooaR9mYyEC
         Ai4ajVWNmAW8/DXxAH7HZkRVCPAxUkOVXN3hxDikKUUvSfaO15/Nlwu6h4lm4njVG15u
         YAfFH7ELoshiQ+uPuGD9FU49rmk77D+UQMkKuTO1BlXUSB6tBhxLQTTFHPMIKn2ZBtrv
         LtCh3MvzAMM0CABeMKul8ygECEl1WEXVxX5FIprpDp1NXFKlfoOzg6S53XzAFXIHpEp8
         0JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2lwt6Sx0UTWiuSHDqtmbXq6SAfVksJDWM7fKnSgID3o=;
        b=umKKtzDQ7L9Xx8nBEl2+TDJVDg8hbmwmPZfOEMaD3HmezBUF5pSgYFGN+G5tY2gOGC
         JJdouihry8l7/2VsNll64mNTSp5PKBScL4SbWJCkpWNvzEW1ww8tNiq3JZq+oqMvrje6
         Bloq1+lPT4a9W/J97DLr4Tn4qfLXVKKwKiWEMlOjbA3peHkJPDNpJqghVb74J9JEnrKt
         VhxgIr/XlkRArUypQhYksx98ogMM3QkHkkyTfRTx+Quk4JEEwi1x+kHaVp6PLQqMLLNz
         6NHUiHsSt/Ffrs3LRTpQIc1hbnMr9hjv+2WQNfju8RHY/cu/15590phrvZOFjGzeoFCq
         Uv5A==
X-Gm-Message-State: APjAAAUH/T00tgJPRaUQmxDKt1zHqnG22Ca8LmJztOH+g7qlns4MtAA3
        1m023LL4UbIAKPtEeqskzmGJwY5qKw02iIsBEmK3CI8pH/kHnw==
X-Google-Smtp-Source: APXvYqxkoOKWN5zqlKveHU1AHKEmEEDld51vJsje6MHPT9yrG2r0T69PcnvuYZ365NaCqahRiS9cOPgvkIKZDlccwj8=
X-Received: by 2002:a5d:5283:: with SMTP id c3mr29127800wrv.268.1561424020262;
 Mon, 24 Jun 2019 17:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <CAJCQCtR3azJyM40P0AyHSAp=uWxchN+R=LR5BxCuzdxQ5_JcbA@mail.gmail.com>
 <CAJCQCtSN5EO5K3T3K0hkzGPX0sXVL_HiL7V-W_aW5kE_1jjfEw@mail.gmail.com> <4d34f586-6045-0fea-e1a0-0b0c4253fb3f@applied-asynchrony.com>
In-Reply-To: <4d34f586-6045-0fea-e1a0-0b0c4253fb3f@applied-asynchrony.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 18:53:29 -0600
Message-ID: <CAJCQCtR6x=uw-+X4_yxNfp6efZOEb6zVx9L=2ApchpK_jp2hwA@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 24, 2019 at 5:29 PM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 6/25/19 12:46 AM, Chris Murphy wrote:
> > Same call trace on ro mount and ro scrub with 5.2.0-rc2+, but also an
> > additional call trace related to zstd. As this is a zstd compressed
> > file system, it might be related.
> >
> > [  366.319583] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  366.325036] WARNING: inconsistent lock state
> > [  366.330615] 5.2.0-0.rc2.git1.2.fc31.x86_64 #1 Tainted: G        W
> > [  366.336202] --------------------------------
> > [  366.341788] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > [  366.347423] swapper/4/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> > [  366.353042] 000000006070e818 (&(&wsm.lock)->rlock){+.?.}, at:
> > zstd_reclaim_timer_fn+0x26/0x170 [btrfs]
>
> Seeing that this is apparently *rc2* (which is insane to ship) the explan=
ation
> for the above is that 5.2-rc2 was tagged on 2019-05-26, but the patch for=
 the
> above problem [1] was committed *after* that, on 2019-05-28.

a. Please relax. I said from the outset it's Fedora Rawhide, they
build mainline rc kernels on Monday, and each weekday there's a plus
version built from whatever's in Linus's tree prior to the next rc.
It's been this way for a very long time. No one puts Rawhide into
production including myself, it's a test machine.

b. That rc2+ kernel above was used today for read-only inspection of
the target Btrfs file system, just because it's what I already had on
hand. That I've been using the rc5+ kernel I cited in the first email
for the past three days, so I'm not sure why the problem starts
suddenly. The problem is with a stale systemd journal.



--=20
Chris Murphy
