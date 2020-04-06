Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4461A0136
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 00:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDFWos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 18:44:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:39839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFWos (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 18:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586213081;
        bh=L3uzkSefdgJhdFHF3waBExM6hDPoIxBB1EI8eUMTBxY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AfdlElFiME1YNW6KjbsuHb8l9/MrzP01QEzaqWqZ9TqEL3WdC+uWp2sJs+Cytsai/
         oEQrpq1tDmYBRQF6PtU77yRiCFzJdK4nV4Lti/Vq8Pl7fWIudMmrlggqmO8d/dHsoa
         wBkf9DJuLSCN/5LY4aEyGOcl5amC0UP9meIkZi0w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1iy2RI03qP-00qAP5; Tue, 07
 Apr 2020 00:44:41 +0200
Subject: Re: [PATCH v2 1/2] btrfs-progs: tests: Don't use run_check_stdout
 without filtering
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200406061106.596190-1-wqu@suse.com>
 <20200406061106.596190-2-wqu@suse.com> <20200406165637.GQ5920@twin.jikos.cz>
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
Message-ID: <1ac7c293-41f4-8249-5d61-62df6a3c35a2@gmx.com>
Date:   Tue, 7 Apr 2020 06:44:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406165637.GQ5920@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lqb8tWxPppm7AqbKWZ89prZDGIx5zOGbC"
X-Provags-ID: V03:K1:dyiNc+7RbYRyzqUJnkAMKRM530Tu6GsvQ86rM6+0gV4HVExEpOa
 3nQSe/GvaigKFznTt6T6EArZEsZK8txikFEJbS747Wwq+A8dQ0IZz4kPuVnPh8NTjEuGrfK
 G6CcMNMHDCBKlDDgshvk/MaBhi07PCu61md8Xphgzja9k/R5I/iRR4Kf81Mo2Y05iKbC93t
 YAbFZ+TKlzo515Epk5mVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RXEBNlDY7PY=:rvWXk7adXVGQ701wUXXVvi
 JI8gu/Dt+dc+EXMt6l8skojZOEItqto9fw6Pyzf/lIoT8HHADERNlrjV23hnG/kh0E6Vqt2Cl
 ljSX/l/AefxhhIs8p5vIpTjChHqQIFN24+0R5taPxKYHcQ0TndcnljPM8XBcre/zQzBG/l+F7
 uU9pF/B1cKrL/w3otOYXLvjR5JdSEGKpADkKmOSbp+22OEHipBAb9Y61ghTsPcBfwqRpMeVSZ
 xAxKl5zRvDmuwGYYv5vs6w+Y29DEFvxjQimZCgRZLqa5kESEO/vEGuJtOOa+IdDHQwymLZ3sc
 Sq5YJYpsR+i70b5x8f4J9c4uT62WooyvhZadZviq/GRwktpgGr/c1ooFUmK55i8eu6GqIUcea
 cLE6TsSP+iI+Mk1TCnQHIp7KrVUlvWig9Q0PqaTnQ6g98nthcJZ9SjchI0ifq6nBFJ9x8wxQW
 tEZMU6memPtSb/UzI4vqj6m2gR3AXqtfDXXw3B0RZkV5OlymdCvlIixfBUZbHzaYl93QJI8N/
 nJdFu5Xmpp3y/7G93XC2bMnkmL0LyTfUAkPq+39lDF7sNexi1qNn0oQrLT30Y4SXkfIQk3Ryv
 K2tjLrIQVnEZZUQThmKPP8OXT4Cu3pMg7pR9Zadh2oRFS1apSIVz3YykkXXGP9DplIWUXeB86
 Ot6bziBZVxNOlif0cR2nP1x70g5gcLlHO+U8D/ihWLDxJUfCC3KA3tAjqRWzNNws75SOHnrOS
 hBCvIUHCRJSHm+8vzHfNzrHBhnCti+9uuYoQPnMd0htOPgRE5Dkaf9AO1JUSlwVUNxqoYrjyh
 nBcam+BMGNzO9vOThrU773KHETnjUxxlnmFYoXKRo9yedS0qcibL/aMc4dd71QBhSD6EQvzb7
 5/iQaykZN2qULE88eAEM3+eZiJlMqmHI1klGYjQvx7jLSJdIQd9rFGgKco1xCxzJSwEqTmapX
 Jilb7aKa5IZFjt96lyE+v0lEOEbKj1E/8EWIMa9X1smW6i41b7vBbfRUPsvEeEN0DfY5SYCxG
 eebmvyeKGKkOrpZ2GTlACX1yh4cf49L+beQZnQTbrsYv7cIiPsBn5Cz9oeIxRyywTGRw7TeaB
 wgRVykpIRVo4K9VOBwfeixECs3pw2XOHM50Yu7ct2hlSk8KTaOH6+y9G/kKw9x5YYeNAF2x9/
 0A9E2LjtrNYDFGRaqj1NcKMc9kFgw0uXUELLzmKA7fN/dXDHII5YFfLr5C1rATc+m44QPW4B9
 64OIyKPNpT+5Vs+53
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lqb8tWxPppm7AqbKWZ89prZDGIx5zOGbC
Content-Type: multipart/mixed; boundary="u0UZuGfkwspfYWUfdPw9iqZztoKFL9lQw"

--u0UZuGfkwspfYWUfdPw9iqZztoKFL9lQw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/7 =E4=B8=8A=E5=8D=8812:56, David Sterba wrote:
> On Mon, Apr 06, 2020 at 02:11:05PM +0800, Qu Wenruo wrote:
>> Since run_check_stdout() can insert INSTRUMENT, which could easily
>> pollute the stdout, any caller of run_check_stdout() should filter its=

>> output before using it.
>>
>> There are some callers which just grab the output without filtering it=
,
>> most of them are simple inspect-dump commands.
>>
>> To avoid false alert with INSTRUMENT set, just don't utilize
>> run_check_stdout() for those call sites.
>> Since those call sites are pretty simple, shouldn't cause too many hol=
es
>> in the coverage.
>=20
> I don't like this, it removes a lot of the coverage. The instrument
> tools should provide a way to avoid stdout/stderr pollution, eg.
> valgrind has --log-fd or --log-file. We can add a shortcut that will
> provide some defaults so we can conveniently use 'INSTRUMENT=3Dvalgrind=
'.
>=20
Then that's too INSTURMENT dependent.

What about adding filtering for the mentioned callers?

Thanks,
Qu


--u0UZuGfkwspfYWUfdPw9iqZztoKFL9lQw--

--lqb8tWxPppm7AqbKWZ89prZDGIx5zOGbC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6LsNUACgkQwj2R86El
/qh/mQf/fv2GI2xRsBJZaB3wZTLA23cX6V6uSUnTY8z1WpCUCJZYHI00sGdft2wf
BnMbaAuMjUkYhQsrWN8zKLCzFhfMEQw9ukGuih6X74aEJF+WHCXtbZACJH6ONp+2
YYGohzUh5nXrDJ7V7aIu7rDyj2K7tGL94DTW6Om9zlpVgGjW4tBtXlrHEQTzE2u+
LhPBLpQaUP0TNCnR5ImCOfaCjZN/fGNAxgUNViTNeJTxvcM3ZfDTBUaQdpY2DG6B
Vk3dn0sa3n6s927a6Z54OK80WD3Und6PQrMcyPVSIGqWYMv0yuvKOnCkks9M4oEY
f3sldVVUVqTHVIqrLSerQ9aLfCf4aA==
=UWKC
-----END PGP SIGNATURE-----

--lqb8tWxPppm7AqbKWZ89prZDGIx5zOGbC--
