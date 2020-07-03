Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C32213376
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCFT2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 01:19:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:54693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCFTZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 01:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593753561;
        bh=30xuG8m88S0h1Du0tjndnXc7X+mqHWBPyzvFnKtxwPs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=CIGcDb2AjrGsSDx3UbYmuEuSKjQURVQJex63th9a0V7jOwqldiaI2X92sD0D13C+c
         BFugpL8S3cq4zU48+0OSwTF2hAaPWifRbSIiz3Wn2x7aEkpj2SRsRWirOPAbDrOuyL
         YEsXyLHqzXOp88jG8hIgiREUVJ6JZReQq4v/Hqj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MY6Cl-1jJPHB0yVB-00YUfW; Fri, 03
 Jul 2020 07:19:20 +0200
Subject: Re: [PATCH 3/4] btrfs: preallocate anon_dev for subvolume and
 snapshot creation
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Greed Rong <greedrong@gmail.com>
References: <20200616021737.44617-1-wqu@suse.com>
 <20200616021737.44617-4-wqu@suse.com> <20200616151004.GE27795@twin.jikos.cz>
 <f792151a-ebd5-2ac7-c9ac-0c274ea1ab8e@gmx.com>
 <20200701173928.GF27795@twin.jikos.cz>
 <0cfc15be-3a4a-c6d2-b294-eeb0a4506df4@gmx.com>
 <20200702160821.GT27795@twin.jikos.cz> <20200702234632.GU27795@twin.jikos.cz>
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
Message-ID: <dce7628b-f182-783b-6f8f-da543bc5421b@gmx.com>
Date:   Fri, 3 Jul 2020 13:19:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702234632.GU27795@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oSCb1Bu6if4oHk4Bbn4JdHaaMavNWpr7k"
X-Provags-ID: V03:K1:3bToV4u7XdRL7wPGC70vYIHhZwAVVvN+VZd8zPHGi0/QO/LMCEm
 RwfvQp6j3VxB8IJD5nRQ6iuzdoN1O5CtVOVcXgfWokX5OMrxCmV+EPnhwOxruW2C6BnT2HN
 kylYlyuxgIwWSj1WozzG3lMnoYQIWreEpPn7FZzMpOM609rIPL/luevJuLnqLxibmRL8MqN
 meMXy5LYXnP3oHgNVRd3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hxHZd/Qbay4=:KnCURrLYy9tDa5hKuV0xjs
 q70WQ29tZ/y3JtRNGzypBUf8hT3PpdVALsXv7QiX0yYN4HYnQLnC2MSRJ+IFwgWMj7sqEY1xE
 zFjPCCd+rNjyl2NZHedZKq7no/5GhmtzwpwJDc3zpGJV3US1SsLtZf79INprXRbT7djH5J1Jc
 83Q+276P9K7/WRqA4Dsf5tTSimHzzfxzJQNcjkOR9/80FYqxYuw8lC2H1tmA7TBPQ7MiDzrro
 CQIpq562pig4iKPZc/Cq9c1ENQgJ9f5/lFJJYzx/hixMaGAbIrETB2Co/pJC7H/mlCa712Zcy
 qLmgq5FskezHg/j7nQO1QrooYeDfbpoj7Dd5wiTeVDEbyqQGmrBwdNOevnBY+pPSombe8VNS2
 MpZ4QSWXtbBB9lx0ntAmbU14FVFTRQ6H137z5ujd8fissBkTWcCS6copRzkGKvaTte6l3te5l
 DR1gIOc674gWB7Vo3tkIvlJk/OGXl8UxvIPv/Atl6j1Uc1oxcwxYaL9pPKYuJrg04/yCP4ZiK
 QKjjjYwPhGIp1tXNvYpLhuRrYETzgQb+Mer5ACNqIM0esYyuCnyOYQcsTyG1chBIyxXs2FlgN
 gnodm0mlKPgnF7uW5TUcWD0gOLt3o9pdrP7vQJ2JCH7z6iGspNpj1yA25aewcoKdGJ5V5ddKq
 mjaBct11DxIbdV/XdNOHev74mseG5rRFjg+ctGpPqUAZCgeSSDFs7HDmAyAef5JWaMHpnV3qZ
 SKDUY2FVmU2OOJY6dWN6UOg4ADYiyh2N/Z8ztT/E9IOYtGVbhAvvmwyowQXzZDR7DiCeM2wl9
 2IREd9ZnU5oncUZzEUxDYgQAeHcHc1CF+hDXPgPUid0G+7Ji3SDuQOeGd3dkHR6VWPsq2ehYW
 T2dVM/rfsUsnTVFTgNNKSrTafR2dFIfYb0bwC31IVCWAbXsfp0XiBLDcVZse2AuKLTWs30sXH
 GqGc8278UYWPJAaeUvvuiT3vTsBfMfna9b6vw68ISOYrqJ2q1GDL2022gdw6Uv7tHyo91/ykk
 IsMs3kYP1am83CzNbODsnDapIkvKN7IMQyhcVAlj82eTpEIUn+S4fJchS5k3gY/wWXS3elqV/
 r8sbucJAP3Ze6EZAd4bUGaq7k0KMxCzshGlXAt2qd/pi9Te+Q/HYRo3qwrvD+fP/s59q2cQDV
 m1MHfrgm/IZxK13LY4r6S630kVvw6trCbyerGdjvK4MzJ/OEUL7ADXExZJB3sKxLc6TinvKCs
 EoFMVw/UthY+MghZ0cEFY5hN/MRGYkftFF6DaBw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oSCb1Bu6if4oHk4Bbn4JdHaaMavNWpr7k
Content-Type: multipart/mixed; boundary="iJxZlTT2rbXoNCuBD2Uo26fCvCWXGFwMB"

--iJxZlTT2rbXoNCuBD2Uo26fCvCWXGFwMB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/3 =E4=B8=8A=E5=8D=887:46, David Sterba wrote:
> On Thu, Jul 02, 2020 at 06:08:21PM +0200, David Sterba wrote:
>> On Thu, Jul 02, 2020 at 07:56:57AM +0800, Qu Wenruo wrote:
>>> On 2020/7/2 =E4=B8=8A=E5=8D=881:39, David Sterba wrote:
>>>> On Wed, Jul 01, 2020 at 11:25:27AM +0800, Qu Wenruo wrote:
>>>> Adding the anon_dev argument to btrfs_get_fs_root is wrong and I hav=
e
>>>> never suggested that. What I meant is to put the actual id allocatio=
n
>>>> to the callers where the subvolume is created, ie only 2 places.
>>>
>>> You mean to extract btrfs_init_fs_root() out of btrfs_get_fs_root()?
>>>
>>> That looks a little risky and I can't find any good solution to make =
it
>>> more elegant than the current one.
>>
>> I spent more time reading through the get-fs-root functions and the ma=
in
>> problem is that btrfs_get_fs_root is doing several things, and it make=
s
>> a lot of code simple, I certainly want to keep it that way.
>>
>> The idea was to pre-insert the new root (similar to the root item
>> insertion, btrfs_insert_root) and not letting btrfs_get_fs_root call t=
o
>> btrfs_init_fs_info where the anon_bdev allocation happens for all the
>> other non-ioctl cases.
>>
>> Which could be done by factoring out btrfs_init_fs_root from
>> btrfs_get_fs_root. This would allow to extend only btrfs_init_fs_root
>> arguments with the anon_bdev, and keep btrfs_get_fs_root intact.
>> So this is splitting the API from the end.
>>
>> What you originally proposed is a split from the begnning, ie. add a
>> common implementation for existing and new and provide btrfs_get_fs_ro=
ot
>> and btrfs_get_new_fs_root that would hide the additional parameters.
>>
>> Both ways are IMO valid but I thought it would be easier to pass the
>> anon bdev inside ioctl callbacks. The problem that makes my proposal
>> less appealing is that btrfs_read_tree_root gets called earlier than
>> I'd like so factoring everything after btrfs_init_fs_root would not be=

>> so straightforward.
>>
>> In conclusion, your proposal is better and I'm going to merge it.
>>
>>> Although I would definitely remove the "__" prefix as we shouldn't ad=
d
>>> such prefix anymore.
>>
>> Yeah with the small naming fixups.
>=20
> It's in for-next-20200703. I've updated the changelogs to reflect what
> we found during debugging the issue, the __ function renamed to
> btrfs_get_root_ref and some function comments added. All patches
> reordered and tagged for stable though the preallocation is not within
> the size limit.
>=20

Thanks for the merge and dropping the unneeded check patch.

All the modification looks good to me.

Just a small nitpick for commit a561defc34aa ("btrfs: don't allocate
anonymous block device for user invisible roots"), there is an
unnecessary new line after "[CAUSE]".

Thanks for your daily work of maintaining btrfs,
Qu



--iJxZlTT2rbXoNCuBD2Uo26fCvCWXGFwMB--

--oSCb1Bu6if4oHk4Bbn4JdHaaMavNWpr7k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7+v9IACgkQwj2R86El
/qiEEgf/RXT6MWp7rTJTP/wqWp273vXWiPNTN0HXM6qc/B6jnQphM3/c99rI2HFC
Sj4YVdG4kviPL5B5yy062rPwL23W95RYFzfA8JjFzj6jvXTHnFyJ02hUvNx6fN0E
hOyvENAu8pxniBl1ushgVtlcG5OYA5eRsqHulIsgoK0k6rncvT28QGxfrZ8L1Dtt
V5DnH82vxcAZTrHRWPz1zJJVKlumfwHOY8gLaPYPTZF3s2v0iteTokxaU12aUjED
y1XKscNBJlwoZndOqDzOfM+OguZt/5WpPUY7ioJp4/D8IRAnH6y8lmuYPg6RwOiY
EZ0fx44veTJBfXxEguRzc6ipiQJM/g==
=FHN8
-----END PGP SIGNATURE-----

--oSCb1Bu6if4oHk4Bbn4JdHaaMavNWpr7k--
