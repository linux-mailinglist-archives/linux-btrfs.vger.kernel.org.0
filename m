Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4412F66B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 10:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgACJwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 04:52:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:53051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgACJwl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 04:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578045154;
        bh=93QUiQ4CHOhOpsRvdvVCFBAebZhcbhSp+QbjiQkVZhw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=M8J0KIGai9qLwke7heIB8mc9UcEcNHxGsPRYvh+QNAANJj1gcOMbyhT25QM++kp6M
         Zx7GBR9nSc4a7tvLt8+hhjyzYLbbfAGzEqlgRCsIqGn/pFcL4ULpcY+uubYMkR2Byw
         v/qXR6N4PgYOq7bCvUJQuvUNDS5eQCdoFgXhvvrg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oBr-1jhMAO2ojt-00wlgc; Fri, 03
 Jan 2020 10:52:34 +0100
Subject: Re: [PATCH v2 2/4] btrfs: Update per-profile available space when
 device size/used space get updated
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200102112746.145045-1-wqu@suse.com>
 <20200102112746.145045-3-wqu@suse.com>
 <c4f6ddfb-c52c-d376-4cef-26aebec4e288@toxicpanda.com>
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
Message-ID: <5ec1095b-b62b-a267-392a-63e6a3f1eeb3@gmx.com>
Date:   Fri, 3 Jan 2020 17:52:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c4f6ddfb-c52c-d376-4cef-26aebec4e288@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DfdPi67QTqp8uCdqXsVIaCTHxruZW5DNa"
X-Provags-ID: V03:K1:jGJBhC9jGQoKHBpoapE6gja9mv3ML5lrmSDM3Y585Rz5EVZAmH/
 WeAX5UV5/0OZCdp/yaz1THvf235YbRe1dpctm7IMAL1tvpE9IX+M0pSnwVruO1Hh4KnFEBs
 7LJGyiy8n0CXI1Rrbtbs8qYHGgSvkzVvtGcsIbbm8f6gkKklwRkRgBbYnYIxDOlERtt4oDb
 23Y1p75Ge7YR5aiNHM/lg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YDdxkItYvKI=:V0Q1oz6MvdfEQF26ZTCV+K
 4DVxik5/zs8ABszQQtvJ34s45hcR68Rmm39eNd0zkTv1TxSwAiQYHbWVs2g11olxK/eN64U2D
 emT20oVXfHBkNqPp3r//aQK7sNGzlpLRH2f2uoLf7Fj5KzVjwTSfAkKwMLTYLAsftYVk4dL1P
 x4sbCBpzsuFJuhx2U6hI8aVHKw4WaSGgsle3Ma4dnYf9ju85XLOD9sL/cb81mFFPuyiwHjnli
 mA41h85A0gdn5p0O5COyscB/MUJaP0+b/ta7d+rBSMnbF7LTH5VKrwTZUKVzW+k5CK/468uNL
 r6t8Pu9tssrqVoZShDuYBJAcRnJ6zduIi9EGeo9FOEfTkGW/peScTOd3nFqOH9AFGPIe8S7pc
 vL975jo5GN846zR6z6xk2CCBJG5TbjHZuNOhFO3gqK/dfvlmaaGDr+YSg715Q6LMU7EBS01Jk
 Izy6XMF7hDbaJBNZ+BCRI0fEmkrwJbOzj78jgoI0zqJPj1ipefEVrvfGV3dXamdheT8AWg955
 Ts4yNQbT8ckuT9nYJdV5UR8NFiZEoojpwxs4AT7ASdGr1OALRUuAHTUTCERYVulqEaPnnkOa4
 +CX46VN5gnloEHqi0Si9k1hzwvKb3/4jIykbyrnLVnVlAS3KLPNMryZ9IjIj7nVEEWeHFulO4
 7ydOiOCdvK+IMxc3ON7yKqrQnA/GU9mQ7fPR4t++2qWRdjhO43R8bEMt021neEDP9u6nSsSvV
 22ZSWN1K8p77QbEpCXT27snxwRPr86hLE4mNAqolwg+Tlg+NJECiEukYmwpWCBOUwpGRFGeme
 4SqHT5Z2LiMpdWpNmF0C5DKYJ4nP2Qu687+ZMeZ5ot8jxngo9DXHnlyZ0hoipWJSwM16y0vKB
 6oDS+4NO1YA13KIYVXxwIMdUQcK648Mp4itsPJx6RPTfCy74mqBVb/kWACvOIyC8EU8H4nQqR
 In0ZzsIjUMUDybCo6JYF8cq33e0lHsPG7PDxY/0waEZHCRKzQHvMkxvk7dH+VE/G/s6Av+Km7
 hInoH0ocpFCA6okzxHYR0xcXh939NGayOSbaw+oE8J5v/n1o9fzL39XBdTNl/m+r6IZzoxz1m
 16i+8pgE2qsNnNS7qVhptrbWkp6vxymeXf7L3fOQfrROQbtuBNYaCsLi1KkgGaJA5/rkop2bb
 OzHRo8RyKSS+nTdk2L7LH+zWcVei9Wy+kbrnteE4I8YdAWX5H/DY6G4plA5KUCDk4cY2zuN84
 NaPr96wbKnc2Ycs5gq74qRO9MCvqBgGTtG32cHdHXMcmbyTUU98E/Wt8C1f0=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DfdPi67QTqp8uCdqXsVIaCTHxruZW5DNa
Content-Type: multipart/mixed; boundary="04D4Kavdn6CEyb9vSGvQWJKgdTm9vFCXX"

--04D4Kavdn6CEyb9vSGvQWJKgdTm9vFCXX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/1/3 =E4=B8=8A=E5=8D=8812:17, Josef Bacik wrote:
> On 1/2/20 6:27 AM, Qu Wenruo wrote:
>> There are 4 locations where device size or used space get updated:
>> - Chunk allocation
>> - Chunk removal
>> - Device grow
>> - Device shrink
>>
>> Now also update per-profile available space at those timings.
>>
>> For __btrfs_alloc_chunk() we can't acquire device_list_mutex as in
>> btrfs_finish_chunk_alloc() we could hold device_list_mutex and cause
>> dead lock.
>>
>=20
> These are protecting two different things though, holding the
> chunk_mutex doesn't keep things from being removed from the device list=
=2E

Further looking into the lock schema, Nikolay's comment is right,
chunk_mutex protects alloc_list (rw devices).

Device won't disappear from alloc_list, as in btrfs_rm_device() we took
chunk_mutex before removing writeable device.

In fact, device_list_mutex is unrelated to alloc_list.

So other calc_per_profile_avaiable() call sites are in fact not safe, I
shouldn't take device_list_mutex, but chunk_mutex which are much easier
to get.

>=20
> Looking at patch 1 can't we just do the device list traversal under RCU=

> and then not have to worry about the locking at all?=C2=A0 Thanks,

I guess we need SRCU, since in __btrfs_alloc_chunk() context we need to
sleep for search dev extent tree.

And I'm not confident enough for some corner case, maybe some RCU sync
case would cause unexpected performance degrade as the RCU sync can be
more expensive than simple mutex lock.

Thanks,
Qu

>=20
> Josef


--04D4Kavdn6CEyb9vSGvQWJKgdTm9vFCXX--

--DfdPi67QTqp8uCdqXsVIaCTHxruZW5DNa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4PDt0ACgkQwj2R86El
/qjXGwf/QEJfwLHBoQxlQr/Kj3N6G2B+rrHXDyE+Ul6MAwGlauN8lJ3RhWE3Zl5l
dw5Q7uq5Dh7jUjTXFmQbRLySCtvKGoHDezPgs2nvv9O7jqDUH4JQDQ/vzmIKJiHT
Kxq4DsG4ohweBRB5vhl3yA4blpf+MceTOce+2bxqTLNkeWN1IZlh97n+GHH4aaO7
Xc3R8A/KkKcdZSxGUoRCGrqw7c27ASKpK8/+95nswd1d3yAMXK06hxaCPNKkgzbK
eEZVUpH3MTLtqVtP8/7MyDhP3R14dIpeN0l33qF930XJ3uQOp/rdJwc+S8301hnt
bhb0ExSOvL/bpitZJEyX66XhrbVD8w==
=pDyt
-----END PGP SIGNATURE-----

--DfdPi67QTqp8uCdqXsVIaCTHxruZW5DNa--
