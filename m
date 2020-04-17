Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D75F1AE749
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 23:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDQVJO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 17:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDQVJN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 17:09:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98644C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:09:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x2so3273613qtr.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GjLLko1j+D5cBVQFxGoAu/S8NINEZY9D7dh8fDZpjqw=;
        b=e7w/PWIDcmDRdGyftTkZ+HjDVdnlIf2Ccd7EzJdEY6ZReMd+vQN3aTu78InKO3X71z
         ls7D3PJ2o0vbMW+Fxk772ZKlp359K0XljmcjCbTQK0brVvzQJ00gW0nDl414FkP+Dxrv
         tLiXfGcljLtV40KD2umdH/hUdyUU7i7VKxV+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GjLLko1j+D5cBVQFxGoAu/S8NINEZY9D7dh8fDZpjqw=;
        b=qb3BWzSKJP1prUOka9z7pV0oGRYt1qaQiumpvP7qudWnNWssOuTKX3WQ4GneWpFawp
         nbqP/I+yHoDRn0G0zWVhGoopa1ty6Ds+EVcMRv+DZo59rb7opsQOkG5R76AC38gzFTAT
         F/FRaJIyw+jSylsCpqNeyjzk1aVFjRcJOYGyGM+kDzKBsthEmvWhqUdRyHB+REpMM/2O
         niEyYoo7O3VccFqoNvOqFp+31GRiHiR2zWsxtU5tKNs18/dRMJFJNucMJCK5VlgIfXMK
         mCCIP/DlHSKzDHZMxRPzPl1VRJCBmGaEwGa29suB0Aj/Zupv6gW2Di4XhMsalcnLhAQn
         1vlw==
X-Gm-Message-State: AGi0PubTQVQowoX0PSH7O64pcaBdvuAiAi+bqvimwfyLGcDGvwZyUHbf
        QTZegKYfWs0vFR1KkwiLb47M2A==
X-Google-Smtp-Source: APiQypKznppjkXX7Rsw1vnN7Crvn/Q2s4NyZot3fo39aLIQKSHJ1BPOkGGPFImLzNwiAJV2uMqnFUg==
X-Received: by 2002:ac8:45cf:: with SMTP id e15mr5107311qto.21.1587157751780;
        Fri, 17 Apr 2020 14:09:11 -0700 (PDT)
Received: from bill-the-cat (2606-a000-1401-826f-4058-2b78-ede2-0695.inf6.spectrum.com. [2606:a000:1401:826f:4058:2b78:ede2:695])
        by smtp.gmail.com with ESMTPSA id u27sm18601821qtc.73.2020.04.17.14.09.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 14:09:10 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:09:08 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH U-BOOT v2 3/3] fs: btrfs: Fix LZO false decompression
 error caused by pending zero
Message-ID: <20200417210908.GP4555@bill-the-cat>
References: <20200326053556.20492-1-wqu@suse.com>
 <20200326053556.20492-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktyc2UzNUDZzGzis"
Content-Disposition: inline
In-Reply-To: <20200326053556.20492-4-wqu@suse.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--ktyc2UzNUDZzGzis
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2020 at 01:35:56PM +0800, Qu Wenruo wrote:

> For certain btrfs files with compressed file extent, uboot will fail to
> load it:
>=20
>   btrfs_read_extent_reg: disk_bytenr=3D14229504 disk_len=3D73728 offset=
=3D0 nr_bytes=3D131
>   072
>   decompress_lzo: tot_len=3D70770
>   decompress_lzo: in_len=3D1389
>   decompress_lzo: in_len=3D2400
>   decompress_lzo: in_len=3D3002
>   decompress_lzo: in_len=3D1379
>   decompress_lzo: in_len=3D88539136
>   decompress_lzo: header error, in_len=3D88539136 clen=3D65534 tot_len=3D=
62580
>=20
> NOTE: except the last line, all other lines are debug output.
>=20
> Btrfs lzo compression uses its own format to record compressed size
> (segment header, LE32).
>=20
> However to make decompression easier, we never put such segment header
> across page boundary.
>=20
> In above case, the xxd dump of the lzo compressed data looks like this:
>=20
> 00001fe0: 4cdc 02fc 0bfd 02c0 dc02 0d13 0100 0001  L...............
> 00001ff0: 0000 0008 0300 0000 0000 0011 0000|0000  ................
> 00002000: 4705 0000 0001 cc02 0000 0000 0000 1e01  G...............
>=20
> '|' is the "expected" segment header start position.
>=20
> But in that page, there are only 2 bytes left, can't contain the 4 bytes
> segment header.
>=20
> So btrfs compression will skip that 2 bytes, put the segment header in
> next page directly.
>=20
> Uboot doesn't have such check, and read the header with 2 bytes offset,
> result 0x05470000 (88539136), other than the expected result
> 0x00000547 (1351), resulting above error.
>=20
> Follow the btrfs-progs restore implementation, by introducing tot_in to
> record total processed bytes (including headers), and do proper page
> boundary skip to fix it.
>=20
> Please note that, current code base doesn't parse fs_info thus we can't
> grab sector size easily, so it uses PAGE_SIZE, and relying on fs open
> time check to exclude unsupported sector size.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Cc: Marek Behun <marek.behun@nic.cz>
> Reviewed-by: Marek Beh=FAn <marek.behun@nic.cz>

Applied to u-boot/master, thanks!

--=20
Tom

--ktyc2UzNUDZzGzis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAl6aGvQACgkQFHw5/5Y0
tyxbwwwAgxFcKthj48t92d0fMSuWD4OrhHE4z+kefhvvj0hGZ5IkP+6nSwiUkE8V
quwZ8vNn2KzYWGefnwZXAQYt6dBzA53sfPpCCP1zr/KVzHUpm6BmmMZH1pO3aTbf
w3UaHPzPUzMsrqFVJSuNfP3CDrMh0pz+dl7KYwUbITTjnsAJVK2eKCkx9a/t07mK
wLVkhoskXAnjfaHlJZDjUZffPnGQaF5RqsLXScke7CcOgnzKkGNNpOsrraZayKne
At0bEYH5h8OV7I1Rqt2HdCUM4onzPasqnJxXP8zA8ZfkGlpRBDyU7m0+xLRQA7Od
qSdK/IEJV2qW6BAIavTKP8j/weOgy54Yh3QM7o92f4Add5U+6ujubycvKu38oaUY
GL96TA8nc/ccHmoAdPo6xXa0U90VZViTQkUQ1fGIaIYQ2AKAHPVzCBo9kgvQC1f5
cCSBlv/SrKUH+xF+r0Bv+Kt34NlxFXo14BEb2cUq572LG806pcl04lXEBImu9qOp
YztFHBaX
=4CBS
-----END PGP SIGNATURE-----

--ktyc2UzNUDZzGzis--
