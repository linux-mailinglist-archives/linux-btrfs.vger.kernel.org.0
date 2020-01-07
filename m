Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D91131D53
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 02:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgAGBqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 20:46:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:38175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbgAGBqS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 20:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578361569;
        bh=GQibQqihDBUYZJRbfNBnVupXCS8MVLFM9YmlQUadopM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JqNvai7nG8zhdhrbjUPFXucojKw/KjLjnrPb1F0cvfqjG4r39Ri6y0C0XglaLgH4+
         Fyq+jXGQ4tUinzNVZsbATNS8VMigAbmWvFPdubBa6B4sLnVgQteMWaPupvegCGiE2B
         X6JIjdLeXfeHR6JBUKGioeV3QpOieKZH5uEkuXWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M3UZ6-1io5iM208Y-000fdA; Tue, 07
 Jan 2020 02:46:09 +0100
Subject: Re: [PATCH 0/6] btrfs-progs: Fixes for github issues
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191218011942.9830-1-wqu@suse.com>
 <20200102171056.GM3929@twin.jikos.cz>
 <e8398282-264a-3ef7-43d5-63f1ac0c7c19@gmx.com>
 <20200103152719.GZ3929@twin.jikos.cz>
 <d9c1ba8c-cf39-883a-5c84-4d1da81c243a@gmx.com>
 <20200106154534.GJ3929@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7982685a-4fd8-91ea-8519-fc931f735ba7@gmx.com>
Date:   Tue, 7 Jan 2020 09:46:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106154534.GJ3929@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fQpOGIwUvFRoGON0whs1BD5elc9wy8yBm"
X-Provags-ID: V03:K1:+qSBz7NbdD7u6q9HXOIM9DyGRqa6PI9wSLDr6dqdJjGlT6AbOdB
 IwLLC+2m/yNy1BuGDgmpQH55r6z4HK6tQh9zcO4ayimommTTglppW0/TLZyaE66RskBIuWQ
 3VfaD8/9AcjCufxl9BDffa5g/5QgHLRWdcbdMe4UPElnlh8ie7Wh3pfYKmosFDuV7vWFt4A
 elSKMuVQM4cRKOaUjrX5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9AlruAQ/G+k=:DH4plUSImPqpr/E6qd4YFa
 OzuZuZd2NrGecyjsgxfpTjcfkIYNhBaGFOIUY6SqpfMRmIt9bPWdI5wEkv0OJAiwOJ5wes1ER
 wzvTEBwrl3Od0b58wxvJZ5tqO6YaT44Vx7XEp8J8Z15VhKfeTwLMMO7mzSqKhH67nvUdOLmrt
 J/T9aAklkJ0mUUFJMT3IpCSJQ/X6u/Tzgd9HOVFlGZ6p4/RDzAtWWMPOoei+9aGHRwXknIJ4W
 QC281mwVMokcRF3X9fmcrmful5ikwLcZNqPiWx6UZPPP+uSvQb7TbH2kspKqLEtyyhUF9LpCb
 Jh44XGMSG2oLPoUQfN0nPKVCuq56DVdx72nqDoufvV9ud1BqRIQfWWllW8gDnAylgkeFxPw0z
 hoeLQ3f6/fzXgQOczqWJEzx/uDiP9aLifdwF+qulV4iXuzcplRE9YVVS+DgCdSwBOjIlDcXvb
 IXTdg4mPaVYmwiqycmwyaopZZA0a0/H5kW4vcbyRGlcvQ6NTIfm4baawvGwL7FAcJdn/NRg/f
 JEblQ74LUB45XyRQH/gyNEhaxPqPlfnmfhyt01YaHGtD94TJuHlzPJAzFzba5F0FgKn0JSp9j
 FM6bP6ld1IVz0fa4omfiSAq8TWeetDTuzQ/z71R4XyAeo1QJJvJCYeD0MrpfCe/mKop2THUXW
 Tr58YtjK+p9Q8fZkAV4kDaMMEM8wITwcqC5TF5XDyZtSgLM19ldQ7h8W69MjZ5StEPrWlcOxW
 xLgopmwqSiNsstTobxyp+Q5QigSyXsbkRWMja5ggB4OJLNWg3M9TWJDOFEC05jhyWT2UR2me8
 xoLybERpS1Pe398HoUS/9uZ/qo+eZOct6Zg8Drffif/bLC8OBK8ZKfKaHfVkoG6+BuLu0CFvh
 DfgvRNBxkfNg/w7dXr0h8QjR6oScThwuYjnjj5oyFwQWcaBfVE9RhdgRFhW500pIwlt6d4AmE
 oczjcYwFXKDonki7hCoR7dnO5CYhW5j/saUtDyE50yPVmnIXCIEh3VoNE0EL6K2YlxKoRDPgE
 oL5VuTKun7xUEQ1500zPtwbeM2cSZvt85WmjOyatehI85PYtT5qcv4u7RL1M8aMNXYKYxvLMy
 WgmFW4Bdunfsy2aWFi2Lc+AtInUdHeub/pitIpgBWk0n8gCCjFaD7nPJTaRL8R78PQsOEQDgm
 8ZMG6b+1uh3TKCbonHc7L9TddZR4zFg4hldJqy4CWzyP/IWlE3dnBzeQWp3Y0ZjNDAETWVCVJ
 RcqW+SQ+Mu9gwxkOSxlObLvvLtSUZ7Ow5Gc0y0y0kGetkWsEtJEwq1V/VXSI=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fQpOGIwUvFRoGON0whs1BD5elc9wy8yBm
Content-Type: multipart/mixed; boundary="BHuamJWOJHeGTELgseVpTRrmfJ9hzyg4k"

--BHuamJWOJHeGTELgseVpTRrmfJ9hzyg4k
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/6 =E4=B8=8B=E5=8D=8811:45, David Sterba wrote:
> On Sat, Jan 04, 2020 at 09:26:25AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/1/3 =E4=B8=8B=E5=8D=8811:27, David Sterba wrote:
>>> On Fri, Jan 03, 2020 at 08:43:01AM +0800, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/1/3 =E4=B8=8A=E5=8D=881:10, David Sterba wrote:
>>>>> On Wed, Dec 18, 2019 at 09:19:36AM +0800, Qu Wenruo wrote:
>>>>>> There are a new batch of fuzzed images for btrfs-progs. They are a=
ll
>>>>>> reported by Ruud van Asseldonk from github.
>>>>>>
>>>>>> Patch 1 will make QA life easier by remove the extra 300s wait tim=
e.
>>>>>> Patch 2~5 are all the meat for the fuzzed images.
>>>>>>
>>>>>> Just a kind reminder, mkfs/020 test will fail due to tons of probl=
ems:
>>>>>> - Undefined $csum variable
>>>>>> - Undefined $dev1 variable
>>>>>
>>>>> These are fixed in devel now.
>>>>>
>>>>>> - Bad kernel probe for support csum
>>>>>>   E.g. if Blake2 not compiled, it still shows up in supported csum=
 algo,
>>>>>>   but will fail to mount.
>>>>>
>>>>> The list of supported is from the point of view of the filesystem.
>>>>> Providing the module is up to the user.
>>>>
>>>> IIRC, doing such probe at btrfs module load time would be more user
>>>> friendly though.
>>>
>>> I don't understand how you think this could be improved. The list of
>>> algorithms is provided by the filesystem, the implementations are
>>> provided by the crypto subsystem (either compiled in or as modules). =
Two
>>> different things.
>>>
>>> So you mean that at btrfs module load time, all hash algorithms are
>>> probed?
>>
>> Yes, that's why I mean.
>>
>>> What if some of them gets unloaded, or loaded later (so modprobe
>>> won't see it at btrfs load time). This would require keeping the stat=
e
>>> up to date and this is out of scope what filesystem should do.
>>>
>> Isn't there any mechanism to load the module when necessary?
>=20
> Yes, that's what we rely on, once a filesystem is mounted it will
> instantiate the crypto shash, that in turn will trigger module load if
> necessary.
>=20
> Probing all algorithms would load more modules than needed, for the onl=
y
> reason to store/print list of what succeeded at that time. Whatever
> happens to the system later will not be reflected here. And that's why =
I
> don't want to do that, so we list checksums understood by btrfs module.=

>=20
But we don't have requirement for all supported csum algo.

So it's completely possible to have a case where we don't have csum
support for BLAKE2.
Furthermore, there is no way to determine whether we support it at runtim=
e.

Now we depend on distro to include all needed algorithms, although most
distro would include all these algos, but this still look a little
strange to me.

Any better solution for this?

Thanks,
Qu


--BHuamJWOJHeGTELgseVpTRrmfJ9hzyg4k--

--fQpOGIwUvFRoGON0whs1BD5elc9wy8yBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4T4twXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qgB9QgAkXS8Cas0tqpKuP4keZu6ffBk
x8gwf/yOrSimJ4nBhsc2h2PSrSFWrE388LARxFGzza0Aei5EoAbPVKh5DbqaJrku
1y+Vf7fqRgFDfkZiLRTnzZpw1vb/zYV5ylxAhrgTtcbQlIDRoK2fNL7Upocwm7eg
QHTIk0ZHMamAxHBOc0Hdd/1iX4IL7oaZtTt0b5T7dTi5omzJqlLuJplUU0en9hHB
Csec+RR8PwSlctgbxL/ZVLoGrWUZ8ODfDGoE3LtgjC5AecpruMackzjCGXq7v1uH
KaYP3TTETrdl1OQnAO3jumTb/j/GLTfYeM1uqncWpy5jV1XKsSZ8P63tKj9kTQ==
=mjV5
-----END PGP SIGNATURE-----

--fQpOGIwUvFRoGON0whs1BD5elc9wy8yBm--
