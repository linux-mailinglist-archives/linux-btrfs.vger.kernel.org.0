Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111002D472E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 17:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgLIQwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Dec 2020 11:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbgLIQwG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Dec 2020 11:52:06 -0500
Received: from ravenhurst.kallisti.us (ravenhurst-smtp-tx.kallisti.us [IPv6:2600:3c03:e000:2e0::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72EC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Dec 2020 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kallisti.us
        ; s=20180707; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hV1N6fryXNTmZBb8U2L1e1J+RzkGVwYc5JZC5KHO+uc=; b=Q+99pDSSZZ9gjiFeDUWEIPs0VU
        XKz6g+lE35L258yYjMC7mCfVtNp7h3F6IQcsNGz7WJ1kSQKfMb3Bv9wS4m7tIzeq6f8IjO29W2ZIm
        NVz+TjAFGEw00DVkXPTtoeq2gFH0wR01ggZDxP/Qvi7VeUUOl56A5unffS1uDt17D0sFG2nrOKdIA
        5TtBI8695h6Q4V0Cv2ht2UjgsrjiZCZT+bnrK0KRqu2C4moReKtZndJCmwQDeJE2oy65iJ3DlIut6
        XAW1xflq39tRhFRNZ8yS66CsGm70fcn6NHGeeXB+L8+VFF2rTsM2/lbbx5gPwB23ykqbZn68GyQy5
        ISt6A3pg==;
Received: from [2606:6000:4500:1400:31af:5cdf:e695:97eb] (helo=vanvanmojo.kallisti.us)
        by ravenhurst.kallisti.us with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ross@kallisti.us>)
        id 1kn2gW-0003rQ-JB; Wed, 09 Dec 2020 11:51:24 -0500
Date:   Wed, 9 Dec 2020 08:51:20 -0800
From:   Ross Vandegrift <ross@kallisti.us>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: tree-checker corrupt leaf error
Message-ID: <20201209164308.noqw2rtukxcgrf4w@vanvanmojo.kallisti.us>
References: <20201208010653.7r5smyo6vloqk7qv@vanvanmojo.kallisti.us>
 <b3c3ef0d-13c7-f3e4-74b8-38c441fb9577@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o43un73gtv32priu"
Content-Disposition: inline
In-Reply-To: <b3c3ef0d-13c7-f3e4-74b8-38c441fb9577@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--o43un73gtv32priu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 08:25:33PM +0800, Qu Wenruo wrote:
> On 2020/12/8 =E4=B8=8A=E5=8D=889:06, Ross Vandegrift wrote:
> > Hello,
> >=20
> > I've got a single-device btrfs filesystem that fails to mount and I'm
> > not sure how to proceed:
> >=20
> > [  118.556075] BTRFS: device label backup devid 1 transid 55709 /dev/dm=
-21
> > [  118.581857] BTRFS info (device dm-21): use zlib compression, level 3
> > [  118.581858] BTRFS info (device dm-21): disk space caching is enabled
> > [  120.035857] BTRFS info (device dm-21): enabling ssd optimizations
> > [  120.037493] BTRFS critical (device dm-21): corrupt leaf: root=3D5 bl=
ock=3D3420303224832 slot=3D18 ino=3D265, invalid inode transid: has 1403012=
92396544 expect [0, 55710]
> > [  120.065595] BTRFS critical (device dm-21): corrupt leaf: root=3D5 bl=
ock=3D3420303224832 slot=3D18 ino=3D265, invalid inode transid: has 1403012=
92396544 expect [0, 55710]
> >=20
> >=20
> > The fs has been in use for a while with no obvious issue until now.  I
> > got this message after upgrading from 4.19.118 -> 5.9.6 (from debian
> > stable -> debian stable backports).  Nothing was done to this fs under
> > 5.9 aside from trying to mount.  A different fs was converted from ext4
> > and mounted.
> >=20
> > The wiki suggests reverting to the working kernel, so I rebooted into
> > 4.19.160 (stable was updated) - but now I get the same error on 4.19.
> >=20
> > The list archives point to using `btrfs inspect-internal inode-resolve`
> > to find problematic files and copying-then-deleting them.  But since I
> > cannot mount, this doesn't work.
> >=20
> > Output of btrfs check is attached.  Thanks for any suggestions!
>=20
> This is caused by an older kernel which puts garbage into the inode trans=
id.
> And newer kernel introduces a check to find such garbage and exit more
> or less gracefully before the garbage reach kernel memory.
>=20
> The check is backported to v4.19, so starting from v4.19.156 the 4.19
> kernel will also report such error.

Thank you, this is the hint I needed.  I booted back into 4.19.118, and
was able to mount the fs.  From there, I could identify the affected
files and remove them.  Now btrfs check passes cleanly, and the fs
mounts on 4.19.160.

Thanks to you and Chris for the help!

Ross

--o43un73gtv32priu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEsAjXULa3g2HtU1bw2rOJMppM+hYFAl/RAIQACgkQ2rOJMppM
+hbYKQ//UzN8fAxkGYT2cBVlp/ddMKpRPUwASJWOPFw6d8U/jdyd/3xROq8Bk342
2+cwu2PSkJHELjJ8BoTHQOvUMCG84LOOZLZjG6aZxw+Cch2iE79AI33vtFIZo9rr
A8ychoDiQkYMhDdPozt7KXpywrNHFpsM80vPkgUf1fxG1/CX1ZDDeRiudbjk1s1S
Xd+Yw6AgLzZ+rx5xk27Ol1J0Joh0t1Cdb1Znm7KS8AxRLLw+g7tljdpcSdaiu8fn
KKhX7CD6sdzUW3rr13Mj3gUO3axwhoEnyVADaqoeuUIpWkMUtgnVRBiWp1pW3mQ9
UJenEeQRiMy0lWIg1mtAGmXkIZRQo7LDPqdxBu7luSRp4kjOrXss5SExzxxzD6WE
LiW0fd+oxc/qLOq7aCC6E4+me8/w8/KO4NlU6MnBM1CBn/2rGMl6cBnLB+tvf1q8
IZbku7kncSOPzXGfhiuYVy4Dr15zP3NN+b8MWFf3OjrtzcXPm06xdSNvV32Dt5mu
v520zqwbpaolZ+vI4SAsC5VLK93cF4PgySKqWn1xO8hy64BfgniovFtUAbsqpHwS
mJel5N8q2WTpEicsMHmdAh8LS2YjqxqDzS9gVypmZCobTUWSJOuqVmqaUgfs8soO
s01zDmSKM7Ba743FlEwUBKOh2Z0O+jDoZnlMhb11r9TkTlVXIwI=
=9TKr
-----END PGP SIGNATURE-----

--o43un73gtv32priu--
