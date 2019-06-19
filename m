Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF44B06C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 05:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFSD1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 23:27:18 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37110 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSD1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 23:27:18 -0400
Received: by mail-lj1-f174.google.com with SMTP id 131so1709336ljf.4
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=BFgIYCI7yRsuw5QDRPV1hqt7vBc44z/uZpU7Ha6zhfM=;
        b=PxoR4KeAx3kCpKMu0syuvMIpW+euhfmXNrZqn2SDzVbDZqxSIcFlhVNleGaFIptTyF
         aLiN9+ixVF2JJZ+9VZiPHPttjGBrUGTeFpdbSpdlfjR3MGqBodkZWnwpJGb8TyB2+7L8
         7G+T8Z6GDBTbc+fRWGF4s4CaiyuTWJhVu0Q6GDukX4kpBoBO8eYtpUnuF7YIK9RdK3tp
         uuaUzh3RQ50KCnxteRQ3cIdv75hKanD3a3WHvtljfM690699R5qHKSZXjJRctVrYpx6J
         hTC1jbalj4VUltfbZCDpNuL3Fx/DYQneABCbDnXHWep4RZ4Aw5UPSEMC1qM3CCby5Lhi
         BcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=BFgIYCI7yRsuw5QDRPV1hqt7vBc44z/uZpU7Ha6zhfM=;
        b=UtomQd4raGCv0clTsXiajsQU1sMZfcOa2t9P895msGu5CfmKYKG7qXQFc5q5j0scD3
         LgAMQhBW4TXwdgMZ/VuvpKUj1yxS9EeZ62CKnHAoDZ0Btao3fT2gB8k9hE/D4NE6jsIj
         dOF25fWNYeS/mtTWR7xdTiJIf2euele/0jBwkbrhkjaischcqNEJa5yVIgNEppcl/Lzn
         MInlxg+D1TUB+y0z/7cKdjwbmJwIqqFk18gCGx8z9ciRXGGf/NO7IrQ79rktt5BRvZ3e
         0LlIHDW9vxMxufNyEt4dA9A1dTiZrehw3a3Aiyg42ukPnranMNnp3erAq7J3Imc8iW+r
         IUMQ==
X-Gm-Message-State: APjAAAVaMZEkfMqM8vCPncAR2BdSzIZlnJflL3pY5h1UQ6Q00aQucv28
        Lp2wyCIjDNVJJnxMSHlHbKTxBTxFsbw=
X-Google-Smtp-Source: APXvYqy3/NECRL684xmBV0nq9e9hQDksGOsgSBAHzxYpQXEaA9EwT8D9LCOTP40AdxX5sQUucGBlIA==
X-Received: by 2002:a2e:959a:: with SMTP id w26mr19146339ljh.150.1560914836098;
        Tue, 18 Jun 2019 20:27:16 -0700 (PDT)
Received: from [192.168.1.5] ([109.252.90.211])
        by smtp.gmail.com with ESMTPSA id 137sm2861203ljj.46.2019.06.18.20.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 20:27:14 -0700 (PDT)
Subject: Re: Rebalancing raid1 after adding a device
To:     Hugo Mills <hugo@carfax.org.uk>,
        =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk>
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
Message-ID: <42d90ede-b469-0c9e-2a97-1d53df5eeaaf@gmail.com>
Date:   Wed, 19 Jun 2019 06:27:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618184501.GJ21016@carfax.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rT68ueeV0r3tYxv8eOqiiNbop2R7oILzO"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rT68ueeV0r3tYxv8eOqiiNbop2R7oILzO
Content-Type: multipart/mixed; boundary="El1G6Ml7erkgUGNGGv2GnQu4FmiEUBOPw";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Hugo Mills <hugo@carfax.org.uk>,
 =?UTF-8?Q?St=c3=a9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
 linux-btrfs@vger.kernel.org
Message-ID: <42d90ede-b469-0c9e-2a97-1d53df5eeaaf@gmail.com>
Subject: Re: Rebalancing raid1 after adding a device
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk>
In-Reply-To: <20190618184501.GJ21016@carfax.org.uk>

--El1G6Ml7erkgUGNGGv2GnQu4FmiEUBOPw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

18.06.2019 21:45, Hugo Mills =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
=2E..
>=20
>> Is there a way to ask the block group allocator to prefer writing to
>> a specific device during a balance? Something like -ddestdevid=3DN?
>> This would just be a hint to the allocator and the usual constraints
>> would always apply (and prevail over the hint when needed).
>=20
>    No, there isn't. Having control over the allocator (or bypassing
> it) would be pretty difficult to implement, I think.
>=20
>    It would be really great if there was an ioctl that allowed you to
> say things like "take the chunks of this block group and put them on
> devices 2, 4 and 5 in RAID-5", because you could do a load of
> optimisation with reshaping the FS in userspace with that. But I
> suspect it's a long way down the list of things to do.
>=20

It really sounds like "btrfs replace -ddrange=3Dx..y". Replace already
knows how to move chunks from one device and put it on another. Now it
"just" needs to skip "replace" part and ignore chunks not covered by
filter ...


--El1G6Ml7erkgUGNGGv2GnQu4FmiEUBOPw--

--rT68ueeV0r3tYxv8eOqiiNbop2R7oILzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXQmrjQAKCRBHosy62l33
jFYrAKC4GO4oioOKB7/DOxXZqlQ7Af+pmACfRVu7rlF/7k4lvODF2+8Wo9tTjYA=
=2ptk
-----END PGP SIGNATURE-----

--rT68ueeV0r3tYxv8eOqiiNbop2R7oILzO--
