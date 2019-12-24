Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991B0129C8C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Dec 2019 03:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLXCEc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Dec 2019 21:04:32 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45291 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXCEb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Dec 2019 21:04:31 -0500
Received: by mail-wr1-f46.google.com with SMTP id j42so18562008wrj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Dec 2019 18:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F2Oo7xsv2zB3qAXSFbrJNzJiLI11W3c5/iLprQuizYY=;
        b=dCAd04zAj2zOJXQpkwYVRi+Q2yuWB6qKhwkEBUCSLZ7JRczVuiw36TQWRTVq5PnEiV
         UQGkkVIJtRUPGK0t5y2hTfA+SC/dLTdJD9RRL/oo6oehvVIc0QN6yNIQWtYdCpDFVHO5
         m92/0/ALwoEkT8dBhQrRHmyPyd6NMToS4D7PezTXH++UzlolZWCV8B0Vsp5IiVJDjn4X
         HZvuEJcs/xa5w7YI3CFUnq0x6BRya5Ob9cmJeojNKaLATWi4gqWBce+KUSHMO8rDJgm4
         +r4dNF0r8vD9dYs1EGdiZmtjfXI7OrOxLY2hTWpkr80p5YITBCmAN2mrmIzh0S1t2erf
         5gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F2Oo7xsv2zB3qAXSFbrJNzJiLI11W3c5/iLprQuizYY=;
        b=Hj4BJUJ8H0Dw2yXqYj/dJ4nRYVqLZnyD8Fw4XVJbZQjdtdhAmJy4nwJNO1BoBE2UZV
         BBVMG95iFc7mYibIRO6gPL8Cc7UOZu5KcSAXUYsKWkPtZaAjGFXAz5xz6AOjih5AAhGo
         ml2Q6xPTwS1tdDrd9RbkbIjvgX46ybHyts2+PWNXEQTIVpGFrG9TrVWgxkqGWdkM5G+j
         5Khq2aBncW8VTCkn3t9gFD8xPx2yBI7rOOpHrU9p9p6ZppBWspFJwDu2LdkX8f2jSlC/
         BDp5mLg1SMWgjMXEbb5MI24mCkYWkKhPnrex4CBIoWRkWs6S6alvVMVzgift41xWW8nB
         Hx4g==
X-Gm-Message-State: APjAAAW5mgmR3sD5kxcX3o5krd1JfjwspwMn7U215P9GHUpWlfM9/iHL
        f8LRjZdLE3cp/lZnkmMJmow2GcNN3zlaEG3Yh0tSb0SnSWin2A==
X-Google-Smtp-Source: APXvYqyU6teR6fTrBsltKc2IIKczOJIv4UTuaJwLWamr+olLQK3c8ypDFnv960L/X5prSqFHNdlL2ZoFOZcjV3EYjKM=
X-Received: by 2002:a5d:5487:: with SMTP id h7mr31524963wrv.18.1577153069427;
 Mon, 23 Dec 2019 18:04:29 -0800 (PST)
MIME-Version: 1.0
References: <16f33002870.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr> <fbf7c50b-fc02-bf51-b55f-6449121e7eec@knorrie.org>
In-Reply-To: <fbf7c50b-fc02-bf51-b55f-6449121e7eec@knorrie.org>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Tue, 24 Dec 2019 10:04:12 +0800
Message-ID: <CAP9B-QkL60aELFZzOzZStbAz2UWj11V8YNPtSWWgwzeEnbLpvQ@mail.gmail.com>
Subject: Re: Metadata chunks on ssd?
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     =?UTF-8?Q?St=C3=A9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 24, 2019 at 7:38 AM Hans van Kranenburg <hans@knorrie.org> wrot=
e:
>
> Hi St=C3=A9phane,
>
> On 12/23/19 2:44 PM, St=C3=A9phane Lesimple wrote:
> >
> > Has this ever been considered to implement a feature so that metadata
> > chunks would always be allocated on a given set of disks part of the bt=
rfs
> > filesystem?
>
> Yes, many times.
>

I implement it locally before for my local testing before.

> > As metadata use can be intensive and some operations are known to be sl=
ow
> > (such as backref walking), I'm under the (maybe wrong) impression that
> > having a set of small ssd's just for the metadata would give quite a bo=
ost
> > to a filesystem. Maybe even make qgroups more usable with volumes havin=
g 10
> > snapshots?
>
> No, it's not wrong. For bigger filesystems this would certainly help.
>
> > This could just be a preference set on the allocator,
>
> Yes. Now, the big question is, how do we 'just' set this preference?
>
> Be sure to take into account that the filesystem has no way to find out
> itself which disks are those ssds. There's no easy way to discover this
> in a running system.
>

No, there is API for filesystem to detect whether lower device is SSD or no=
t.
Something like:
       if (!blk_queue_nonrot(q))
                fs_devices->rotating =3D 1;

Currently, btrfs will treat filesystem as rotational disks if any of
one disk is rotational,
We might record how many non-rotational disks, and make chunk allocation tr=
y SSD
firstly if it possible.

> > so that a 6 disks
> > raid1 FS with 4 spinning disks and 2 ssds prefer to allocate metadata o=
n
> > the ssd than on the slow drives (and falling back to spinning disks if =
ssds
> > are full, with the possibility to rebalance later).
> >
> > Would such a feature make sense?
>
> Absolutely.
>
> Hans
>
