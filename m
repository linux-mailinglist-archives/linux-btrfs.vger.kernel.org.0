Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1813F85D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 02:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLBCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 20:02:50 -0500
Received: from mout.gmx.net ([212.227.15.19]:42075 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfKLBCu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 20:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573520483;
        bh=C8O2s6Pg9DeIECtbMxhVUG4s7zeGxSs5e1ITqZ6XaLY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=A+2pRRME4iEEv9RL+IKRTg+2+I5Yhsq3bR+D2v+ZXuzsFzoj/8pqdxoTajoP2xTmd
         Ud4Csa7XacWL+GmSM6a7X3Asq07IfMR4uoKwiDtwx8BnNeDZuBZebU6Hpak9tY0grd
         TapbW1PcpkIRU6wExjdVRr0ONTE1Zzqe1n6D+oyQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9dsV-1hsMYZ1fM5-015YKb; Tue, 12
 Nov 2019 02:01:23 +0100
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat
 features
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191111065004.24705-1-wqu@suse.com>
 <20191111180256.GR3001@twin.jikos.cz>
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
Message-ID: <aa6d036e-bac9-1756-51b7-12167bd949ac@gmx.com>
Date:   Tue, 12 Nov 2019 09:01:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111180256.GR3001@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zZYimA061lfdEJZZIUfuA8hjGyhhKhTsI"
X-Provags-ID: V03:K1:n6bSDFV8UbcIA9xb6mzpWdhgkLsa7nEILSM+RRfK1EvmAQqd6d5
 snk+UNQC+ghhT2XgJgjkUp9UbnpUk3m21f3wvTqQN0cdAC9h7K4EBJwld2l4IJOpBol5bLM
 Kw0lY4K4oVmCd9uCesXMJ2NpphZMhpD3+C5u4QfxSKIIkTXKiQesehkfxg8ODHAr84Jv1z9
 CCoLXlnwH45J0icT0601Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LDz/PtYAx2w=:hcj0LxdR8aRpsSh4b/UEEO
 M0CzgojWUbzy3Ocyu1PTFRWhRtudX/KBWcPilzryoN/TPy2BLavnlzJjMgJRyqNKhxnFRNT74
 15h+WW3YKnPg3XYsW/cfdg5FLb09rsKxx6sie7YUPSsEa40W1wRVE0aEeCUQZke3HvQMwTtOv
 nUA8mTDbyzFTbofeb4mr3o0eo8dlF6BQX4uYVGi2J97Ue6DT7CchLaWy56CogyobIW3jfFfqZ
 rglmgrA+jA2iUlWLj0QIGcW68GmodJs2KiglZh0o8gBgsZp6UrOknqT0CuqMZkcQ8V5Ehl4D7
 mEfQDHuVrS6UDsp6CuEATHzjo0jFcMh8lVDGeLYA7A5irBVX/9rpOsSogbKRf0ao4OEoiDClr
 g9BmDrDN0dVe3eysBfix1vZklpsK+MrTaRsdfD+kLRgwMga6vUlL/kQ+QdnWzP6ZcZVVw2uNQ
 zfFISq/eMwwfX17NK4f74KwlnM08+DT7w1mWKHGB0Dy3Of77UjDeQI7t5Lcjq/S9LM3Bjo777
 wh3IvOngpvP3A3y8Wn1fHmNx2m/cDtQLsxFqx6fQcDu/U6DnTnQhSJVQ6wmGUGOdeykfsosrF
 A5gWK/1oATMX6C7Gk88AjpX4TAk+igbD0OCITqlsbFE9otwSEc0oqoDGYXGmCWzlqbiZUD0R1
 FDwzo/AnK2LZjGTTxI+tStnzontqIZUhq8OC891+fvqPm1ugPmo8Qfig3tOAQIEuDGVwi0DlN
 8NI/vedDU0k1XoBQKPMNzS5dQRTQFeYxEMRQF3LBAeMgNfcTAv7MbytChGy/gEaLva9N1hjfu
 ODxSMuxqMsKJ3XFs1oEG8tnNJ9ENj9Hfcb8Ww3isABep6qOUO6Tku0BSaqiJQncR1DCFtvflr
 fjn+6q+X8XtA4HGmu+C+heYp39erVX9FgPmwDQwjF6eM7dsRE7ilLgsiNwX2oMUMcHvCSum7P
 NaQZSeW3I3paVKG574SKCAoOfYonvgJ4ltkcrzMT8xRKb6ApVW1hZq2rnNmeFaG1Dhsx7RhnS
 2UPcRzicM6q8DXZa5HYhAV/BQsc6QsmlGtmRUzhP8CAhbRm9nW7e7spENxEEAh018cUoOaY9x
 O6Hct+71QBk5Vy+LRPThCISRXMEGQ158x8kWBPPpVsiZZfYo3n7Yb0ZqMQausSCWB/aDScFHH
 ctHb0mem3JBNeqGm5o/taQZmKvMfkin5zq2CnhQnXNe0IlHcfreb820shm5w/hXXyKYDe2WZE
 NQh/Z/CrS7YqzQWM7Iu5S7vDrlYnwddKoLvjs/3fTFgu3JUPOjesq0n6dEFY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zZYimA061lfdEJZZIUfuA8hjGyhhKhTsI
Content-Type: multipart/mixed; boundary="WRJLP6Gvvo6lfZJRhwRlgGukrcTQBy3bg"

--WRJLP6Gvvo6lfZJRhwRlgGukrcTQBy3bg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/11/12 =E4=B8=8A=E5=8D=882:02, David Sterba wrote:
> On Mon, Nov 11, 2019 at 02:50:04PM +0800, Qu Wenruo wrote:
>> No-holes feature could save 53 bytes for each hole we have, and it
>> provides a pretty good workaround to prevent btrfs check from reportin=
g
>> non-contiguous file extent holes for mixed direct/buffered IO.
>>
>> The latter feature is more helpful for developers for handle log-write=
s
>> based test cases.
>=20
> Thanks. The plan to make no-holes default has been there for some time
> already. What it needs is a full round of testing and validation before=

> making it default. And as defaults change rarely, I'd like to add
> free-space-tree as mkfs default as well, there's enough demand for that=

> and we want to start deprecating v1 in the future.
>=20
> I have in my near-top todo list to do that, with the following
> checklist:
>=20
> - run fstests with various features together + the new default
>   - release build
>   - debugging build with UBSAN, KASAN and additional useful debugging
>     tools
Already running with no_holes for several previous releases.

Not to mention new btrfs specific log-writes test cases are all already
using this feature  to avoid btrfs check failure.

So I think this part should be OK.

> - run stress tests + the new feature

Any extra suggestions for the stress test tool?

Despite that, extra 24x7 host may be needed for this test.

> - check that the documentation covers the change
>   - mkfs.btrfs help string
>   - manual page of mkfs.btrfs: benefits, pros/cons, conversion to/from
>     the feature (if applicable), with example commands (if applicable)
>   - wiki documentation update

Forgot this part.
I'll add this info in next update.

Thanks,
Qu
> - verify that all commonly used tools work with it (image, check, tune)=

>=20
> For free-space-tree specifically, there's
> https://github.com/kdave/drafts/blob/master/btrfs/progs-fst-default.txt=

>=20
> I don't have objections to the patch, that's the easy part. The above i=
s
> non-coding work and is namely making sure that the usecase and usabilit=
y
> is good, or with known documented quirks.
>=20
> Making it default in progs release 5.4 is IMO doable, there are probabl=
y
> 2-3 weeks before the release, but this task needs one or more persons
> willing to do the above.
>=20


--WRJLP6Gvvo6lfZJRhwRlgGukrcTQBy3bg--

--zZYimA061lfdEJZZIUfuA8hjGyhhKhTsI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl3KBFwACgkQwj2R86El
/qjTBgf+MIU62lyh/bUPRb782oPBaY9Ml2EGRpFdBt6Z6D99/K4xml0Rr6I9hCMS
qekWjXSStW/sRef4H3O/wwQmW0xSgLfAA05HyXbi9vpdw9hbP8N8BPrT/8eMsZcW
ldUa3sd1IXKMCSrPeoF8b5IQAvXO9MclYinGQP979o73L25UBPtK1Yjg3iGjbxuB
JJQxlGvv/qrZhvlw5G9R7zcsDIO+f8WYntA1T3CxXQ8YC5TXbPqe8CHG5iRbC+ka
ge83PITitw/v+nt2DdEnguQLuBJFGIxhxnD0JaYzczL4D1GM0JBQVHMytfylkjvg
0aKRPRqKyavnYBLo3gTof2CgSjTy9w==
=xMMu
-----END PGP SIGNATURE-----

--zZYimA061lfdEJZZIUfuA8hjGyhhKhTsI--
