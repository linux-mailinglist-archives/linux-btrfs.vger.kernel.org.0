Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12B78047D
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfHCFbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 01:31:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37053 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHCFbk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Aug 2019 01:31:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id c9so54317977lfh.4
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2019 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=4kkYLku9e+k31V4M785nWWOo3WsSN6m7jku1fpEdjOA=;
        b=RmmSqi53ZDiK53me/fqKuwOSnMsQnpAm8hsbaODO6eubcEH4IFoZBPRRGgZYayz+p5
         lp0KFudhl+YWyLJUMnZv5OzQ8vPDDGLfYOMlp7q/WMQcns7AsY9hu7xvoh9fGz3nXH7E
         F+E3qRc+eIaicOM5LHSe/DbCtJTmp3NpJuJBHAGZcxu5cDhSzIZRyc0JdJ5A9zdwXbcw
         qp1kHiHhzUSr67XiVx5efl428ffNclnTdJMYSNjkbkJ2uyEgU/wly02myZXTjT4AE6yX
         2fXfsmyoIE8tJWncnyrsng0Brevjm1UT37IOEbC3q96Rlvzq9FxBsAIlREZFBuSklTyH
         Msbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=4kkYLku9e+k31V4M785nWWOo3WsSN6m7jku1fpEdjOA=;
        b=Go2/dvWIMPcv1ww7uSfkmQGoFBITtsYS0zE8Ht8UEDVHgAr7TmI2fDpxMctTqi2ZO3
         sRRRzHW58Dmu92zO0YAooIm6uW1/0spfBUMDfsoZ77g/9lVp9Iaj6tMu19yrNKys9J8N
         VHQ0wcGqfURUSRcQP2j7ubcMxHNduQTAROAWIRsS8Yyxkw/O0yZsYOKWhFASgNl/cqVV
         1P+hM/fcGU/qlQxuZ+DO5H6ZSNLN3vRnqVfa3PeXBZEiwytLL+DIjrO+HijnqbwNFDNc
         gi2T2P47XWr105uzihij2hotIWju9hqNAd+SYBweVeHIGggGPTxPO9+n4a4kLPWnWSS+
         lU+w==
X-Gm-Message-State: APjAAAUkpQicmK5PAgUzY2YQx6G/6HpApTQVxPNYP8uheXoueTPeRYXG
        Mj2EAVr9y0cxhOofoJqkwDvdKhkiAwA=
X-Google-Smtp-Source: APXvYqzATZejem3bRdL3bInaSV+DBafhceYIZ61FKbmbO0npu0haeEysAPiRKklpwQ9r8D4yMf43Cg==
X-Received: by 2002:a19:4349:: with SMTP id m9mr65361438lfj.64.1564810296735;
        Fri, 02 Aug 2019 22:31:36 -0700 (PDT)
Received: from [192.168.1.6] (109-252-55-203.nat.spd-mgts.ru. [109.252.55.203])
        by smtp.gmail.com with ESMTPSA id g68sm15785307ljg.47.2019.08.02.22.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 22:31:35 -0700 (PDT)
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
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
Message-ID: <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
Date:   Sat, 3 Aug 2019 08:31:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rSyUDRh2jpAbdkL3pYH1zVPBHpRRLVuSV"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rSyUDRh2jpAbdkL3pYH1zVPBHpRRLVuSV
Content-Type: multipart/mixed; boundary="BKbxEY5bRni96CLd9xpCLxyusWRENR03H";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Message-ID: <96f2509f-fd4b-ed5c-7e48-730d3a9875f5@gmail.com>
Subject: Re: Non-existent qgroup in parent-child relation prevents makes
 qgroup commands fail
References: <665ad51a-def8-b60a-8ea2-b76e46f306d2@gmail.com>
 <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>
In-Reply-To: <5dcb6a1b-42db-cc84-a403-288b30c2842b@gmx.com>

--BKbxEY5bRni96CLd9xpCLxyusWRENR03H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

03.08.2019 2:09, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>=20
> On 2019/8/3 =E4=B8=8A=E5=8D=882:08, Andrei Borzenkov wrote:
>> bor@tw:~> sudo btrfs qgroup show .
>> ERROR: cannot find the qgroup 0/789
>> bor@tw:~>
>>
>> Fine. This openSUSE with snapper which creates and automatically
>> destroys snapshots and apparently either kernel or snapper now also
>> remove corresponding qgroup. I played with snapshots and created sever=
al
>> top level qgroups that included snapshot qgroups existing at this time=
=2E
>> Now these snapshots are gone, their qgroups are gone ...
>=20
> Kernel version please.
>=20
> IIRC latest upstream kernel doesn't remove the level 0 qgroup.

Yes?

> It may be the userspace doing it improperly.
>=20

Not sure what "improperly" means here. snapper removes qgroup after
deleting snapshot. What is "improper" here?

Snapper obviously does not track every parent-child relationship beyond
what it itself cares about (single summary qrgoup that includes all
snapshots).

>> and what can I
>> do? I have no way to even know what is wrong because the very command
>> that shows it fails immediately.
>>
>> bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 0/=
789
>> (0/789 QGROUP_RELATION 2/792)
>> (0/789 QGROUP_RELATION 2/793)
>> (0/789 QGROUP_RELATION 2/795)
>> (0/789 QGROUP_RELATION 2/799)
>> (0/789 QGROUP_RELATION 2/800)
>> (0/789 QGROUP_RELATION 2/803)
>> (0/789 QGROUP_RELATION 2/804)
>> (0/789 QGROUP_RELATION 2/805)
>> (0/789 QGROUP_RELATION 2/806)
>> (0/789 QGROUP_RELATION 2/807)
>> (0/789 QGROUP_RELATION 2/808)
>> (0/789 QGROUP_RELATION 2/809)
>> (0/789 QGROUP_RELATION 2/814)
>> (0/789 QGROUP_RELATION 2/818)
>> (0/789 QGROUP_RELATION 2/819)
>> (2/792 QGROUP_RELATION 0/789)
>> (2/793 QGROUP_RELATION 0/789)
>> (2/795 QGROUP_RELATION 0/789)
>> (2/799 QGROUP_RELATION 0/789)
>> (2/800 QGROUP_RELATION 0/789)
>> (2/803 QGROUP_RELATION 0/789)
>> (2/804 QGROUP_RELATION 0/789)
>> (2/805 QGROUP_RELATION 0/789)
>> (2/806 QGROUP_RELATION 0/789)
>> (2/807 QGROUP_RELATION 0/789)
>> (2/808 QGROUP_RELATION 0/789)
>> (2/809 QGROUP_RELATION 0/789)
>> (2/814 QGROUP_RELATION 0/789)
>> (2/818 QGROUP_RELATION 0/789)
>> (2/819 QGROUP_RELATION 0/789)
>> bor@tw:~/python-btrfs/examples>
>>
>> And even if I find it out, I cannot fix it anyway
>=20
> Furthermore, latest kernel should automatically remove the relation whe=
n
> deleting the qgroup.
>=20

Yes, seems to be the case now with 5.2.3.

> Would you please provide the (minimal) script/reproducer causing the
> situation and kernel version?
>=20

I cannot reproduce it on purpose with kernel 5.2.3 and btrfsprogs 5.1. I
do not remember when I created the configuration in question, it
probably was late 4.x or early 5.x. System was periodically updated
since then and I noticed it only now.

Actually kernel should be dropping parent-child relation when removing
child since kernel 4.1 (commit
f5a6b1c53bdd44f79e3904c0f5e59f956b49b2c8). May be there is (was) some
other code path that skipped it.

OTOH this is not atomic. First qgroup item itself is removed, then
relation. If removing relation fails for whatever reason item itself is
already gone and we have situation above.

> Thanks,
> Qu
>=20
>>
>> bor@tw:~/python-btrfs/examples> sudo btrfs qgroup remove 0/789 2/792 .=

>> ERROR: unable to assign quota group: Invalid argument
>> bor@tw:~/python-btrfs/examples>
>>
>> I can remove parent qgroup, but it does not clean up parent-child
>> relationship
>>
>> bor@tw:~/python-btrfs/examples> sudo btrfs qgroup destroy 2/792 .
>> bor@tw:~/python-btrfs/examples> sudo ./show_tree_keys.py 8 . | grep 2/=
792
>> (0/789 QGROUP_RELATION 2/792)
>> (2/792 QGROUP_RELATION 0/789)
>> bor@tw:~/python-btrfs/examples>
>>
>=20



--BKbxEY5bRni96CLd9xpCLxyusWRENR03H--

--rSyUDRh2jpAbdkL3pYH1zVPBHpRRLVuSV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXUUcLgAKCRBHosy62l33
jHR/AKCptxGpkDWBinqYgQ8CG8biFlVUFQCgo9rIiS14AYwOeAFZ2qnNb5kbhrM=
=AbRk
-----END PGP SIGNATURE-----

--rSyUDRh2jpAbdkL3pYH1zVPBHpRRLVuSV--
