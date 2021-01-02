Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AB42E86D9
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Jan 2021 10:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhABJ0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Jan 2021 04:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbhABJ0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Jan 2021 04:26:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933ADC061573
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Jan 2021 01:25:21 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l11so52630400lfg.0
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Jan 2021 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=AP8MKOqV0Z8Jp1BV42Ulutg5XGXdK8yiKKHwUav2Qxw=;
        b=DORh5NNWcIBo607fTnvFDNrNLBFY1rBCLyq1vRwucWpMKtP7w6D7tpBG0+jC6Z9Rj+
         3552LIjiLJTNDEtPovkraLiuazl0YWTRo/SQEQ2vg963cJUIGd1bPjZIkN4ng9FkQqf/
         1ecriEjp0zCNd+3OCuYHBsLeFf2Sb/TrxDfdeOzHTGc773w2ERxVdwTM6B7NrcILW1AG
         9NBwiBCtpY1rE9B49mhB40Fzm/9r7ObnwLI85YOS6cQgHNMXoWJOopCYKpiy98EiXIt0
         MpaHZ1jILWwCqZXnsu+m2V0+WMHmZFjfYnpMlPq4NYddfHzAuy9kVESdm4Gy6jyQ4wB8
         iUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=AP8MKOqV0Z8Jp1BV42Ulutg5XGXdK8yiKKHwUav2Qxw=;
        b=D27B1CD3b+T/vi4g1JAPKy7Dipj/Mm2cb41DREN/EaY8wyg3507car9wIpT2HYM1BZ
         6c3hUxJyt4/GwgDuDkdKVSZ7aN4GOHsK3LtZY+Oe473m9Uz3x88ihcQsPCjVJjILl7my
         jotvXD3qv1pZRkGs3qRaUcokCGnG7Q85nr+GRb0rSpWCmh9+hajRul3S5+mjT6rhTZ6f
         hPfBm7OoIfjKOqTPLl9mqlTX50eQIh2YcNbn1z51QmTDvKkFKg/p/NSUv540eObJXqoe
         om7fWEjw2svWJZIzS/H7zm8R3uHLXrPlozGQwOzd1iO03P8FDZdfhLqIPv7IVw4gh9Gt
         pv2w==
X-Gm-Message-State: AOAM532Y75FpfPeGp3gUHeY39n2f6pABITUqx2AZrxve7Pc+ZxW/pIxg
        ntOHxDqH+JxU36uEoXKNzYtpGJQbeW4=
X-Google-Smtp-Source: ABdhPJwAO/MkYswhyoMvobsnOybxrMzvKx0Y8DQlPBJsAk1zjxosbKlVwIqxXe1fCbXyqWhHMjCr2g==
X-Received: by 2002:a05:651c:1342:: with SMTP id j2mr33840221ljb.91.1609579519790;
        Sat, 02 Jan 2021 01:25:19 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:ecb3:590f:aaab:50ba:573b? ([2a00:1370:812d:ecb3:590f:aaab:50ba:573b])
        by smtp.gmail.com with ESMTPSA id 84sm5727546lfg.210.2021.01.02.01.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 01:25:18 -0800 (PST)
Subject: Re: hierarchical, tree-like structure of snapshots
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     john terragon <jterragon@gmail.com>, sys <system@lechevalier.se>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CANg_oxwKbzmMcz3590KhRz5eSgK+_s8thGio8q90KyDHm44Dow@mail.gmail.com>
 <f472181d-d6a4-f5f4-df7f-03bc7788b45a@gmail.com>
 <CANg_oxzP_Dzn89=4W_EZjGQWgB0CYsqyWMHN_3WzwebPVQChfg@mail.gmail.com>
 <20201231172812.GS31381@hungrycats.org>
 <CANg_oxw1Arpmkm+si_fUVzgEmVfF_UYy0Fc-d+AuMyK543W_Dw@mail.gmail.com>
 <d151361d-5865-f537-ba59-41e1cd3eb8ab@gmail.com>
 <CANg_oxztFRbw+NqHbnvvK6HS3g67hDkSgk6TpMbd-zgYSv9URw@mail.gmail.com>
 <20201231213650.GT31381@hungrycats.org>
 <49e405a1-ca48-7654-6b1e-408bcf6553b8@gmail.com>
 <c61863f5-64f5-2fe7-0607-11debddc1d7f@gmail.com>
 <20210101231109.GU31381@hungrycats.org>
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
Message-ID: <351be9e1-054c-7d28-b46b-3651cace36e3@gmail.com>
Date:   Sat, 2 Jan 2021 12:25:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210101231109.GU31381@hungrycats.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="evQiqHY6VAYLZ945H4W3GPfflk85VBXcY"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--evQiqHY6VAYLZ945H4W3GPfflk85VBXcY
Content-Type: multipart/mixed; boundary="zcHg2xXdM1UluZsZilaxP0dLLLwAWJeMn"

--zcHg2xXdM1UluZsZilaxP0dLLLwAWJeMn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

02.01.2021 02:11, Zygo Blaxell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, Jan 01, 2021 at 11:40:28PM +0300, Andrei Borzenkov wrote:
>> 01.01.2021 14:42, Andrei Borzenkov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> 01.01.2021 00:36, Zygo Blaxell =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> ...
>>>>
>>>> Yeah, I only checked that send completed without error and produced =
a
>>>> smaller stream.
>>>>
>>>> I just dumped the send metadata stream from the incremental snapshot=
 now,
>>>> and it's more or less garbage at the start:
>>>>
>>>> 	# btrfs sub create A
>>>> 	# btrfs sub create B
>>>> 	# date > A/date
>>>> 	# date > B/date
>>>> 	# mkdir A/t B/u
>>>> 	# btrfs sub snap -r A A_RO
>>>> 	# btrfs sub snap -r B B_RO
>>> ...
>>>> 	# btrfs send A_RO | btrfs receive -v /tmp/test
>>>> 	At subvol A_RO
>>>> 	At subvol A_RO
>>>> 	receiving subvol A_RO uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, =
stransid=3D7329268
>>>> 	write date - offset=3D0 length=3D29
>>>> 	BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=3D995adde4-00ac-5e49-8c6f-f01743=
def072, stransid=3D7329268
>>>> 	# btrfs send B_RO -p A_RO | btrfs receive -v /tmp/test
>>>> 	At subvol B_RO
>>>> 	At snapshot B_RO
>>>> 	receiving snapshot B_RO uuid=3D4aa7db26-b219-694e-9b3c-f8f737a46bdb=
, ctransid=3D7329268 parent_uuid=3D995adde4-00ac-5e49-8c6f-f01743def072, =
parent_ctransid=3D7329268
>>>> 	ERROR: link date -> date failed: File exists
>>>>
>>>> The btrfs_compare_trees function can handle arbitrary tree differenc=
es,
>>>
>>> I am not sure. It apparently relies on the fact that inodes are ever
>>> monotonically increasing. This is probably true for clones of the sam=
e
>>> subvolume (I assume clone inherits highest_objectid) but two subvolum=
es
>>> created independently have the same range of inode numbers.
>>>
>>
>> In particular in your example both A/date and B/date have identical
>> inode numbers and in general INODE_ITEMs are identical (including
>> generation numbers) up to times so two inodes are compared as changed.=

>> At the same time INODE_REFs for them are considered different because
>> INODE_ITEMs for root have different generations. This leads to code pa=
th
>> that attempts to create additional alias to existing inode, as it is
>> regular file it tries to link it. It does not really compares ref name=
s
>> at this point at all.
>>
>> This would not really be possible if A and B were clones of the same
>> subvolume (not necessary consecutive) as A/date and B/date would alway=
s
>> have different inode numbers.
>=20
> After v5.11-rc1 inode_cache can no longer be used, but any filesystem t=
hat
> has inode_cache in its history might have cases like this hiding in
> metadata even with a linear series of snapshots.
>=20
> The send code is mostly used to transmit linear sequences of snapshots
> (a series of snapshots which capture the state of a single subvol at
> different times, ordered from oldest to newest) between machines that
> are not using the inode_cache mount option.  Any other case isn't getti=
ng
> very well tested in the field, even if it happens to work sometimes.
>=20

This is the only possible way to do it in NetApp and ZFS. But NetApp is
really much more usable than just that (I do not say ZFS is not, I just
have less experience with it). It retains unique identification of every
snapshot that is transferred so you can reverse replication and then
reverse it back, clone both source and destination volumes (which clones
their snapshots) and continue incremental replication of clones starting
from arbitrary snapshot pair, you can cascade replications (including
fan-pout them) and resume incremental replication between arbitrary pair
of systems in replication cascade. Nothing that is even remotely
possible in btrfs. Replication in btrfs is not really suitable for
anything more than offsite backup.

>> If I force different generation numbers for A/date and B/date (by
>> syncing in between) send stream contains correct sequence of removing
>> old B/date (from A clone) and re-creating it again.
>>
>> Which shows that unfortunately generation numbers are not reliable to
>> differentiate between different object generations (pun unintended). A=
s
>> I understand generation is tied to transaction and multiple changes ca=
n
>> be packed into one transaction.
>=20
> I'm pretty sure that the 6000+ lines of special-case code in send.c sti=
ll
> don't cover every possible case, or even all of the likely ones, even
> with linear snapshot sequences.  We still get people on IRC reporting
> strange receive issues, and usually the best solution we can find is
> to start over with a new full send.  That's OK for small filesystems,
> but when you have to unexpectedly do a full send of dozens of terabytes=

> over a medium-speed link, it's probably time to switch to rsync.
>=20
> Subversion used to have problems like this (maybe it still does, I
> switched to git years ago) where a complicated commit that combined
> multiple operations on objects of the same name would break the tool.
> I'm surprised btrfs is trying to do similar things in the kernel
> (though with the current send implementation there's nowhere else we
> could do them).  At least for fsync we get to say "nope, too hard,
> do a full commit instead" when complications arise.
>=20
>>> Also I am not sure if using later clone as base for difference to
>>> earlier clone will work for the same reason.
>=20
> That use case can come up e.g. if you have snapshots of / and you roll
> back to an earlier snapshot after a bad upgrade, but your backups are
> using incremental snapshots made from '/'.  Then the last-sent-snapshot=

> (from the bad upgrade) is newer than the origin subvol (from an earlier=

> good upgrade, with new modifications on top).
>=20

btrfs does not even support rollback. What is called "rollback" today
works only for root subvolume and is not really rollback but switch to a
different copy.

> Cases like these really need to work, or at least reliably throw
> errors when they have failed,=20

Of course :)

> as the application that rolls back to
> earlier snapshots might have no knowledge of the application that does
> incremental send backups on a user's system if they integrated tools
> from different vendors.
>=20
>>>> but something happens in one of the support functions and we get a
>>>> bogus link command.  The rest of the stream is OK though:  we fill
>>>> in the contents of B_RO/date, rename A_RO/t to B_RO/u, and update al=
l
>>>> the timestamps.
>>>>
>>>> Oh well, I didn't say send didn't have any bugs.  ;)
>>>>
>>>
>>
>>
>=20
>=20
>=20



--zcHg2xXdM1UluZsZilaxP0dLLLwAWJeMn--

--evQiqHY6VAYLZ945H4W3GPfflk85VBXcY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCX/A7+gAKCRBHosy62l33
jGhSAKCVRmqeGJ1aRodjiw8b+SWcu+umjgCgnVLReQx6dGvYYInRvFUfcfktgpo=
=edWV
-----END PGP SIGNATURE-----

--evQiqHY6VAYLZ945H4W3GPfflk85VBXcY--
