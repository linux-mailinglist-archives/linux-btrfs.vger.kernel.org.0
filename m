Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88E9C497FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 06:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfFREP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 00:15:59 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:42541 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFREP6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 00:15:58 -0400
Received: by mail-lf1-f44.google.com with SMTP id y13so8132017lfh.9
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2019 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=pVOQpFzcr+i5NPKk1md78FKl7+PlQ47Bst/DRW3YKc0=;
        b=IOxvW1UwvaxiENbJ8aJlMOyJh6N4ezv6RcPDIYtZHTrGwmXoBakUVBYA8waplc/vIq
         tnvqVI6yO/5rgI4Q+qFCj2p9geiPlpRiaFkm99bl12g5a2UcKslciuGS2KMFJ5i4TtgH
         5YwnbPEKIMjnKNMp8TvUKQPMbe1NUDOOkaChkSS+C4DnBo9JA/dtE39JPWRqobiIK40S
         WxpvntvDJkYLwx4wW16btFlbo/HszyK52FmQhGtwnrhrGZrTLD+LalJcXcR4or8C7iAU
         2s7yxsaYdnBxif4zMJ3VXhindLGSydVevZQ6pR+5SsJ8+8jk2SSqlPIxNKWF7ZJpEWQR
         X9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=pVOQpFzcr+i5NPKk1md78FKl7+PlQ47Bst/DRW3YKc0=;
        b=V91z1IpDgcC94+BP5V6nB9kB34mpWx/V+ozpFdPNVSS3phF/tkOKUaDQ1vIu57zJbe
         TXYe+7Iy3YMDoR20bhiQS8TmjyPfps/P8JDPHTSdQhz7JAHb2Q9mx5iWFJvKrZv/CZ8R
         abZXhF68b25/5ZNLi6SGVWQ+fyD0tHxk3AykfqJzTrjRKZX5fzefDqEFmZM0KrqmH/zx
         Kggp0yc10pH1FzrgGxKUPP2yDPWt8c2lXO6mPJMVtxAIEHZWoh2m16s5fpJa9gowh+az
         7ndC6mkxCa2opKDvklhMtvCR2kzg9dYRAtDC3Rv0nkCGUdVRxX5mjhBgvt0nFHk+8GPu
         1bhA==
X-Gm-Message-State: APjAAAUZ8saNiqIrSzkIqgEcMlsncf9szYNiCKGGvwsKkVvfV6RFoV+W
        2w4K1Zb+tQgoqhBMJkGr1tPmJQ5w+DY=
X-Google-Smtp-Source: APXvYqyOvvu6wpHA3L5DPDHMwFMvBxBzS8gw3z/2HBHZjRfrrI3iZkBjedZv7cwCPwSSfJFftpzzOg==
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr4812570lfo.181.1560831355752;
        Mon, 17 Jun 2019 21:15:55 -0700 (PDT)
Received: from [192.168.1.5] ([109.252.90.211])
        by smtp.gmail.com with ESMTPSA id 137sm2375985ljj.46.2019.06.17.21.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 21:15:54 -0700 (PDT)
Subject: Re: Issues with btrfs send/receive with parents
To:     Eric Mesa <eric@ericmesa.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
 <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
 <97541737.v72oTHCfnW@supermario.mushroomkingdom>
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
Message-ID: <52e0b712-2710-b3aa-3247-e2546020050b@gmail.com>
Date:   Tue, 18 Jun 2019 07:15:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <97541737.v72oTHCfnW@supermario.mushroomkingdom>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WwJRAHGswNEPMXbsgtmlHE0jhlBl8ShYo"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WwJRAHGswNEPMXbsgtmlHE0jhlBl8ShYo
Content-Type: multipart/mixed; boundary="GpTYjcTwNoRQAQCiwoyuQ4nRE9QPhaKCG";
 protected-headers="v1"
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: Eric Mesa <eric@ericmesa.com>
Cc: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <52e0b712-2710-b3aa-3247-e2546020050b@gmail.com>
Subject: Re: Issues with btrfs send/receive with parents
References: <3884539.zL6soEQT1V@supermario.mushroomkingdom>
 <2331470.mWhmLaHhuV@supermario.mushroomkingdom>
 <b2bba48e-a759-cb99-cf2c-04e89bce171e@gmail.com>
 <97541737.v72oTHCfnW@supermario.mushroomkingdom>
In-Reply-To: <97541737.v72oTHCfnW@supermario.mushroomkingdom>

--GpTYjcTwNoRQAQCiwoyuQ4nRE9QPhaKCG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

14.06.2019 0:22, Eric Mesa =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Thursday, June 13, 2019 2:26:10 AM EDT Andrei Borzenkov wrote:
>>
>> All your snapshots on source have the same received_uuid (I have no id=
ea
>> how is it possible). If received_uuid exists, it is sent to destinatio=
n
>> instead of subvolume UUID to identify matching snapshot. All your back=
up
>> sbapshots on destination also have the same received_uuid which is
>> matched against (received_)UUID of source subvolume. In this case
>> receive command takes the first found subvolume (probably the most
>> recent, i.e. with the smallest generation number). So you send
>> differential stream against one subvolume and this stream is applied t=
o
>> another subvolume which explains the error.
>=20
> Yup. Any idea of how to fix?=20
>=20


I do not think there is easy way to fix it for existing subvolumes. So
remove existing ones, and start replication from scratch making sure you
do not have duplicated received_uuid on either source or destination side=
s.


--GpTYjcTwNoRQAQCiwoyuQ4nRE9QPhaKCG--

--WwJRAHGswNEPMXbsgtmlHE0jhlBl8ShYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXQhldAAKCRBHosy62l33
jFXkAJ9rDcQjE17A/i1neeGecdkhZv6SFwCePDV5qk50CcBLTM6WQtGxqgo7pVI=
=KLu5
-----END PGP SIGNATURE-----

--WwJRAHGswNEPMXbsgtmlHE0jhlBl8ShYo--
