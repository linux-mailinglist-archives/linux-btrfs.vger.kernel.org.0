Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A721319EFEF
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 06:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgDFEdy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 00:33:54 -0400
Received: from mout.gmx.net ([212.227.17.22]:36361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDFEdy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 00:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586147627;
        bh=0bzAbKum1SHr64ZOhOgM6bRFC0odcSC8EGJ1qRHozcI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=d93G3RLuJm+hM+16sMhLdHMVSXhlJjK5s+YNU1hFX1XbpzjuSAKiaakfIHF8aUuqp
         OWkIXgE9Hjh7V0bL9bYD9xeZgR6rVftfbXlT1pB1F6uyZUNeIAHcertvUvMbk2qMN3
         6TD56izQsPk8Vo/cmlQE1P8pm95D6lBwTHhvcN1o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17UQ-1j9fiC1Txq-012aWe; Mon, 06
 Apr 2020 06:33:46 +0200
Subject: Re: [PATCH] btrfs-progs: tests: Introduce expand_command() to inject
 aruguments more accurately
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200330070232.50146-1-wqu@suse.com>
 <20200404005228.GL5920@twin.jikos.cz>
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
Message-ID: <1ca2ab80-f6d6-004b-e738-bd849aa87f48@gmx.com>
Date:   Mon, 6 Apr 2020 12:33:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200404005228.GL5920@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pp4RTIQmYJMr1QB06RKb9XQRkbFM5ybmq"
X-Provags-ID: V03:K1:Eq7+Fj7jLEwikxlOvvjOCCdWZTvLkcWWh6IrEIKFJvS2BFAF3HL
 iUeMqKV8YYsNB38wjoQ+SpyD7fXuvHTDUEjK0GnVVLyjcYvaGfP/WOw2Wqc2TUJKyyzCoXO
 taruODVReXUDn7SZxUdeeI+aPnp4Fs240IJOVMhvm5NSspF8Tiw9WiUssULDGZtcnNUxdqE
 RrBXuL8D0jeImnAr7Z/Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KiIDzVgZv0U=:iCrBQlyiEpFh3HF5rJb5Gb
 +/ekLIlDPTC3kncWZk1eswuJjg5RGhezDMRuOErjscRbY989YSgO7iuUCZAQyfzmJ2Pq5Jnit
 dwEeDSLRTFIlUnBEMUBnnaqSbIIskFJh4uHZq2ePmkMo87pCVf0m8FXTQagK0egQ3yXg9NgPp
 jMtFe7CagqA/BV6Fe4CXFnhaf67vu+QFWPOstGNTcadkrfh9h10qoJsEjjRHFCpPx8BnHu4UH
 06ihnadc+hiuJ++jT6G9t7UgsHt+z6CI1BrLzc4RuUG27Cv85R3vKeym98bzetl8XDFcfyYPh
 MxmFTm5LOa7/h4xoJb5HsF5MThbRotJjI64UqNxQ9pKpwLOl5XB3nmyh9hMcYrK/v03nzQV5q
 NhJtdYLXnPTuxJHvMkQQBCf1Vew3JXq6YxGTF9T4UTm32q7SCuQa7YLt7kmP4ZXNmJIntbm89
 9K+/I12fC7JE3Snzzpi3OXV+7uiECbslXfq1RFsyJLZsRA2qsT1Rng+6qSA1tJ1yUVV46yX0F
 DM5/HXt4VSxeRLWeyMp/wUYC74yWQ9rkhTBr8zfgIpuIWyiwvd27a+vuO9ne4LV6FfmMTJWq8
 2S6rfzjFfIzxlYjzB+Hz21EEIKUcjhKu2IdKU5UgU1pVUvqMHQXLpI1Rq44492Wf9Oc8H8Pwx
 pmTk3NqJH+t21r4WYbFSYBow+V58GLv0wNlQo/iApcVdgXQQnd43NSmQn92eh/ousonAfhZBF
 U7R5z/Ch0miAves8XU9JRDDRNXwrFIVE76qhTZGTyue7ohMMdO4IxRn1tFlalFlNquxn/sSb9
 iHtkzkajR5xFGzrhGvQIv8Q4fvMbfrJy7B5XckaCv6nKJXN33u+IVywWBM0vu44nIX0siVimB
 IDmYkCNL20WYnthDuXFSlErBJBo7sUc4q8NvvQRnKUW04pFDwzk2rkxJJ0cPaP6G4F2vWOF+L
 V9nYPbqfBtFYkhu70c73GyeH9xXe25e8J5zj7Is8wB3pBZTvzwALHm6g2Cv+ZqdZkzj0JqXAK
 vYGhQ/fKYMKOOCZFpF3emNqQoafs81fedVfzHvNWN4VzzeDNHoFFijYRGwUHwnVQitq7ddIyq
 3Kgoxc/0OvMroFG3TJbKL3Se/bSOpFqT1J6fxsHa4ckdXzJ2GfHOWE/fl7aYP53YK08TQGc5X
 YPwI5hVZ1EeR5YgH3SP0HdO0UnMC5+aESOFMBcqIy/4RnL+W04Xf4lptaELckZ0QPn03DBEF5
 fD3QDtqfFStaV+1fj
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pp4RTIQmYJMr1QB06RKb9XQRkbFM5ybmq
Content-Type: multipart/mixed; boundary="EN40y94e1PCOxYvvCQzJcODsIaSpoyfzC"

--EN40y94e1PCOxYvvCQzJcODsIaSpoyfzC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/4 =E4=B8=8A=E5=8D=888:52, David Sterba wrote:
> On Mon, Mar 30, 2020 at 03:02:32PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> We want to inject $INSTRUMENT (mostly valgrind) before btrfs command b=
ut
>> after root_helper.
>>
>> Currently we won't inject $INSTRUMENT at all if we are using
>> root_helper.
>> This means the coverage is not good enough.
>>
>> [FIX]
>> This patch introduce a new function, expand_command(), to handle all
>> parameter/argument injection, including existing 'btrfs check' inject.=

>>
>> This function will:
>> - Detect where to inject $INSTRUMENT
>>   If we have root_helper and the command is target command
>>   (btrfs/mkfs.btrfs/btrfs-convert), then we inject $INSTRUMENT after
>>   root_helper.
>>   If we don't have root_helper, and the command is target command,
>>   we inject $INSTRUMENT before the command.
>>   Or we don't inject $INSTRUMENT (it's not the target command).
>>
>> - Use existing spec facility to inject extra arguments
>>
>> - Use an array to restore to result
>>   To avoid bash interpret the IFS inside path/commands.
>>
>> Now we can make sure no matter if we use root_helper, $INSTRUMENT is
>> always injected corrected.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>=20
> I don't know why, but with this patch (without my fixups) the misc test=
s
> get stuck at 004-shrink-fs. Per 'ps' output it's inside the test.sh
> script so not waiting for sync or such. I need to do the releease so
> will skip this patch as it's not critical.
>=20
Strangely, with my patch, the "for (( i =3D 1; i <=3D 7; i++)); do" loop
stuck at i =3D 6 forever, thus doing the fallocating again and again on
the same file.

Will pin down the cause and address your comment in next version.

Thanks,
Qu


--EN40y94e1PCOxYvvCQzJcODsIaSpoyfzC--

--Pp4RTIQmYJMr1QB06RKb9XQRkbFM5ybmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6KsSYACgkQwj2R86El
/qhYugf+LZ4ckL5MaKiAEZcNAYNbnhWug0b3oRJt41ps5tzsgWTNrhBbScag5SOn
Fw7OABOMVWqA12pGd2WUDAlBbSNfwRuNphdVrUsJU04bfP3h0p1oCdJhUp4+FXQh
GC3Hntx2cfx9Rw5RNVcrqDgmyq5Eqz5yh3Emj55Ha1U2INg6H/ThgDHBmFVklg6i
E7bTWL2+DiQ/mprEJ2dAk1G3ArlJ5jK6cXg2o/w0D5vvRzzoeCAu37PKV8XPsRcu
o2VP32DNL8Bc0mjHLOoiFsEHnPfPJD9Sxu9QspRCILL/b/FukwCewlhLA1b4+8yS
pAvFTrEdTKHypRpIk+WGJ4Jyk+UTQw==
=O+L4
-----END PGP SIGNATURE-----

--Pp4RTIQmYJMr1QB06RKb9XQRkbFM5ybmq--
