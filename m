Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F344FBF0
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfFWNmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 09:42:24 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36857 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWNmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 09:42:23 -0400
Received: by mail-lf1-f49.google.com with SMTP id q26so8148166lfc.3
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2019 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=8GMlkkdcmvSR8dBQ0PluYnkjZVm+pPx7UxHYiJNWF78=;
        b=ZB1GTfOIZa1FYzKUdwNLF5SJyAQBHageTaMNmipKNzNuUEjDDVwP/Xn3AMTpjGSi4w
         gETXLEWvNBV8hvP+VP8NXRfdFzNrRh6NmEnUBPV/zcqY4DHlYZT6p7HNGs6Vjk6A+Av+
         1yXegutsDH9zH+0/tF9eG74ntgRfKwd7Pg3PmrzO9a8QUffSp1LVhT/mcS0c4u+GJepP
         deBgz4zNkxu0cXAC7T/r+fnPOyfmPBtWxQ+z5TITYSTwsqiyJZZ1HJADPadhgzbaH1hn
         /1D+Pa38sTqpROq90vTXhvenMf+tHXpTl+F0Io6BgxWbx0ehiqxFW3qtOb+q7SRC91q+
         D85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=8GMlkkdcmvSR8dBQ0PluYnkjZVm+pPx7UxHYiJNWF78=;
        b=lFCSs5cdbb5H1Qrm+Keb66MduAAeNhHYo6YNVq5mKRgn6Grqi0hwW0K3EVXKdsMDAl
         8S2bXA2WjxPtyLZ43tNmxfwiq+FpThNQZIsC28rTLSHOinBMcqEoUuh2v8F9SOGsNMLp
         CqUNi9k+IvxS+nz3DJ5WXV+h/AG/ScOU23YmkwZc8/L3bMybPb0Ltul9LL2rJNZg8LdG
         yTMUw+tkIHuVfSYbyu4AQY+W5XXPvongf6QankOh2MXeAMFiuKJ1RREwHU9bri7Yrzc0
         0EaL2nrh6Gg5WGJESBJM9/j7sI0NVDdQJEJ74qiXqBGtMdSdcE7rxbya+ef4eDO8bQTY
         mI/Q==
X-Gm-Message-State: APjAAAV3Vr+zQ66uj8DVDzM0AROENNroUTySA71yBMhpPzz16PKpt6Vf
        lxhnPf4mE4OKXbOsFrq8EgBHWKdN
X-Google-Smtp-Source: APXvYqwAMLb/Y7qirA/e9sJm+5htrMIW6gIvAbC9LZ9/XpMYkzf58wN24I0I3Fc3AVLrJGZl1BBS1Q==
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr3619864lfl.188.1561297340396;
        Sun, 23 Jun 2019 06:42:20 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-211.nat.spd-mgts.ru. [109.252.90.211])
        by smtp.gmail.com with ESMTPSA id i1sm1140917lfc.86.2019.06.23.06.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 06:42:18 -0700 (PDT)
Subject: Re: Confused by btrfs quota group accounting
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
 <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
 <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kc0mQW5kcmVpIEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT7CZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AFAliWAiQCGQEACgkQR6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE
 21cAnRCQTXd1hTgcRHfpArEd/Rcb5+SczsBNBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw1
 5A5asua10jm5It+hxzI9jDR9/bNEKDTKSciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/R
 KKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmmSN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaN
 nwADBwQAjNvMr/KBcGsV/UvxZSm/mdpvUPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPR
 gsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YIFpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhY
 vLYfkJnc62h8hiNeM6kqYa/x0BEddu92ZG7CRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhd
 AJ48P7WDvKLQQ5MKnn2D/TI337uA/gCgn5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <63286845-0fc3-e595-3e35-e8e2bef4fd17@gmail.com>
Date:   Sun, 23 Jun 2019 16:42:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="3x3iZVVlUu5r4fu5mHmNd43GMUSPprFPo"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3x3iZVVlUu5r4fu5mHmNd43GMUSPprFPo
Content-Type: multipart/mixed; boundary="M69VuMiFT40AHrG8uyYpgN2XfCebW38xK";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <63286845-0fc3-e595-3e35-e8e2bef4fd17@gmail.com>
Subject: Re: Confused by btrfs quota group accounting
References: <eeb418d8-13a1-39c3-c6d1-dd5a2127abc9@gmail.com>
 <669a0428-0517-a10e-c658-c8137463450a@gmx.com>
 <cec540b7-f1c1-93f2-adb0-5f0155215e73@gmx.com>
 <7ecc3db3-7af7-f3cb-e23f-04c20f47dd8c@gmail.com>
 <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>
In-Reply-To: <2c0e3d7e-9b7d-dde8-c4f3-2ca89071efbf@gmx.com>

--M69VuMiFT40AHrG8uyYpgN2XfCebW38xK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

23.06.2019 14:29, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>=20
> BTW, so many fragmented extents, this normally means your system has
> very high memory pressure or lack of memory, or lack of on-disk space.

It is 1GiB QEMU VM with vanilla Tumbleweed with GNOME desktop; nothing
runs except user GNOME session. Does it fit "high memory pressure"
definition?

> Above 100MiB should be in one large extent, not split into so many smal=
l
> ones.
>=20

OK, so this is where I was confused. I was sure that filefrag returns
true "physical" extent layout. It seems that in filefrag output
consecutive extents are merged giving false picture of large extent
instead of many small ones. Filefrag shows 5 ~200MiB extents, not over
30 smaller ones.

Is it how generic IOCTL is designed to work or is it something that
btrfs does internally? This *is* confusing.

In any case, thank you for clarification, this makes sense now.


--M69VuMiFT40AHrG8uyYpgN2XfCebW38xK--

--3x3iZVVlUu5r4fu5mHmNd43GMUSPprFPo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXQ+BtQAKCRBHosy62l33
jJzBAKC3MV64O9cJpdfoPgXEMyIbvN7JGgCfaUTZNVgQ+oLld7gGjVkDjiak6bU=
=/OH/
-----END PGP SIGNATURE-----

--3x3iZVVlUu5r4fu5mHmNd43GMUSPprFPo--
