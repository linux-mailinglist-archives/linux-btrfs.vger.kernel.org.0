Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936DF2317AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 04:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgG2CaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 22:30:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:34921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbgG2CaJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 22:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595989804;
        bh=9YIzVZnqRlPJDXnZDMIDrdtVfp6CxS9tUvELYt5ON4k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BE4Ndt3B5Iup4uyJhyW+mJdjzUY7bfEy6XXxgdk2CIZN7QkIrXHFQMYCBpNM/rS4a
         OQAejHk/J8t6k+/FgLxc3AOFJ0FHnB1W0akApsdPdkVuX6+AiRIcbwURE8vum7nmzR
         pkD/dz0pVpU7QLWiOjiUjRPRqvxk7qMi7oD7l7Sk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f5T-1k4iaS3XuJ-004Diz; Wed, 29
 Jul 2020 04:30:04 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
 <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
 <20200721135533.GL3703@twin.jikos.cz>
 <cccdcdc8-db5a-779d-7b99-346ef14133e5@gmx.com>
 <20200722113220.GR3703@twin.jikos.cz>
 <CAEg-Je-QVTWQeFg1gJMSXcBHzniSjMNxSXiN2L++_YVeTwZH_g@mail.gmail.com>
 <493ab1f9-9f58-6d8e-647a-9092e1e0480f@gmx.com>
 <CAEg-Je-VLKs1XO+PocCDVPb8mQPFbXZxYmC7CRnCqkSxVk1EBw@mail.gmail.com>
 <b49639fb-20c4-6944-1109-57c7a19c8039@gmx.com>
 <CAEg-Je8TAWG-mnBs1657CTuNNDyvO52t99v4ncO6NfK_V0H2_w@mail.gmail.com>
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
Message-ID: <ee1eb7be-dcf3-8400-55fe-0c347c66b839@gmx.com>
Date:   Wed, 29 Jul 2020 10:30:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEg-Je8TAWG-mnBs1657CTuNNDyvO52t99v4ncO6NfK_V0H2_w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j75vpVAtwa5O46pwON9pxul9av984Eh4h"
X-Provags-ID: V03:K1:xTTnuWlWRrp+ETlMJ/ew5HjJYEg9dp1lqFWu3rgip1hZ+eWm9cv
 4/oKhe4wion58rkLQoZYPDTyWqt4Q1MfseOJu2sMc9wm0eKHRZesWwe5khbI6kyRnI5kYJv
 rAqBtE5YJF1IiOT3celTCH6p+PgvBLetcR6WnfDfgw1ZfdMUT4rRAnYPQ8f5+RllnJQTTjW
 vFFyahr4HbvE84Gg7upDw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L0SHyOgOQYU=:nJoM9WaBZfjOmOiC2V2gSa
 ZSAXsk/QCAJ6h0BwTaDIRXRlsO47m+NyO2SDlFIVYyd46YoWaAZtIxMQzoUhoC+B4S2zpNDUC
 maYP9VHZ6kALLo3EeUJbf6lJv3M7nfvZX+rKfPPsv7JLt3r9R1iozDRkCkJdzNz99i3aJtak8
 +1BvI6gWCOUiLNIbBtHNLREik+SwEVklUy8e2CsOFa6/3Tj8pFcWdv0XZCoEUpBSV1z6fBy8Y
 69bPGNANLs9Vt8qEEcMH4vau066wvdcokiCrzpwl3+7RO1YdlY2/8WVcm3uXfUwsdPb3F1Klt
 R2aac1opfKxwrsKiA9psG+o3d8FROZo/3dpjlVl8U+FAIJ6KRCvBfSaeWLS8ThOQDKvEQr/zg
 +TAdQWVJnD8fSpdPqufvSnhdRV2vy9hXLLvl1Hsu3yhXzv5D/QhYf5sesOlXthk7o9o1AuO4g
 Da+KKnClzPFbt8y2IOLp9IRjnkyU2mJwMH6PerUZyRgG0Ny+8WqdTPqN2/3x8q0Z6bj9zd++O
 qwHAG+P6PWdQDfF+SY3r7nVStENCPJotPWYjKphBCSE2jJzeULTOoHFijtgXhHz4fGm7F9IhG
 kkdtauZJN3OhmliqpilwS9HWtE+b0GxbUzDHHryd2VpcPHwpo6g2mZL9mAWbunhy8pA32H3iV
 A/yi/iauC2z6c+M9vMEfrOqTQg8yMg781oRTcoFa3A194Ncl1/hfA9mXKkjvq5HzCGtUoIF6k
 0rKJxxRGBvYdKtZtHU23IfykNghOHbUwnV2SLFSDNZzFrc+/10EBAQ2AYQ2xQYmjthN+d+XgO
 0+EM/iQdDS15IOpeIl/E3tZZhhUurNNMmuEPhJhA7eHtiJFqlV7dHSNNPhuh0KSg0sV8nQgOg
 MI02tcLVOjGXtePd/tZ5gAw8tDqACeY8E0tCJ71bC4urvESMYBT9ROGq2xWr0rJtEN2QJf0Mt
 8ovlUt9MEvr0AD7gAVS9K6yxTVbICi7Ucu4qramQV1TKWusbMqCGs5bgX6QM8XEyXlTwvF0uD
 IrgMhiaZt22rk17qF1uiaF/qAyY6lDn9pCLqCWoCooTnp/nHiiakC6U5bVpJzbGYuxBy+KqoX
 A7paTlFPZSJIzEq7wAhqknFDrIOQukUO84ogLicjrFOdE5qiUc/ej5dojvtynMGCDyJPh+kzj
 ake/hQkxBYG045mql+kiFIy5YcRtGCv0mw0ge5PDFK5cbdNbDjUPellxoJdrBjjacUW84oysH
 pp8z3Qfgs3SE8x3L9eSC4YM4irJ2jAHBsMoeQEA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j75vpVAtwa5O46pwON9pxul9av984Eh4h
Content-Type: multipart/mixed; boundary="mf9cgjg8cOcUZREIHSVZstoC3UzQ3Jbb7"

--mf9cgjg8cOcUZREIHSVZstoC3UzQ3Jbb7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/29 =E4=B8=8A=E5=8D=889:56, Neal Gompa wrote:
> On Tue, Jul 28, 2020 at 9:20 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2020/7/28 =E4=B8=8B=E5=8D=889:14, Neal Gompa wrote:
>>> On Thu, Jul 23, 2020 at 8:02 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>>
>>>>
>>>>
>>>> On 2020/7/23 =E4=B8=8B=E5=8D=889:31, Neal Gompa wrote:
>>>>> On Wed, Jul 22, 2020 at 7:33 AM David Sterba <dsterba@suse.cz> wrot=
e:
>>>>>>
>>>>>> On Wed, Jul 22, 2020 at 06:58:39AM +0800, Qu Wenruo wrote:
>>>>>>>>> Thus casting both would definitely be right, without the need t=
o refer
>>>>>>>>> to the complex rule book, thus save the reviewer several minute=
s.
>>>>>>>>
>>>>>>>> The opposite, if you send me code that's not following known sch=
emes or
>>>>>>>> idiomatic schemes I'll be highly suspicious and looking for the =
reasons
>>>>>>>> why it's that way and making sure it's correct costs way more ti=
me.
>>>>>>>>
>>>>>>> OK, then would you please remove one casting at merge time, or do=
 I need
>>>>>>> to resend?
>>>>>>
>>>>>> Yeah, I fix such things routinely no need to resend.
>>>>>
>>>>> I have a report[1] that seems to look like this patch solves it, is=

>>>>> that correct?
>>>>>
>>>>> [1]: https://bugzilla.redhat.com/show_bug.cgi?id=3D1851674#c7
>>>>>
>>>> Yep, looks like the same bug.
>>>>
>>>
>>> So I backported this fix into btrfs-progs-5.7-4.fc32[1], and the
>>> reporter is still seeing issues[2].
>>>
>>> Pasting from the bug comment[2]:
>>>
>>> [liveuser@localhost-live ~]$ sudo btrfs-convert /dev/sda2
>>> create btrfs filesystem:
>>>     blocksize: 4096
>>>     nodesize:  16384
>>>     features:  extref, skinny-metadata (default)
>>>     checksum:  crc32c
>>> creating ext2 image file
>>> creating btrfs metadata
>>> convert/source-ext2.c:845: ext2_copy_inodes: BUG_ON `ret` triggered, =
value -28
>>
>> This means we have no space left.
>>
>> We don't know if it's the fs already exhausted (little space left for
>> EXT*), or it's btrfs' extent allocator not working.
>>
>> Would it possible to update the image?
>>
>=20
> I'm not sure what you're asking here? Do you mean update the live
> environment? You can boot a Fedora 32 live environment and update the
> btrfs-progs package before using it like the bug reporter did...

I mean, upload the binary dump or e2image dump of /dev/sda2.
e2image -Q would be much smaller and without any data stored in it.

Sometimes that's the easiest way to debug.
Or we need to add tons of probes to btrfs-convert and let the reporter
to try-and-report to pin down the bug.

>=20
>> BTW, even btrfs-convert crashed, the fs should be completely fine, jus=
t
>> as nothing happened to it (from the point of view of ext*)
>>
>=20
> I figured as much, but we shouldn't have a case where btrfs-convert
> crashes like this...

Yep, the BUG_ON() should be removed and replaced with a more graceful exi=
t.

I'll do that soon.

Thanks,
Qu


--mf9cgjg8cOcUZREIHSVZstoC3UzQ3Jbb7--

--j75vpVAtwa5O46pwON9pxul9av984Eh4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8g3ygACgkQwj2R86El
/qgeigf/SciAdkrKcqtfnCi8NDAru8jkNJCYTATwcRK7ZjC7pZDLheU8/9hpmRLR
jUJCEUZVc9VuFyUnwayqZvM0RrtgYSkclHZ5pbTw26C1RlEWstiFwt3TwQqdtwPP
XYkQA1CGH1vlcXW/kftqsPmWn14/XvoqtRtReUxfptk5JUAp+GbOrCz0UKt5eACF
6DVYhyafjPTgEwJlRISjiT/xuGhM3zXl27Qnn2noXXwdry3gWKCcpIRAuS7TgEgD
iNLs2Owst2FH0cGmZwgk01Jb9faaZFEGlyerXly3bMOlLPAHRRb6TAWyQAX+zjAD
E9s5S4XLSei6FOvGmFOzXlu0sz3hmQ==
=op5g
-----END PGP SIGNATURE-----

--j75vpVAtwa5O46pwON9pxul9av984Eh4h--
