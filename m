Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA796C0FD2
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Sep 2019 06:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbfI1E67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Sep 2019 00:58:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44412 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbfI1E66 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Sep 2019 00:58:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so4384492ljj.11
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2019 21:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Itna0pJ8txEtMM62Fa2uZtpKUMQobFyR2tYuBaeTUVI=;
        b=B012aqXVPxEA99MjpIWVKhZfuX9chyRJaS5fy3YTK5OJ5JDzo6ZRIdp4D6R9mm+KEI
         1vDCa8WgwVyfsc/V937ewqxlvO0e6ZcLtsquWdNUfa6sP1/BSgVmp/30dmuWZsFApdEY
         q6RHNYhDc5CWoRYhj+18o/7iHPkh8igH+Vb126HD8zNx2o/NpHUYrljhNkQiv3WnITt2
         3Ip/AqGFE5gXsX2JateYHdgcNVAKjixgEca6tpUFU52DWuAcIllGyoxvFXIeQo+B7iYk
         /bYle+hkXm7Kx4WD9yyWS+w2k7922kUW0lkG30bq7Owmy1ByhtrBnZ0pDIwt34t5XDeG
         mn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Itna0pJ8txEtMM62Fa2uZtpKUMQobFyR2tYuBaeTUVI=;
        b=oL08loHrDroV7yCd+w8m6uV7uUtgthweR0VSitw2A6erkH8kk6AAXPH6wBQ3Hjebhh
         E/PMzpwX9LQ8JRrPl8Y7Jf04aKDcIjGKNc+8AzXwBEONej7cuA1d5l8IZNiP0AWbsTV7
         nDnn/zZmsI5UzxamefE+BiCvYMUkM+USJLs3pOiRIieX9vsxaFh/nIZiIb3X54l7+Uwr
         coXyWeyfc5A7UrBEyRiBvTuCShDtEiB/Yt6H4OzInjMvm6ljGSY5KoBoFLB24UgvOqjC
         m4Zrpd/kJEalPmNPuYzlPSgg5iZ42/nNr6yBhZAFCH/UFSH8ezHwL2N19MUCtp1ln2Z9
         9h5w==
X-Gm-Message-State: APjAAAX6mCWq+NJRhTUbqaj7HtMwhEcNeHABWeGH+SKdNzI6FQbsSNqZ
        tn0qOKdYMXDbv6SHO6kGMNphwyQHcok=
X-Google-Smtp-Source: APXvYqyhDvlNG8adSTwAMgJ6NMTJhARpqr+aGIvzDGqwEHrGG/k+0TUPhmtkxiazAzqZ/JlGPH5yiw==
X-Received: by 2002:a2e:9a03:: with SMTP id o3mr3189427lji.51.1569646736412;
        Fri, 27 Sep 2019 21:58:56 -0700 (PDT)
Received: from [192.168.1.5] ([109.252.54.49])
        by smtp.gmail.com with ESMTPSA id k13sm973536ljc.96.2019.09.27.21.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 21:58:54 -0700 (PDT)
Subject: Re: Btrfs wiki, add Parrot as production user
To:     Nicholas D Steeves <nsteeves@gmail.com>, dsterba@suse.cz,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtRtJ5LjO4vseJCP1zANF7dbjDtcsnoTTNs5YAmHt=NWRw@mail.gmail.com>
 <20190827124611.GG2752@twin.jikos.cz>
 <871rw1du17.fsf@DigitalMercury.dynalias.net>
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
Message-ID: <39b1aca0-3119-1611-10d4-f5b4003ca132@gmail.com>
Date:   Sat, 28 Sep 2019 07:58:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <871rw1du17.fsf@DigitalMercury.dynalias.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AkNdMPlDz8euLDTGkGwPjGi6BaqMMfO9S"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AkNdMPlDz8euLDTGkGwPjGi6BaqMMfO9S
Content-Type: multipart/mixed; boundary="BBJ8FjG9Pyi73SkkjQEOX3gtcztSV8yHa";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Nicholas D Steeves <nsteeves@gmail.com>, dsterba@suse.cz,
 Chris Murphy <lists@colorremedies.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <39b1aca0-3119-1611-10d4-f5b4003ca132@gmail.com>
Subject: Re: Btrfs wiki, add Parrot as production user
References: <CAJCQCtRtJ5LjO4vseJCP1zANF7dbjDtcsnoTTNs5YAmHt=NWRw@mail.gmail.com>
 <20190827124611.GG2752@twin.jikos.cz>
 <871rw1du17.fsf@DigitalMercury.dynalias.net>
In-Reply-To: <871rw1du17.fsf@DigitalMercury.dynalias.net>

--BBJ8FjG9Pyi73SkkjQEOX3gtcztSV8yHa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

28.09.2019 5:38, Nicholas D Steeves =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hi David,
>=20
> David Sterba <dsterba@suse.cz> writes:
>=20
>> On Mon, Aug 26, 2019 at 06:55:47PM -0600, Chris Murphy wrote:
>>> https://blog.parrotlinux.org/parrot-4-4-release-notes/
>>>
>>> Looks like they switched to Btrfs by default for / and /home.
>>>
>>> I think they should be listed on
>>> https://btrfs.wiki.kernel.org/index.php/Production_Users
>>
>> Added, thanks for the tip.
>=20
> If this is the criteria for Production Users, then NeptuneOS can also b=
e
> added.  This distribution was an early adopter who defaulted to btrfs
> since sometime around 2014, using linux-3.13.11.
>=20


Along the same lines all current SUSE distributions (both commercial SLE
and openSUSE Leap/Tumbleweed) default to root on btrfs (with
customizable subvolumes, snapshots and rollbacks) with transactional
updates as an installation option.


--BBJ8FjG9Pyi73SkkjQEOX3gtcztSV8yHa--

--AkNdMPlDz8euLDTGkGwPjGi6BaqMMfO9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXY7ojQAKCRBHosy62l33
jACRAJ9mq1m5yyAsPdqaOd1AysNMQ65N0ACggjYJiiCnqKATjUTA6CDbu5KXh40=
=CUgG
-----END PGP SIGNATURE-----

--AkNdMPlDz8euLDTGkGwPjGi6BaqMMfO9S--
