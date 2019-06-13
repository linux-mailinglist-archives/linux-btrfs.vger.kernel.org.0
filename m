Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187C74458D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfFMQoo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 12:44:44 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:44776 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfFMG0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 02:26:19 -0400
Received: by mail-lj1-f181.google.com with SMTP id k18so17319834ljc.11
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 23:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=n+XMcs1qi7jNntqjWjorThmb6Ojs+bBugPZb2Tj6xVA=;
        b=CsTq/tZIy/ohd3KBGExL6MERfTiLXeptgN4cd6PCandRi3xiOyyzJy5m0cGccSmTb5
         MzKQPYZJ5RPgzqnXNuf+FFQlEAD8TCwzLYmvkAWSZFv8LzSvRf/IEDuaZVgqqKIaxBob
         kGtaEiqeeYu4xh261k6T5NafIr4vB2REMe+lr1s6Cw9NxWLkeHExkRWGh04E1zvq1tWM
         fabC44jo1rttbWyXH6S6c+tqAJQvvIw5GmxDvzMsB30hX+B6OAC4kgH0Nwb4x6CZ+Uyy
         uFyYT4xU1MF6yelKyIYo0R0AP3gHdKul/9uMJi1vxmHpU23w177k31HX0pyuf3UdQFtP
         Ba1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=n+XMcs1qi7jNntqjWjorThmb6Ojs+bBugPZb2Tj6xVA=;
        b=Gjv2ewrz7TJXkNULF3urzrHtGlJzaD2mZAkSJEqpc44utIxLHzhA+Rgu+b+VSETSol
         wfJlDqcFhG96NrO4qLZ1RQkVginJQcUTL/mp8++3z5JaWB62ANQzeH9u+e2wHCjaOgi7
         wrRYUMtD55AsyQZ9SQRmzb5m+yr3lV1A6J2eP/leiU4mQSIJDXQqnd3OUuQOKMHLYc12
         e8bJHfZKstPd/bS3JlE9xc3fJtGC3yvvuG3kuSX+YEgJHCXbYWzzwy9FwiXkj22Eglng
         MGmBcMd7o2YMyQSxA0LTnlxnxGGVtGcV6BM/dy5b5ydU8E2x6fNmJf4prcF7O+nXv0+b
         jomQ==
X-Gm-Message-State: APjAAAWylXu+4e2fTlrSpgfTvuHhRL7jPztfF7R5n8d2M/CKpieX993o
        RYmrAvF1UJd0VVkVcB1VXzh/JTsI
X-Google-Smtp-Source: APXvYqyixHlWn08ke3mFlRW9VNz7DEA7tzQl1ZNLoF8z5W4rBxG4TzyuVoI2y6lxx9KAgCkcGO2yIg==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr18174852ljp.202.1560407176297;
        Wed, 12 Jun 2019 23:26:16 -0700 (PDT)
Received: from [192.168.1.5] (109-252-90-211.nat.spd-mgts.ru. [109.252.90.211])
        by smtp.gmail.com with ESMTPSA id u22sm430423ljd.18.2019.06.12.23.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 23:26:15 -0700 (PDT)
Subject: Re: Issues with btrfs send/receive with parents
To:     Eric Mesa <eric@ericmesa.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <2008850.MjMmxLcJHu@supermario.mushroomkingdom>
 <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com>
 <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
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
Message-ID: <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
Date:   Thu, 13 Jun 2019 09:26:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ogeaqexS2avV1guayVGzPJDUCfjcepPb4"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ogeaqexS2avV1guayVGzPJDUCfjcepPb4
Content-Type: multipart/mixed; boundary="I4Lkls9J3lGHHyH86dvn5OIZfc3zHY7FI";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Eric Mesa <eric@ericmesa.com>
Cc: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
Subject: Re: Issues with btrfs send/receive with parents
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <2008850.MjMmxLcJHu@supermario.mushroomkingdom>
 <21ecc5c2-7e4c-803e-5299-7ee150d6af4f@gmail.com>
 <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
In-Reply-To: <2331470.mWhmLaHhuV@supermario.mushroomkingdom>

--I4Lkls9J3lGHHyH86dvn5OIZfc3zHY7FI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

13.06.2019 2:03, Eric Mesa =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
=2E..
>>>
>>> # btrfs sub snap -r /home/ /home/.snapshots/2019-06-10-2353
>>> Create a readonly snapshot of '/home/' in
>>> '/home/.snapshots/2019-06-10-2353'
>>>
>>> # btrfs send -vvv -p /home/.snapshots/2019-06-10-1718/ /home/.snapsho=
ts/
>>> 2019-06-10-2353/ | ssh root@tanukimario btrfs receive
>>> /media/backups/backups1/ supermario-home
>>> At subvol /home/.snapshots/2019-06-10-2353/
>>> ERROR: link ermesa/.mozilla/firefox/n35gu0fb.default/bookmarkbackups/=

>>> bookmarks-2019-06-10_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 ->
>>> ermesa/.mozilla/ firefox/n35gu0fb.default/bookmarkbackups/
>>> bookmarks-2019-06-09_679_I1bs5PtgsPwtyXvcvcRdSg=3D=3D.jsonlz4 failed:=
 No such
>>> file or directory
>>
=2E..
>=20
>=20
> On the source disk:
>=20
> # btrfs subvolume list -qRu /home
> ID 822 gen 3042780 top level 5 parent_uuid c6101e57-acd3-e54c-a957-
> b2b6a033bc42 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid=20
> 7247f4a0-6ea2-0d49-b5c5-1ea2ecb8980a path home
> ID 823 gen 3042727 top level 822 parent_uuid -                         =
          =20
> received_uuid -                                    uuid f83e53b6-dc88-1=
a44-
> a5e8-f220d5d21083 path .snapshots
> ID 2515 gen 3008316 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uu=
id=20
> 8ef83478-86be-8a47-a425-1dc6957a0fbe path .snapshots/2019-06-05-postdef=
rag
> ID 2516 gen 3021663 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uu=
id=20
> cbb67aec-02ed-8247-afee-38ae94555471 path .snapshots/2019-06-08-1437
> ID 2518 gen 3027353 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uu=
id=20
> ca361150-1050-5844-bff7-de5c89b5cc05 path .snapshots/2019-06-09-1550
> ID 2519 gen 3028168 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uu=
id=20
> 5fa82b5e-59e1-2549-a939-5dabc99c0f2a path .snapshots/2019-06-09-1944
> ID 2520 gen 3032614 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uu=
id=20
> df437aaf-0f40-344e-8302-932ea8e5f197 path .snapshots/2019-06-10-1718
> ID 2521 gen 3034140 top level 823 parent_uuid 7247f4a0-6ea2-0d49-
> b5c5-1ea2ecb8980a received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uu=
id=20
> 2b985685-d88b-784a-b870-8f5f8fcdd08c path .snapshots/2019-06-10-2353
>=20
>=20
> On the destination disk: (I deleted 2019-06-2353 since it wasn't a vali=
d=20
> backup and I didn't want to get confused when determining which backups=
 I=20
> could delete)
>=20
> btrfs subvolume list -qRu /media/backups/backups1/supermario-home
=2E..
> ID 2983 gen 15033 top level 258 parent_uuid -                          =
         =20
> received_uuid ab1ea98a-b950-2047-802d-3b26568e2e14 uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 path 2019-06-05-postdefrag
> ID 3545 gen 14310 top level 258 parent_uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e=
14 uuid=20
> 26791559-bd47-e44f-9e2f-0ea258615429 path 2019-06-08-1437
> ID 3550 gen 14878 top level 258 parent_uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e=
14 uuid=20
> 7c9787bc-fbc4-c146-b88b-e5dd10918eaa path 2019-06-09-1944
> ID 3582 gen 15012 top level 258 parent_uuid 7685ff5c-0a72-
> f94e-93d7-7736f68b3ec5 received_uuid ab1ea98a-b950-2047-802d-3b26568e2e=
14 uuid=20
> 44963c1e-7bc7-f34a-9370-ce180ce05b69 path 2019-06-10-1718
>=20

All your snapshots on source have the same received_uuid (I have no idea
how is it possible). If received_uuid exists, it is sent to destination
instead of subvolume UUID to identify matching snapshot. All your backup
sbapshots on destination also have the same received_uuid which is
matched against (received_)UUID of source subvolume. In this case
receive command takes the first found subvolume (probably the most
recent, i.e. with the smallest generation number). So you send
differential stream against one subvolume and this stream is applied to
another subvolume which explains the error.



--I4Lkls9J3lGHHyH86dvn5OIZfc3zHY7FI--

--ogeaqexS2avV1guayVGzPJDUCfjcepPb4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXQHshgAKCRBHosy62l33
jL+FAKDGa3B0+DdWXcxe5hOXbQOmzUF2WgCdE58dAmFlOu4J5Mk2/ASKRzEZqUI=
=PCgr
-----END PGP SIGNATURE-----

--ogeaqexS2avV1guayVGzPJDUCfjcepPb4--
