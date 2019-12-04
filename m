Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD761122C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 07:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfLDGGQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 01:06:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:41555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfLDGGP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Dec 2019 01:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575439574;
        bh=4IOPHU6cTCc/pa3ogIPlSfORbkTZ6wRbpSq/bGHYx1Q=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=CMlv7p9UCQhyL5RuDGSurBm5wBoPgPCA/NvaFIOfbJEjSHE6KPMS+ZV7zdoqYalAA
         lGahDK67jo85NQSO6X2bx0FcXcj7lAdUH0nISwH2rot7ySYfjhu5nejJTN3hrXB7xK
         AbKr7lQ1K2Hqw4TsnT2iveYZISDxmUIVUawHxbnk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1My36T-1hqKuw42Sl-00zW0M for
 <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 07:06:14 +0100
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: btrfs-progs: misc/016 hangs at ioctl
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
Message-ID: <3b8f824f-0c55-b54b-e23d-257ad1b2f239@gmx.com>
Date:   Wed, 4 Dec 2019 14:06:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K82oO81Geonn6SBJTqJkGyLoSSBUASqYW"
X-Provags-ID: V03:K1:lMYYY6xQaSQRF1DWnEU48h0bs7URP1ywELQGTE9EMO05VChBAng
 71H+hdf233gyR/l6eCowZh8PX9TG5vSfKVSuyKIfhIr0uWbR40iKGi5z0+f5wrDi5HAcjnI
 R33PZcai656Wooivr3fr9DAuAzN46xw6TM56WNepDVdtrVKmxZQTFxU6C1EP/pTYLMHffX9
 XR9HpQgbQg1P1RbEcfJwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Vh62Ju1du4=:wbadK/vcawcUGt4zssig3a
 VKtdFxyS4okeEIl0iaT+DtmhGwMonF49uQJHebUO6baPr6DAjVBaBjcYbdfQRGB681RLPfdqJ
 hygFdx5JpYMhcUKKLvoe/lEQF1jmrWo6QvwRaOgEq0GIWfaOXQuarKAgO+Z+IjZwhwV8DKCVY
 zCPhiZdqM8upiKWWvurSYCp+/ogOwMv5TlLk5HJpWa+nejL7Ih9mFekqlogf3IIYbDTHSGNbk
 4b/8UY2Y0ElF7dH/1NFR5sflCcTB/SXJxrFwVOAxFe0VKvNmaleUVbAmhdVQGXERbbDYXoiGC
 Ry+yYy+e7R9PKGn+KsUNa0gMN2/w+jzEYLp5nQgg1b2tMfzgiV3/LaR3J/hwuxdk2u6AxTRv3
 DtW0ErljJifNphB5xyN2KVIUBDveZ8J2YxJkS0MKWotGvQkdn+xcVXS0ALr1QCZ2K0Bfc3Gop
 MKdkBXc4P9q9/6q7So/stQua4CCnn6sJCNOyIA3oSd/wbRpF4GyyHcYfEbywRTFgx+IqgOAEb
 stdF8jwvRaj+4bohfTQu2U/fNKcWJL4mXVbkrzdDBMpKpTxTBMwAGSLRR2oLAD7Th7Q7o5/qj
 +m7iO+xahTLFUx0s5fO/7OYxrh7mPDqrbIdS8ZJckXW7Q5I9UcnvBG2jEizm6rQZSZL7SsdFW
 7Imo2WwWoy94qiu9QF8Qfg+BwHE/qStXiYaECpz80aEF+f8Xf0ZBVoQSR1nlbYyA/Ly9tEvIF
 cKhMHceRC6aiLYh81nVtN1MbDOjiPKdVAaggx3r4Q3bwzIioS1qS3iGAnFTbZvGQQiQUfw9sV
 8I+hO3C4VXzDg5QsuDPrfZ6M/beG6onnNcHya3k4uJaCzGJYi8z9B6CrOOn3MO1w+NFJ2MPD/
 2eoT4ixUBEiRJb4JmNIDAY34P+QBpxVdDiKaL0lO1k6pi5C+BdDNiZAudHKRb860Hh7gbjIMe
 qF2U4CsZuD54wSjcs7OF6Adn7VnKwmJXayD9AHRvgM9443MbvVK/PZ97hfdgjLt0dwHEG0MVn
 y2LcC3YeJ7JxaYjpQO6ghPhiM9I8oRfT8gKATHdINesxNFa9gnVzF3TDgk32gjiyqzGi9k+bl
 Cy//5yk6VnbIjow81yCEKxAp6ITwqCz19DWx0WNsiSMQsU27Uf6ZRoE5wQr/RaugmOljMcUcA
 RddxB+lLMwWYkRRvvA5b3i5G1fyQx/7+YUJtC6BGpHMXtvLME+QmYHEQovNjwVU51U+PWsFTV
 rHOa+4t2dshHgqHkCzqMUYnYKW2UkKxjrdoAyz6URkCJDhWpIwIis+IXZpGk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K82oO81Geonn6SBJTqJkGyLoSSBUASqYW
Content-Type: multipart/mixed; boundary="69ogynLcUzzw5nAc7E5fGF07jUfz5pw3b"

--69ogynLcUzzw5nAc7E5fGF07jUfz5pw3b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Found a strange failure at btrfs-progs selftest misc/016.

It hangs at current master 63de37476ebd ("Merge tag
'tag-chrome-platform-for-v5.5' of
git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux").

What makes it even more mysterious is, misc-5.5 passes.

Since there is no other btrfs pull, it's caused by some upstream
non-btrfs commits.

Doing bisecting, but any clue will be appreciated.

Thanks,
Qu


--69ogynLcUzzw5nAc7E5fGF07jUfz5pw3b--

--K82oO81Geonn6SBJTqJkGyLoSSBUASqYW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3nTNMACgkQwj2R86El
/qj34Af7BcXWdPZ8vOTRh6ijd1qmKUzdWJX2b75ihGOdQWsISLubpy0FgKx50hoo
ZqC4tMwc/krJ17wKOswFogWe3ZQ3a3xhaXROC98qQovK16Yx5LQYarVOnwMnXNWt
pg4D0lr0/rsgiAlWNYQunA34SwZX3vXQkJbSO5kmKZ9aI8vMfBOkdJvk4XzQ2Lfz
vvczQf6ET/BdrLQsLc09mQIc5lWc/NcS6FhemSUJVmYFQ8lGA/1fYHeX/OwGnMBq
9wtKACfCMBT2ZYjjhuQ8/fr8f5q6hKilFYj0AXqFWGTgZ9Y8vjyGRdnFHgGT53mZ
AdgUohaCSulRpfbeUIBSvcquxNfgQg==
=j8RY
-----END PGP SIGNATURE-----

--K82oO81Geonn6SBJTqJkGyLoSSBUASqYW--
