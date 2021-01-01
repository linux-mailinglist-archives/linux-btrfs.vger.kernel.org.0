Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE522E8596
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 21:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbhAAUlQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 15:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbhAAUlP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 15:41:15 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C976C061573
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 12:40:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h205so50510370lfd.5
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=NRDZWhQZgcWB0EtTA8F8OJJB6sYye8qN+DzXZOSChfE=;
        b=EAylsrUEbj6Kw77k2Chhtpqo2AzQxupb1XW95jxNOjARIAKxoP8muig1aAh7pw1YD7
         h5XrOyF9oxqMkKzlRPJDiTyBxRo74yW1ac8xYg4L7Gn+p0UjgxohKD7uM08CW8zJqgR8
         EazeuW37zyevmSvM59+qy5PhoePFHHggYrKYspvjADja9P0OSgP/QMzu/X541tJPszZj
         p8svD2NHlgSTDmmQRTzHKifw4QKlijnbV5kTnzcDQgp28VyE0dYGAf4klSE34yPXy4E+
         IAtmY9qhKZkyl0+MycYlTRNRj2AMeSnTTyZd2dDppiuPuMoA2pUPWz/UNbBogv+RSFCo
         qJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=NRDZWhQZgcWB0EtTA8F8OJJB6sYye8qN+DzXZOSChfE=;
        b=IOwYlBvpwNEN6h5aAHA3BPLMJOW3q8HJdpWOLkJZ8kK0CzhKkvUN+IUGS6hAJkZTFq
         Ku+tl6fbLLtGlhnmHPfcJSUDpDdARbN54l+7hyTf6k0P6Uyy75XD9KhGyJPqnUlDf4ia
         cGmwZcFKKst8i1fa3l2Cv9bjI+5XwyJz+/QAt+r+YGrosx1+BE51noAb2TmEGRDVAzx0
         ztdWjGBWRCPpptO9aaYqJw93O/PRD6CrXGqMUgSrTD3bVVZrfHlnOHmOE8ZPqeV4gBgz
         3X/P/uEnd1VccxggFn6AUK35+m30nLKfutH1wFeKMaMrC+z+CKn2msTNylCHfZQ1j5x7
         SPhw==
X-Gm-Message-State: AOAM531TVHJ4rzf9aIv7zgkdLikM6MKc1cWplpcFcf7tv6xOB8b2Uhd9
        +A3zdowd8M7RgsemXEuqEV5eBAwY2PA=
X-Google-Smtp-Source: ABdhPJyAwqDsTQhc7lHPcnmaDFAZkij6bF7CGaQhk3Ol3VAsua6KmnBbPrqyw180W7t6QICj8LKzlw==
X-Received: by 2002:a2e:a310:: with SMTP id l16mr33656551lje.142.1609533633513;
        Fri, 01 Jan 2021 12:40:33 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id y24sm6196970ljm.125.2021.01.01.12.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 12:40:32 -0800 (PST)
Subject: Re: hierarchical, tree-like structure of snapshots
From:   Andrei Borzenkov <arvidjaar@gmail.com>
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
 <49e405a1-ca48-7654-6b1e-408bcf6553b8@gmail.com>
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
Message-ID: <c61863f5-64f5-2fe7-0607-11debddc1d7f@gmail.com>
Date:   Fri, 1 Jan 2021 23:40:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <49e405a1-ca48-7654-6b1e-408bcf6553b8@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="U8CaCMwNkdTZPXTIkfqbAjtVI3a48RBAc"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U8CaCMwNkdTZPXTIkfqbAjtVI3a48RBAc
Content-Type: multipart/mixed; boundary="4jrxFXQFpOuA30qU8ABMHpDWQMdItcKPR"

--4jrxFXQFpOuA30qU8ABMHpDWQMdItcKPR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

01.01.2021 14:42, Andrei Borzenkov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> 01.01.2021 00:36, Zygo Blaxell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>>
>> Yeah, I only checked that send completed without error and produced a
>> smaller stream.
>>
>> I just dumped the send metadata stream from the incremental snapshot n=
ow,
>> and it's more or less garbage at the start:
>>
>> 	# btrfs sub create A
>> 	# btrfs sub create B
>> 	# date > A/date
>> 	# date > B/date
>> 	# mkdir A/t B/u
>> 	# btrfs sub snap -r A A_RO
>> 	# btrfs sub snap -r B B_RO
> ...
>> 	# btrfs send A_RO | btrfs receive -v /tmp/test
>> 	At subvol A_RO
>> 	At subvol A_RO
>> 	receiving subvol A_RO uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, st=
ransid=3D7329268
>> 	write date - offset=3D0 length=3D29
>> 	BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D995adde4-00ac-5e49-8c6f-f01743de=
f072, stransid=3D7329268
>> 	# btrfs send B_RO -p A_RO | btrfs receive -v /tmp/test
>> 	At subvol B_RO
>> 	At snapshot B_RO
>> 	receiving snapshot B_RO uuid=3D4aa7db26-b219-694e-9b3c-f8f737a46bdb, =
ctransid=3D7329268 parent_uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, pa=
rent_ctransid=3D7329268
>> 	ERROR: link date -> date failed: File exists
>>
>> The btrfs_compare_trees function can handle arbitrary tree differences=
,
>=20
> I am not sure. It apparently relies on the fact that inodes are ever
> monotonically increasing. This is probably true for clones of the same
> subvolume (I assume clone inherits highest_objectid) but two subvolumes=

> created independently have the same range of inode numbers.
>=20

In particular in your example both A/date and B/date have identical
inode numbers and in general INODE_ITEMs are identical (including
generation numbers) up to times so two inodes are compared as changed.
At the same time INODE_REFs for them are considered different because
INODE_ITEMs for root have different generations. This leads to code path
that attempts to create additional alias to existing inode, as it is
regular file it tries to link it. It does not really compares ref names
at this point at all.

This would not really be possible if A and B were clones of the same
subvolume (not necessary consecutive) as A/date and B/date would always
have different inode numbers.

If I force different generation numbers for A/date and B/date (by
syncing in between) send stream contains correct sequence of removing
old B/date (from A clone) and re-creating it again.

Which shows that unfortunately generation numbers are not reliable to
differentiate between different object generations (pun unintended). As
I understand generation is tied to transaction and multiple changes can
be packed into one transaction.

> Also I am not sure if using later clone as base for difference to
> earlier clone will work for the same reason.
>=20
>> but something happens in one of the support functions and we get a
>> bogus link command.  The rest of the stream is OK though:  we fill
>> in the contents of B_RO/date, rename A_RO/t to B_RO/u, and update all
>> the timestamps.
>>
>> Oh well, I didn't say send didn't have any bugs.  ;)
>>
>=20



--4jrxFXQFpOuA30qU8ABMHpDWQMdItcKPR--

--U8CaCMwNkdTZPXTIkfqbAjtVI3a48RBAc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCX++IvAAKCRBHosy62l33
jJBkAKCX/BrADpl4jH+Dja9+d/h0MpesHwCeON8VLsCFKXRD996MtUO337vEDSk=
=Zb/B
-----END PGP SIGNATURE-----

--U8CaCMwNkdTZPXTIkfqbAjtVI3a48RBAc--
