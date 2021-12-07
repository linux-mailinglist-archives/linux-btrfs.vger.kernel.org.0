Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1046B124
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 03:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhLGDCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 22:02:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:36999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhLGDCf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Dec 2021 22:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638845943;
        bh=l7F52h5IGLZCsX0sQnU71ER1kJ0LAKhjZvtp1hmK/TQ=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=SpG402jKBOZabqeImbsF/5rwTA04s8wUEfm7mxBwZBuiAx6TDmgBtkeHmuMpgaVUa
         6RHS7ofaGc8d2mDwTW3uJ2UwwEvtpumg2cAqy05ax4OdoLYiCxw58GSmzA2e14cOz1
         9VWeETsxAzSuRJztzbbTyoeMfkLQSNQbLKr1qKMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McpNo-1mKXuX0YWw-00ZzTD; Tue, 07
 Dec 2021 03:59:03 +0100
Message-ID: <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
Date:   Tue, 7 Dec 2021 10:59:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: ENOSPC while df shows 826.93GiB free
In-Reply-To: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:siXc5EylfuCT8na/RaQxWrGp/TFAvQJqWGeEZNcDxMbAxOZVRsd
 /9fUixSXNfm3XKgTaYRIYi7sC0h6iPWxrcZqSpWjbW2frWAzZgfY3AKNAthJfgUCabDnWMN
 O3qJ++t+Pz+JgOEu2wO7gE2jap67IQaE3nTYujbnHy2ZOGnzYqbrIqYR9ySwvNikwFCPydD
 bNlohZxWxGC7B7AcKrjsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jji2zcn5KY4=:+bCXUdp1UB++EGB465KZL1
 /48qfGIWtU79pPL3MTtzZhwqse02PyMzuJpqua6xd86XE+h3t57WNazWyy7kUyLvLxOhFSCZl
 F3dGjIIgcz8D/YLfhTkSnxTSSMTfY5f/FZNkETfgKqXuuvDsONosxM3f4DPVvCI4GC4KyJQBv
 AJoAXgrvUK0XsNT0tMgyCw9cL410oOBDca2hQbORtPHoYqMvskN6RW1ycSN4J/twG3YbD9YDf
 Bg577CyvOPTLNMBlwMDRfLi+c9Wxb1CLbmGpLnM/WGGl/C4JJuZrM2CRvjn0SHC+vBp6sXiEB
 s5GQBDU6qL1YpF97ubgVerC34mv2jAwxzcu81v26z4uS0Ayyo/C3XRgijO3X7TlbJ9sFGjtf4
 09fh51nkRGW1E04JfzQ+Us+Icht1lgDkd55RXWUX3oFOXv9RgyCfh+qtfnqE7N6ZCKmaAToG9
 ibKTaorPX0izfcA1rN+pYnx9xstiUm5WzrXd8mqr1W68DCUszMqbuN0VvlIKk1YRWntFryO7a
 d4vNbxqvQ+su8C3+yPVnTaA+vUtdgLl8t74pE4v4cDws+kYs0S8keNuxuGSdCcw2hrmKaDpmE
 YnW7HP5N4vU2dHfXm8fBhqTD1yvNG6lGU7vIa1Il34FYBGDaSGPbVIfBZpiQ4kd7SoFaYs0a5
 mrIdHLlq/yS4lv3PZfvo4jT2tm6GTBxQANIiTo2Gk1iC0yGsiYDhNpQLgA85fQ9fhE41c54e7
 vy+0/Ex+xaEQfyFR1TL5QTEY14XFO3la919FsHu7mLOrB9kWdEugpx5eZ7yChODEAEw3DCp50
 G4hj7GH4K1aW/p07nTPetu7gHyvICPspsGEsbpaG40dZF2VIk2h7CLnof1cTjUfIEYXzRO2hQ
 wwlYNDkAfB8wy9k04bGBFS7rKtmo6TNmZFFT2F85wQMCxhTGNZo/qAByLudi837y7rrFeRmKU
 QZtqrAvBZkeKKPQJ3hfui+mZhdiHMzPU+4m6b8Twq1e+nHfFgIC2mj+zLWo6CgH+yW/L5JcGd
 ZKBg6nnPxMYi3x8VG6jyQhnXgZo+2KQAmjYgRkSVZONtXWtahuhOuEvjrOngz3vpcuxBY4JJO
 kj1eyN9unbmpMA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 10:29, Christoph Anton Mitterer wrote:
> Hey.
>
> At the university I'm running a Tier-2 site for the large hadron
> collider, with some total storage of 4 PB.
>
> For a bit more than half of that I use btrfs, with HDDs combined to
> some hardware raid, provided as 16TiB devices (on which the btrfs
> sits).
>
> It runs Debian bullseye, which has 5.10.70. Oh and I've used -R free-
> space-tree.
> I don't use snapshots on these filesystems.
>
>
> On one of the filesystems I've ran now into ENOSPC.
>
> # btrfs filesystem usage /srv/dcache/pools/2
> Overall:
>      Device size:		  16.00TiB
>      Device allocated:		  16.00TiB
>      Device unallocated:		   1.00MiB

All device space is allocated already.

>      Device missing:		     0.00B
>      Used:			  15.19TiB
>      Free (estimated):		 826.93GiB	(min: 826.93GiB)
>      Free (statfs, df):		 826.93GiB
>      Data ratio:			      1.00
>      Metadata ratio:		      2.00
>      Global reserve:		 512.00MiB	(used: 0.00B)
>      Multiple profiles:		        no
>
> Data,single: Size:15.97TiB, Used:15.16TiB (94.94%)
>     /dev/sdf	  15.97TiB
>
> Metadata,DUP: Size:17.01GiB, Used:16.51GiB (97.06%)

Your metadata is full, although there is some free space (512M), but
that's mostly used by global rsv, for very critical operations.

Thus your metadata is full.

>     /dev/sdf	  34.01GiB
>
> System,DUP: Size:8.00MiB, Used:2.12MiB (26.56%)
>     /dev/sdf	  16.00MiB
>
> Unallocated:
>     /dev/sdf	   1.00MiB
>
>
> yet:
> # /srv/dcache/pools/2/foo
> -bash: /srv/dcache/pools/2/foo: No such file or directory
>
>
> balancing also fails, e.g.:
> # btrfs balance start -dusage=3D50 /srv/dcache/pools/2

Since your metadata is full, btrfs can't reserve enough metadata to
relocate a data chunk.

> ERROR: error during balancing '/srv/dcache/pools/2': No space left on de=
vice
> There may be more info in syslog - try dmesg | tail
> # btrfs balance start -dusage=3D40 /srv/dcache/pools/2
> Done, had to relocate 0 out of 16370 chunks
> # btrfs balance start  /srv/dcache/pools/2
> WARNING:
>
> 	Full balance without filters requested. This operation is very
> 	intense and takes potentially very long. It is recommended to
> 	use the balance filters to narrow down the scope of balance.
> 	Use 'btrfs balance start --full-balance' option to skip this
> 	warning. The operation will start in 10 seconds.
> 	Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting balance without any filters.
> ERROR: error during balancing '/srv/dcache/pools/2': No space left on de=
vice
> There may be more info in syslog - try dmesg | tail
> # btrfs balance start -dusage=3D0 /srv/dcache/pools/2
> Done, had to relocate 0 out of 16370 chunks
>
>
>
>
> fsck showed no errors.
>
>
>
> Any ideas what's going on and how to recover?

Since your metadata is already full, you may need to delete enough data
to free up enough metadata space.

The candidates includes small files (mostly inlined files), and large
files with checksums.

Thanks,
Qu

>
>
> Thanks,
> Chris.
>
