Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA84150826
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 15:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgBCOMP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 09:12:15 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52237 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbgBCOMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Feb 2020 09:12:15 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 9FEC674A;
        Mon,  3 Feb 2020 09:12:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Feb 2020 09:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgianit.com;
         h=subject:to:references:cc:from:message-id:date:mime-version
        :in-reply-to:content-type; s=fm2; bh=aQQQMy6k7T9kVhQUFhEPOlD2mq1
        aRowXxgTjI8Knz9I=; b=Cp5MF/4QXt7H6491KhIcjsXgnGZAOTygcwXrF+dYdKb
        /KyOfK1BEwFoX5BwtLd/QEXl7SxUwBAJjj14InO2KQYirfQhRVUXoptbcs8LePi5
        2PpxKJinThZUQE1cC/zRWn1pFgews67hwVINz/FwYmcojrAsJhVh1+yq8z5AW0Dr
        7YviHYapQloT4/fNbj9YyDQNhkQ2c0ap421bo6XitQcFKyY98CODbrBHdERwyzcA
        uqxR10HcLX331XnWPnaKjawQWVMyMExDgjFVjjDm2TJjleDXEKgKPmzNE+0rFFkq
        U8nSGvUStXZRcm4reuINeyqPAp6ILi8puwBNRfpEK2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=aQQQMy
        6k7T9kVhQUFhEPOlD2mq1aRowXxgTjI8Knz9I=; b=HvldXRtP3ggMG5skSF7Vkf
        3xrosRfJdr7hJo68OqTb9fdzolBjUHKPV8xsfvplcfqNCb7uzYPAzXOnRbfNTl+w
        pcY0V6BiBI+E4rE39AQBbXs60zyXmekYC62qZ+dtNE4hO/Ac7EeOFaxaDx/0YnAw
        7qa58j7OcqZKuoqCFLFx19bcq5WxOc6bJ+6FXmKfQlUMaGpFMahdFbxxgJFsmSE8
        9/PsxlLOoM3XEeotzqblsi70tNe8pr35T7ta4/yEzx71ay15nW7nDOK03s/jWOpd
        iyQLzcgk/XeSXGqVuTj4AGCbbdbO5IOEuiay+8F3tdlAJ+udQ1e8iAQyHzptlT/w
        ==
X-ME-Sender: <xms:PSo4XrEQtunLzxMOtpfjlXQjXO-5wc5qoKnuBgFfiyh05jo_ZZtwcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepuffvfhfhkffffgggjggtsehgtderof
    dtfeejnecuhfhrohhmpeftvghmihcuifgruhhvihhnuceorhgvmhhisehgvghorhhgihgr
    nhhithdrtghomheqnecukfhppedvfedrvdeffedruddtvddrfeeknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvmhhisehgvghorhhgihgr
    nhhithdrtghomh
X-ME-Proxy: <xmx:PSo4Xu6lxU6qc_U7WAbdUjZOdRxWtlyqxmSOLvocEq_1GrIUyR4FFQ>
    <xmx:PSo4XqkDwB-HM1OqPJf4u4hNdFjTWBTUcTE1KYAIoMXqeRb4l5Uffw>
    <xmx:PSo4XpRI-yjYzV1125Zh8YvK0-zCu_HoBMHZZM8gqJL5c1tcZaFdhw>
    <xmx:PSo4XmbbdPaYtbcmjEdLQzS9_5pPgHsYuyBHXmO3drJ4dR25LcNntg>
Received: from [10.0.0.6] (23-233-102-38.cpe.pppoe.ca [23.233.102.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5C6330600DC;
        Mon,  3 Feb 2020 09:12:12 -0500 (EST)
Subject: Re: Root FS damaged
To:     Robert Klemme <shortcutter@googlemail.com>
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
 <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com>
 <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
From:   Remi Gauvin <remi@georgianit.com>
Openpgp: url=http://www.georgianit.com/pgp/Remi%20Gauvin%20remi%40georgianit.com%20(0xEF539FF247456A6D)%20pub.asc
Autocrypt: addr=remi@georgianit.com; prefer-encrypt=mutual;
 keydata= mQENBFogjcYBCADvI0pxdYyVkEUAIzT6HwYnZ5CAy2czT87Si5mqk4wL4Ulupwfv9TLzaj3R
 CUgHPNpFsp1n/nKKyOq1ZmE6w5YKx4I8/o9tRl+vjnJr2otfS7XizBaVV7UwziODikOimmT+
 sGNfYGcjdJ+CC567g9aAECbvnyxNlncTyUPUdmazOKhmzB4IvG8+M2u+C4c9nVkX2ucf3OuF
 t/qmeRaF8+nlkCMtAdIVh0F7HBYJzvYG3EPiKbGmbOody3OM55113uEzyw39k8WHRhhaKhi6
 8QY9nKCPVhRFzk6wUHJa2EKbKxqeFcFzZ1ok7l7vrX3/OBk2dGOAoOJ4UX+ozAtrMqCBABEB
 AAG0IVJlbWkgR2F1dmluIDxyZW1pQGdlb3JnaWFuaXQuY29tPokBPgQTAQIAKAUCWiCNxgIb
 IwUJCWYBgAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ71Of8kdFam2V1Qf9Fs6LSx1i
 OoVgOzjWwiI06vJrZznjmtbJkcm/Of5onITZnB4h+tbqEyaMYYsEIk1r4oFMfKB7SDpQbADj
 9CI2EbpygwZa24Oqv4gWEzb4c7mSJuLKTnrhmwCOtdeDQXO/uu6BZPkazDAaKHUM6XqNEVvt
 WHBaGioaV4dGxzjXALQDpLc4vDreSl9nwlTorwJR9t6u5BlDcdh3VOuYlgXjI4pCk+cihgtY
 k3KZo/El1fWFYmtSTq7m/JPpKZyb77cbzf2AbkxJuLgg9o0iVAg81LjElznI0R5UbYrJcJeh
 Jo4rvXKFYQ1qFwno1jlSXejsFA5F3FQzJe1JUAu2HlYqRrkBDQRaII3GAQgAo0Y6FX84QsDp
 R8kFEqMhpkjeVQpbwYhqBgIFJT5cBMQpZsHmnOgpYU0Jo8P3owHUFu569g6j4+wSubbh2+bt
 WL0QoFZcng0a2/j3qH98g9lAn8ZgohxavmwYINt7b+LEeDoBvq0s/0ZeXx47MOmbjROq8L/g
 QOYbIWoJLO2emyxmVo1Fg00FKkbuCEgJPW8U/7VX4EFYaIhPQv/K3mpnyWXIq5lviiMCHzxE
 jzBh/35DTLwymDdmtzWgcu1rzZ6j2s+4bTxE8mYXd4l2Xonn7v448gwvQmZJ8EPplO/pWe9F
 oISyiNxZnQNCVEO9lManKPFphfVHqJ1WEtYMiLxTkQARAQABiQElBBgBAgAPBQJaII3GAhsM
 BQkJZgGAAAoJEO9Tn/JHRWptnn0H+gOtkumwlKcad2PqLFXCt2SzVJm5rHuYZhPPq4GCdMbz
 XwuCEPXDoECFVXeiXngJmrL8+tLxvUhxUMdXtyYSPusnmFgj/EnCjQdFMLdvgvXI/wF5qj0/
 r6NKJWtx3/+OSLW0E9J/gLfimIc3OF49E3S1c35Wj+4Okx9Tpwor7Tw8KwBVbdZA6TyQF08N
 phFkhgnTK6gl2XqIHaoxPKhI9pKU5oPkg2eI27OICZrpTCppaSh3SGUp0EHPkZuhVfIxg4vF
 nato30VZr+RMHtPtx813VZ/kzj+2pC/DrwZOtqFeaqJfCi6JSik3vX9BQd9GL4mxytQBZKXz
 SY9JJa155sI=
Message-ID: <1f891d68-ad1e-e303-cea8-b3fff5d21f66@georgianit.com>
Date:   Mon, 3 Feb 2020 09:12:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qTnv1ca0iEcg9L8uc3HTu4dWAGfRoaHrH"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qTnv1ca0iEcg9L8uc3HTu4dWAGfRoaHrH
Content-Type: multipart/mixed; boundary="5m7XjDz73fWXU9sMzdPylqUScrN5RW1Kd";
 protected-headers="v1"
From: Remi Gauvin <remi@georgianit.com>
To: Robert Klemme <shortcutter@googlemail.com>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Message-ID: <1f891d68-ad1e-e303-cea8-b3fff5d21f66@georgianit.com>
Subject: Re: Root FS damaged
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
 <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com>
 <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
In-Reply-To: <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>

--5m7XjDz73fWXU9sMzdPylqUScrN5RW1Kd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2020-02-03 8:58 a.m., Robert Klemme wrote:

>> If you have an idea how to reproduce such problem.
>=20
> Not at the moment as I did not observe any unusual circumstances.
> Having the system up and running for a while is probably not a useful
> test. :-)
>=20

Have you recently converted to space_cache=3Dv2 or otherwise tried to
clear / manipulate space cache?

On the 2 systems I've seen this error so far, it was shortly after
converting space_cache to v2.




--5m7XjDz73fWXU9sMzdPylqUScrN5RW1Kd--

--qTnv1ca0iEcg9L8uc3HTu4dWAGfRoaHrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJeOCo8AAoJEO9Tn/JHRWptCNwH/2tI8xNd8M0g8kjge8dVCL3r
wvmpf1kyWHdzrhGqVVXcib11B7DVLFZ2v/sK1C/567gUOhHDTWMeDtn21yuwnPDP
QpaW6uw6ja1oAMY0CHVGTCpBooeI0zkU9MbJpt/RUhxHQx3mNoZhMth31xZbuCD0
wUcjGJryKgjU8TzktYgoLaItA9WR1YIII7AoAZOuu/eHS2psXg34LtyE7iQMT5ps
XUN9cjcYtOgCUlXrWrcEcp7WQMQ50UMwXc6ODG9HDjwFF4JI1Y3AXXV6RO86Yv8V
IS6rlvn2Qbhzq4gmIXEsndVTng/y3gpC1kOW7BmeptN7CKyPb6qaIyE8F7y3Cgs=
=rlsJ
-----END PGP SIGNATURE-----

--qTnv1ca0iEcg9L8uc3HTu4dWAGfRoaHrH--
