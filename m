Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5E2AA8FA
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Nov 2020 04:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgKHDVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Nov 2020 22:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgKHDVo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Nov 2020 22:21:44 -0500
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 Nov 2020 19:21:43 PST
Received: from prometheus.amsuess.com (alt.prometheus.amsuess.com [IPv6:2a01:4f8:190:3064::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F40C0613CF
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Nov 2020 19:21:43 -0800 (PST)
Received: from poseidon-mailhub.amsuess.com (unknown [IPv6:2a02:b18:c13b:8010:a800:ff:fede:b1bd])
        by prometheus.amsuess.com (Postfix) with ESMTPS id DF8CF407A0
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Nov 2020 04:15:23 +0100 (CET)
Received: from poseidon-mailbox.amsuess.com (hermes.amsuess.com [10.13.13.254])
        by poseidon-mailhub.amsuess.com (Postfix) with ESMTP id 85C23AB
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Nov 2020 04:15:21 +0100 (CET)
Received: from hephaistos.amsuess.com (unknown [IPv6:2a02:b18:c13b:8010:ee15:f155:f2d1:e50a])
        by poseidon-mailbox.amsuess.com (Postfix) with ESMTPSA id 998C264
        for <linux-btrfs@vger.kernel.org>; Sun,  8 Nov 2020 04:15:20 +0100 (CET)
Received: (nullmailer pid 774834 invoked by uid 1000);
        Sun, 08 Nov 2020 03:15:19 -0000
Date:   Sun, 8 Nov 2020 04:15:19 +0100
From:   chrysn <chrysn@fsfe.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: doc: snapshot -r and -i can be used together
Message-ID: <20201108031519.GA773195@hephaistos.amsuess.com>
References: <20200629111500.GA65690@hephaistos.amsuess.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20200629111500.GA65690@hephaistos.amsuess.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
        prometheus.amsuess.com
X-Spam-Level: *
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello btrfs maintainers,

On Mon, Jun 29, 2020 at 01:15:01PM +0200, chrysn wrote:
> This aligns the man page with the usage output of the tool.

this small documentation fix (also at [1] for MUAs that don't like
months-long threads) seems to have gotten lost on the list, could you
have a brief look and consider applying it?

Thanks
Christian

[1]: https://www.spinics.net/lists/linux-btrfs/msg102679.html

--=20
There's always a bigger fish.
  -- Qui-Gon Jinn

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECM1tElX6OodcH7CWOY0REtOkveEFAl+nYr4ACgkQOY0REtOk
veFUJA/+ITt/SR+EQXUnsCM6O+zcfXsjkwcUdC+hKDwl8eC6UBU31vUuHA/tAgdp
drQyk0tLLcsxkKG1omFAXeR+z7gTZtr8DLThiySANUWGreODC56O3LYvKP8bd3WH
W4rBLfMxKWTJg1ZB/hRhZBuoBPV5kbte9nKIaT5OYBTTClxRmLOjlU8vrc7qkYPx
08GxwPi6upeZTPEEpQRB5DvgANi9xfFpszYqlEcHyWXKLB6RspQmSqYhJXSmwTsx
QFhfnhlWvjdGd06ECYZmu0XGGMb1d5RLulf6yjg704S7V9zssxDSEBs/Vut92QQh
iIa3FWjODgvsTZhLj7pdeV5/zwInyPJoFErTeRsq4WnfkPPB8PTHzOanOQ3AjtBY
zLmXWUhoJuX0rQVu/0rnkHRgxAUv0iTKuYOZR205m6t0NrSQ9dh2jgpS9FRu0ZXn
ik/88glWExnJqF5V9VC32XOfhsh5NsLJbvlC8yZi0vAJdyhUL/zXqgISe2jXReao
xwCxAaaXQjJCUPpbHZP74JmfAK4GL9z6/APOAzpcSGYVJBP1RCEagGuzNxyAsjs9
i6Gp3iKDfo28nWGu3vcBRxEEgMm/V2T3hWUv7GfyOe33BehLF42/quThFsQS2uvZ
KvuBsnSTJUgNOJyybNfiIjw6X8lVXU8zKplGgFHRoXRL7pzBATk=
=2Yix
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
