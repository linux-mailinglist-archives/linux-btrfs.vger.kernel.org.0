Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBC2E8395
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 12:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAALmw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 06:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbhAALmv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 06:42:51 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFF9C061573
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 03:42:11 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m25so48617970lfc.11
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=8OxKmz3TTsoBjaqebizBLvxjRLC+ok+QbXaMPEm1lSs=;
        b=No47UPgzuwQJf3FDeGS3i9xOfNNcILJuo2x75ScwMbFzgurPg1WLSHAp+0zKAi1Gly
         r9oEwerIZo5U4f1hkOym5gszjViFnQ7gZoM3iE8LuUXzwyg1qdPpwQ10usV5UxOb5iOR
         g+SEwicjtosG5Rxg2rosaTUYLJxBKjz4CKvVfX4G0X2tvX61Z1wero/7g6Ff09FUGf9A
         8AAZ7+xlTGLgBMgnP40DxXZko1yAwZMO6XFGvHwoAYnUWrdC6tpONk483K8hkWaFj1Dx
         aveG5cI2DkplJfeQ3zhMdCjctTJW7rOybbF8dBg/1FVM1hurQMAXVXCEhEacjSSh3fcR
         s7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=8OxKmz3TTsoBjaqebizBLvxjRLC+ok+QbXaMPEm1lSs=;
        b=f0pmkeA7iUiC5r1voUyO78+sk+Ug21lcM86+5IUNcfgj4Txp2LKTW+cSWwetFDqvqP
         lKX11SEs40y0ytQe8sd9CEp1jSOJhCQymS73DOW92ZFatuGJrSPmrJWEPXlVDycBA4zg
         ZK1dQlwrJc5r3KHjgeoVxzfFdNV+1CfUFG2Gb//tSDhW0JWAdqQiY2R7xXsH1kyfugmB
         et4IueDnqqj2SxftRu1RFrxRHhteePX+W1UyPu9Bs9YK1BtygX+Jfc8KaVH4AUbKJAae
         HpMqiLuLu+tUy7xJ3mHH1Yj9T0cUJdrYKbXSoCUIL8K4xIShIVEgKerysBTMw5whZa/k
         Im+w==
X-Gm-Message-State: AOAM530e4xbWJp+DiWHrfQjYVytz+NhYYH8hj/ESmbh3wUeLTKHmMEcK
        7LvJ+88R0KA1eRsyNz8ZdKtL/HKH7WA=
X-Google-Smtp-Source: ABdhPJxiz9Gi9DVs9xBq2FWo6cw33k4AJwIoMcsrSeas89wSHRyoZe7cl2OdCAZXDzbfryC/+/iQ2Q==
X-Received: by 2002:a19:f617:: with SMTP id x23mr24797209lfe.428.1609501329503;
        Fri, 01 Jan 2021 03:42:09 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id n133sm6468159lfd.152.2021.01.01.03.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 03:42:08 -0800 (PST)
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        john terragon <jterragon@gmail.com>
Cc:     sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxw16zS21c-XqpxdwY06E2bqgBgiFSJAHXkC9pS2d4ewQQ@mail.gmail.com>
 <c81089eb-2e1b-8cb4-d08e-5a858b56c9ec@lechevalier.se>
 <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
 <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org>
 <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
 <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
 <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
 <20201231213650.GT31381@hungrycats.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Autocrypt: addr=arvidjaar@gmail.com; prefer-encrypt=mutual; keydata=
 mQGiBDxiRwwRBAC3CN9wdwpVEqUGmSoqF8tWVIT4P/bLCSZLkinSZ2drsblKpdG7x+guxwts
 +LgI8qjf/q5Lah1TwOqzDvjHYJ1wbBauxZ03nDzSLUhD4Ms1IsqlIwyTLumQs4vcQdvLxjFs
 G70aDglgUSBogtaIEsiYZXl4X0j3L9fVstuz4/wXtwCg1cN/yv/eBC0tkcM1nsJXQrC5Ay8D
 /1aA5qPticLBpmEBxqkf0EMHuzyrFlqVw1tUjZ+Ep2LMlem8malPvfdZKEZ71W1a/XbRn8FE
 SOp0tUa5GwdoDXgEp1CJUn+WLurR0KPDf01E4j/PHHAoABgrqcOTcIVoNpv2gNiBySVsNGzF
 XTeY/Yd6vQclkqjBYONGN3r9R8bWA/0Y1j4XK61qjowRk3Iy8sBggM3PmmNRUJYgroerpcAr
 2byz6wTsb3U7OzUZ1Llgisk5Qum0RN77m3I37FXlIhCmSEY7KZVzGNW3blugLHcfw/HuCB7R
 1w5qiLWKK6eCQHL+BZwiU8hX3dtTq9d7WhRW5nsVPEaPqudQfMSi/Ux1kbQmQW5kcmV5IEJv
 cnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT6IYAQTEQIAIAUCSXs6NQIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAAoJEEeizLraXfeMLOYAnj4ovpka+mXNzImeYCd5LqW5to8FAJ4v
 P4IW+Ic7eYXxCLM7/zm9YMUVbrQmQW5kcmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWls
 LmNvbT6IZQQTEQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AFAliWAiQCGQEACgkQ
 R6LMutpd94wFGwCeNuQnMDxve/Fo3EvYIkAOn+zE21cAnRCQTXd1hTgcRHfpArEd/Rcb5+Sc
 uQENBDxiRyQQBACQtME33UHfFOCApLki4kLFrIw15A5asua10jm5It+hxzI9jDR9/bNEKDTK
 SciHnM7aRUggLwTt+6CXkMy8an+tVqGL/MvDc4/RKKlZxj39xP7wVXdt8y1ciY4ZqqZf3tmm
 SN9DlLcZJIOT82DaJZuvr7UJ7rLzBFbAUh4yRKaNnwADBwQAjNvMr/KBcGsV/UvxZSm/mdpv
 UPtcw9qmbxCrqFQoB6TmoZ7F6wp/rL3TkQ5UElPRgsG12+Dk9GgRhnnxTHCFgN1qTiZNX4YI
 FpNrd0au3W/Xko79L0c4/49ten5OrFI/psx53fhYvLYfkJnc62h8hiNeM6kqYa/x0BEddu92
 ZG6IRgQYEQIABgUCPGJHJAAKCRBHosy62l33jMhdAJ48P7WDvKLQQ5MKnn2D/TI337uA/gCg
 n5mnvm4SBctbhaSBgckRmgSxfwQ=
Message-ID: <49e405a1-ca48-7654-6b1e-408bcf6553b8@gmail.com>
Date:   Fri, 1 Jan 2021 14:42:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201231213650.GT31381@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="CYWvFPWJlusun06kiHbz57uATiuLwSfTd"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CYWvFPWJlusun06kiHbz57uATiuLwSfTd
Content-Type: multipart/mixed; boundary="3v6FSrF5QxpjIMzqQvUl5RtwUZRcjCbGL"

--3v6FSrF5QxpjIMzqQvUl5RtwUZRcjCbGL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

01.01.2021 00:36, Zygo Blaxell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
=2E..
>=20
> Yeah, I only checked that send completed without error and produced a
> smaller stream.
>=20
> I just dumped the send metadata stream from the incremental snapshot no=
w,
> and it's more or less garbage at the start:
>=20
> 	# btrfs sub create A
> 	# btrfs sub create B
> 	# date > A/date
> 	# date > B/date
> 	# mkdir A/t B/u
> 	# btrfs sub snap -r A A_RO
> 	# btrfs sub snap -r B B_RO
=2E..
> 	# btrfs send A_RO | btrfs receive -v /tmp/test
> 	At subvol A_RO
> 	At subvol A_RO
> 	receiving subvol A_RO uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, str=
ansid=3D7329268
> 	write date - offset=3D0 length=3D29
> 	BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D995adde4-00ac-5e49-8c6f-f01743def=
072, stransid=3D7329268
> 	# btrfs send B_RO -p A_RO | btrfs receive -v /tmp/test
> 	At subvol B_RO
> 	At snapshot B_RO
> 	receiving snapshot B_RO uuid=3D4aa7db26-b219-694e-9b3c-f8f737a46bdb, c=
transid=3D7329268 parent_uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, par=
ent_ctransid=3D7329268
> 	ERROR: link date -> date failed: File exists
>=20
> The btrfs_compare_trees function can handle arbitrary tree differences,=


I am not sure. It apparently relies on the fact that inodes are ever
monotonically increasing. This is probably true for clones of the same
subvolume (I assume clone inherits highest_objectid) but two subvolumes
created independently have the same range of inode numbers.

Also I am not sure if using later clone as base for difference to
earlier clone will work for the same reason.

> but something happens in one of the support functions and we get a
> bogus link command.  The rest of the stream is OK though:  we fill
> in the contents of B_RO/date, rename A_RO/t to B_RO/u, and update all
> the timestamps.
>=20
> Oh well, I didn't say send didn't have any bugs.  ;)
>=20


--3v6FSrF5QxpjIMzqQvUl5RtwUZRcjCbGL--

--CYWvFPWJlusun06kiHbz57uATiuLwSfTd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCX+8KjAAKCRBHosy62l33
jNTuAJ93vD9JYL8pXkSZU50LkljW4EvcmQCcDE5hsa0X+LGIqVmtqQA+acToMx0=
=QuFq
-----END PGP SIGNATURE-----

--CYWvFPWJlusun06kiHbz57uATiuLwSfTd--
