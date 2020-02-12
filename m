Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3324B15A8DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 13:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBLMMN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 07:12:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:47403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgBLMMN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 07:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581509521;
        bh=ra5ITDwjgBh1KvYEpcfTq97+E6i7WsJNiQmhxv+9lMg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=eRmpZiFucMIbsUNJg9YeTYKpqEBGAi8Ef9a7XnYCVRtCH2KM61sK+GWQWgDAnO7ol
         cMokAk7WVROJsQk03i6zaQGR2ZcWiqx57K6i3X7WpI4uh7CwVxhzNnQyOxSnUwRGoV
         6cj0vrFE0JZuiYB7tPdynkx6D4zN7FcbumdPAh/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbzuH-1jdNYF49tv-00dXbx; Wed, 12
 Feb 2020 13:12:01 +0100
Subject: Re: [PATCH 1/4] btrfs: backref, only collect file extent items
 matching backref offset
To:     ethanwu <ethanwu@synology.com>, dsterba@suse.cz,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200207093818.23710-1-ethanwu@synology.com>
 <20200207093818.23710-2-ethanwu@synology.com>
 <0badf0be-d481-10fb-c23d-1b69b985e145@toxicpanda.com>
 <c0453c3eb7c9b4e56bd66dbe647c5f0a@synology.com>
 <20200210162927.GK2654@twin.jikos.cz>
 <5901b2be7358137e691b319cbad43111@synology.com>
 <aeb36a34-bc9c-8500-9f36-554729a078fc@gmx.com>
 <20200211182159.GD2902@twin.jikos.cz>
 <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
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
Message-ID: <8eeca7c0-8283-8cd6-2354-9eb9373c9bd3@gmx.com>
Date:   Wed, 12 Feb 2020 20:11:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <c3b0f59840b81f4dd440264fb4276d9f@synology.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ltXwPmsbSr1cvfO1oRmOKcBcrQYImWq0u"
X-Provags-ID: V03:K1:4X2gXWnTf8k4cDWNMkP/gYOKLcWpGWLJDeqzBjQ2W9JeBh1yztN
 vDhzq36jr3kWaFac5iO0YLuTCjoY46DMjlCFSyaYyLmUerAt3qtt2EVXvHAjakTU+4pGP7C
 IURlwvTIZXZPWQfNcHxJ93fZBlh6oGyNUgkVzVwnzEe8/tQ2h3WvYq/3Otd0oE2y9uov0VT
 2X4/GKOxpjOz0jbCYEGuQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JxKBwriOy+E=:Di6gOHTVbZruTnJPexIryC
 U9igmbT3W3AAD85oSwEu1j71ATuCa8W1OTfJJK0lxxpBBUrgL4pYsAYs2HInpv5LWCj+mVNsj
 Zz82iPPtXV9OiUVmzmSCzEOd3G8h8nIzUAaOXYxA2B8CcEIXkUiVsY3rtXi5mj8lrKC0Ibpwc
 t7ZN+gLBUk/WIHUX3Mq8fB5PNDkB+/HrbfD4hevklV8flyfCk/fjxXXu+9xvPK4ss+asTa5vk
 Zi6vbnxUPyVzXAlZvkF2yfzwpoV6U0hXidow1EGn27oc0KGUeC714OAuVWP/eggZZuv8+TyWX
 IIhqPRNNXr20W90jUAT0Ppo9tBj64/O75RaN9VnBnrNuHRYRYiBKHP1URk8ZnuOYI8+v8u4VP
 4Q1bBX+/gsSSDBC/K0I2G7gxtVrKmWaKCfnxtZkYiVMRrdp0s1qIWYNkEnuGnRIrElS/RJ3sR
 kvagGs+PpHdxZA5gbQLfT/A/pEC3i75fOiUSPO2rTKz3pkLyD40a7XQNMSbqXggSTXNWoJPXw
 TL65SR9ep0oNLggg0RWV6y2pVfk+npgnIS5m3rfUEVaMbCxlnCUPUwWZqBDh294Y0qq8uq1y6
 469niypcukI0R9MJmpSdsOGanqBMG1c2QRks0SWmq1ku+hK6PZ3oROuvkqF/5j/uW3CiT0GTd
 BIEYBTdXC1LB62ii01MSm54SJ3G7Z0/IN8RPLCZpJq87//WxfxII5aXH0pYOQQBmLKYlcxQIZ
 T+LQ4UPnz3xz0lvtZFPEK68B3Q8WIBXBUowEBeyIyOfGRo7g1Devb9p0cksqBCPABKWXaHFYt
 Y886yj85Gbabka6pB6LIG0XZzK4x/D2I0VWddJ7dgN2vCWidTovQcqjFsLD+gZV98QODS7GRx
 vDMams2abG1+DjyH8zCumuz9CevfYKZLyQIt8uYu0N7zVYnZZOWe4mHuadeIpFwlEWbBZqMD9
 3qf1QfNWi/6lcDkqlrvCowg+uCPlhHF+7QF5XdCPfTzWT0gAYb2JD7T7s5FkJuK4AwodSB8qx
 Dziz+myEA/fGUENR6kR9lgnRguKgjk0B53w3FapfVvvwnA9wfhM72pkiust1gn9/TnrMjSHGt
 Bt7ABM3wi4tK5aPUfVyWFRG3lFITSYYcn5QaW4rqdf3qBD/3wlJfI/Ab9IzpKkYW+HTK9kCXA
 HUU5C529IzxKyUhIxf4uOe8jany3PqfbVC25fbHAHhj8gc5oSdAg8OrRU1xZAUDV9U7WSyX5Y
 f1LXZlFzFesACytgi
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ltXwPmsbSr1cvfO1oRmOKcBcrQYImWq0u
Content-Type: multipart/mixed; boundary="eSy2dJKgE40AnV85pLZj67rNEoj5Cmw84"

--eSy2dJKgE40AnV85pLZj67rNEoj5Cmw84
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/12 =E4=B8=8B=E5=8D=887:32, ethanwu wrote:
> David Sterba =E6=96=BC 2020-02-12 02:21 =E5=AF=AB=E5=88=B0:
>> On Tue, Feb 11, 2020 at 12:33:48PM +0800, Qu Wenruo wrote:
>>> >> 39862272 have 30949376
>>> >> [ 5949.328136] repair_io_failure: 22 callbacks suppressed
>>> >> [ 5949.328139] BTRFS info (device vdb): read error corrected: ino =
0
>>> >> off 39862272 (dev /dev/vdd sector 19488)
>>> >> [ 5949.333447] BTRFS info (device vdb): read error corrected: ino =
0
>>> >> off 39866368 (dev /dev/vdd sector 19496)
>>> >> [ 5949.336875] BTRFS info (device vdb): read error corrected: ino =
0
>>> >> off 39870464 (dev /dev/vdd sector 19504)
>>> >> [ 5949.340325] BTRFS info (device vdb): read error corrected: ino =
0
>>> >> off 39874560 (dev /dev/vdd sector 19512)
>>> >> [ 5949.409934] BTRFS warning (device vdb): csum failed root -9 ino=

>>> 257
>>> >> off 2228224 csum
>>>
>>> This looks like an existing bug, IIRC Zygo reported it before.
>>>
>>> Btrfs balance just randomly failed at data reloc tree.
>>>
>>> Thus I don't believe it's related to Ethan's patches.
>>
>> Ok, than the patches make it more likely to happen, which could mean
>> that faster backref processing hits some race window. As there could b=
e
>> more we should first fix the bug you say Zygo reported.
>=20
> I added a log to check if find_parent_nodes is ever called under
> test btrfs/125. It turns out that btrfs/125 doesn't pass through the
> function. What my patches do is all under find_parent_nodes.

Balance goes through its own backref cache, thus it doesn't utilize the
path you're modifying.

So don't worry your patches look pretty good.

Furthermore, this csum mismatch is not related to backref walk, but the
data csum and the data in data reloc tree, which are all created by balan=
ce.

So there is really no reason to block such good optimization.

Thanks,
Qu
> Therefore, I don't think my patch would make btrfs/125 more likely
> to happen, at least it doesn't change the behavior of functions
> btrfs/125 run through.
>=20
> Is it easy to reproduce in your test environment?>
> Thanks,
> ethanwu


--eSy2dJKgE40AnV85pLZj67rNEoj5Cmw84--

--ltXwPmsbSr1cvfO1oRmOKcBcrQYImWq0u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5D64wACgkQwj2R86El
/qgGwAf8D/b0ieD/wqKVuS7f9pXntwgesiaNRP5kDfZ9NuGEt3jh69PKi9T9UUFs
7Dsu85pi8kifnjL4zmU4XYwYfI+f8qNP+O0z80JKfMLl+TUZpvyC0KdjxpLswrhc
IGtQvCeLUqROwFpiGclOt2hPA4/usduWO6OQz4hf6sfHjCvFgxdTVwPTb87+8nVe
J79JVe5TFumN+y10olIu8pNZ2CI4PENK95jCI7gBWMv+cW0sCyvZ7/iDvCvkF/JY
WV2t1L8P9QOfRB8aWTQs9dMX+Jyz3bXLpWrDt6yxeQZAqK6JcO8sX0dnhl9z8kLe
PNyc889n1u0XkBbiY10ciZJqhyvvzA==
=muFz
-----END PGP SIGNATURE-----

--ltXwPmsbSr1cvfO1oRmOKcBcrQYImWq0u--
