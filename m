Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE362C642
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfE1MPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 08:15:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:55673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfE1MPW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559045720;
        bh=Pcht+kAtSxw4K/+9SBLcho/0j/mEnf5c8LiDQ/HuFYI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MN8jUyoLD7piir1SApyKx9w5XVLneCQDjH8t3wnefX0sjU99pU3cJDfXDpxt3G1vp
         Mp5DVvz815NVUeCnF0WFLUoGRLicnSziKy45kKj+Jvs7ASjy2I/g+jTHZgV3gxAHT0
         xWQaDKRKHBz3W9NJboyayG6NPywJ84seEhSX2vXQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from monk.localnet ([129.206.205.141]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0Np-1hUDZF2gUf-001OEC; Tue, 28
 May 2019 14:15:20 +0200
From:   Dennis Schridde <devurandom@gmx.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed on 604602368 wanted 840641 found 840639
Date:   Tue, 28 May 2019 14:15:15 +0200
Message-ID: <4832525.7q4I5aUDuF@monk>
In-Reply-To: <CAJCQCtRS1vvaczdpkYjkzWHWZgPxyq_B7XR9tY5yHhGAaBU7qA@mail.gmail.com>
References: <5406386.pfifcJONdE@monk> <CAJCQCtRS1vvaczdpkYjkzWHWZgPxyq_B7XR9tY5yHhGAaBU7qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2612858.MPL6rfmJeg"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Provags-ID: V03:K1:w/70vlEKxvXXEYHg2krG+Lejbhk6wOOUWkBb9ksobBqxoSw8Ig+
 uaX3QN5jPtz2ORKsWGwN+pPlwdu0s7c1lBvvdDP3DApYRX/PHZe3u5SLTYLfTyVOt3Sdj1Y
 LcZ5ieodZG+Fzwje43c7VULIQoaPSfIRv4yEx2XWEaGn13UXd0AOXJc9hnAm7S/Y8mTkg5U
 j3UYwFAjWppGkNi+rv0Dg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5lq2o3balEc=:9ItBPeZxIITEhAp2ihVgEn
 tvexNm+FsSVWd1Bu8Q9ZlPGhHCAxaQGE1Yl1JjKwiI/hKT33KnY8Q8Skl2oetjfCdwQk76RAK
 RId85ZPGboKiQFTALUPqJZrzXDpZp2rM+/iYabytMgD9MEDSriEtzy4lBYSRVumGnUn+PeX3n
 Ns0zOumpuoZUp9M3FfqYGoYO3L87KqzhaMxNQyHdDDcV4MOv93kNXggo3Aegi3LRSzylHDNiN
 RAo5Qyx+ZKnkX4GV2L8O2OXZ109Ls11nS2EnbXrCUKK9S82f8UIHQbamdmXNxHzkD2dioCCzZ
 lpeF+BX5ITdlSZ9LeFEhyvG96M+YS9kwYEDALGqE36o3Z2xTK3z+wC1bR2nwMsYDk8G00rIlL
 2E1yN2pnVUMWRHHKEyUr6eMcA8bGkA0mvsMjZhw+qt0ul45eYj7xeCIfQDrc//3kV3dVutUnr
 w9xTXKHrtxVNrGfNadjlkoYR6EhtPmLRJmDSPt2qDVnQJYaJ0NE56RjVtC6TFKw66eRnqVdgD
 SY4NAGZEau3lSK7hSAoU3/oJXwu+HYpLN9+7KtBgZZ5O6OVXeTpKvmdFU70q8bcqJqGQiSflY
 Wvp0/A8hjFq2AlBW0sJ70XEyzX4FUTjt1aR3nlf9MSN6kgvnHPWkiZctLwLmp2Gdpr6XmPfiL
 44EDPazwSH7vBEUGoKXxXLhKf/DJNK4tTfXZhHZZQfm3+X1/oWs295FpMpnTnXetqDsCgp8Ih
 tsvp/TsKpWF0wYbEVAf9XDZT5pXqDj7hawJgFquPBCFkB8DQEfmLlkXEpISzA2XNUTvPYXQAJ
 rsL5Eyqo+VJEpwkSfWLHwdqb+F/N3ng2qtSJiiYRnzqc5PFbM0WXEsHtby3w2hLNTP2Lwx8l4
 bG/xShZSh+iv7wz2yEBESlhPu9ESUONoeOzaeHKXgxIw+cSSjzLodYLfrJOsGyS+yKVqxuAqL
 Af75mwP+2L6eC/2kzrVuSa8A4bXIPZz8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart2612858.MPL6rfmJeg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 28. Mai 2019 06:31:00 CEST Chris Murphy wrote:
> On Mon, May 27, 2019 at 3:33 PM Dennis Schridde <devurandom@gmx.net> wro=
te:
> > Yesterday I upgraded from Linux 5.1.1 (built with GCC 8.3.0) to Linux
> > 5.1.4
> > (built with GCC 9.1.0).  The next boot was extremely slow and the desk=
top
> > environment (KDE Plasma) never really started, but got kind of stuck i=
n
> > the
> > startup screen.  So I switched to a VT and pressed ctrl+alt+del.  The =
next
> > boot stopped early with following message:
> >
> > [T445] BTRFS: device label <...> devid 1 transid 840641 /dev/bcache0
> > [T599] BTRFS info (device bcache0): disk space caching is enabled
> > [T599] BTRFS info (device bcache0): has skinny extents
> > [T599] BTRFS error (device bcache0): parent transid verify failed on
> > 604602368 wanted 840641 found 840639
> > [T599] BTRFS error (device bcache0): open_ctree failed
> >
> > How can I recover from this?
> >
> > The filesystem should have several snapshots (created by snapper [1], =
on
> > every boot and hourly).  Will they be of any help recovering my data?
> >
> > Best regards,
> > Dennis
> >
> > [1]: http://snapper.io/
>
> What happens if you revert to 5.1.1? That error suggests the super
> wants a newer transid than what exist on the filesystem, which
> suggests file system metadata was dropped. It's not certain from this
> information what caused that: device, or some layer in between like
> bcache, or Btrfs.

The basic issue appears to be the same with Linux 5.1.1:

[T512] BTRFS: device label <...> devid 1 transid 840641 /dev/bcache0
[T587] BTRFS info (device bcache0): disk space caching is enabled
[T587] BTRFS info (device bcache0): has skinny extents
[T587] BTRFS error (device bcache0): parent transid verify failed on 36867=
2768
wanted 840529 found 840072
[T587] BTRFS error (device bcache0): failed to read block groups: -5
[T587] BTRFS error (device bcache0): open_ctree failed

I think on subsequent boots Linux 5.1.4 also pointed out other transids th=
an
"wanted 840641 found 840639", but I am not sure and I am hesitant to keep
rebooting in case that means loosing more data.

=2D-Dennis

--nextPart2612858.MPL6rfmJeg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEE0Ngi/nirHnbsz3NFz+h/M161qdwFAlztJlMACgkQz+h/M161
qdxpDQv/cK2AyfyZYfYlP1g2YxETFKaGhsg/l31MkQ1+TfbiQh1H/8YQltPHupOC
jFjaa0kClof/vgLi6XY67enCMo1K8C2ibGZLdUblx0mJ629sy2RpAYlm1kQXh9m0
QcKbBZbv+GUnOG7BxkM+s/+sTkluaxdqyO9wf1FBW0MR7myYD3X9OG2nhmNxiAmp
OF2yGU+5p+eOCPL6jZ3K67d22XXGyNtVZJufqoR6Pq2XhFj18MG39k9ISTy8vSiz
Q+0eLzuTGJTfPIbrqWKeYK72uKUH1c45rEJDyL/DOIc96lBbalw8Oex858QiNVNb
qLFs7h+OYrEoh3PmLD9Su/m+W0Q6tv6yDkCeL4RKHMi4uH297OPN37IUYDITvS6w
lUCw3owv43u0BbYwUZV62dMDwAS6vm0B2ujZABB4ax6sc0V4LlHkw4xenkPrNYRW
mLPxB6dQ15IfBfdf0A289Q78KUm7t1FX1RZMECHpK+5nGJJ6SP73l4YdGGNf9brQ
hm1opRFs
=sUHV
-----END PGP SIGNATURE-----

--nextPart2612858.MPL6rfmJeg--



