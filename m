Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A95361A3D4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Apr 2020 02:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgDJAZk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Apr 2020 20:25:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:45919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDJAZk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Apr 2020 20:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586478334;
        bh=opC6ry6uUaoYTNfil27y3If6QO80Hi37jEDDtrKc74s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ARmodaWN5PAAMkj5e9MYi9Gj6SSp4NurAs9gcWja2zWvXWFAy94bHWsWGtcVgnKDD
         NEvXkGJEY4qbaPMMmB9aHWgwhetQyAGD+ghBKz45LherrEDQkCEk4f1qiK4zqZLwoz
         Pdj8pn5CUdXFPleYbsZdLkPjZat8bOmQOU719Djs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9X9-1jVBvg2M7d-0099Vr; Fri, 10
 Apr 2020 02:25:34 +0200
Subject: Re: [PATCH v3 1/2] btrfs-progs: tests: Filter output for
 run_check_stdout
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200407071845.29428-1-wqu@suse.com>
 <20200407071845.29428-2-wqu@suse.com> <20200409155204.GD5920@twin.jikos.cz>
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
Message-ID: <4b74897a-ea6a-9e9f-e735-a990acf2c9cc@gmx.com>
Date:   Fri, 10 Apr 2020 08:25:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409155204.GD5920@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q0ZQr6BMntoO1MKMP1CW5vp6shFjsLhwe"
X-Provags-ID: V03:K1:F4JxrT02vGEFLt1A5aSOR6/GVMGTj1il3uJR6gcrRolLlA770SP
 4v/eNXIEZ6oN3bR8DuRpU4EgWoioMzuGwnl7zpTZEuUSbInXQ/abBxF8uiJppRtS79U8f43
 WyTzg6Fbbon0Wq1j6IgByxcs3+dQwYvKFq9yk8H1tMrUFz21pGkE1y/0eiOxqQKI7XV/hhO
 ncOsvhV3FAiawERK1ugNQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gzVlDvfhyA4=:RoiEcFN0+yWJ8lEj33SLTI
 ql5pi/bAp/hYL8GAu270zUtnBEjv7SOv3Z47NuHVrp6tlgjRZyDOtFwycMbzoasfox0NNh+An
 jh0OmuewwtqIT6EruTe81QB72SMsddeC47QizalWsZONQnQuCJDj8HGeD9IDxpRbyW32PPf0b
 xV6PpDxJrO7sgo1mEdupXw8nf28GR62etBuQI5+bT/DEIJu8kKhdczZeH2uBt/0GHsXm9lsIa
 29BqX4YoqYyGeuzmmQukbjPCdGpwVROaHkVDeYPo5Hx4MK1IsKGr1WICAFVpeg4RwvDpHdkIp
 BggvyYyzU7quMAo7bajLXRzLRjV9xOrjwuyXOPGyGItH9Icphjh/IjfLoUyCMpuNBvqLPzCfz
 6g4kD5iLmilmOKeRyojLxsmdtnNATW2H2nfiSgicz2wkRCrvaA4QAAlx5e5biis0VYYhKPmlR
 6/vZ4wOyrCs538exTlsh0CD9VnMFQAzR71EOUyj7c1lv61w8G41cZehRACdcnvl4EqcQjknQ9
 bkdqy8ipgEzQEWrBseZDt610OaRHP9MYX35PX81iiOXcssnaz2JeYN25Y1uoPuTADH8TmatxX
 uYPoCdvuy5UJzFZYXFUrqki1r4PdxOCe8aMNtDOkrLrPaSWYgMUa5Sd1B7qWLmBrNnc9BsSId
 VjSLuAFTucGiLCZS8SCo42nhn9nLB0Ua9EZdsaJdeLgH2JkVze8LImgP5WWF98sO9NxpaOUfy
 vlKK+rIWIWNuZrYv8svazlhlzXr7WK26fGY5OyeCI/ZyV7HKhbO2QZhoAJrn0GYwsW5xkzThE
 VjO/YD6KGELJv8fThbaNlPdZy3icaWOCYJVc5wRuN6xcbyrGgqxCiqh+uK+urVkPv1iAZE6st
 OPi4P5fxmz1buIxTrItP333ir1Nt5O51pwyA6gf0tvtMv51B+pZQU+ewdQNuatxvj6rnrglMr
 goEdX4FpeHR2wrRqtlC6mlOtg6fZY5UWYkkfmEeG9HIYV8y57dFbud75vviXqx2NC4GuL53+v
 Zdpx59m9SBCTmb0zCRNv2OKjq+qRltNg8x7ThiKSz/tnPRjXEnpqn2bUKuT3r9e2E4pAK/xu/
 3TQLTN917TDjvIkPjEM65luQr5bmGjdWCuAFoLN+ZztY/tPufRcFN8RiRrADV6H1iTckkSk9T
 yfd1j4X9omPxA7WxKuMpdoo/4eGku4Ntrwn+4mSm9Y+g89ITYrBw29DOK3fqJAFunMg08ZLZE
 7VGHpIl3O/Yt1csLy
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q0ZQr6BMntoO1MKMP1CW5vp6shFjsLhwe
Content-Type: multipart/mixed; boundary="GrcZTeh4Uw5GCc83pkhF1gf8WVCwRNr9V"

--GrcZTeh4Uw5GCc83pkhF1gf8WVCwRNr9V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/9 =E4=B8=8B=E5=8D=8811:52, David Sterba wrote:
> On Tue, Apr 07, 2020 at 03:18:44PM +0800, Qu Wenruo wrote:
>> Since run_check_stdout() can insert INSTRUMENT for all btrfs related
>> programs, which could easily pollute the stdout, any caller of
>> run_check_stdout() should do proper filter.
>>
>> The following callers are affected:
>> - misc/004
>>   Filter the output of "btrfs ins min-dev-size"
>>
>> - misc/009
>> - misc/013
>> - misc/024
>>   They are all calling "btrfs ins rootid", so introduce get_subvolid()=

>>   function to grab the subvolid properly.
>>
>> - misc/031
>>   Loose the filter for "btrfs qgroup show". No need for "tail -n 1".
>>
>> So we still have the same coverage, but now these tests won't cause
>> false alert if we insert INSTRUMENT for all btrfs commands.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  tests/common                                  | 13 ++++++++++++
>>  tests/misc-tests/004-shrink-fs/test.sh        | 11 ++++++++--
>>  .../009-subvolume-sync-must-wait/test.sh      |  2 +-
>>  .../013-subvolume-sync-crash/test.sh          |  2 +-
>>  .../024-inspect-internal-rootid/test.sh       | 21 +++++++-----------=
-
>>  .../031-qgroup-parent-child-relation/test.sh  |  4 ++--
>>  6 files changed, 33 insertions(+), 20 deletions(-)
>>
>> diff --git a/tests/common b/tests/common
>> index 71661e950db0..f8fc3cfd8b4f 100644
>> --- a/tests/common
>> +++ b/tests/common
>> @@ -169,6 +169,9 @@ run_check()
>> =20
>>  # same as run_check but the stderr+stdout output is duplicated on std=
out and
>>  # can be processed further
>> +#
>> +# NOTE: If this function is called on btrfs related command, caller s=
hould
>> +#	filter the output, as INSTRUMENT can easily pollute the output.
>>  run_check_stdout()
>>  {
>>  	local spec
>> @@ -636,6 +639,16 @@ check_min_kernel_version()
>>  	return 0
>>  }
>> =20
>> +# Get subvolume id for specified path
>> +get_subvolid()
>> +{
>> +	# run_check_stdout may have INSTRUMENT pollating the output,
>> +	# need to filter the output.
>> +	run_check_stdout "$TOP/btrfs" inspect-internal rootid "$1" | \
>> +		grep -e "^[[:digit:]]\+$"
>=20
> This does not seem much better, now it's specific to the commands and
> calling the commands directly in new tests will make it fail.
>=20
> If we find another command where the extra output must be filtered,
> another helper. The instrument-tool specific filtering is IMHO fixed in=

> one place and future proof.

I get your point and concern, and kinda support your point.

>=20
> I want to avoid adding yet another test coding style exception like "fo=
r
> inspect-internal you must use this helper", we have already enough like=

> new tests not using the mount/umount helpers or opencoding other
> existing helpers.

However the problem only happens for command with one line output.
Like the min-dev-size and rootid of inspect group.

All other common tools will need filtering anyway, like qgroup show or
dump-tree.

So just several exception would still be acceptable.
>=20
> My idea is to let people write tests in a natural way and adapt the
> instrumentation tools as we know what problems they could cause.
>=20
I used to support valgrind specific options to solve the problem, until
knowing you're using a simple wrapper to test.

Yes, we're only using valgrind anyway, but I'm not so sure for other
guys, maybe one day some new tool developer would use their own fancy
tool to check btrfs-progs.

And if they find that we're using valgrind specific option just to make
all tests pass, and their tool fails due to that reason, they may just
exclude btrfs-progs and express their disappointment against btrfs.

Considering the exception is really not that many, the trade at least
looks good enough to me.

Thanks,
Qu


--GrcZTeh4Uw5GCc83pkhF1gf8WVCwRNr9V--

--Q0ZQr6BMntoO1MKMP1CW5vp6shFjsLhwe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6PvPgACgkQwj2R86El
/qjRVAf/fK646OsasIPPI1PUWKif4aysMWjFtUZIpK5MuuaN6f0BMQ848CzhGz6d
T+UeGoiGJ3BQ3aNAfdySC0E5OKvrJZHzYWG9nvZ/g+HQEvVZNBuHYIejGSmpnLSe
6M7IJA/X1PERKGGWbXhTaG5Xy71L7c9+UF8pk7qJ//Nb6n1JTOISMsukzbx8jiC6
XtEDB9J6cDf2CP2lahEuz5jZ1HFHY1blPrTIHl2ExUv9bJ52BW1WDod8XFz86Ijf
kJ8CnwKsoLcIrQWzu4d3ZLIgWrzZvP9KieUEhpdNGIc4Yx5px0Y6RQi5SZnuavws
2moagBkWEEj4Ykxqbo6rPiAXLl4sfQ==
=2r8X
-----END PGP SIGNATURE-----

--Q0ZQr6BMntoO1MKMP1CW5vp6shFjsLhwe--
