Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F719D688
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbgDCMQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 08:16:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:57495 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403912AbgDCMQr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 08:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585916198;
        bh=DvdaowzPvwTGR3DfT5Z//HcJKwgVbvpjRlCcm9BMYQA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=CD3JB/Mb8u2YqU0mnMl7rP0LQZkfTXIER2ajc1sEHICZQCLPHFxH2aDOoBnn5jlSR
         KirpsKLrVFB4SceGZJ1rNnsjcXAynAB6pfP+5KkjNHtq1XcJm5+Wz2twSFOZp8kU8o
         BtKko4FYQZs4t4ELsaswtcQ7iI0ZIabTRcgRXxcg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MUGe1-1jjx0H0DsR-00RLLv; Fri, 03
 Apr 2020 14:16:38 +0200
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <CAL3q7H5sBk0kmtSQ_nuDnh1jWVTPfmWHbw7+UhJZ=NLgW0a0MA@mail.gmail.com>
 <fdec5521-d2a1-1a51-cd42-10fa5d006c91@gmx.com>
 <CAL3q7H6FCA2gW-0LS1Zh9Dnq29KCY6JhFJwPrEm_Ohvc+6r79A@mail.gmail.com>
 <c683620d-b817-f406-3a8e-7abbfcad14a0@gmx.com>
 <CAL3q7H7GXpnaK-jPQybi3PfoMJtr7gJQ0tha9fYG-he0vrzdXw@mail.gmail.com>
 <fb1a7773-8166-6ed5-8a63-d3ec86e1a70c@gmx.com>
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
Message-ID: <f77f715b-2220-b65d-d42a-7aae81f274f9@gmx.com>
Date:   Fri, 3 Apr 2020 20:16:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fb1a7773-8166-6ed5-8a63-d3ec86e1a70c@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jw8saDXvDYi6EpOerxYOdIb9G22HbVSF0"
X-Provags-ID: V03:K1:2M6SqNRcubnAcfp5hGBe9o4tA/el2UBrWBzBEoXHQVmblHvyZ/q
 E783F56PnrKjB34pER8vdaGvtjbajT8sOxQxT8N969loB7CU4ILeGA7bUX09yIf+q0u847a
 WW9ewpYu5hgEbG8c8Ej1XPW+jN2l/twBPi2m9g9CFAP8H1NBPBf0Mq20lUj1AHN7c9GeA5/
 U3CDoNu1262TCR+ETuoUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d2LbOYd3E6I=:IYmTwrhXUF/2c+7GgEFWvA
 u5sjD+I0pP/6iaPDcdQYZskfe3rJoDKWVd22x5uzDCV8PWxlwQ46bnTTIFVI0JHgCbU8H95cX
 BFvKYtCDfR2FPnrYq+VJ31PCLTv7wYgIrOv/oCMReQKc3xhV0Kd/oWY4SYTHYhHxtAAqtNaUm
 bS3BdtEh2UYc1Bf7bclBaPO7aMamEPXvKq4pHzSd2OzZTpY0X4wruheRQ4IXWrKyuPrYW5vDb
 zj0nAvPh7zGHTD5OHeonvtS5ATrL5COMRImBItbI9fYqwQZiGexzUQ+Hx6+A6l3AgytRL2GBO
 HxesFrAYpT3IeUrkI+JM6XIi58GM8FfrbAf84c4zd4DgJdJ3HZE8rI+Sq56ZA85ZhR6ghP/mm
 9EsN0KQDWVYNT7DWDqsYOcGKKl61eyHX0pSuEe//WjwPpl8KGcTRSY+m/F370b5g4YmmPnNFt
 4oe6XVWOFwLAXg+/0rRJ965UZRYiKyQiiysM98EJTzXmeYgrSRdhTiaelKh29fh23ZRkVy+xJ
 4XBVQ8mIuqOECYHSBmDAMcfUXx9bKtsixyAtCa82za+dpzMtV2xITBVQ1GDJDBUAT+of6FsB6
 NlmWGEmbX1PB48TDY8xohRwlyXmP94V55abJjkClImKNflkw3p5qnBH1rcVp24t40UW++kx/U
 fitT3ynLVi4m9gkNP3scvh/tADf6ME2aSniF0cI+LlNwgo5m3CNmvNPvbVVY3YPdjZMmw5EJb
 Gu2Eep1Ge5DC818Kb78Fz2Tz++ptympXI82spc3pcCL3K+FB09/j1MmUVl7Rz4pT0rxqkn8oY
 2WbKhbSAd6aPglj+f8S79fRYIt/FDVk3d5zywOQCBRQyxeZhaXoBUAs7MiNmn7dmedvqzHxLY
 tZ3JXIw/W3beLgryLpz1PyD69OLEgnlqGUe5imLcYrWDmXn74i6FYrIemTAGeEEl4r0Kq4x2n
 wCT8ofOHMQ97VeaNHFQWsPBckbFWGXlXZ9lGfc2aZ25fjPrikiQyVyiNFVTNrlOlOOaRK+i2S
 FJEyRD98VKvVSAy+4AAdkoIS6R8ufHBnACj1iI6qmwVqp51DV8b4InFBiQaOSxfUADAFt6nMM
 3F6iH4RXN7+knkZLCwHIBzurJevwMyJXbdsR62NRUgZkr1rQewRS/CWH1rIcikMuIu9jVqHEr
 PK93BAmBGqdoncproaCJ0Ko6D5Q7pclndhenIuOn6TqcFI3kaNj0dAZEmUVR5EvFtl3AlHceZ
 g2NS8NrmbZ4WL+JNH
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jw8saDXvDYi6EpOerxYOdIb9G22HbVSF0
Content-Type: multipart/mixed; boundary="x5Lmu6EvBsSmsXv9aIWiWKLNLyJ2FQ9Fc"

--x5Lmu6EvBsSmsXv9aIWiWKLNLyJ2FQ9Fc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

OK, attempt number 2.

Now this time, without zero writing.

The workflow would look like: (raid5 example)
- Partial stripe write triggered

- Raid56 reads out all data stripe and parity stripe
  So far, the same routine as my previous purposal.

- Re-calculate parity and compare.
  If matches, the full stripe is fine, continue partial stripe update
  routine.

  If not matches, block any further write on the full stripe, inform
  upper layer to start a scrub on the logical range of the full stripe.
  Wait for that scrub to finish, then continue partial stripe update.

  ^^^ This part is the most complex part AFAIK.


For full stripe update, we just update without any verification.

Despite the complex in the repair routine, another problem is when we do
partial stripe update on untouched range.

In that case, we will trigger a scrub for every new full stripe, and
downgrade the performance heavily.

Ideas on this crazy idea number 2?

Thanks,
Qu


--x5Lmu6EvBsSmsXv9aIWiWKLNLyJ2FQ9Fc--

--Jw8saDXvDYi6EpOerxYOdIb9G22HbVSF0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6HKR8ACgkQwj2R86El
/qiBKggAgvHU8x3CCFpKgVaHxE7ZIg36wl498RM9LXo8WWopfDsWRTMS7EysrrkI
Rid67Q5LfOJKml1fbQvE58lLf74mJg0EXYVvEzH5eeowt5RpAEaALGv1/78rmudZ
hART4CytFOkdn+dRtkXkpbYewx+cL/aGOGh1NDhdRuquUhLVbOX0wjJcepnxHcjS
bEErxlmqrzSTZZ+rJ/in6ABzhXEOh/KUu3s/HogB9HA7G0HaASLY4eQq9bCB6NFW
jHJVSr5Ot6sVr6w4pV6YZd8JkKBulSQB/nAl6/hCTnreY/aVZme7lFSG7/qGTHzl
xIRGl+3+hsdUAdc0WTL8HTJkZlmKmg==
=T0w1
-----END PGP SIGNATURE-----

--Jw8saDXvDYi6EpOerxYOdIb9G22HbVSF0--
