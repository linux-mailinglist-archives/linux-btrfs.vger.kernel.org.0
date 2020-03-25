Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C0191DE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 01:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCYANA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 20:13:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:57497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgCYANA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 20:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585095178;
        bh=Gkq4pMqlMvM3jEMngy0BB5xddezddbkuCRxB0dCZE3M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F8ZWjNgwit+CnAcSEqjWS3AJaT338CxR9YWRO75xnkB/ZEErkGYv6g4csS4OJPwmW
         Ss5UnMDWcncY54A32uGTOGU1wkU0gyzmrKAKloxAwr32qqbaeNgwKGpfDXWlXKl4BF
         rng4zGxyALBMDd0SoJvRBwQpaaePOjanwCbH/Ink=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UUy-1jGLQx2tgA-000btC; Wed, 25
 Mar 2020 01:12:58 +0100
Subject: Re: btrfs-progs: RAID1C3/C4 missing some info in btrfs_raid_array
To:     kreijack@inwind.it, David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2f5db5cd-001f-449d-d370-697f3494ed34@libero.it>
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
Message-ID: <cf046899-7a7b-a93b-2340-c996cbfbc6ac@gmx.com>
Date:   Wed, 25 Mar 2020 08:12:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2f5db5cd-001f-449d-d370-697f3494ed34@libero.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QtgTFA1rwHtnRjndoU2BwE1v4WjIS1a1B"
X-Provags-ID: V03:K1:k010b+JHtW+Tv97uRYQzu0IMBI0Ili4l+rc/f3YKFw4z+DM96Pd
 oRUc4WD9chA6XRF4IR3q6yUtVKfdhNXcZMkbKKJhA8VCjWwuEEBDIJ1qRlATBlyTnMeVUHL
 jpF0YQqHCdLlDHxHFXeoX6Xc8MYAaRjNNW+RbHVVyQWd3xe+fziekaOQ1WDHi9bypGm2KUu
 BxJv/QSU7acRft7tknAGQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yjArE68GJ+4=:TQw7PDX5xfp8R3DLATCU/H
 aJ0ROdSdES60szlUiI76i7WPxCktg3d56XsW/1SunvjV9AHaSZmVx0k6761oEqQ3G40AUAcsU
 k3tm5icpfZdmbR76jAt6TiCudjMcvdmdVmBzcfQnhu5nZ+WjMQvuBIB0u8G2TVB9J+YewgjFH
 q6RxaWhGTrFlyP6ri3DfMTOseBjVP2JoE1R6HpFN8HmeFx/wtS9B1+bCnB1SWhbwE6aDS8NKI
 wVxYeoRFLych+FZxIxUZkJe0Jc2reZ2KlWcf8t0mhJ0pEv5I0nMMYYN1FBzSGocXCbDzXDZgY
 NOOYewuldP1AOTbaz7DXn7La/lK/MJl9nYt4CceaZIhWG63qjc6Bux5LQswg6TOGXCMdQocf6
 Xl5+/Ujf/o17LU3EIZBYcx3HrZLkaDc2BNb9wSzn5Xfb8aQMPGg2YW5/VHyknGEd4mHJB+1NJ
 x3Vu4x+HitLg9wu/9KRwy8fQxM39yhsgfNaxuNupqMss9o5+o9XrgMPWh1CTw0RUN7tu0T0Hl
 rGoEdwg8TVZvPtp56Ix75T3Qk6i6YVgDNBlAlE1DNSMixyO7s+58Yoxq5QhuR3zJcOL/aWVdY
 Ap57Qf732JzUbIwlSTEGZmwC7efMmguZiM1UYl0jCZt3nF+h60DCS6xTdkRhw+eva6IU2Jdv1
 u7HPoq4VCYKk6l98L0fW6BhYSHtwC3cXIZXYb+E8JGG81Xm+1L6EEsKJHlz+I87Bk0G1NC6ji
 3HgyGq3MOmc8y7FRlveuo7uKHvz+h5yqOqaXhHXwNXsw9SS6p+G4ssCzmtUrgdiLcCCs9wQ5r
 R1MLq7Rr62e18WBe6p5RKkk7IdzGVqf/wCaMZ6SEOWQbjybX8yJg39cbfsG7jGa8zHcqsovpv
 X/zksYHBvUTEOMKOVZlg5M80JMcPtGID2wyoZSYHK1C05k0fNLkMXX2DZepjvFFcHL94bPm1J
 DiLd9WgDpKOsbTxGP1yKV4IyKArotrs+JkqozJvN1/174D/nwy0Z/ePMsbPjqqg3Ps/xmCVv3
 /QlEsuhGvQxXGVGUtzZQox7CuEl9phArmcbav7lxkhfhCftM98+4/mF5HlrVVMVrqYqdRWOIA
 qUg/7B1ZioenxMsn3nUqk4s2aj4x8OYOw1vtcRTqTtINd1LJz7gYcF1YoI4rH1MrGoeNRnNKG
 2vhWSIkORKMJBoaUUoMuY2i7xALnhW3uc96lhhLWD88oNwNs3QjKfmcxrNekfou9zp146gx76
 4+Xtx2D8mgO+43Fic
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QtgTFA1rwHtnRjndoU2BwE1v4WjIS1a1B
Content-Type: multipart/mixed; boundary="j5YhEj9uZKaJUe3QkWl9axXlu6aK9ks8j"

--j5YhEj9uZKaJUe3QkWl9axXlu6aK9ks8j
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/3/25 =E4=B8=8A=E5=8D=884:00, Goffredo Baroncelli wrote:
> Hi David,
>=20
> I noticed that in btrfs-progs - volumes.c in the array
> "btrfs_raid_array", the info
> raid_name and bg_flag are missing for the item BTRFS_RAID_RAID1C3 and
> BTRFS_RAID_RAID1C4.

In devel branch, it's between RAID_DUP and RAID_1.

Thanks,
Qu
>=20
> Is it wanted ? Which is the reason to do that ?
>=20
> BR
> G.Baroncelli


--j5YhEj9uZKaJUe3QkWl9axXlu6aK9ks8j--

--QtgTFA1rwHtnRjndoU2BwE1v4WjIS1a1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl56ogYACgkQwj2R86El
/qjtdQgAnMkIxVucQPgGtBKgS2NQAbvZ1vPpSeI9AFNydrIfHD4PIX5rZI1mdBeF
GKzba9nFxZdJ+qIqbJri2lzIuFEjp9DQmOsRWb7LwSm4Pk0jtTtz8SssMrj0MIbk
MxAXSdilscMacq+1HVuIVxPLF0VQKxK4wwK58geyuUA7ayWB7emNMDm1MNjsxH/W
CFQDqRUwvwSqPO5gTjkuL4GL7X+d8Wb28/kZn2bBTC4RTCPdIOxNFjz1Ou9f471s
xDRNM6Vvd5Qw2s015VlJqKiZSNB4LJK4ssgIMQJXjUuN3JUv6JihAY/8KhrtNQWu
FmX6XNNFMni/wLnKp1B8EAzc+wJiIA==
=UPUN
-----END PGP SIGNATURE-----

--QtgTFA1rwHtnRjndoU2BwE1v4WjIS1a1B--
