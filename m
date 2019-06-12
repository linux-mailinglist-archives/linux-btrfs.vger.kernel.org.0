Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1689641B95
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 07:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbfFLFnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 01:43:11 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34607 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFLFnL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 01:43:11 -0400
Received: by mail-lf1-f46.google.com with SMTP id y198so11067840lfa.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2019 22:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Su9RpNVGZUEDn2JSY4vOVguvbb6eyfAGA/XWNuigqD4=;
        b=pDQQ9FPV3eDo8yQEjYT5u4Gt+uGSmJUHzleCJxxOqiU/s9KdK9mo0su+Gr2wtgXHr0
         2vweREJs43FATEH2vBeXSazA1OCdRMNxBCKjLK+7FJGjSHnzDY4HIWY9Gdy1zFE1qBKJ
         ePeoJhG2yBBdRKeX984yv6cGYK6iVp7AQqR1K33TC/gxW7TDrM5E4+eb75qL4hBCYz/R
         E9KWvAOXIHqfD5/qr02dgbL1s8zoWe7Thg5NfpJoNzw2mC9190j4mV2u6p49Sld8M2/K
         IIgSIgR/o7vqXA5o5icOYF3pV2hz+m9u1HcdXFJflP4Y5xUFSzDGzh0TOmtxHIczeOIJ
         Y3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Su9RpNVGZUEDn2JSY4vOVguvbb6eyfAGA/XWNuigqD4=;
        b=ZC1e4uh3sB81f5ZDRt81EvjQSKNu9GBgzVsGacuFwGeX0I5k5a/G6zHebX2Pfm0Dtp
         z2QarS6flgo+bdpDg/jQ788gcCJy+fc42s3qhg1mMbsov4oeR7oOTnXxo3q6SbA8LEab
         7huTSUAkjEGMeoY4JCrMamSpnq9n+rlRGv18QQYlHti9DuKtX601GCI18yr3AE4ikJs7
         QdNR5t3DEnjO0XsjMfevEgxZQ0GJErHAxTH3QTcWhXIjEO4tw+nipFmk0OgPqZ1K/wdx
         S1Ar6Nw194e38RfErNazfdCp9ao2EWBTwNFBWJqtY9ehqHr4HxB9G6hgJM6x/uF4nVgy
         k2eA==
X-Gm-Message-State: APjAAAUbrnw1gk6qomMtJK1LpSPLM3Ha4s+nSEP7PFC4/sjY8ttu6L+R
        F75Y9rDeXVxvHlK93yo7BNLZTFbsn4w=
X-Google-Smtp-Source: APXvYqxqxqUeNYp8X1Qxva2xMMFBZwXruPqDAm0ZtKhrpJBv/j5GA2cqg3HEf56xF4Bur5pYCIv6tQ==
X-Received: by 2002:ac2:5a01:: with SMTP id q1mr25821730lfn.46.1560318188484;
        Tue, 11 Jun 2019 22:43:08 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-211.nat.spd-mgts.ru. [109.252.90.211])
        by smtp.gmail.com with ESMTPSA id m10sm2875659lfd.32.2019.06.11.22.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 22:43:07 -0700 (PDT)
Subject: Re: Issues with btrfs send/receive with parents
To:     Eric Mesa <eric@ericmesa.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
 <9d9f4b67-57c1-2003-8e15-52e8460c3c9d@gmail.com>
 <2008850.MjMmxLcJHu@supermario.mushroomkingdom>
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
Message-ID: <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com>
Date:   Wed, 12 Jun 2019 08:43:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2008850.MjMmxLcJHu@supermario.mushroomkingdom>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wbzK48qKgpsDepW0WQMIaEDja2W7E9nIe"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wbzK48qKgpsDepW0WQMIaEDja2W7E9nIe
Content-Type: multipart/mixed; boundary="GKTPYBRsaTor0XLzbDne9JI0vTLzsSNfD";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Eric Mesa <eric@ericmesa.com>
Cc: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com>
Subject: Re: Issues with btrfs send/receive with parents
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <CAJCQCtSLVxVtArLHrx0XD6J1oWOowqAnOPzeWVx3J25O7vxFQw@mail.gmail.com>
 <9d9f4b67-57c1-2003-8e15-52e8460c3c9d@gmail.com>
 <2008850.MjMmxLcJHu@supermario.mushroomkingdom>
In-Reply-To: <2008850.MjMmxLcJHu@supermario.mushroomkingdom>

--GKTPYBRsaTor0XLzbDne9JI0vTLzsSNfD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

11.06.2019 7:19, Eric Mesa =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Monday, June 10, 2019 11:39:53 PM EDT Andrei Borzenkov wrote:
>> 11.06.2019 4:10, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> It's most useful if you show exact commands because actually it's not=

>>> always obvious to everyone what the logic should be and the error
>>> handling doesn't always stop a user from doing something that doesn't=

>>> make a lot of sense. We need to know the name of the rw subvolume; th=
e
>>> command to snapshot it; the full send/receive command for that first
>>> snapshot; the command for a subsequent snapshot; and the command to
>>> incrementally send/receive it.
>>
>> And the actual output of each command, not description what user think=
s
>> has happened.
>=20
> Here is a new session where I'll capture everything - well, on the defr=
ag I'll=20
> do a snip.
>=20
> #btrfs fi defrag -v -r /home/
>=20
> ...there follows a list of files that just scrolls infinitely....
> /home/ermesa/.dropbox-dist/dropbox-lnx.x86_64-74.4.115/_bisect.cpython-=
37m-
> x86_64-linux-gnu.so
> /home/ermesa/.dropbox-dist/dropbox-lnx.x86_64-74.4.115/
> tornado.speedups.cpython-37m-x86_64-linux-gnu.so
> /home/ermesa/.bash_history
> total 1 failures
>=20
> # sync
>=20
> # btrfs sub snap -r /home/ /home/.snapshots/2019-06-10-2353
> Create a readonly snapshot of '/home/' in '/home/.snapshots/2019-06-10-=
2353'
>=20
> # btrfs send -vvv -p /home/.snapshots/2019-06-10-1718/ /home/.snapshots=
/
> 2019-06-10-2353/ | ssh root@tanukimario btrfs receive /media/backups/ba=
ckups1/
> supermario-home
> At subvol /home/.snapshots/2019-06-10-2353/
> ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/
> bookmarks-2019-06-10_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 -> ermesa=
/.mozilla/
> firefox/n35gu0fb.default/bookmarkbackups/
> bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 failed: N=
o such file=20
> or directory
>=20

Does
ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/bookmarks-2019-0=
6-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4
actually exist in snapshot /home/.snapshots/2019-06-10-1718/ on source?

ls -lR
/home/.snapshots/2019-06-10-1718/ermesa/.mozilla/n35gu0fb.default/bookmar=
kbackups

What is the content of the same directory in matching snapshot on
destination?

Please show "btrfs subvolume list -qRu /home" for source and "btrfs
subvolume list -qRu /media/backups/backups1/supermario-home" for
destination.





--GKTPYBRsaTor0XLzbDne9JI0vTLzsSNfD--

--wbzK48qKgpsDepW0WQMIaEDja2W7E9nIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXQCQ5AAKCRBHosy62l33
jNlTAJ9zzRU53W632Qr8dgrElkNlA66W1QCfa5+dmlRdVqTpNfY0BuuVhdEFYms=
=IXbs
-----END PGP SIGNATURE-----

--wbzK48qKgpsDepW0WQMIaEDja2W7E9nIe--
