Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8274043B13A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 13:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhJZL3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 07:29:48 -0400
Received: from static.122.18.201.138.clients.your-server.de ([138.201.18.122]:44928
        "EHLO mail.render-wahnsinn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhJZL3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 07:29:47 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 07:29:46 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE6A28B191
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Oct 2021 13:18:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=render-wahnsinn.de;
        s=dkim; t=1635247120;
        h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
         references; bh=hyrpsjyR96xEnH/BO1I16A4ax2ZaMVaPg5XZubMrOsA=;
        b=M/Z26WUZXYllvBVgarsvN+uNYAJy0a1VZ4LKQd9ZEOGVzLxlVY7C1HpgXz0kVSJtBGXQ31
        cqPtDypMrsIchuuHl9230Km6FD8zn2zwC7E2o5FCijBuWN7M/wgymxVh8OWnjVbo11R++T
        Q/OuTxztHmFUyBnslpageFsVqXY93//zcF3T/3u7XsyuKH4j70dnw5FWnxiRwOLA51nriQ
        +887KQlLWM7gJXqS/KvEICv6Ug8tutifn44EIdfPNekiIDfzTvd3LjHqyJMZlkzdlJfc5a
        NjHeXV/INr0FF0e0vkMUOY6qL1VC7SP0zG+Lh2R0DeYTSgK8K44KJzGGhk5a9g==
Subject: Re: filesystem corrupt - error -117
To:     linux-btrfs@vger.kernel.org
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
 <654051a3-e069-a8bc-08a5-0fb5561144df@gmx.com>
From:   Robert Krig <robert.krig@render-wahnsinn.de>
Message-ID: <3b6d89c4-f9da-5966-0c61-dcea5f17d87c@render-wahnsinn.de>
Date:   Tue, 26 Oct 2021 13:18:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <654051a3-e069-a8bc-08a5-0fb5561144df@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d91W82mMusqS3V1XlSHRyXGmf2HQAY617"
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d91W82mMusqS3V1XlSHRyXGmf2HQAY617
Content-Type: multipart/mixed; boundary="Wg4okHyfVuMvDqGTOZUYodUO3SqSHzMBY";
 protected-headers="v1"
From: Robert Krig <robert.krig@render-wahnsinn.de>
To: linux-btrfs@vger.kernel.org
Message-ID: <3b6d89c4-f9da-5966-0c61-dcea5f17d87c@render-wahnsinn.de>
Subject: Re: filesystem corrupt - error -117
References: <em969af203-04e6-4eff-a115-1129ae853867@frystation>
 <em33e101b0-d634-48b5-8a32-45e295f48f16@rx2.rx-server.de>
 <c2941415-e32f-b31d-0bc2-911ede3717b7@gmx.com>
 <69109d24-efa7-b9d1-e1df-c79b3989e7bf@rx2.rx-server.de>
 <em0473d04b-06b0-43aa-91d6-1b0298103701@rx2.rx-server.de>
 <146cff2c-3081-7d03-04c8-4cc2b4ef6ff1@suse.com>
 <884d76d1-5836-9a91-a39b-41c37441e020@rx2.rx-server.de>
 <em6e5eb690-6dcd-482d-b4f2-1b940b6cb770@rx2.rx-server.de>
 <3ce1dd17-b574-abe3-d6cc-eb16f00117cc@rx2.rx-server.de>
 <em2512c4e9-1e5e-4aa0-b9fc-fb68891e615d@rx2.rx-server.de>
 <654051a3-e069-a8bc-08a5-0fb5561144df@gmx.com>
In-Reply-To: <654051a3-e069-a8bc-08a5-0fb5561144df@gmx.com>

--Wg4okHyfVuMvDqGTOZUYodUO3SqSHzMBY
Content-Type: multipart/mixed;
 boundary="------------F5F52BCC4109661F32CDC313"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F5F52BCC4109661F32CDC313
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

If you are on Debian 10, you can enable backports and install both a=20
kernel and btrfs-progs from backports. This would of course require a=20
reboot. Apart from that, this shouldn't conflict with any other=20
dependencies, unless you have something that explicitly relies on the=20
installed kernel version.



On 26.10.21 09:24, Qu Wenruo wrote:
>
>
> On 2021/10/26 14:03, Mia wrote:
>> Hi Qu,
>>
>> thanks for clarification.
>> So I should just ignore these errors for now?
>
> Yes, none of them is going to cause any direct problems.
>
>> What about these ones, you haven't mentioned:
>> bad metadata [342605463552, 342605479936) crossing stripe boundary
>
> This is the same, it just means it crosses 64K boundary, which is not
> supported for the incoming subpage support (using 4K page size on 64K
> page size systems).
>
>>
>> Problem with updating is that this is currently still Debian 10 and a
>> production environment and I don't know when it is possible to upgrade=

>> because of dependencies.
>
> OK, understood the situation now.
>
> Then I can't provide much helper as I'm not familiar with Debian...
>
> If not reproducible so far, I can only recommend for a memtest to rule
> out memory bitflip, which could also cause the bug.
>
> Thanks,
> Qu
>>
>> Regards
>> Mia
>>
>> ------ Originalnachricht ------
>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> An: "Mia" <9speysdx24@kr33.de>; "Qu Wenruo" <wqu@suse.com>;
>> linux-btrfs@vger.kernel.org
>> Gesendet: 26.10.2021 00:45:18
>> Betreff: Re: filesystem corrupt - error -117
>>
>>>
>>>
>>> On 2021/10/26 01:09, Mia wrote:
>>>> Hi Qu,
>>>>
>>>> sorry for the late reply. I tried the btrfs check again with arch
>>>> live cd:
>>>>
>>>> root@archiso ~ # uname -a
>>>> Linux archiso 5.11.16-arch1-1 #1 SMP PREEMPT Wed, 21 Apr 2021 17:22:=
13
>>>> +0000 x86_64 GNU/Linux
>>>> root@archiso ~ # btrfs --version
>>>> btrfs-progs v5.14.2
>>>>
>>>> https://gist.github.com/lynara/12dcfff870260b6bc35b9d1137921fc4
>>>
>>> OK, so the metadata problem is really there, but it shouldn't affect
>>> your fs right now, unless you want to mount it with 64K page size.
>>>
>>> And for the new error (inline file extent too large), it may cause
>>> problems, but under most cases, kernel can handle it without problem.=

>>>>
>>>> I'm still getting many errors.
>>>> Sorry I currently don't know what caused this. I suspect it might be=

>>>> Seafile since I'm now having a currupted library there.
>>>>
>>>> Should I use --repair?
>>>
>>> No, --repair won't help in this case.
>>>
>>> In fact, your fs is fine, no on-disk metadata problem yet.
>>>
>>> For your case, I can only recommend to use newer kernel to have bette=
r
>>> sanity check.
>>> Meanwhile I would also recommend to run a memtest to ensure it's not
>>> some memory problem causing the bug.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Regards
>>>> Mia
>>>>
>>>> ------ Originalnachricht ------
>>>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>> An: "Qu Wenruo" <wqu@suse.com>; "Mia" <9speysdx24@kr33.de>;
>>>> linux-btrfs@vger.kernel.org
>>>> Gesendet: 25.10.2021 13:18:54
>>>> Betreff: Re: filesystem corrupt - error -117
>>>>
>>>>>
>>>>>
>>>>> On 2021/10/25 19:14, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/10/25 19:13, Mia wrote:
>>>>>>> Hi Qu,
>>>>>>>
>>>>>>> thanks for your response.
>>>>>>> Here the output of btrfs check:
>>>>>>> https://gist.github.com/lynara/1c613f7ec9448600f643a59d22c1efb2
>>>>>>
>>>>>> Unfortunately it's not full, and it's using an old btrfs-progs
>>>>>> which can
>>>>>> cause false alert.
>>>>>
>>>>> My bad, gist is folding the output.
>>>>>
>>>>> It shows no corruption for the extent tree, thus I guess the
>>>>> transaction
>>>>> abort has prevented COW from being broken.
>>>>>
>>>>>>
>>>>>> Please use latest btrfs-progs v5.14.2 to re-check.
>>>>>
>>>>> In that case, a newer btrfs-progs is only going to remove the false=

>>>>> alerts.
>>>>>
>>>>> Any clue on the workload causing the abort?
>>>>>
>>>>> For now, I can only recommend to use newer kernel (v5.10+ I=20
>>>>> guess?) to
>>>>> see if you can reproduce the problem.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Mia
>>>>>>>
>>>>>>> ------ Originalnachricht ------
>>>>>>> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
>>>>>>> An: "Mia" <9speysdx24@kr33.de>; linux-btrfs@vger.kernel.org
>>>>>>> Gesendet: 25.10.2021 12:55:46
>>>>>>> Betreff: Re: filesystem corrupt - error -117
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021/10/25 18:53, Qu Wenruo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2021/10/25 16:46, Mia wrote:
>>>>>>>>>> Hello,
>>>>>>>>>> I need support since my root filesystem just went readonly :(
>>>>>>>>>>
>>>>>>>>>> [641955.981560] BTRFS error (device sda3): tree block=20
>>>>>>>>>> 342685007872
>>>>>>>>>> owner
>>>>>>>>>> 7 already locked by pid=3D8099, extent tree corruption detecte=
d
>>>>>>>>>
>>>>>>>>> This line explains itself.
>>>>>>>>>
>>>>>>>>> Your extent tree is no corrupted, thus it allocated a new tree
>>>>>>>>> block
>>>>>>>>
>>>>>>>> I missed the "w" for the word "now"...
>>>>>>>>
>>>>>>>>> which is in fact already hold by other tree.
>>>>>>>>>
>>>>>>>>> This means your metadata is no longer protected properly by COW=
=2E
>>>>>>>>>
>>>>>>>>> "btrfs check" is highly recommended to expose the root cause.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> root@rx1 ~ # btrfs fi show
>>>>>>>>>> Label: none=C2=A0 uuid: 21306973-6bf3-4877-9543-633d472dcb46
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 189.12G=
iB
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 size 319.00=
GiB used 199.08GiB path /dev/sda3
>>>>>>>>>>
>>>>>>>>>> root@rx1 ~ # btrfs fi df /
>>>>>>>>>> Data, single: total=3D194.89GiB, used=3D187.46GiB
>>>>>>>>>> System, single: total=3D32.00MiB, used=3D48.00KiB
>>>>>>>>>> Metadata, single: total=3D4.16GiB, used=3D1.65GiB
>>>>>>>>>> GlobalReserve, single: total=3D380.45MiB, used=3D0.00B
>>>>>>>>>>
>>>>>>>>>> root@rx1 ~ # btrfs --version
>>>>>>>>>> :(
>>>>>>>>>> btrfs-progs v4.20.1
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> root@rx1 ~ # uname -a
>>>>>>>>>> Linux rx1 4.19.0-17-amd64 #1 SMP Debian 4.19.194-3 (2021-07-18=
)
>>>>>>>>>> x86_64
>>>>>>>>>> GNU/Linux
>>>>>>>>>
>>>>>>>>> This is a little old for btrfs, but I don't think that's the=20
>>>>>>>>> cause.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hope someone can help.
>>>>>>>>>> Regrads
>>>>>>>>>> Mia
>>>>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>

--------------F5F52BCC4109661F32CDC313
Content-Type: application/pgp-keys;
 name="OpenPGP_0x9C4BEBAEAE29D145.asc"
Content-Transfer-Encoding: quoted-printable
Content-Description: OpenPGP public key
Content-Disposition: attachment;
 filename="OpenPGP_0x9C4BEBAEAE29D145.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDiBEQs8ngRBADxnMYyyi39PcZptDdfgekIjeHFO90mA5nfBI4u2eRZO5N6+P+kaU77XUzl2=
TlP
QVTC0XymxRFfECaza3/wqoe1cYlHkQGS8XvFOmh5HG/Nfk5YvHpOA9AWpFpiOfOmtqcyu1q6d=
Lt+
r2D0Z2SxXfuvMTxlbOV4/wHbSke9u/lHxwCgnG1F6d6M7J58o1WP0bPf1Ev61ukD/3PrrnWJO=
1zk
Gjh+3Ti0nw2TDsepLjixOO2zKMu9tDlCjg9Z25VQ+mntJ2FulXcy+QIQypLkzucjzftu9h89r=
EdS
MW47uHNnpzu3e/sYyou5i6RoeLLA2rv4GBmL4gHFKFikbEpETWu2S4FkvoWEO0mtp8MF5nW+p=
VAd
5WPfSshoA/4r794mryK9OLj8vFVsG+Zj0yS7mhVkuh9c77tMCVPDukVsGPGE/zc5iTDIO/IlX=
TX4
JhPZNi2HJsjzm+Vm1qIH4nCfaR+/Rt3GSERydn/BZ/Lk8vTZSwfIHdNZ48OZ/ufjgydH4VGUp=
wAr
HS+3PTqAc52U1aHjCRBCOzbhTod3Dc0sUm9iZXJ0IEtyaWcgPHJvYmVydC5rcmlnQHJlbmRlc=
i13
YWhuc2lubi5kZT7CYwQTEQIAIwIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheABQJNXk6lAhkBA=
AoJ
EJxL666uKdFFD1kAn2LIfGRO82TtgGj+aJ2xO0BG9K2OAJ97xl0OUXizEZcks/yVv0E3VSjTD=
sJg
BBMRAgAgBQJLHmW/AhsDBgsJCAcDAgQVAggDBBYCAwECHgECF4AACgkQnEvrrq4p0UX7mACdE=
MaV
S7DqRYoSEL5z5b8nPAjMf3cAnRXjFGunI1oEMSEqJac/CsPLuSyxwmAEExECACAFAkseZdACG=
wMG
CwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRCcS+uurinRRVugAJ4kAq4mofwY1OZvTDvNyK/XH=
N/9
MgCfSP1xNHi27KTLXvK9uwWW9U4ZXLfNJlJvYmVydCBLcmlnIChEZXIgQWRtaW4pIDxya3JpZ=
0Bn
bXguZGU+wmAEExECACAFAkQs8ngCGwMGCwkIBwMCBBUCCAMEFgIDAQIeAQIXgAAKCRCcS+uur=
inR
RdKUAJ9YA1UMThuUhaUjXUvHaD1vpq4GrwCbBcOpa4zDc8ojYBDd9D3p4ud+EkbCYAQTEQIAI=
AIb
AwYLCQgHAwIEFQIIAwQWAgMBAh4BAheABQJNXk6lAAoJEJxL666uKdFFRMUAnj9B/upckb2ov=
k5m
hKpvE5G65BRMAJ9zI6TSLnVIgyj663X+LEH7WovNP8JjBBMRAgAjAhsDBgsJCAcDAgQVAggDB=
BYC
AwECHgECF4AFAkiZaQcCGQEACgkQnEvrrq4p0UXKtgCeM+0CF04/PqWcHVJ0mLbOe7nHogMAn=
02p
kVJ0XZqaTX/aGfunqQM239OCzSFSb2JlcnQgS3JpZyA8cm9iZXJ0QGJpdGNhc3Rlci5kZT7CY=
gQT
EQIAIgUCTV5OtgIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQnEvrrq4p0UVY5QCfW=
LTN
vFss2yA2dwlR2lGV0BVYfwEAoJh8d05YTT8uR/rXnpYOZkf9PA+VzSdSb2JlcnQgS3JpZyA8c=
m9i
ZXJ0LmtyaWdAdmllcm1hbWVudC5kZT7CSQQwEQIACQUCSx5mIwIdAAAKCRCcS+uurinRRc3rA=
KCS
DJKuploSp6hx+F490pKOD5duRwCdF5Btv1AuvLboLxQQttYaCwzbJhHCYQQTEQIAIQUCSJlpb=
gIb
AwcLCQgHAwIBBBUCCAMEFgIDAQIeAQIXgAAKCRCcS+uurinRRZYdAJ97DvO85Y3Mmy1VKqsbT=
v/C
+ud5AwCeK2+ya8iu5ZE/2r27crz66bxEmITNKVJvYmVydCBLcmlnIChEZXIgQWRtaW4pIDxya=
zJA
Y2hhaXJvcy5jb20+wkkEMBECAAkFAkseZh4CHQAACgkQnEvrrq4p0UUm3ACeKI2rj8mv014qY=
MHh
QT8MVDpTIdYAniEe+4vx70KOZOEvajVrv/E6j8+0wmAEExECACAFAkQs9JcCGwMGCwkIBwMCB=
BUC
CAMEFgIDAQIeAQIXgAAKCRCcS+uurinRRffqAJ0VOmF3t1hMsehpnPdcgTtIoLxFTgCdG5hs6=
A65
f3JoUCIU1Jg4v1AU/X/NMFJvYmVydCBLcmlnIChEZXIgQWRtaW4pIDxya0BtYXRlcm5pc2llY=
npl
aG4uY29tPsJJBDARAgAJBQJLHmYXAh0AAAoJEJxL666uKdFFAk8AnRsODatI1jswm5ZeK1R4U=
EwG
U6ffAKCH0kCPYF4ptb5n1zGiO/nZOmh6rcJgBBMRAgAgBQJELPT2AhsDBgsJCAcDAgQVAggDB=
BYC
AwECHgECF4AACgkQnEvrrq4p0UVjEQCfcPkwDqLNoIsrW7xEmXorh8VNWP8AoINW+n585YBYR=
4Hu
wNWc4z0L4V06zTBSb2JlcnQgS3JpZyA8cm9iZXJ0LmtyaWdAY29ycG9yYXRlLWNvbmNpZXJnZ=
S5k
ZT7CSQQwEQIACQUCTV5OlgIdAAAKCRCcS+uurinRRfd4AJoCZIErH/TcQ134Tbe3T39VfFMh0=
ACe
MLU+mXGA9/9iuihknwy1+w0W0gTCYAQTEQIAIAUCSx5mNQIbAwYLCQgHAwIEFQIIAwQWAgMBA=
h4B
AheAAAoJEJxL666uKdFFTC8An3BaNU2V3TEOyD+Js1DPqes3YHyQAJwLfEsVhz4xwgBB4XdNg=
zza
jTVGqc0xUm9iZXJ0IEtyaWcgKERlciBBZG1pbikgPHJvYmVydC5rcmlnQGNoYWlyb3MuY29tP=
sJJ
BDARAgAJBQJLHmYSAh0AAAoJEJxL666uKdFFWSIAni6FIOtTdRiyecztG3k/t8XH19vvAJ9vS=
zxi
urq5vP54ASN1ldM4BP9p88JgBBMRAgAgBQJELPr3AhsDBgsJCAcDAgQVAggDBBYCAwECHgECF=
4AA
CgkQnEvrrq4p0UXbLgCeJP5aVGPOlIU3guGHifP+YAK06ngAniZvMhmQCffZK+Nsef5I3a7ri=
fmF
zTNSb2JlcnQgS3JpZyAoRGVyIEFkbWluKSA8cm9iZXJ0LmtyaWdAdmllcm1hbWVudC5kZT7CS=
QQw
EQIACQUCSx5mDQIdAAAKCRCcS+uurinRRVJGAJ0R0yk7Vma61aWd7pH8/KwtmoURrwCeL53SZ=
W0H
P3tc5fytAWuHJ88TM9HCYAQTEQIAIAUCSKlrpAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAA=
AoJ
EJxL666uKdFF9psAnROMX0rGMagTAqivBIWlBHckLee3AKCYKCOBfHrPWcVVJp2HtJwWTCdYC=
M05
Um9iZXJ0IEtyaWcgKERlciBBZG1pbikgPHJvYmVydC5rcmlnQG1hdGVybmlzaWViemVobi5jb=
20+
wkkEMBECAAkFAkseZgcCHQAACgkQnEvrrq4p0UWK2QCdGz2ka8en02mIwrAwqpKIzxGH2EoAn=
3K5
6B0b9zHam1amdtaD0tr3wvp7wmAEExECACAFAkVa+c4CGwMGCwkIBwMCBBUCCAMEFgIDAQIeA=
QIX
gAAKCRCcS+uurinRRZGrAJ4p94NLPwq0WB3qLS+tYYD5huVezACdGiOQ2Z3wr2ySaFFWXZ3Jl=
WWy
LLDR/wAAOrr/AAA6tQEQAAEBAAAAAAAAAAAAAAAA/9j/4AAQSkZJRgABAQEASABIAAD/2wBDA=
BIM
DhAOCxIQDxAUExIVGy0dGxkZGzcoKiEtQjpFREA6Pz5IUWhYSE1iTj4/WntcYmtvdHZ0RleAi=
X9x
iGhydHD/2wBDARMUFBsYGzUdHTVwSz9LcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwcHBwc=
HBw
cHBwcHBwcHBwcHBwcHBwcHD/wAARCAHgAV0DAREAAhEBAxEB/8QAGwAAAgMBAQEAAAAAAAAAA=
AAA
AgMBBAUABgf/xAA5EAABBAEDAgUCAwgCAgIDAAABAAIDESEEEjFBUQUTImFxMoEGFJEjQlKhs=
cHR
8DPhFWIk8TRTcv/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/=
9oA
DAMBAAIRAxEAPwDx4k6ICEiCRIehKCxpp3NlaQ4oPYeFzh8bT3QawNoCCAqQThB1oFSPQLYLO=
UFh
jKHugOkE0grzOdupoH3QM07iRkZQOQSghzbbSClMxzTjBQdHqKw7CAXz7DYOEBOmEkdg5QdG9=
xbj
lAiZ8x4tBnaszBv1kFBUf55j9SCjJKWnPKBYmJtBUlNklBXegSfqCB78MAQTpxyUBPQIegmDg=
oGO
QJegKBBEyBLUDAgUg5BLclA1gcHhB6DwzV+VtaSg9PpZg8DNoLYyEEuQCgVJMG4tAkuc9wQWo=
W8I
HgIJpBKCu+g/KAofqQPQTSDqQQ9gcKKCnPpetIM/UQyMBIOEFVmsETyHILOm1rS7rSC0/WRhp=
PCD
E1PiDHaja3Pug7Uatoi+yDFlfucSghophKCu8oEvQLGXhA6TikDIRUaCHFAh6AoeEBuQJegmD=
qgi
ZApqBgQTq4vKmcBx0QJKBunGeEF4RU26soEulMTvdBu+DeIOcA03hB6jTy72AoHOQKkLqoIEN=
iJN
lA4R7aQWIggYglBKBGoaCCgKBtAoHIJQcglAEpphQZmpD32AMIMiXRl81uCDV0miaI6DeiCr4=
loz
5Z22g881gilO/ogjUytc2ggphptA1+I6QVXIEuQDHmRA2TkBA5opgQLegQ9AyH6UBOQJegKBA=
M6B
TUDAgt+IsvIzlBn+yDR0UFgFBptgAZ9kFebTR3bggfpJo4SKAQbEHisbRVhBY/8ALx/xBAJ8V=
jP7
wQE3xSPuEBjxOM9UDGeJR/xBAQ8Tj/iQEPEo/wCJBI8Rj/iCDna+Mg2bQSzXxgYIAQGPEI/4g=
gn/
AMgz+IIJGvZ/EEE/n2fxBBx1sZFbggB2oiI5CCq+WMyWSEF2HUMY3BCBGs1MRaQSEHmdd5bnO=
LUG
XXqtBJ5CCJTwEFdyBLkHQ/WgY7Lwge7ApAp6Cu9A2L6UEuQKegmDqgidApqBgQaUrC4EkIKUk=
Pqs
BBe0fpaPlBdfJtH2QVpJNwKCk+7wUAU7oUBiKYixaCCycYygZDFM52SUGhFp3bcuN/KAdRDK0=
W1x
QUHv1LXfU5BH5jUj95yCfzOp/icg09BJK+I7ySgPWSyxwekkEIMv89qf4ign8/qgfqKDh4jqe=
5QS
PEtTfKBjPEJzgyFjvcYQEzXaoybXH7oLDdVKDd2gfNrpWuLGvuuaHVBVe6aUE7yT2QRpX/tg2=
Ubm
O9JCBc8TtPMY3/IPcdCgW3P2NoFy5cgQ5Al6AoBkoGNzIga9Al6BL+UDo/oCDnIEvQFB1QROg=
S3l
AwIPUS6UFtAIKE+lI4BQBENhyED5CHNPwgpy20FBQdKd6B+nfbhaDa0zWOYKQS/TAuukBCMNO=
AgM
GqQMLQ4IK82naWkgIK3kBBHkBBb0LNsm3ogZ4jHbR7oM/wAgdkE/liaoIGN0O8eggu7HCAfyT=
mn1
xuFdwgsDw5r2Nc0jdV/ZBAiDG7HtAPQ90BRxx7xY3DqAc/KABC1r3He127KAzAW0Q011A4KA3=
6aO
ZwfC7BOC7p7FBGqg83TmJ7KmhPpN8t6j+6CgWbWE9UFN/VAo8X1QLcLH90BQige6BkQ9aAnoF=
PQI
fygfH9IQc5Al6AoOEET8IEtQMFoPZXlBDmNcgqTaUEkhBUkjewHCCtN6sIK0el3SIGSQFjbrh=
BY0
WoLXUUGzE8OCBcmHIEOfTkFmM2EBSD0IK+w8kHKCKQOgGx+51AfKBmqliexpDxz1KCg/VNaS0=
Xu7
GsoIbrwwt3R1WLqkFhusD6ywO6WLv7oHySuMbLFMeKxyPj/CCGTbXbnEBw4eOqBeomEjHMeBu=
HB/
ugQZSS0AltD+aA8yNNkO9wgtadsm3dFkirB/eHYoGSRiMOmiIBdkx3x7/wC90AgmYtc1pzmuf=
sEF
HxFjWOIZ9JFi0GTIPdADm4AOMWUCnNc91NBPRA9kYjYctLkHRCrKCHIFOQJdygsM+kIIcgS9A=
UHB
QROgS1AwcIPZEZKCEEhALomvGQgpz6QchBVEZiN0gGUhzaQVAwtfYKDS08xaAgs+a1wQQIy4j=
CC5
FEALKCZAKQLMoYK3AD34QV5NVpxZDA4+wNIKs2sDxW0AIKznsd++AOecII8tjsscT3DXcIC/K=
OLf
Q5pIHwgZHE0Yog9rQWY5iw+W9xpwANoOIYDbHt33TmHgoOc1sjgG211VR/sgX5XQggtzXt7ID=
je+
N3ILje4Hqg0dO5u4Pa7YCKI6EfPsgfMwxtJaY3FuC1v7w7oKQcIJjg1t3Ajn2/ogra4tdRvdn=
IPZ
BRkja04sX/NBzovSKGfhAuQVy3+SBf7pLRn3CAmghp3BAlyBT0Cj9QQWG/SEEOQJegKBBE6BL=
UDB
wg9kg4oOQcg7nlAD4WvHCCnNpKsgIKkkDm9EENB4QWdNGS4Wg14YBtCBxDWdz8ZQVdXW22mj3=
QZc
+pwG7g4+6Co6SUmtodYQA6VodT2FpKDhLEaOxrzfUIDDtLvPpLHdgf6WgKqzFMN38JFFAk6i3=
VJh
wPKC5Fq3EbH+oHAvogJ7o5oy66IGSEBRvdbadePSSga2pCLw4fTf+UA6kHeXNFODtrv/AOkDN=
K4O
fcb9rwfp790Gp6ZIx6gPTQAw684/3ugzpfMhtgdcMh9N831+EFZ4LYvMOQDQcgRLOKO2jfNhA=
tkh
vHCBzSXGjkfCBoYwCwwDGaFIFamJhZubi/ZBnSCigQ9Av95BZH0oAcgU9AcHCAZ0CAgaDhB7A=
nJQ
daCbQdaCCcoODqQEHAhAL4muHCCi9rWvIQMjcAccoL0M4I2k0fcIK2q1IaSN9+6ChNPux5hr3=
CCs
NruHC+6BD2hv72T8oBdI8AVlvVBAka7GwUe2EEjOKDvbqgEhpA5b/vZAEhd+96h3GUHRTEEAn=
4cg
sCUgkh4JOSAgtR/8XmAHyyaOeCgtQFzofTl7ff8AkUDz5crA8mt7acR0P9/+0C2A7rFNLhWco=
Oml
lZTyAAXEEnqRSAdRrP2lbtwLdzTSCtHqBIyVhA9Q3ADAsHsggM3M3PY1rQaNXgoJa3Ya2VfBB=
QQ5
5a3af5oCZJQzj4tA5jyfpF9iCgo6mI0XCvjikFF6BbcyBBZQA5Ap6A4OEAz8IEBAxvCD1Euo/=
aYp
BLtSA3ogWNXQwgX+cN90Efm3Od2QMfM8tQRBI4n1EhBaLw1uSbQZsz/XgoBY9zjVgIHh2xvqk=
x90
FdzmvdVuA6HhBXft6NB98oAEgF3wRSCXU4ANIN+1IFkj95td0HM8skBx231QT5dG2n/pAw+sA=
Obn
36oA8sOpoJa734QV5Ii00RRQCy2kHoEFvS6gh3llwDXYF8f7/lBpwOoeY36mktcKx/tILcjWm=
Rzn
O2skbR29HdP97EoEQvqXySA51mh3PZBX1Gs3tMEm7byw1kdrQZz5SSDwR7oJhOD7455QaOnFh=
gYW
kN5IQP3NLHtAa2Rgog3Rrr/VAppMbtrmWD+6cj7IOf5cUlM+hwsOGP5IGM2uacFoHWrpArVRu=
LeN
x7coMmZoBOAECWZkQWEAOQKegODhAM/CBA5QMHCDfeyzZQCWWggRgII8sICaxoQNJbSAQ+jhB=
LpC
QgruZuNlBLIgx1gFx+EATShpzV/7hAjznHLW19kAhznfULHsg58THDcLH2pAOwNxYcPlBDhgX=
ZHY
oBj8ogsJcD/vRAstfGbabHRATZ3D68g9EEmbm0DGlso2PHPCBToXMftJsdECstODSDb8Pna9x=
30T
IAXWEF3SkOa+NxNONGs1XX7IKuobFG4NfG9kjSKka8VfxX90Gfqpd8nmXdnt/ZADGNc7eBvOc=
EEI
FBrtxB9JHQ4QXdPFJ9QaSB+9H6gPcoLkjgcHBIzi7+PZADA50ZBLSW/cHsgGMNewlldyDn/Qg=
Ze4
0Cciq7ILDGuLA5oBA+oXlBS8T0wB3C6OSQUGO1u2QiwfcIHoAcgS9AyDhAM6CuOUDRkIPSFhK=
CPK
cg7yigjynIO8koO8koO8goO8koIDAzJv57IK8+qIZTfS09R1+6CkZXONgADugF0g53En34QKM=
hB5
FoBM7+j0HBz3WKNdQgMeYTW3HdBB3k+pgcg7c/pfweEEEFwIdgoBLnNG14PseqAo3eoNPHQhA=
50g
NWg58bSQWij2QMgtjWuBALHYxzfRBdjmLJGlzvTIASTwCgLUyN1GmI3EGN/U9Dj/AAgoRemQ+=
YGD
OLzn4QOkjaHtEdlw6A5v390HStYGNBcLNmqvbnFoAhOx+6I5rhqCy57JI2gCiMB3T49kHMrGM=
dig
50AafRuLT0pB0JAcMgdig0NO9rXgOb6hygZq4muYfUKv5CDzupjdFqS1wbXIIQCUAOQKegODh=
BE/
CCsEDW8IPYiMIJ8sIJ8sII8sIO8sIJ2BB2wIAkAaLon2AQZOskNndwOG9EGc9/mSW+6HRAt5L=
nWf
sBwEA7S88j7lAYhI5dXwgMgdya7oILQavP3QdjjA+Qgg0DgkfdAJOfUP5IBP6fCAmkFtB1Hsg=
JzG
F+MYB44QdIKAxzygloNUSfZAQdg/xIGnUOLdpFt+n7IAdN5bnULBFEHqEBMlHlulY3LRRrsgQ=
+R2
0GvSW5/37IGskcGi3cc56oGQP2yNLm7TyCM/flAcu4PcXEDdkFvBKBkJcKsggjgoLsMjCWNkH=
PBv
HwgObSsjLywE7iDVYCAtONxawgiuMXhBa/aRM2+l0bsZGKQYmuia2VwDHNaDna4OAKCk6umUC=
3IF
PQHBwgifhBWCBreMoPbBBKDqQdSDqQdSDumUFLxDUeWzay7Ptwgw9RKXHt90FaiUEgfCDroYF=
ICG
8mxlBxfRILaPygEkHgkX0KACXDgmkAB2RdEfHCDi4DuPugkOvIP6oGel7rIpx9kDKzk+4KCaw=
AQE
Eln0kcUgIRkV8oILDXCBRb390ARWJPlBMjdpBs7a7oIjt8gaTtvACCxI3y5A11AdCeCgv6Isl=
dsD
hfA3BAzY00HN2O3011V1PP3/AKoJLWtkc4MHsAUD4XFgG1xLdvH/ANoGizIHxubXO12P59EGv=
oZG
FoJDXNr1NJBKDD/EOhbp5hIyQbTgZ4HRBhFADkCXoGwfSgGbhBWCBjeEHt0EoJQcg5ByBOol8=
tuB
bjwEGDrZHveQ53+EFJxAx1QGQKGPmkAg85x8IJtoy1ov4QA57gLoj7IBMruD6h7oALgelIOtw=
rGO
9oI3d2hBIc3t9igINaeAfsgYyJ5Hoaf0QGwkAtOQeiB8TA9pLeByCUDmQgjmj2QG6PcRihWPl=
AJi
NZGECnwHkhAh7CLoeyBYaN7W8i85/VADWtY8OLfQ44yge65GBjyCbNeyB+htj7AF9j1vhBd1B=
kky
x24VdONUgY5+8B0ZAutzmjg9SgcajaW8vHc1X+4/VA1rhLF5kjQHs424P3/ygveHta+iKskWO=
pP+
/qg7xvStOkd5jd0YB2uBy09MIPGu5wgW5AqRAyD6SgGbhBW6oGN4Qe2CCbQTaDkHWg60FbWOA=
YT1
pB56e3OPQFAjbZoIG7LNmwfhABjcD3+EAWRgYQBuIvP6oIPyEHCMdHC0BD043X8hB1j2PyEEY=
7AI
ILnDh1fCAmFx/eP6oGxkF2T+qC1HHbvT90F2EUQw2expAzZRo8dCgPygc/yQLkjsZwEFaSP2p=
BTf
FRLuEHN2uaxpvaMV/dAxjGkljwRt4dfZBwcT6Wm23ZCC7DAdu/JjkacdQgdCxkbnPLttAEFxo=
P8A
+/8AKAiQWlzm7mjB7hAyB8ZjBa8vvAFZHf5Qamnh2tL9jgSfqH90GnK06nRuaxrXNc3gjn2Qf=
P8A
WRiOd7ReDRDuUFV3KBT0DIPpQRNwgq9UBt4Qe1CCbQTaAXvDQgX546FAbX3yUC9WWiMk490GB=
IA5
1/Szt3QDuLMB1+yAXkVZOECi4DIFn5QDe7kEIO9PFu+5QdtAOP8ACCDtrt90A3XBI+6Di9wQD=
uvk
Wg7HZAbc12QWGN6gf1QX9K0irbfuEFyKPd8YNIGllnGUBbaQLe0FBXkbYQV5I7BQVHsIv/KCx=
pIt
8rS6gSLPS6KANQ0CTzY2hocbLRwD7INDTagMiaXUN2HYvjqEFgRsmcSBuY8HB5HweqCIA0tDG=
2B2
cbP/AGKKAmw00tALXg3hBp+GufvBccgZvCDZ0vpLhhzH0SB+7fCDwv4haGeJSNAwDQPcIMkoF=
PQM
g+lBE3BQVeqA2oPaBBN0gTJKGnlBWmmJbhBVbI8PQX4X2Agr+ITWAwG/hBmzEk0Me6Cs+yaBp=
ALb
vFlBO0nmwPlBxIHAN+6BbnG6v9EEWeCUEV3QE3YOUBYPHRBFXi0HBreKFoDY0E4BQaOmj4s0g=
uMb
yGDPUoLEQAbV/J90DWj0oIIz7IBcL6IEvHZAl8div5IK8sY312HKDmbw5pIIoUKHDUDI3DyA2=
/UT
6Rffg/rhA6NrC2RjSGPGS01RKAtOdpEZa5kjeAD15QXZy143MtjwLIHTF0PbJ/0oG6OT8y9ge=
za8
cOHUdkF10RicaFsrcev+hBf0wJJjfZxQPX5QeX/FuneNSydzGjcNpLepQecdygU9AyD6UETcI=
KnV
AY4Qe0CBc79rUFB8hJQcJB1QQ8tIwgASubjogja51ud1QIlzY5KCvssZQcBV0gF7cXWfdAvbf=
P8A
RBG0A/KDiK7D7oA61ygmscEIIPPdATWlx5sdgEFhkBsU0/dBdg0tmzgoLccIGG8da5QWAwAC8=
DsE
BcjGEBDDUHDj3QTV8oFuYLQKewuGOUCfJAu7LigW5pL6vpVoAkELnNaS5oa3acZvugsxNZI/f=
G6n
x7STVFxzf8ggtMj86IPZZDQccGuqBLWve3y3A7mH0nglBZ0Ty1jjIbLSMDnPdBsabVMno0LI4=
I7e
6C8BteXxkgDgdQg8r+KzI3VMa9wc1w3Nc3hB5tyBT0DIPpQRNwgqnlAQQeiGtzygiacuCBIdY=
QLN
2gkupATXDqgYSHR0OeSewQIcyw68D+qBLmuceyB8cIDa22eST0QKlAJxR7GsfZAosdZAFDuUE=
GEn
mx8jJQB5Y6Z9zwgGg00TZQQQ57qaCe2ED4tFI/kIL8WhDQAgsRQNBIAQP8rcNoNDrSBjWBooB=
AVW
g6kE4pBDeUBEfZAIbaDtgCADHZQVpW0/CClI0uk/kgttuHy3sIG4Efav+0FnS6j8vO2jTCakx=
xf+
g/dBcYGx6u3Brxuqx07H/eyAvyf7R8sIaZG4c3jcCguaCOMBryaNG6HI6j9P6INKnDZIx4c0D=
lv8
7QeS/FQa3UDbJe425h4v+If39wg865Ap6BsH0oBm4KCoeUBDhBoN+sZQW6tqCMAIAeeyAQb5Q=
Fyg
YwGqQG6MkCiSEARx3KB05KC3MwRxgVb3ZDf7lAMWjef2jhtPQnp8IBmYyBt0B7lBRc4ufk455=
5/6
QQIHyEEHa3vWPsgsReHiwTf3QXIdI1l45QWGRBvRAfloJbHQ+UBhqCUA11tBACCQ3KAqCDigg=
III
NZQcBhBW1AFHHKCiRcg7HCBxy2Eht7R/dBbnY7zQ8NBG0XXbhBfaI3xebtA9OT2d2+KQX9PI2=
SQt
YBI5g9JrLggY3bIfKbYFWN3uMUgQJXwvG/FGg4dD8IMv8VaVkwZqIjTw07mdMIPKOQKegbD9K=
AZu
EFQ/UgIfCC0XG8ILEU5OCgNzkBAYQcG2UHVRQOF1hA8sIiaN3KA9HGN5JF136lBdhgF73CySg=
jUP
EbHFxpoQZb2y6p+8t2s4A/3qgtRaJoFuaL/h6fc9UD2wi7QSGIDa3ugZtpB21BKCCEHUgikHF=
BF5
QRlB3sgJoQSUEDOEFedmOyChw/1Y7FBZ07bxINtH6hmuxQaOmAlth2tNek++MIC052Nmh1Dtr=
T6X
Acg9HD+6C1oWU4VRc00f6V/v9kFgPa2cRlodE71Md0zzfcf0QOnja1gkAsjuOfn/ACgxvxJ6t=
Ax8
bXFj+RXDkHj3coFPQOi+hAMvCCmeUBBBcpBwBBsBA5pJ5QPH0oIukEtBcbQWIGFyCzG0eYAeu=
UFv
QMa9r3EXZQWZMD0hBVdpvMeHPNgHhA7ywAAAABwg4txSCCMIBpBw5ygPFIIwgnCCLCCLQRaAT=
yg4
IOCDqQSH0UBEFwQF5e0WeeyBMovogqysBjILQDzaCIHODxsfte3GeCPdA5uXhu4NBNB23II6F=
Ax7
94dTjI5oIJHNDoQUD9N+02Frz5jgBt6npaC6SXReZssMsuaDwTyR2yguQSukG0uHmDGeHDt8h=
Bne
O7x4O5wYLH1C/fkIPEvJcbJsoEvQOi+lAEvCCo7lBIQbfkjsg7yR2QT5Q7IOfG4DAQKAJOUFp=
lBi
CWzBiAo5yZCR2KDW8O//ABif/ZA52UEBAJNIBJ6oBvKATygkIJQR1QFikAlBxwggnKCCg4IOQ=
d9s
IDYzeaKBzWbTxgBBxBcMZKA2aYlhJpBT1GnOXDogpOY4kOZ9QQNZqXNftki3MxyfUP8AIQQIZ=
WSG
Zr9zTk2e6C/o2xHSl0npIJNc0e1ILEeoMQMs1ua0WXA1vbXtyUHSayOOVnlD0OG4EoLskem8S=
0bo
nOaCeK6FB4PxLRy6HVPhlABBwR1CCi9A6L6EAS8IKh5QSEHphEgnySgJsBsWEFnyWlnCCo/Tg=
Owg
B8dBBUlBBQFp2OLkG/oRt0wBObygcgnogVID0QDSCCEEUglBNIOAyg7jCAHHKAXE1hAAegJBx=
QdZ
pBLLtBdgAIohAxw+6A4oxeevCBzG9+OtIBm07XQj35pBnnTcgZBB6cIAER3tjGXUdppAIn2kR=
Oaw
b3Vu4F+/sUHOkDJAxrdrgy8gEOQZ+olcGmNryGE2WtJrP9kCte90Olgh3G3W+uwQd4drHwStc=
HGu
yC5+KmefDp9Y3q3a727FB5d6B8f0oAl4KCmeUEhB6+gBaBbZh5lINOJjXxhAX5awgU/SHogrv=
0r+
yBJ0dnIQNZp2s6ILUI2sPygK6tBwegg5QRWUHOCCAEEkUg7hBBwbJwgEnsgBxwgAoFueAgWdU=
xgs
kIAdq2k+lyBrZmkCiflA+Ih2Q5pHzlBdifR70gttqQEgUggmvdA6J36FBa8sSNo/ogz9VCWEs=
PXg
+yCpH+zk3vywGr5A9/hBHi0ZZH5rWhzL9XUUeD3CDNkY6F3nxy21osXkH2QJe8z6qnUGx2XOA=
wRy
gp6x51M7paoHAHYIAhsINHXEzeBg5uOT+RQeedygdH9KAJeCgpnlBIQetmNMQZ24iW0G3pZts=
AJQ
WdPqQ4HKBplCA2U4ZQA/YDWEFectagrv1LI4+ckoKh14LsnCBketaTW4WgsslDhhAYdhAW4EI=
Oxa
CHE9EEXhADnDgoALwECpJmt5cgqT+IMaMZQZ8+uL+pr5QIEpccoGh7iKHCDmvcO9oLMOocK6U=
guw
6l24Wcdyg0tNqqsE2gtsnD6usoLcRB9N+6C5Dng5QTq4d7A7khBkiwA00RZqxz7FAT4ACIMeV=
K0h
qDLniMUAjkDPRe1wPPygz55WeU2ICqFPP8XZAprmcBADmbZccEWgsatxj8HI/wD2PAH2QYTuU=
Dmf
SgXLwUFR31FBwQeplmDm4QUPqlCDZjirS37IE6GQ+aWoNQDi0BtdtQVZ3kyW3ogzNXqXiTaUG=
fPL
I4kNslBX2yDoUECVzebtAxuskacOQXYPEn4DuD1QaEOq3DJQWg/cLCCbwgW59IEzSGjXKCjNO=
5rT
QyEFCWSSQc/KBHkvd3QNj0l/U4BBaZBA0fU2/lA4NgAoFqAS2PpSACxo457oJbjqgcyVzeCgu=
aWU
g5vPUoNbSSEuu7Qa+mcCLtBbw5ueqDH1bGs1TmuHocLPZAtojZHHFdgP+o52/B7IK/jmnA08k=
8Rp
7RuaP428H9EHm4iZGHdnCAAKfSDSfpmu0cMwvdu2lBQ8bftlj04OI25HuUGS7kIHt+lAuXhBT=
dyg
4INpjZKyggtcHWEG9oHibThpOUDGaRsLtw6oLQbuGECpbZygQ17W2XFBj6nUwulNZN8hB0EG+=
W3D
0nqgu+VG2rCCrqTpGg7wCgz5X6MYax1n3QKc+FrqqRvyEFrSSNB9Eg+Cg1IHP6oLjWoBkZ1KC=
pMd
qClK4EoK75AOBZQKc4nkn4CBmlaxz71G4N6AIOlh07dRJTS5hFtpBQMTy6wwgIDDZWjkoCEkr=
XVZ
QPjleRkILkDHu6INKGKqzlBe0oIeK/VBs6ckZPCC2wiuUFPxKF72bogS4DgIEaGETEXuaCMgf=
unu
EAvhc5xgcHANY5zSO3b9bQeXla6GeRslbh2QVmjdLfug9DHCPy+kZ3JcUHldfIZdZK/u4oKh+=
pA9
vCBcvCCmeUHBB6iZm0DCCpK8VhBZ8Mmc2T2Qa7pS7lAenc+SQBvCC3qNFI9oIQUNX4Y/yiQSQ=
eUG
RH4awPO6zSDRj07WwCggzPEHSD0stBnDTy7g54sdkDZYg9zCxjWFvKAZ9OZn73PrHAQLGnz6S=
flB
peGmVh2SGx0KDZYeO6CJuEGdqQbQUntJBpAljCCbGUDGxsHDKQMa1pQH5F5CAXwjraBZjHAag=
lsB
dnb/ACQWItKBRIQXI466BA9ooIH6f6/dBsaSqybCCyMFBz3ENLxms0ECAGvl8xlAg3j+qCZY3=
xzx
zB2Dd/CDzEuidrNRII3ENDjtHYWgQzSCCYtdeO4QaIl3wySMwyKMhqDyc4aHkNznnugR+8gcB=
hAu
XhBTdyg5B6/UsLx6UFF2ldeUD4GNhcgvue0sBCDR8G2ucEHohGCzhBkeJzDTAh3BQYZeHEkdU=
Fji
MD2QU542uNkWgS8N7IFPDawAgrvZfAtBMeme42UF/TwBgGEFsIBlKClMNyCuGZQExrSaIQGdP=
XRB
AiFcIDbGO6DjDfVAQhaOpKAwzGBlA2Npr1CqQOaBecICAF11QPgZZ90Gjp7Z3+6C4TeUAucKI=
JNE
VhBMLI2vABJvINVXsgT41uj0EhaCQW1jogwfD5PJlaTdYtBr67QM1RbJE8NPPygzfEoPyXhUo=
c31
OPHsg8Y82SgX++geOECpeEFM8oJQev0cu6P1IJmog0gpOJJQNY8htEoNLwnVsgO5xQeo0mtjm=
YNj
gUFHxrTnURHb0yg81Gxwm2nug0JECC0IFuZeKQB5LUBNhb2QHsAHCAmjCDrQKkegrPOSgEZQc=
Gm0
FmKy2j0QS5nUBBHlfZBIZjPCAwAOyDqA6BBPzhBG8ICbJkXRCC1ERusYQacDw5ozkILDTikHP=
+lx
ujXVAGmduDOh556IHeITBmmIcQAet/og80QPMojae13SDR08jyxrAct490FP8Vzu/IQDqbtB4=
13u
gWPrQPHCBUvCCmeUHIPSad52YQObJuaQUFdzqcglh8yQNCCzLpyxoKDY/DcMnmucb2oN3WSMi=
iO7
hB5d212rBacbkD38IEn3QdXZBG3CCRge6CACSbQEcN+UCycIEvPdAlxACBJkooGRyByC01pPC=
BzA
SEHFvRBwFBADkA0QMoIcbGEAkngoB3UbyUFvTy0Rk0Sg0I3WQ5p4QaMR3NB7oGuFso9Qgp6Rr=
hK0
B17bodsoB/EJ2aAObYtwsIMGNwsEklBp6NwIo/b2QZf4n1Eb9RHC53pY3PyUHm5AWuIPRAtv1=
oHd
ECpeEFM8oOQehgvy0F3QRNeTuQL10LWH0oI8KhuYvdwEGlqdriB0QanhupigiAsCkAeJ6xk0Z=
Acg
8/p5HM1jGngmkGm/hAsNwgmkAkUEEAoCBA5QBu3knoEAuukCX5QIfwgT5ZdaBLi6J1oNDSajc=
KJQ
XWnCDucoBJzhAo4OUEF1IBc60Ausn2QKc7JpA2KTaaPFINDSS4YWkG8EINrTkGMdUFlAuNhDj=
XF2
gzPxKJJ5dPp43U6Q7c8coMWTT6nTP2Sxua4Y4QPj1X5SPfMC28NsIPO6id08jpJBbnG7QV3FA=
Lfr
QOQJl4QVHcoOCD2EumETaCCm2cwuNIETah0jrKC1o5y1tAINKNheyycoBMB7n9UCixwdWSgaI=
Lc1
9cG0DygjoghALjygW54b8oADjI6ggbW1qCH1SCrK7sgWDbkDCAG9LQUtTW0oF6R5/RBqQS4oo=
LAd
YQCTRQKJrraAXn/pAG7uUAOfZOUAPIFIOa6nA8hBfgJvc0INrQy2NpOUF+M2CgcBaDN12nfL4=
vpC
ASGkEn4KDZlA5LQa7oPNfixkPltLrBd2zdDCDxT63GkCygFn1oHIEzcIKh5QcEHtp5Q47Tygy=
daw
h1hAiJu54BQaTWNZHYQO0eoO/agsz6hsYygCJ7X+pBYikDztAQQ/DiCgW7sgEuHFoAe4AXaCp=
LLZ
oFA+CmAE9UBfmGPeWA+odEAyPoUgqTPxlBSf4gyN1UXEdkFiPWMljsWPYoK08u70jJKA9OA1t=
dUF
xkguuqB7JOloJD8G0AuPW0AFxtAtzsZQQXYQQCg7cQEFzTEkNzirQbelw5rsix1QacV5QOYCf=
sga
B6+EEzC2EIPO/iix4cXOo3TAe2bQeHKACgiP60DUCZjhBUPKDgg9d4l+yeCEGfM8vbaANMLky=
g0n
j9mEC4nBjkHatwkAo5QNj/ZwhBo6CL0bj1QN1sZYA8ccFBTdwgU490CJZABVoKXnAP3O4CAna=
01Q
QUpdY4G2mnd0DIPEHyemSr7hAU8gIouQZsxAcQOiDo5HVg0gswuoGhZwLQPbI1oN4HdAInLLB=
PVA
LdWWkZ4QXodU2UY56hA4vCAdxu0AnKATxYQRnCAhkILukcaooNjSEuaB1bx8INXT4w7lBZagY=
znK
A38IPPfimJ0nhxaBgOtB4N2CgFyAY/qQOQIm4QUzyglB7bxWHzW2OiDHLKBb2QRBG/zgACg2H=
QER
AOQV5oNrLQV4Ii6YXxaDaZpWuaAUFxoDGADogRqtRbS08IM9zr4KBT3IKmodgoMuV53UgEvdV=
Wco
FSZIHCCBTXAN+5QOpzttoESCj7oCY2mmulDKA43FjnniqAH3QHMTtNcA5+ECS+2N9sIOdlrSO=
eEA
skLHWCR3QaEOpN7TlBbY7cLB5QHVFBBb7IJDaABpBHAIQWtNRc2uQg2tJ6W8i6QasDQHA9SED=
2nC
BsaA3/SgoeIaR2p0ckbcvokA9fZB86mhsu2gh7T6mlBUcg6P6kDSgRNwgqHlByD1+o1RMeEFK=
Jw3
W5Bp6Z0LRuxaCZNSx7gAcBBM8kZiQUopWh4QacOosgAoLPmAirQU9UBRNoKzAHNoHIQBIwoKG=
vds
j4QZTiSQTklBO6xxwgEZfZQGyO5MVQ6oHBlwho+u6PwgAszTwaCAXxkRgNstObCDhvIJJyayg=
iMn
DqsjBB6hBzogS5oNDpfRAG1zSWnkf1QBJh59kDmU+PqCOCgtaaQjDuhQaDSHNH80B0KQDyCgE=
4CB
+k+sWfZBs6cFwa0Gg6kGtC702CSPdA60DojaBjstQCx9Oa3uaQeO/GGj/KeJM1cQps4t1fxDl=
B57
WwgATMHpdz7FBVj+pAwoETcFBUPKDkHp3i48IKYNE2gEyuBoEoHaUOlkq0FnUMdHQvCCsd3RA=
+HU
OY3N2gNuufu4NIDl1RkjrqgrQzujfud0QaZp7A4cHKDJ8XFbRSDMYzc4Vkk0gLDX7XD/AOkDD=
EA1
tg5ygYzYLAwfhAxsYsEHhABApwc7njugja00CcjsEAEAg0DwgFtNAx8oOhIe7Y9tB3BCCA2jt=
cQb
4cECZWVYdjqgCKwDV9x8hBoQttrMfVRQXoW+nPJQM21goBqsIBeaCCxoWEuBOAg3tIyrzgFBo=
MoN
AGEBB+aQWoeEBuNMJQVYZPN14a3IjbZ+SgofjSIP8F8zrFI0384/ug8fpdssDo3GwcIM98ToJ=
nMd
04PdBxQIm4QVDyg5B6GOT9jVoK5JNoBDSTkILOnuKQOQWppPM5QTDCHPzwgtO0sQrhBHkRbg3=
CCZ
dG1jgRwUFfxDRFkBkb0QB4VP5kRidy3j4QM1OmbMCXdv0QYvlmKSVpFBuAgXG0vns8E2g1DG1=
wAH
IQCIheQga2JlIIfDHeAgWY2NN9UCJAOmECwwkZCCCGsArkII+ok0g6ePc33AQJhb+0FGgcG0G=
j5L
mMGMj/f7oLcTgWlB3ygBwBz0QLfyEGh4ezdZuvdBtwghu08+yCwXBrR3QTE7OOqDQiw20Cdfq=
Py+
mJGXuw0dygLwuDydNbsyPNuPcoM/8Zu2+ASD+J7R/O/7IPDaIgkjdX3QW9RpxO0VW8DB7oMx7=
S1x
a4URyEFabhBVPKDkG1AcUUF+GBhZZQFLHGG0KQV5W0BSCGncgMl8YsFAk6uUSZJQG7UvL2nhB=
el1
n7EZygmfWeZpdp7IM3SsfHKHtPHKDXB9NjqgydftYHBo9RN/ZBTgAdJf9UF6SQRACxu9kHDUs=
f8A
U2j3CA/NiAsk0EAedHmtxpAt2pZxtJQIfqKP0gIAkc+7ux7IBaLIcCga0kHIwgMkOB6YQJZXn=
EAV
3+EFwyh0D2XZZwe4QFDJYBsj2QOcTSCHmqr9EAXkFBp+F7pd1t9IKDaYAM9KQRK/iuUDdMLI6=
INE
YaB3QVHRnV68fwRCh89Sg1GtDWho4CDzH47nA0UUF5c7cf6f5QeM0xG/ms9kGrA8toOot6FAG=
u04
mYXs+to/VBhTcIKpQcg2seaAEF+6jFFAl8meUHSPtiBUBt6C3JIwM6WgovcN1gIGQtEjhuFBA=
eqL
Y2ikCoiXjlAT5DEMIHaHU73eW81fCBXi8Za4P6O6hBnRuDT7oH1uaDf3QcAXWb+EAuO1vO5B0=
bhs
cTyeUC95LQRkg0gEuuw4ZtBMe4naDdcIHNYdnUHsgkgtYCcoAL82BYQKOSSHdLQHFIWuDXcXy=
gdD
Kd9AYCC+Hbm5QRYtBLB6xglBuaDELe/F+yC655ZH7IKxktxbeeQg0dGKA9kDZJ6eWt5qh/lBe=
0kQ
jhFclAyR7Y43Peaa0WSg+dfibWO1eodIeCaaOwQZGmNO6oNFltAo3fRBYheCRQ+QUGd4xpA0G=
aL6
T9Q7IMU8oO+6DW3gG0DhPbKtBVMrt+UFtjh5eUAAkOsIBe4lyDt1mkFhv04QBMzcMlBDRsbhB=
DvX
yg7ySBuachBYkedXoyw/8jcn3QZBP6DqgsQWSAgvOgcRbQBfXsgRLDtYawBx7oK1gMc3GeEEM=
GGt
r5QTtJ9JJ2ji0DYYLJvFoLoYGtBJuu6CvOQWUP0QVHkh2BVoBktrubvGUCxklti25BQOgOQD0=
KC8
x1DlAxpxwgfpmX0skoNrSjaR2CCNTOGj26IF6b9o/HPVBq+cIIr5dwB3KDtHg75Dbig1oZRRB=
QYP
4h8T3k6aI+kfUR1KDxfibi5wAQVIrv8AwguxyObhwJruguRvY7nBQNeNzC14JbwSgxtd4Y6M7=
9P6
2HNDkIM9zHNNOaWn3CC8AXIIJLSg4UTaC7pQJHhqCzroBDGHBBnF1lBb00THPG4oNGfSNEO5i=
DJ1
ElNwgU2UkZQMDhSDhMWiigNj79TDlBQkjc1/GEBxv2uCDSg1VtzwOiCJXF9kVZyUFNzDfQ9kE=
sbT
7PUYQNoDnki0BggMQKfqNo29ECHyk2ECTRo/qgkg3R9QtAtpIduIsVSDg4l1g5QXYnu27twcg=
tRk
V7oL2ib+1a4nHZBp+ZsicSecoM2SUyOPPOEF7SvbDEHv5PTug46h7n24+o/yQaejeS0fCCPEf=
EPI
iMTD+0d26IPOzPJsnlBha12+d3thAuMZz9kFpj3NFZodCgfG4OxkFBZa99Ve4eyBgkFdumEEl=
kT8
vAJ9xaDG+nhBO0FBBaAgZp37JA4dEGnODqNPdoMaQFriOyBscjgEGtBqS7TbXFBQkj8w0gRNC=
Y+u
EA7g3qghztwQCyUxmkBSv3Rg9OqBLK3IHRvo/KCy11tIugBj5QC8AOok4QcDb2gHgoCkNP4z/=
ZAt
93fSigryvFoBdmkACwflBxsAk96QM2BwxZ9kC27mzChZtBoxRNO7YQAMj3CB8bK/dOOqDQ0wD=
WWc
HlBGq1BkNAmuqBDXUbQNDnOO5xz/AEQMafUgufnPKj2s+r+iCi97nuLnGyeUFbUOppJ6IMFz7=
cXd
zaDmuzdILLZO5IQMa/GCEDw4bbyEBB58l11jKDhJjmkCNrRHnlApzgBhAhxJQFG6kFuPVubHt=
QVn
Hc+ygcyqQWYCOEDHs9Jc1Bl6idziQeiBG4lBO4gIBDs2UD2v3tDTwECnW0kXi0BsfQN/ZA+F1=
mig
N7rx3QC30vzkVfPRAzlzjd4soBLttDo6kFOS9xHOeiCWmyB2OQghth2cjlATm2KJ977IJiFvo=
5QW
ZIXYfQbWL7oLnltkbvDBGaANXk90D4m7WBpqgbQHJKSAOg7IEE26uSgaxtfKBg4QSg5BDjSDO=
8Rl
2wkdXYQZJPsEDIyOoCB7Qw1yO6DtoFURhAQLhwcdkDGSu8mS8208oKwlIHKDpZCTVoFXaAggj=
hBL
TSCQ4EoLMVEIJc/YgtaZ++EoM3UNAc75QIApBBygZHp5ZPpaa7lBai0dH1yfYIA1cTYxbevdB=
WY6
sHIQMjfTh7oDLxeUEl1O3HN2gJr/AEAng/zQCX0Qw3aBL7A9NudySeiAom1R5IGUDDHUdnlAg=
WC3
NcoHMbuouw4ckINTTuILdzA8Ny4Ht8/YINXURMcCIiSXC2hxFn4KDNe/bY68IFbyTQGTwED42=
bfc
nkoGgICpB1ZQceECpHUEGLr5N8+3o0IKvTogJnHTKAxY6FBJd70gguNYKA726Z+RnCBV0gEmz=
aAm
5QS40EC7JKBoG4IB205BZY4NagU95c9Bd0JthCCnPHI7UODWkhATdMB/yPr2CBzBGz6GC/dAd=
uIs
mggU+YDDUCifNBJGO6Bbo6JGKQDtIaQTTr4QE/I70SgFjtxqqoYCAx9LAfdAt59Zd1KBm2oGh=
tlz
jZ+ED42EN2A9bJHX2QE5rqIPANfdApsdkgg44QPijc9wABv3QbuiiZIwNLQS4ULHygo6p7myb=
M1H
6UCnzPmLWupzuhrJQPih8sZy48lA4BAQCCQEHUgBxQVdRIGMc48AIMJ5LnOcTklAOEBtodbQE=
Sei
ASXe6DhaDpHE7W+9oJPZBzQga1oa1Al1koBcdqCWOooJLrKCfV3QPhhs7n4agsslZFewIAdK5=
5QC
GklAZLYxZ5QV5JXPPOEERxmQ/wDqEByU0UOAgrunIoAAAc+6DVh8OOo8KZqWZJJtBVOnLQQG5=
uiE
CnRUaAAJQEInGItLaPZAJhO83x0KBsUJoCsfzQWRC5rWEZs9EHPZyBdXkkIIia3h9Aj7oLrJo=
Yo6
DNz3DJQHDqnxtMoIDg4V7coKrnOnIABLr/kgsxacRi+XdSgbSDqQEAgmkEFAtwQZXi0tARA5O=
Sgz
KQQB7oCDccoIOEHZtBPRAIzKgYM2SgMjqgguvCDrACBL3AlBAygNjCT7d0FqMAC9ufdBLnknl=
BAF
5QMArKAXy7cNQV3OLjfRAcUZfk4CB5dQoYCCtM7CCq88oPZfhIiXwORh/deUFTWRmGV1jCDH1=
D9s
1cklBcgH5gZxaCZdE6y4GygAQSMBuySgJoncNu4gDogL8uXEFziSgLymgoJ29ggNkbpKYBebp=
Bdi
gbE2hk9SgkhBFIJAQSg4hBFIBfTWOe40Giyg8xqZTNO6Q8koFE4QRZQTZqkHD3CAgfZBOUC4z=
b3H
7IGnoEEtfbaQA51II5CANqA422fbugawb3Y+kIGk9AgJje6AiQECnyXwgSTaBsMe7J4QNLsY4=
QQ4
0EFSZ1lAki0HrvwU8GHVRfDkFrxKEPLgeqDyeqY5msLXchBf0TtpCDVaNzbQcWhAJaOyASxAB=
YOy
CYoHyv2tGOp6BBeZG2Ju1v3PdBBQAQg6kHUg5BNWg4NygzPHdSI4hp2n1Py74QYJcUEFx7oOv=
9EH
A54CAr9ggmz0AQS4kBAuH6R7lA0nKBIdSCS6wgEOIQEy3OoIDcbIY3hA9o2NDQgNra5QSXUgU=
9yB
ZN4QS0W4AILW6hQQDyUC5nUEFRxsoDa2gg3fwfN5fipYeJGkIPReIxEWR0KDA8T0olb5jR62f=
zQZ
8BIe35QbUBwEFgtB6IAMRBwggxnsgOHTGTJw3qUFghrG7WiggWUAEIOpB1IIIQcAgIBBEsjII=
XSS
GmtFlB5HUzunndK85cb+ECr90EfJQd+iCRQQSEBAoBld6Cg6Pj4CAr9kCSEHVSCQLQMry2f+x=
QHA
wgbjyUDgKQQXZ5QA53ZAsmzQQdwgZG0tyevCBiAhgEoKsz7JQLjG549kDXZNBBoeD3Fr4ZB0c=
EHu
NW0OYHdCKKDInhLScYQYWrhMM9j6TkILenlwKygvMf3wUDAbQWY4PTukwOgQTI7oMBAkoAKCE=
HUg
hBNIJAQSAgwvxBq9zhpmH0ty/wCeyDFr3QRXugivcIJr3CCaHcIJFIJsDgIAlNiuiAmfSgJto=
FHl
AVelBMYBNngICA8yX2QWAOiCHFABND3QLJ5HVBzQTgBA5rA03yUBEoOCCJnUKQVHFAUWG33QW=
Imf
qUGz4ZBcrTXCD17Bv01HsgziLtp6YQZXiGm3sNcjIQZulk2/Vyg0Y3F5DWZceAOqDY02kMEYf=
NRk
6DoEETSWeUCCbQCggoIKDkHUgmkHBAjX6kaPSOlOXcNHcoPIPJkcXONkmyUA0g6kEUgmuiAgP=
dBN
IJwOyBUx4QE36QgYzrlAJgd5m0oClY6MURhAJ9EfuUDIG02zyUDCawgAlAFoOaNxCBwpowKQS=
MII
5QG0UgrTOtyBB5CCxE3qeiC5pWF8mOEHpvDdPtAxyg3oG+goKMsJD3e6Cq7TSSnjaOpOECo/A=
tO6
YvfK43y1uAg0tLodPpAXRMonqclB07rQUZEAIIKCEHUg5BNIJpBzW2UHmfHdWNRrCxpuOL0iu=
/Uo
MsmuiDr9gg6/ZBwPsg4H4QFk8Wg7PUoOx3QLlIwgJvAQGOEGtpo2u1Ac4INDxCDTu0hkIGAg8=
04b
5a6IHjAQCSgAnqUEe6BkQ9N90BHlBCCQgl5pqCo8oBjaXOQWR0AQbfhOl3EE9EHp9LFtCC5LN=
Hpo
C+Vwa0DJKDyXif4jllm2aRoZFf1nk/AQPZ+I4nObH5ZrjdIeUHavxsFuyJwBPO1BY0HjMbmNi=
1Eg
DuA4oL0jkCHZQLpBCDkEUgmkHAIJQVfFdV+S0Tnj/kf6WfKDyBNkl1lBFjsggn4QdfGAg6+qC=
bKD
qJKCUHIFy9MICbwEBngINHzfKkPZAGt1bnwht+nsgqaccuPVA1At3KAUHcmggdw0BAJQcgNoQ=
Kmc
grO6IGx00X3QWdFGZpwPdB7Lw7TBkbRXCDTc9mnhdJIaa0WSg8Z4z4pL4hOclsLT6Wj+qDMKA=
SgW
7CBRNvySg3fCPGnQBsGqJdFwHdW/9IPQgtc0PY4Oa7II4KASghB1IOQcg6kBNFlB5bx7Wfmda=
WtN
xx+lvuepQZRygnjB5QTx0CDseyDrQTY90EX7fzQdfZB1E1yUC5RxwgJoQH2+EF/a14slBSnNu=
ofC
BzRtaAg44QLKASUDI2gG0BEoI6oJbygM+lqCrKbKBQy4IGk4pBueAaazvIQeu07aaEGD+JfEN=
/8A
8aM+kH1e6DzqASaQLc5AlzkCzlAbCXDGUG94DNPD6DufG792uEHoHNoBw4KAUHIOQcg4IKnjG=
r/J
aFxaakf6W/5QePc5AI4s/ZBwyg5AVDuEHYHVB2L6oOsdgg7d0QdkoFyICZxaAycoP//ZwmIEE=
xEC
ACIFAlMDjeMCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEJxL666uKdFFIQIAn3aNo=
OoD
pFuub2ToJKyAQiT8GketAJ43Gm6pynyPyKdbRNTsHCneh4gk6s7ATQRELPKCEAQA4IwVq6xVt=
JSA
D+pS43ShqXjrDcqKMWpOIG3D1tsECyTMeTTxMc8hauelfbf2M1p+6abR9Pv8qd8bOvY9TVfF2=
1XT
KgWDJB7t4AhYSFVd0FM/Y7PIEiWo7LsPTtTTivvHoht47ojtwy52Tt1X+HpTl7TrN1jCV4jEw=
PE1
/fes8lsAAwUEALmlmbXOjcd77CtaHqIM5bxjnmlM1NESm1VrkVpo4QSwZX5pXRL1JO+ar+NKH=
rUU
7p4b9zNYt7iCN6GMdtaaIba1pEWEgXHkU2zP7Ojs+sLOHytJJ1dCZN17TqXyqR7dD1TSw0ZuN=
nzY
yG3RZu36Km8zOwKdwzW7oOiuNdSLGNHGwkkEGBECAAkFAkQs8oICGwwACgkQnEvrrq4p0UVA2=
ACf
YSdEJN1CqibIB/pbkpAZpqWVO0EAoJa5qJtQNItgaTp4FsBVBVCVbwsXwkkEGBECAAkFAkQs8=
oIC
GwwACgkQnEvrrq4p0UVA2ACcCT4WO4faye3L11z52j30k42jVNcAn1uBZ+r7JZ/aNnoO8Ry+1=
v2Q
75Mo
=3DzWea
-----END PGP PUBLIC KEY BLOCK-----

--------------F5F52BCC4109661F32CDC313--

--Wg4okHyfVuMvDqGTOZUYodUO3SqSHzMBY--

--d91W82mMusqS3V1XlSHRyXGmf2HQAY617
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRAnIgNm1oVT9en70WcS+uurinRRQUCYXfkDgUDAAAAAAAKCRCcS+uurinRRfjQ
AJ9eclab2bfhonlvOn6rt4jNK0DXTQCeI2Ekwne7QBPMqTjq0o0+UBTzOY0=
=5YMp
-----END PGP SIGNATURE-----

--d91W82mMusqS3V1XlSHRyXGmf2HQAY617--
