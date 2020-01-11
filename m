Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4747F137C15
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 08:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgAKHZz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 02:25:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36933 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAKHZy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 02:25:54 -0500
Received: by mail-lj1-f195.google.com with SMTP id o13so4482124ljg.4
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2020 23:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=FSf9P1ctCh+cvnODJR88EoPG9yXq3qgrzQlRAWa82CY=;
        b=U7/vPJR5qL4KnE3i/BRc/4tXIwLRAI2wPrTTttMVx/Bz1MX7z7WsfZzAcLNIYLXhNK
         JiAzsy8FA5aHn29v/uBGyc4oEwqFpOfRqpqR6/2BnnDTWwNEkNtwD9jwikYjDAiNk4Hq
         kpHTWuGkn6hzLt+ntINaeCpANOK+/T+IvQmMNZgcIAVUgFcfrn6RL15lWAOXVXI5rlJ7
         RHvwn3IRj6h1fBwhx1ZbDydrWSRggt2SI+vPMCE5gIpJ4d11qLbZUUn39QxpYdCxm23u
         SKJ+JrMG1XXuvx/h1gNvx0z/JyIGkQ3Tg2L415NINwRN/8vi8VY6YbpVNBprqAJFqYDj
         y7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=FSf9P1ctCh+cvnODJR88EoPG9yXq3qgrzQlRAWa82CY=;
        b=NoqK8zK+gVViwA+BIt7HLfTeRHjAASzbu4AMA3ZuuczPjnyQwhUgHRFANZ4zR9sprv
         BOmNR6vUjX1e7ksnSi2/96bxyPGETBxeaeWnq7rfaEgdDP49p/+mW49pUhHwvTZ/PE/C
         HkZNS91a/9FgMTn+x0+AzZlWG8eErSxNrx8BjIEsX5sDmdZSk0hh3fe1hHxnTX0AEFNU
         wLyQHC0weESdDgKXSATIIpIbxqTnr8t3oR0+q57qyZjwFTYDMR16a8dBzFUMU1yRP0ni
         Q5FvwBm3LS797M5H/9ELJaM0REDY7i8T2w78YUDnnninht3CMbtCBqUywyEL0bSRFzSC
         RTIA==
X-Gm-Message-State: APjAAAXy9c7hYRQzeGV9+egp2r8Ob0e9F8fP+vesmT1/AtEOh0iH+xnf
        DMOY4jyK1tmZuMx5sYvCB+klAwTuyG8=
X-Google-Smtp-Source: APXvYqxZ/76TcMGBVLlDWK9bPrSokp2iKerH0hmkOlXXL0EYhGJL7nAaQcArkRluZKu5bH2NuN19RA==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr5230110ljo.86.1578727551303;
        Fri, 10 Jan 2020 23:25:51 -0800 (PST)
Received: from ?IPv6:2a00:1370:812d:af15:a51e:b905:dd2b:45cf? ([2a00:1370:812d:af15:a51e:b905:dd2b:45cf])
        by smtp.gmail.com with ESMTPSA id c27sm2185529lfh.62.2020.01.10.23.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 23:25:50 -0800 (PST)
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christian Wimmer <telefonchris@icloud.com>
Cc:     Qu WenRuo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
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
Message-ID: <dc9eeda6-5ddf-c874-c377-703c83b95215@gmail.com>
Date:   Sat, 11 Jan 2020 10:25:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bd42525b-5eb7-a01d-b908-938cfd61de8c@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OfwPzgzm4Jkh6bDQKfogWSNglfseF4EOJ"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OfwPzgzm4Jkh6bDQKfogWSNglfseF4EOJ
Content-Type: multipart/mixed; boundary="mFS3gL6Ay9rsdbIYn7YfkYqkrHKS2HzKf"

--mFS3gL6Ay9rsdbIYn7YfkYqkrHKS2HzKf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

06.01.2020 02:50, Qu Wenruo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>=20
>=20
> On 2020/1/5 =E4=B8=8B=E5=8D=8810:17, Christian Wimmer wrote:
>> Hi Qu,
>>
>>
>>> On 5. Jan 2020, at 01:25, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>>
>>> On 2020/1/5 =E4=B8=8A=E5=8D=881:07, Christian Wimmer wrote:
>>>> Hi guys,=20
>>>>
>>>> I run again in a problem with my btrfs files system.
>>>> I start wondering if this filesystem type is right for my needs.
>>>> Could you please help me in recovering my 12TB partition?
>>>>
>>>> What happened?=20
>>>> -> This time I was just rebooting normally my virtual machine. I dis=
covered during the past days that the system hangs for some seconds so I =
thought it would be a good idea to reboot my SUSE Linux after 14 days of =
working. The machine powered off normally but when starting it run into m=
essages like the pasted ones.
>>>>
>>>> I immediately powered off again and started my Arch Linux where I ha=
ve btrfs-progs version 5.4 installed.
>>>> I tried one of the commands that you gave me in the past (restore) a=
nd I got following messages:
>>>>
>>>>
>>>> btrfs-progs-5.4]# ./btrfs restore -l /dev/sdb1
>>>> checksum verify failed on 3181912915968 found 000000A9 wanted 000000=
64
>>>> checksum verify failed on 3181912915968 found 00000071 wanted 000000=
66
>>>> checksum verify failed on 3181912915968 found 000000A9 wanted 000000=
64
>>>> bad tree block 3181912915968, bytenr mismatch, want=3D3181912915968,=
 have=3D4908658797358025935
>>>
>>> All these tree blocks are garbage. This doesn't look good at all.
>>>
>>> The weird found csum pattern make no sense at all.
>>>
>>> Are you using fstrim or discard mount option? If so, there could be s=
ome
>>> old bug causing the problem.
>>
>>
>> Seems that I am using fstrim (I did not know this, what is it?):
>>
>> BTW, sda2 is here my root partition which is practically the same conf=
iguration (just smaller) than the 12TB hard disc
>>
>> 2020-01-03T11:30:47.479028-03:00 linux-ze6w kernel: [1297857.324177] s=
da2: rw=3D2051, want=3D532656128, limit=3D419430400
>> 2020-01-03T11:30:47.479538-03:00 linux-ze6w kernel: [1297857.324658] B=
TRFS warning (device sda2): failed to trim 1 device(s), last error -5
>> 2020-01-03T11:30:48.376543-03:00 linux-ze6w fstrim[27910]: fstrim: /op=
t: FITRIM ioctl failed: Input/output error
>=20
> That's the cause. The older kernel had a bug where btrfs can trim
> unrelated data, causing data loss.
>=20
> And I'm afraid that bug trimmed some of your tree blocks, screwing up
> the whole fs.
>=20
>=20
>> 2020-01-03T11:30:48.378998-03:00 linux-ze6w kernel: [1297858.223675] a=
ttempt to access beyond end of device
>> 2020-01-03T11:30:48.379012-03:00 linux-ze6w kernel: [1297858.223677] s=
da2: rw=3D3, want=3D421570540, limit=3D419430400
>> 2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] a=
ttempt to access beyond end of device
>> 2020-01-03T11:30:48.379013-03:00 linux-ze6w kernel: [1297858.223678] s=
da2: rw=3D3, want=3D429959147, limit=3D419430400
>> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] a=
ttempt to access beyond end of device
>> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223679] s=
da2: rw=3D3, want=3D438347754, limit=3D419430400
>> 2020-01-03T11:30:48.379014-03:00 linux-ze6w kernel: [1297858.223680] a=
ttempt to access beyond end of device
>>
>> Could this be the problem?
>>
>>
>> Suse Kernel version is 4.12.14-lp151.28.13-default #1 SMP
> I can't find any source tag matching your version.=20

This is commit 3e458e04fab3ee8b0d234acf09db1d9279f356d9 of kernel-source.=


> So I can't be 100%
> sure about the bug, but that error message still shows the same symptom=
=2E
>=20
> I recommend to check updates about your distro.
>=20
> Thanks,
> Qu
>=20



--mFS3gL6Ay9rsdbIYn7YfkYqkrHKS2HzKf--

--OfwPzgzm4Jkh6bDQKfogWSNglfseF4EOJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTsPDUXSW5c6iqbJulHosy62l33jAUCXhl4dQAKCRBHosy62l33
jN/EAJ9hCr4vHDUMWrmXoVo/jBl/a1kZPACeKca6EwXQwifGpP2Gn4BfI2zd/xQ=
=aTbq
-----END PGP SIGNATURE-----

--OfwPzgzm4Jkh6bDQKfogWSNglfseF4EOJ--
