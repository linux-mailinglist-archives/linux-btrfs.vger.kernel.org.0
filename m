Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E708512BD8D
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Dec 2019 13:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL1M24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Dec 2019 07:28:56 -0500
Received: from mars1.mruiz.dev ([167.71.125.59]:53150 "EHLO mars1.mruiz.dev"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbfL1M24 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Dec 2019 07:28:56 -0500
Received: from archlinux.localnet (unknown [66.115.176.23])
        by mars1.mruiz.dev (Postfix) with ESMTPSA id E13FC40728;
        Sat, 28 Dec 2019 12:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mruiz.dev; s=201908;
        t=1577536135; bh=z0xrScxyfQzNaC2hW+t/oFvHeB6YEgTbqh60lPy4Te8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLiYVmz/TLTov0NZLdtcSZtJQI9P1qP0oKMB5A1y1lUAtx1pa0tLMCHFotk9Yqovp
         nKl3u18dW5rEn9aqIw+bIOY53J0NeFV4xXJcdvS5MVGXVs/BY0PCW38nPMoWgr4+Ov
         mvv/pOWUAfUfQ8TMbAwrQUDeflJbLLQRPy3xEHfTQsKiPUvN3SGp2nvnUE27RjjaeH
         rlMy897fZV8B5YFyKIi4eMJ7CpKd3cK3gfMyXFLneVwZEtstdP4ggIm0X6JO/5g7/i
         hepcLXCPVSPDvpStSaaXcT37s027QV2Ryb4IlP11e9Gt6EEyRDueSSWPBK7GG5f6BW
         9xcVK89wIS3Nw==
From:   Michael Ruiz <michael@mruiz.dev>
To:     linux-btrfs@vger.kernel.org
Cc:     quwenruo.btrfs@gmx.com
Subject: Re: Error during balancing '/': Input/output error
Date:   Sat, 28 Dec 2019 04:28:50 -0800
Message-ID: <7734220.NyiUUSuA9g@archlinux>
Organization: mruiz.dev
In-Reply-To: <f6659a3b-9720-40dd-df3b-064fa4c393c8@gmx.com>
References: <4196932.LvFx2qVVIh@archlinux> <3499056.kQq0lBPeGt@archlinux> <f6659a3b-9720-40dd-df3b-064fa4c393c8@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1824941.usQuhbGJ8B"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--nextPart1824941.usQuhbGJ8B
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, December 28, 2019 4:05:54 AM PST you wrote:
> Doesn't this filename look familiar with previous logical-resolve output? :)
> 
> [michael@archlinux /]$ sudo btrfs ins logical-resolve 253563502592 /
> //home/michael/.mozilla/firefox/default/storage/default/https++
> +www.pinterest.com/cache/morgue/16/{b696bf53-d26a-48eb-9688-
> ab3c5fd49010}.final
> 
> The URL, the UUID, they all matches!
> 
> So yep, the file itself doesn't match its csum in the first place.
> 
> It looks like balance doesn't go regular file csum checking, but copy
> all data and all csum without verifying them, then check the csum of
> data reloc tree instead.
> 
> Thus this causes this hard-to-locate corrupted files.
> We should make it more user-friendly I guess.
> 
> 
> And obviously, just remove the offending files should allow you continue.
> 
> Thanks,
> Qu


Wow, you are right. I was worried my file system was corrupted and I'm not 
sure the exact cause leading up to this error. If there is any more debug info 
I can give you so that you can get a better idea of why this is happening, 
please let me know. 

Currently I am running balance, but I predict it will finally be able to 
complete sucessfully. However, if there are any issues I will send a reply 
here. (If I don't figure it out myself using what you just taught me)
Thanks a lot for your help. I am new to using mailing lists such as these, so 
hopefully I did everything by the rules here.
Thanks again Qu!
--nextPart1824941.usQuhbGJ8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5lRECE0UfhBqjDUbhv/EZtxrWIFAl4HSnkACgkQbhv/EZtx
rWLelggAkBUhv/9t94G95OyNT3B7+kX0jB00YtDQy12dNEBRKcafmgY1+rXWc7V3
T6MOjzX0oFXVNTjA5ZbzHgtuo7tI40TIcD5dob+AzOJdMSUIlCAXWCnpHllTdOLC
tciVNNwvt7RoGbxCz4B7seWEAFwHwoKckttLIL8YHgsCq5fSinbPsqxXVd8UkcbB
CmhpnlNnJzjwoR9EbyFwpCryHtRMCbF5NDYMGCitjBKv64r0NdWWeT73HVTgv6EU
0mY1efWfuztEWYdIC3IUKwCeOxmJYNcSuQkQDUXR3zx8ygkK3I7tzKPPBwzd9a/w
Gn1EykedF4QLlnLHT2uR19RJ7+YL1w==
=8KpQ
-----END PGP SIGNATURE-----

--nextPart1824941.usQuhbGJ8B--



