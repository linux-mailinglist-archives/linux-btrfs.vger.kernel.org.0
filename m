Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D937826D0C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 03:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIQBqn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 21:46:43 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56590 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgIQBqm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 21:46:42 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:46:41 EDT
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kIiqF-00061g-DK; Wed, 16 Sep 2020 21:36:07 -0400
Message-ID: <b1eec667d42849f757bbd55f014739509498a59d.camel@surriel.com>
Subject: Re: [PATCH 5/9] btrfs: zstd: Switch to the zstd-1.4.6 API
From:   Rik van Riel <riel@surriel.com>
To:     Nick Terrell <terrelln@fb.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Chris Mason <clm@fb.com>, Nick Terrell <nickrterrell@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "squashfs-devel@lists.sourceforge.net" 
        <squashfs-devel@lists.sourceforge.net>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Petr Malat <oss@malat.biz>,
        Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Date:   Wed, 16 Sep 2020 21:35:51 -0400
In-Reply-To: <4D04D534-75BD-4B13-81B9-31B9687A6B64@fb.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
         <20200916034307.2092020-7-nickrterrell@gmail.com>
         <20200916084958.GC31608@infradead.org>
         <CCDAB4AB-DE8D-4ADE-9221-02AE732CBAE2@fb.com>
         <20200916143046.GA13543@infradead.org>
         <1CAB33F1-95DB-4BC5-9023-35DD2E4E0C20@fb.com>
         <20200916144618.GB16392@infradead.org>
         <4D04D534-75BD-4B13-81B9-31B9687A6B64@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-00l4H219Xi95l7myD8I0"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--=-00l4H219Xi95l7myD8I0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-09-16 at 15:18 -0400, Nick Terrell wrote:

> The zstd version in the kernel works fine. But, you can see that the
> version
> that got imported stagnated where upstream had 14 released versions.
> I
> don't think it makes sense to have kernel developers maintain their
> own copy
> of zstd. Their time would be better spent working on the rest of the
> kernel.
> Using upstream directly lets the kernel profit from the work that we,
> the zstd
> developers, are doing. And it still allows kernel developers to fix
> bugs if any
> show up, and we can back-port them to upstream.

I can't argue with that.

> One possibility is to have a kernel wrapper on top of the zstd API to
> make it
> more ergonomic. I personally don=E2=80=99t really see the value in it, si=
nce
> it adds
> another layer of indirection between zstd and the caller, but it
> could be done.

Zstd would not be the first part of the kernel to
come from somewhere else, and have wrappers when
it gets integrated into the kernel. There certainly
is precedence there.

It would be interesting to know what Christoph's
preference is.

--=20
All Rights Reversed.

--=-00l4H219Xi95l7myD8I0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl9ivXcACgkQznnekoTE
3oOPpggAtolHgM9baGGYRypnu9M14qxIuWCs0R5dsHUAIeaf3t58BwsYiat23RYs
FzWV01KQfvBTe9eQUKM/m9u+p3kqegVy3tIrE+4VCx1PxWpjlnB42ep6+02SXLzz
P82Z4KvkyvwRw8jF7ixqa4vQN2G3pTOUejb9hN/BULrYZxijOR9/MoYXo2xGXZP7
7rX/7LiqVYGommGQxYE5dEsVlXLSKdBdkV5690AwVUVky/eaYM4oxhp0882DscYy
3BB1f4yAkmBlDATmTucb5dLpQM/1l2RMrpg9bMUNO/tmVmeq7LIszs/ymSXhi21U
iIiPectvPTSs+UZiD7oxuK0x3OBzoA==
=wqCT
-----END PGP SIGNATURE-----

--=-00l4H219Xi95l7myD8I0--

