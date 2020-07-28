Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84CF230985
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 14:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgG1MD1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 08:03:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:51759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MDZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 08:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595937796;
        bh=T+7w8SArpXT7gqQiEQqqqPNVWr/Re8BcwoGQ0DwdtGY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=L2CNclTYGPG8tbgcFhIXyBNj23eKlY0WeCL/aw2uWF4uyrXoxcp3rAkQ54d4YJ6SE
         EgBZGD4QchIjFqEKp9lVBNjlv6jaSOmKyzGbTfqdthtwpkw8kYmDYLMkGCtKb0Jb4r
         d4pT6m+2glSnvfqKoy/fdtxbFAb49ImcisN5qxvs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MlNtP-1kUXgl1T5B-00lq4H; Tue, 28
 Jul 2020 14:03:16 +0200
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
To:     dsterba@suse.cz, Daniel Xu <dxu@dxuuu.xyz>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200728015715.142747-1-dxu@dxuuu.xyz>
 <20200728113837.GR3703@twin.jikos.cz>
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
Message-ID: <0ccb18f3-d4eb-9978-b4b6-157cd7c922f0@gmx.com>
Date:   Tue, 28 Jul 2020 20:03:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728113837.GR3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pm8avbt6TopGAiLyZdDcIUKWffdRVecOw"
X-Provags-ID: V03:K1:gL8kEz7Nbi/sVfoWbyFmyB9t9xHGKEV/HBPTrpq33lu4qGn6Uvk
 VK4gQG1GMqAnVjMJ6xcGljkTGAK3ncKKJJN9n0jhyp8aj96DBjDBMjsUBdIV2xQrpOrpOKT
 iEM1xMxwonhcxwwGKiQr3GGYUUH4D5E3gBlV8crlS0Rq8sVUxcWR7bNjNbCfBVbLNnTlzKk
 LmamghshlRN9ajii2o1hA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QsasHnd8ZbY=:WGlKmTX5pwcX1VPSi9XfAK
 Ntzt3ZMrIdjPjQ0wvJSsVY1KjUJ46we4jjEztp4EMxDOvrNXnKJ1o6SdShFQyoypQeW5/8bIR
 hxI4axUivUeQkFl3D4AynKrUKkUZaJCcXCVSrzS3HOgp5iaiuCcmeRiX6g2Aml0sdmrHywVdZ
 /pGt6qnZ71Esef74JYf28R5nhPUgz833/26gREoqUBs25U3v4EqroW2FJ3qdAt/uvPQSAKWXG
 39UvuM9a2ft9x+JmN9fz6owj+sQ/NInHT1x4ELyHDZzhYS5QXACiBv7NQSuCoF4N1JTWmcgF2
 INeewW1Q1El7/v+2Sl18fnYgvFg3iDEPYaNsaylVO/1gVifxO6rUKXGo0i7mhjSVYOSS0O88I
 WmGG01i25L+dWvRNXek6C8uWgwo4Aw+MTH+8Jyunw97BWw7L0qiNtFb1YyQpzkA8HY346v8pW
 ty7ZA7S9wN3PuxuCJtc3G/53Ys+KmIWWzKlVY0NS9s2ar4T6ZZivW7z5WgYhF2izXOMrShgag
 yNMO0BbdDdFZmuR/AKNIMVde7qNjyhQgYmdDqN9ji+klMyG9CAzawLULI5Pit40ipVfvPXMrF
 8imbRRfbD+ui+LhqQXCMuCHKS7uCs3UZoYmQzNHajFZOwMjB76Nr7UAEC8gkDzH0OQFMx12df
 TDPCHy3Nl+Bk2MZ4cooGFMkqKZN6vcBEwpixZBPpHnV3bDnmhM02hmOyYKnanQDs2vWdiyKwq
 4fA0/HOqNnB34WWQaZzUUZxCJFxhZmzlPipJvemMTC0c3nihjZ+/my8+4ynjw2Rkmj5B+WOs9
 aMpmElIBdktGQyVXMVl7+NMMqwC9Gw81dir4bFa3AzueQ72ehVBV07h2CeLt5sqVxXKoHeh8H
 +BKdQEn7sI5eqhtCANfsgnx9XOxq0DmPW0fmlt5jX5GOJUT3fYYHZ3N1cgByvlQ4Z3S5UGUvy
 QQDY2vmlBU/dP0LeysaYWgh1sDkclXG29+bUrfQTlpddJ1ZNeNQgFjWYgtnqwBRIRN63YIpBO
 pVkxJRj2qNLcPxcumQjcsNeJ3KJEtNaSw5C7Y/dNR7iKTS8WJDCu2ivcKn5gLbrgxBDwVUGw6
 VADEf25pH52kb7rq1zWmijRTQZ73E8OgjsKkaUHWPtVAem2aBvzr2XFYVP+kgN4ZAlSLBq7Oz
 PUP5/QLXh0Z38BxKe/DIg5hd7FK9YvHxVSuZYq/JMgUhEtViC05OvWgZaDeM65N8BJJhlwS44
 mUKmbSkwfvH7fvFwbVbUtpkw1GCg7XsyJrALnEw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pm8avbt6TopGAiLyZdDcIUKWffdRVecOw
Content-Type: multipart/mixed; boundary="SEYkphycO1ka2N34yORIDgOKd6IzZhhMP"

--SEYkphycO1ka2N34yORIDgOKd6IzZhhMP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8B=E5=8D=887:38, David Sterba wrote:
> On Mon, Jul 27, 2020 at 06:57:15PM -0700, Daniel Xu wrote:
>> Not all contributors work on projects that use linux kernel coding
>> style. This commit adds a basic editorconfig [0] to assist contributor=
s
>> with managing configuration.
>>
>> [0]: https://editorconfig.org/
>>
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> ---
>> Changes from V1:
>> * use tabs instead of spaces
>>
>>  .editorconfig | 10 ++++++++++
>>  .gitignore    |  1 +
>>  2 files changed, 11 insertions(+)
>>  create mode 100644 .editorconfig
>>
>> diff --git a/.editorconfig b/.editorconfig
>> new file mode 100644
>> index 00000000..7e15c503
>> --- /dev/null
>> +++ b/.editorconfig
>> @@ -0,0 +1,10 @@
>> +[*]
>> +end_of_line =3D lf
>> +insert_final_newline =3D true
>> +trim_trailing_whitespace =3D true
>=20
> Does this setting apply on lines that get changed or does it affect the=

> whole file? If it's just for the lines, then it's what we want.
>=20
At least from the vim plugin code, it's just for the new lines:

https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5ebad=
cba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494

It just call the replace on the current line.

Thanks,
Qu


--SEYkphycO1ka2N34yORIDgOKd6IzZhhMP--

--pm8avbt6TopGAiLyZdDcIUKWffdRVecOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8gE/0ACgkQwj2R86El
/qjiiwgAgoiYC2iK6k5vdaaxaK0r6RuKmodUsmpyVVGCQKiB9IeLB1IciIir7c9c
B/XglN2YY6P8PdLKRzt1ukYKg9nAW4Adt5DZl/uGE9gSmfdpnwxHapPL7fAd03v8
2SNRrcpS1bNSfemtU+PqqcdE+5a8HPKacNavtHWlULOeA23Y2qePCpibKMEj7d+U
/aGHnJr1XMX3Mf5vnMMu4wo0+5rTDOaHEDVcfJ6VmAf9SjVVL0UOcV8LfWY+IlV4
6b+SVNprsZWWg1UftbiqSAmIE7RS3a6uVkmU1eoHvF0eS7gLPET9vetVkMj+UQne
Po9UWrixTdiD2I3qpjmjJKIW7pbDkw==
=TgeW
-----END PGP SIGNATURE-----

--pm8avbt6TopGAiLyZdDcIUKWffdRVecOw--
