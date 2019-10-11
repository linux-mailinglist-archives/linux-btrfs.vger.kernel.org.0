Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C994D376B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 04:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfJKCM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 22:12:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:50949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbfJKCM2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 22:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570759641;
        bh=hJTZTs/s3ThVQnshpTAOylSOHaZ4EvkWE1wOHm1fKEA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a5DlmZzto8x6I5pop63+Jj1kFuLefl9ELqT5dhMEEnFCg4ZTGN5eHr4/p8fgXvhFa
         ZsYlQXDtpQA95lgajYktNyvzPZtg/IZ32bkPeJzRgml6qTLc5cRIjlQ+69irDmeDNz
         y2axn06LSo3ImLGGc+wuCm3NfF1PRzV88Hof9KuM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulqN-1i071X2HAZ-00rmru; Fri, 11
 Oct 2019 04:07:21 +0200
Subject: Re: [PULL REQUEST] btrfs-progs: For next merge window
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191010085932.39105-1-wqu@suse.com>
 <20191010161757.GV2751@twin.jikos.cz>
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
Message-ID: <64097cbe-4c2d-2c90-f64f-b4dad84f87ed@gmx.com>
Date:   Fri, 11 Oct 2019 10:07:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191010161757.GV2751@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dGcBbARLXa5g6qgPIVvSEbtEctZeqK0sU"
X-Provags-ID: V03:K1:tUdJePnq8LcEh70zXsrCrcw7OOweT6PC4RWp2yeBFuY2ifu6Cgc
 TFgfQOixq3gQXPVdJHsseZeZby6j8RV6vW4uKEtnq/kq91bG1AUbuKrTQ/n+dFs2HcsFHTo
 r+BG3PdI9D+754n2cVpWbJlgp5GCws+DCykh+5VsJiVzjLWFu2jcaZCz3MFAcdObyH6uJIn
 GHQR9WG8ktYz6NSSxybRA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nmQR3D04xAU=:ggtcnxCkOWA6X0neL9tE7n
 0E4slh9ZV7TphxLh89zFqmpLSMVz4j3C5M8QKqeTJjOO8y/Wtawu+l2tPA509agAG9bP3liqu
 MWxA5D8HJZ9Z2PD2jjPNLznFIQYvdTV9tF1HR+3IL8z8+Yf4WTSLFqTykq+DJDRRQhReN/x5r
 U5VylRyAYCAoyDngGoTi3Sog/zaiaTtvNZdlYT72Ud4SSkqLXzzpIk4jqLmF8Jh/lA+L/VjMz
 r1pH1r3JxrfJnhyo+8/kF9TdalFwOeLEKJszqKooB78dCrmhbvvAtnx3uHVU14NTi61hHXtug
 vanK48n5P+bb5wHq0z3skjw+Mn07mVX7ZmLPXJEqWasEtwOonDrtNtZVWuTQSzLavLvmYvI4S
 o7JFtPogFTWiiuAYUetHLAekdisdxtc+moMXlxt4Lt42WoJO5zrPTfGZKDiAcylBYwwnXcTby
 kkhGpopyUmpGh7q514uTsdyRhejvxFRcUqhrxgYPnKKKHaQn7O8lUnHMa7Q/Dl5OW+axRHU8o
 PYPLPI79HAhR2oCl9b5kiRtvac0moN0c3/ATrieyXPWMskXhCNextmvy7pS8vevkxo2kyN/GT
 +jYxZuRjOmyH4MxuZAeUsOQFYjh8D+YpUPkCuGkAKeqfgB+Blr8YvTz6CwB+23iAlsFS2YaT0
 6RnVCCRzPGjs2Uw8A9S2NEF/hqZf31srqSmeRxjsrkf9uvrdCo+JCf6tW9KFZDL+slNMd+oE0
 XuMeOGOgv+xoa66A9/42zg9GUVVER4vhaT8ZvAZ5Z0g67ex5fu8dX9KxXv90jCkVaRyf0BzpM
 k93ekByAUxLP3IXyn5zlbHoTmXiet34kHtfWozYJvypj4PTENC8iyS+26nKDY3zeUpMswarNQ
 4/k+tD8u1qKpDMHO7vDWaECM7yPlIxS1Dxld3zV93WkSfrtPTTjW9TtvWarWN1K+cKoaIpOJ6
 BjWUp47eBL39CGSAntBd4AUl+IdFnDCMtQsQYDZM1+IQ6zPgWPlnCFn8TV6rmsOSFVWqhWi1X
 4vVvZXVHgtSL/WP4ncjKzLrFys++Hb6+MSIo9GDA1pVlGSf5KWAPEXQQUIX2HaYsiOw8wcTfu
 Euqu/KzmRS1FCeIkUFBAxFnjxjMTkzsgxvqJO8JhhvwWuZjt/GIYRcoS4PopVYcjeaoZ6ViVA
 jEqAwdVA+Y/kSOj0NuwjEE0fXK4UhN2D0OQavW/Wjbf5g/OClCri8ug6NWuFFW5ajLJqofznh
 z01iUMRNU0XNRSVF4VwrjkedpzFrg0B3xzRSJGV18eY4RzxcFapC8OKPuTGE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dGcBbARLXa5g6qgPIVvSEbtEctZeqK0sU
Content-Type: multipart/mixed; boundary="UL290PFDB0erNKDMsWFOEHCZohSvpHtMZ"

--UL290PFDB0erNKDMsWFOEHCZohSvpHtMZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/11 =E4=B8=8A=E5=8D=8812:17, David Sterba wrote:
> On Thu, Oct 10, 2019 at 04:59:32PM +0800, Qu Wenruo wrote:
>> This patchset can be fetched from github:
>> https://github.com/adam900710/btrfs-progs/tree/for_next
>> Which is based on devel branch, with the following HEAD:
>=20
> Thanks for putting the branch together, I've been too busy with kernel
> work so progs are lagging behind constantly.
>=20
> The current devel branch is almost ready for a release, some patches
> will be moved to 5.4 but I'm planning to do release by tomorrow. I can
> pull your branch as-is to 5.4 so we have time to fix any problems.

No problem at all.
Since I don't expect this pull get merged in the next release either.

Thanks,
Qu

>=20
>> commit d928fcabc8aed32b5ccab71220abcff9bffac377 (david/devel)
>> Author: David Sterba <dsterba@suse.com>
>> Date:   Mon Oct 7 18:23:52 2019 +0200
>>
>>     btrfs-progs: add BLAKE2 to hash-speedtest
>>
>> Please note that, for some binary test images, the patch from patchwor=
k
>> doesn't apply correctly and would cause empty files. Not sure if it's
>> abug of patchwork.
>=20
> I'm applying patches from my mailbox, I know that patchwork used to
> misapply patches eg. when fragments of a diff were in the changelog so
> I'm cautious in such cases. Thanks for letting us know anyway.
>=20


--UL290PFDB0erNKDMsWFOEHCZohSvpHtMZ--

--dGcBbARLXa5g6qgPIVvSEbtEctZeqK0sU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2f49QACgkQwj2R86El
/qgbcQf9Hy6BpOgij4gKFmJyF8e4vuKPxKs6Bldc+oXGUasCeCOQXifvfOqlE6Br
aJ7Srgr+lMa+QShzxKUiISYYKZ+Hx6hwHah2coFbNORK8jyaVjN+zueYlneGm2Hm
vFmSe4Aog/hTEjstTgn80EwHpNTJV8+cNXFcl9YjaUNuom62OezWVi3Se0ydjb/B
4b/VTWyIWWAu8jhWJCLtLUiVqoF7sspNZgw2FBfO2phuvlWetnJ4RUWVyIktXnRY
1+GJlu9XA79db10IBD3ErM+JbcsRoY0afqQrDkpzM5vzvDuvKmz4HU/BFch/9Vix
3j3/LAAUWkiQCT+UupXD1Y6mkpOJJA==
=hkCC
-----END PGP SIGNATURE-----

--dGcBbARLXa5g6qgPIVvSEbtEctZeqK0sU--
