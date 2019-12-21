Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08698128AE5
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Dec 2019 19:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLUSvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 13:51:41 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:52293 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfLUSvl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 13:51:41 -0500
Received: by mail-wm1-f45.google.com with SMTP id p9so12085563wmc.2
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gMD8iehaR4JSzykYou5ZsOpAGsyP5ohfHmfM5YV52AU=;
        b=RqU8lmshqM3N1Ka+e11QjS+sJQEc6+rPDKC21/c2ztwH2WZ0OQdPlT2WqpC2ibVa8o
         Znbysr5PEXJQGV239wa2s//45kcZgQ96RqzEMgN1PxtYv8OxyToTY1nGHHcT+b1Z3Nni
         4GXIbs9bN6E7CfnZgKvfves9GmsZ/tAWF4inNRhYOObckBt9YynXp9xpCg1IM6SkFwWp
         oyI0red87rTqjoKEI20yVW0zlP7P1DkatPNeF/lImV9M7Mb54/1qHX3s5PqdI6rWWxRh
         XaSDb5DzMLPrfhipgsJij3ze7FUT5qrg8QGbOhX+9W9aYttAN3kPG/04dFfmcpoXVCy7
         YUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gMD8iehaR4JSzykYou5ZsOpAGsyP5ohfHmfM5YV52AU=;
        b=c0RZOqkcXOpemWZQi/ottggpXztjfYQ+b5P2eHJESpPBbLSD5f0VOO3MOOru4pnpgp
         6+f2F7ceisy+/iVWHQ2bKKIm2LoSsGM0H8O03MvlyNrXOm++Py/k9CNmERD+XM3gAfEk
         nWc8iNmQ1HU08cxT5KnRe79YZ1dfSHFTAS6Zl0f8cnPKB1j/SFrjgaI4LpfLqP12fQmM
         cHbTE+kgQTuvBr810bydshCxbuO/B0+WGzVel9KtkxlHoCUR54Go6NJhkYzz/Mpmx4iY
         X77Jc5WEh/Ec5zf/we6uhUuNb5yYYP41DV0sI5Albz1mLfWNXCd/r8VY7vZfgPDk2Hpc
         ksTw==
X-Gm-Message-State: APjAAAXkwRrCB4ZqJ1fPEuCAUsNJeN8Nk1jLFikzNxAVB6gr3Ci0BWk1
        DdQW6XY84VNdm9EQ3g2cY4RgT/U5ySEEgHrCbXwNaA==
X-Google-Smtp-Source: APXvYqxD9tSkRbUZb10Zs+JLUeUhAOJfeZEWSBNvse4Tj1F9BO/jHYtFzNPX+wpiu985Pkuc3iorSzPsE0+yUWygJv4=
X-Received: by 2002:a1c:81c9:: with SMTP id c192mr23072473wmd.44.1576954299133;
 Sat, 21 Dec 2019 10:51:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTcaSy+sm9JayVWXYu1fe7QXyWMmhCbJKwQs3Fuuzy15g@mail.gmail.com>
 <6eaa5006-038c-c543-f714-279998168476@gmx.com>
In-Reply-To: <6eaa5006-038c-c543-f714-279998168476@gmx.com>
From:   Chris Murphy <chris@colorremedies.com>
Date:   Sat, 21 Dec 2019 11:51:23 -0700
Message-ID: <CAJCQCtSyQxZWxfnW9pPx2=EN7dn0+6-w_7MT3r5LSj6yqvjY5Q@mail.gmail.com>
Subject: Re: dump tree always shows compression level 3, zstd
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 20, 2019 at 11:34 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/12/21 =E4=B8=8B=E5=8D=882:27, Chris Murphy wrote:
> > kernel 5.4.5
> > btrfs-progs 5.4
> >
> > test file is linux.tar (not compressed), it's the only file on the
> > file system in each case
> >
> > /dev/sda5        53G  2.8G   50G   6% /mnt     none
> > /dev/sda5        53G  2.2G   50G   5% /mnt     zstd 1
> > /dev/sda5        53G  2.1G   50G   4% /mnt     zstd 15
> >
> >
> > mount and dmesg both show the value for the level I've set; but btrfs
> > insp dump-t shows extents always have compression 3.
> >
> >
> > [47567.500812] BTRFS info (device sda5): use zstd compression, level 1
> >
> >     item 14 key (328583 EXTENT_DATA 2060582912) itemoff 15488 itemsize =
53
> >         generation 51 type 1 (regular)
> >         extent data disk byte 6461308928 nr 20480
> >         extent data offset 0 nr 131072 ram 131072
> >         extent compression 3 (zstd)
>
> This number is not compression level, but compression algorithm.
>
> typedef enum {
>         BTRFS_COMPRESS_NONE  =3D 0,
>         BTRFS_COMPRESS_ZLIB  =3D 1,
>         BTRFS_COMPRESS_LZO   =3D 2,
>         BTRFS_COMPRESS_ZSTD  =3D 3,
>         BTRFS_COMPRESS_TYPES =3D 3,
>         BTRFS_COMPRESS_LAST  =3D 4,
> } btrfs_compression_type;
>
> Level is not recorded in that field.

Oh lovely, that's embarrassing. Thanks for the answer!


--=20
Chris Murphy
