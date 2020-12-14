Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CAE2D9578
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394498AbgLNJre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 04:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgLNJre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 04:47:34 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54633C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 01:46:54 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id h4so10133135qkk.4
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 01:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=bG3OfK93OTt5aeq0EsWXM+Fr8VsHBVNWpyzYQP/PJmQ=;
        b=YUJQRGa04QMXiPnhUxIAil2HtWiWLghzS3x/n9M2KoEd8cfvo9uj8WriJip7/FEV//
         X5gUY84XQFPvwSjZifY8A7vfTV88wJDb2q4JsPh7Ge5RkeQwmbLRCuo26gh2enPO/S1s
         kCcgkoOdsfHNYHm6QlFiDkzP8R0CnYuqmtsb7G1NBrm71Sw84LQuDmBDq6Qh707PcPX7
         fsbr38N7JoyCEs+dKHBJrABG3h+D1+4cWs8zr05+d6cVmi2o2ggBs3Qz4za5f4+b1o+k
         GClRE/wA8B2dxH4/U1uT1v+usRVetz4IeDa08hTSJnohSR0K2i81oMsP+uxiHnsLkel2
         OLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=bG3OfK93OTt5aeq0EsWXM+Fr8VsHBVNWpyzYQP/PJmQ=;
        b=Po5q6mCAYMElXzt2q99p+6UPuCV2WyGRV4U+prfYyx0x1CpfAwcnabH+B/mqRYYqY3
         TEzZy+lR52QcJpsGpOFIAZZz05YSJBDHy5Yi3W/FZJba+UIxgK4bfOWRRb+if0mmAajl
         NnXLnI6zamCsPLclQ2FD9ZAjZMNVli+SiHBsZuM1KytTbStNrwR6Qy8n6w9fCZZvpqWU
         /Y+57F0Kl8gwoRze8VjZa3d5f5juQqjQ8IeK25V0R2zmdsz1I6R+VTn+YnZyQ89Ja3c5
         vcNgI5wvHVyb5OM7cbIhu4nNvjRKRB3mE0OaFVCzpCtLn7SbfpE+9SO6dI+8uafsJ9hw
         QSvg==
X-Gm-Message-State: AOAM5315HKvpVVDhv5fQgKWoSmWXTw7qmUi1hyOYxqRM5oDAo929UrgT
        L+tbnMO7bqaj/Qm3RMdnQpvzIfDdCk5stUcRGKA8OnMsOuI=
X-Google-Smtp-Source: ABdhPJwzrD+VoJu0Vnb36dJGO8hoqsI+tnAOL5FCd++UKoB6CL9Oiv7ZB7s3jmkSgGIRLKEMNnN8mqXLOc9TsTja+dI=
X-Received: by 2002:a37:5cc2:: with SMTP id q185mr24215546qkb.479.1607939213572;
 Mon, 14 Dec 2020 01:46:53 -0800 (PST)
MIME-Version: 1.0
References: <6ae34776e85912960a253a8327068a892998e685.camel@gmx.net>
 <CAL3q7H72N5q6ROhfvuaNNfUvQTe-mtHJVvZaS25oTycJ=3Um3w@mail.gmail.com>
 <d4891e0c7aa79895d8f85601954c7eb379b733fc.camel@gmx.net> <CAL3q7H5AOeFit_kz4X9Q2hXqeHXxamQ+pm04yA5BqkYr3-5e+g@mail.gmail.com>
 <40b352dfa84e0f22d76e9b4f47111117549fa3bb.camel@gmx.net> <CAL3q7H7oLWGWJcg0Gfa+RKRGNf+d4mv0R9FQi2j=xLL1RNPTGA@mail.gmail.com>
 <1f78cd5d635b360e03468740608f3b02aea76b5d.camel@gmx.net> <CAL3q7H4r-EtnMc=VD2EP01HsLCqg-z8LfMnFseHrNEv=rjPT_g@mail.gmail.com>
 <c0aa48c7db8c00efe8dd9a2c72c425ffe57df49c.camel@gmx.net>
In-Reply-To: <c0aa48c7db8c00efe8dd9a2c72c425ffe57df49c.camel@gmx.net>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 14 Dec 2020 09:46:42 +0000
Message-ID: <CAL3q7H7LCaRE_28RRY0zfHiJo5G1EkDHKCuue3-052AeuXmG4w@mail.gmail.com>
Subject: Re: btrfs send -p failing: chown o257-1571-0 failed: No such file or directory
To:     "Massimo B." <massimo.b@gmx.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 13, 2020 at 9:55 AM Massimo B. <massimo.b@gmx.net> wrote:
>
> On Wed, 2020-12-09 at 10:29 +0000, Filipe Manana wrote:
> > So to confirm if there are other problems, you really need to let send
> >
> > and receive processes finish (don't kill them). If they finish without
> >
> > failure, then check if temporary directories (or files with the same
> >
> > name pattern) still exist or not.
>
> I continued with send|receive successfully with a lot of snapshots, then =
I found
> some new error. Is this also related?
>
> clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC/..=
..pdf source offset=3D20705280 offset=3D20709376 length=3D4096
> clone mb/Documents.AZ/0.SYNC/....pdf - source=3Dmb/Documents.AZ/0.SYNC/..=
..pdf source offset=3D20713472 offset=3D20713472 length=3D4096
> ERROR: failed to clone extents to mb/Documents.AZ/0.SYNC/....pdf: Invalid=
 argument

It's a different problem. This one because the kernel is sending an
invalid clone operation - the source and destination offsets are the
same, which makes the receiver fail.
Can you tell what's the size (in bytes) of "mb/Documents.AZ/0.SYNC"
after the receive fails? Both in the destination and source.

I'll look into it.

Thanks.

>
> Best regards,
> Massimo
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
