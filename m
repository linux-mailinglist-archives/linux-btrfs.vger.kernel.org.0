Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52853179CEF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 01:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgCEAqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 19:46:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:55307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgCEAqY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 19:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583369178;
        bh=yKBxtmSK7+/YS22cLugkfFcabl+sCb+4F1OZ5WVLaB4=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=EoLyx3NUyOIyz2hsZvtp7YN0XspYxWJtlrBQRgl/yhcfQCqY1aAoS3KKs/Wgo0qDY
         e+U/JtWwkui84kd/ReQo7TehlvuVd7wLMP1q7KKaEt5cAhmZRyd4t3FY8kKt4KWz7f
         3CkoD/t/QOF6eESuq7e8mOxG1Mg5Z7IwyNST5Vp8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhlKy-1jnPFR3Y8m-00dlNs; Thu, 05
 Mar 2020 01:46:18 +0100
Subject: Re: [PATCH] btrfs-progs: Output proper csum string if csum mismatch
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200120093205.37824-1-wqu@suse.com>
 <20200304142802.GU2902@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <5fe0776c-4e99-e124-4211-0abe9a90924d@gmx.com>
Date:   Thu, 5 Mar 2020 08:46:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304142802.GU2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VMnVUQczo2bYebPDcXT1yyZXHgMydrMhc"
X-Provags-ID: V03:K1:KzS6fFxbGq5wJV+S7QrXHk2vZP2hQxjfpqYDmKqL2szDsdVDt0k
 vi2T7jepPbqRZATm015yeZmyaLZVZgBR+d13CbCQxKjIfTJiCrEworgcN2u59HchzV2o4hn
 uY4+EOZEn+eU5S7uRnZDXss1PXjZc9BNoH3MohnkMiJEv/7XEYuqiRuP7Jo8vq/uv41k9l9
 1+9rCxwFZue+bDc6hT8zQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hbl3Bnx0M4w=:ZFaURh0dooG6PAAeObnmP5
 rU4wX6B/Lb5hwhuSrX8Dlr1/9VdFpazFs0Qpf1IwmOwakXl/Zih/X578sPiFfLwMihVsoTJZM
 UoKloY6GUaLAptuzrtTHCatYlRPW+eUjFdw2Bdn1xqDquWayuFa0Me56yQhzsuWI7tvvTrdEW
 kzKGpLbA8htieTflsf6j2kvuLK7DLxIxeoRc5TrsDCCiiY6EinC21CabTyYlKPW3M/7A1akV+
 /K8f5fPykaZTiMUILY72z2JgM0gBWxZwhAH1n2E94dlQROtifDFqQcGPC5+VczcDPwMw15rHX
 9wH3LeKrho+aDmOBIierd/2LEeC5ZBc/nY4IvGhNSt48GOerV5jt3em3xRujqDIu+rcd0nlWy
 DN8WQj5NiMi2MOB1yApKlZ2UdVip5Q4ThZPW6NdMj1mFe3fR0GwNfXHl0T9MEcSWZ4zzKNhpJ
 pk2UTvT8aajxIHo6FV6qPUJsbczWl1NVaOtp32YnNh9hIP+S/R/p8hgDkjdHYxc33aMZk/BJw
 oCYvbdqr46ofMPmb28hPc6yA+0UooNY9GScfFPzex1WFRBT34kzGNzKY/EXFPmdXDLCLqu2AU
 bx4tI0DygUigAwkgh9mD9Dw6+2FPDp7KsC6Z4ERrE6D4az6maYSnuofig3UI3mAaa8PkxEg2G
 W4YB78JFJxhH3VQ98o5v1dvsqEw7A/XN8UoWSGzgKLoQh7BI4MznDJ+eYuRYjFWasORfwd+VJ
 7Zfz4BS+KDvc/qLy/yWcylbJzjLmvpOqb1xfbocg/xE70BB5iG52WjQyhU0mWiQc+6Ey6XayE
 Y0SDCs4C02LC6k5LxWM5i+pWYpNL0m2uk1B5ml/2dP/eNJsN5XfUmjad4TcW1etpjbeSe8H7F
 dgeOwv6sFmDnJZ0Ilp35iLkFKDk7VWz1MGnxrItebZuZcUecRXRlkyc4JTfSoFaKUZHJ5NKg+
 eRP7wWU2DzqGMCSHNl5MI+8VuAXbZa9spsL1YOHQ7Oty9zQuVV4yeWhiWJkBz8jl9lcstfr4/
 CIyhE9UTGZgvTeJ5l9MoPc4SmoAwPeseBzBbhB6cwS3QNq4dkzU2PvOZvIhI/J8FLLSy7OKdu
 QnyjldWcTBogEDlubyKJfSytopD2UoA318NwG5ctoHzQo5xgILFiFcfVIZqCibpEak3fOyehJ
 +469OWfx4c5HuZIfek/0fQfTcUJysOfAOOjBetliv3vHlDW9ROJ+C0LXYOAxJz1RF1spCQyR5
 u+njZ3EnCeT2BObeA
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VMnVUQczo2bYebPDcXT1yyZXHgMydrMhc
Content-Type: multipart/mixed; boundary="PE0p4FCF0eHQ5AUTXk8OckOUHfPlCMePW"

--PE0p4FCF0eHQ5AUTXk8OckOUHfPlCMePW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/4 =E4=B8=8B=E5=8D=8810:28, David Sterba wrote:
> On Mon, Jan 20, 2020 at 05:32:05PM +0800, Qu Wenruo wrote:
>> Introduce a new helper, csum_to_string(), to convert binary csum to
>> string.
>>
>> And use it in check_extent_csums(), so that
>> "btrfs check --check-data-csum" could report the following human
>> readable output:
>>   mirror 1 bytenr 13631488 csum 0x13fec125 expected csum 0x98757625
>>
>> Other than the original octane one:
>>   mirror 1 bytenr 13631488 csum 19 expected csum 152
>>
>> It also has the extra handling for 32 bytes csum (e.g. SHA256).
>> For such long csum, it needs 66 characters (+2 for "0x") to just outpu=
t
>> one hash, so this function would truncate them into the following
>> format:
>>  0xaabb...ccdd
>>     |       \- The tailing 2 bytes
>>     \--------- The leading 2 bytes
>=20
> Kernel prints the whole checksum and also 2 on one line,
> btrfs_print_data_csum_error. The short version is ok for quick comparin=
g
> but for consistency do you think it's too bad to print the whole
> checksum? Eg. when I see errors, copy&paste the checksum and can cross
> check with the kernel messages/logs.
>=20

Personally speaking, for kernel I'm in the middle land, leaning a little
more towards shorter csum.
But I'm not confident enough for kernel, thus there is no such patch for
kernel submitted.

For longer csum, unless we have some intentional conflicting algo, it's
really hard to craft csum which makes the leading and tailing 8 bytes.

Furthermore, the only csum human can really use is the csum for all 0
page. Otherwise all csum makes not much sense to human.

But still, full csum may still make sense for certain corner case, and I
don't want even a small chance that user reports csum matches in dmesg
but still causing EIO.
So I hesitate for kernel patch.

As usual, you have the final say, and if kernel patch is needed I'm
pretty happy to submit.

Thanks,
Qu


--PE0p4FCF0eHQ5AUTXk8OckOUHfPlCMePW--

--VMnVUQczo2bYebPDcXT1yyZXHgMydrMhc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5gS9YACgkQwj2R86El
/qiaqQf/Vh+PDZYLpe/g9cvRxfnhRqMCrqRgFOjASkgJC4mEYhLCKuIee5oajS6t
4wu/FRWMs4wrc/YC9kpS0Y/wYa0t2iPK4Y6wZ0eCwSogbODwj9rJACF6Hb7Z+xis
+sXV69DnMgbkOYpvF0ceWN0HH4l9Xu7Qko1OEwuC1xs/0j4G8AAXfTQcZhu4vpJn
50TmiQalpCCWD/atEBz7Mjev281gCuW5UJwZEp8Xohl6iGTH6YCxcrTvSDcDsUlT
t2Z6ttPK0/aGikR+TKnyDA6UzrYdneCNnl/qKTf7BPSQ0kzUYRTv/KhYnxO8RelY
ZcGtPaIs0VrExVwcOoMFP2iV9jRjgA==
=JLEv
-----END PGP SIGNATURE-----

--VMnVUQczo2bYebPDcXT1yyZXHgMydrMhc--
