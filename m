Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E734D804C3
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfHCGtb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 02:49:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39005 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfHCGtb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Aug 2019 02:49:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so684556lfn.6
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 23:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=g8e0CQN+assFoxhsokD7yr8Isvis9q8fmQBF9ZETggo=;
        b=SvfvR5Q5qmAnMYD/LY2/3w3VJczfgVCda5bh+ecztgGgWDbEjDkTYzwxwK4/5erMpw
         5eQyIPivKq2EtIu6lxgiO0AiYURSPFAllq8T0rjboIjBQRKkTrjuDmK60VvTUvKoZXQG
         G8Fr0sbuMosUxosEOg6I87gjbP8p9a+HKeZg9020AfNfsmgzke28Fsoo/RWs0s7iyvvA
         8YFHZuI+OTCEXHtkTrFapleZ2Zsgtx35grsGQS7Mu1Eyw3EQQQz+fG0oEOqFAZvmzin3
         8umP7oEmo4TD7vAQLr0g3UU1bhXk3gfnNiRCSubzqtG/wve9q+b1o71a9K4SLU8JncuQ
         QgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=g8e0CQN+assFoxhsokD7yr8Isvis9q8fmQBF9ZETggo=;
        b=lKtJsb73wFmF+kAkAKGdakUCQ7E7eEzmYayMp4VThG91Z037ts3DTfFV0Vq/12frMi
         7gXUHfKeeN547dE4J+RRTvWlZHx8jRGZqCSAv09xzD9I3Zrj3exrTwHUTA2C8C7DgIln
         t7jxIk+tvpIAcRbCnsgcKALB1VgzGnwCKgASeuNAqoWmZntOELmAvV6pkpaDDwoZ1g+B
         na3EqvZolDgdo/bNgYJ4N/mqfgduxswqCqx6YqTrq9VM6v0a8BST56vJGQV5NDuuLMXg
         SCQcfCIcddlkftskRwH9eZ3fiB7t3zfo/5/oKkjXRqWgA7dbVRw59Qd8CzMmHAC7MHRX
         EU+A==
X-Gm-Message-State: APjAAAVf/iuD6PgSRSvMCc0a6RLrbz44hNOKuZ8ojjmYxKkI9NAvB7xM
        JY7LkXDyX5MXDVF8tyDeBwIHCENZT1E=
X-Google-Smtp-Source: APXvYqz4Cd9NyTwUKEGUv/F7irDymal97s9+en3JQFJF5Qkb9joosbYZyY9k3hsWidKOQlZwjTmTSg==
X-Received: by 2002:a19:ac41:: with SMTP id r1mr6654750lfc.100.1564814968929;
        Fri, 02 Aug 2019 23:49:28 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id d10sm15398412ljc.15.2019.08.02.23.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 23:49:27 -0700 (PDT)
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
 <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
 <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
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
Message-ID: <5af7cf6f-50dc-7984-e030-e329622d4cec@gmail.com>
Date:   Sat, 3 Aug 2019 09:49:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="k0H2KmbYV4xqnS0PrzBbgYmCQk7n0WpAD"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k0H2KmbYV4xqnS0PrzBbgYmCQk7n0WpAD
Content-Type: multipart/mixed; boundary="i06w78RgXkf65VBYVwuiklG7IWPxXlvCh";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <5af7cf6f-50dc-7984-e030-e329622d4cec@gmail.com>
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
 <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
 <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>
In-Reply-To: <677ae3d7-10d8-9073-e5d3-e38de65da9ee@gmx.com>

--i06w78RgXkf65VBYVwuiklG7IWPxXlvCh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

03.08.2019 9:17, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>=20
> On 2019/8/3 =E4=B8=8B=E5=8D=881:31, Andrei Borzenkov wrote:
>> 03.08.2019 2:09, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>>
>>> On 2019/8/3 =E4=B8=8A=E5=8D=882:08, Andrei Borzenkov wrote:
>>>> bor@tw:~> sudo btrfs qgroup show .
>>>> ERROR: cannot find the qgroup 0/789
>>>> bor@tw:~>
>>>>
>>>> Fine. This openSUSE with snapper which creates and automatically
>>>> destroys snapshots and apparently either kernel or snapper now also
>>>> remove corresponding qgroup. I played with snapshots and created sev=
eral
>>>> top level qgroups that included snapshot qgroups existing at this ti=
me.
>>>> Now these snapshots are gone, their qgroups are gone ...
>>>
>>> Kernel version please.
>>>
>>> IIRC latest upstream kernel doesn't remove the level 0 qgroup.
>>
>> Yes?
>>
>>> It may be the userspace doing it improperly.
>>>
>>
>> Not sure what "improperly" means here. snapper removes qgroup after
>> deleting snapshot. What is "improper" here?
>=20
> Doing without using the qgroup ioctl, but some extra flag in snapshot
> creation/deletion, which can also add relation at subv/snapshot creatio=
n
> time.
>=20

As far as I can tell, this is exactly what snapper does:

            if (qgroup !=3D no_qgroup)
            {
                size_t size =3D sizeof(btrfs_qgroup_inherit) +
sizeof(((btrfs_qgroup_inherit*) 0)->qgroups[0]);
                vector<char> buffer(size, 0);
                struct btrfs_qgroup_inherit* inherit =3D
(btrfs_qgroup_inherit*) &buffer[0];

                inherit->num_qgroups =3D 1;
                inherit->num_ref_copies =3D 0;
                inherit->num_excl_copies =3D 0;
                inherit->qgroups[0] =3D qgroup;

                args_v2.flags |=3D BTRFS_SUBVOL_QGROUP_INHERIT;
                args_v2.size =3D size;
                args_v2.qgroup_inherit =3D inherit;
            }

Do you say it should not be doing it?


--i06w78RgXkf65VBYVwuiklG7IWPxXlvCh--

--k0H2KmbYV4xqnS0PrzBbgYmCQk7n0WpAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXUUudgAKCRBHosy62l33
jBRrAKCmqAIWJ9Cg0G5wEYVZ93OD5JhKIwCgoI00wAWbij9fFRQvrt1wNVXlEJ4=
=kZYa
-----END PGP SIGNATURE-----

--k0H2KmbYV4xqnS0PrzBbgYmCQk7n0WpAD--
