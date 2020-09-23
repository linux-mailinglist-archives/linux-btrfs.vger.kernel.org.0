Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67889275657
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 12:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIWK3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 06:29:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:60425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgIWK3B (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 06:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600856927;
        bh=qIr/OuYYNAbYDj22Sb8DqYO6oV5dMSnzRONJKfuvOFY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=LafYmGuuxsUyycDKfpZ4AYAMB4HycesDuZqdZODweKqVl+rj1a3W1zlYVSLoxYORs
         n3Jc6pE0aMTfXgrpDUNDu2thdpuWJPMybRpBTjU4KvAksDUq/Vxko51+8Fh6Qm/Dtx
         EEGLc2jM5+uUhzyxcr/pRriq93bxZvAFryrPLGIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MnaoZ-1kmMUV1jGP-00jb7O; Wed, 23
 Sep 2020 12:28:47 +0200
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
To:     dsterba@suse.cz, kernel test robot <lkp@intel.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Martin Steigerwald <martin@lichtvoll.de>
References: <20200922023701.32654-1-wqu@suse.com>
 <202009231428.5CFBSt9U%lkp@intel.com> <20200923093133.GJ6756@twin.jikos.cz>
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
Message-ID: <ab9e6eb3-6aff-1ea3-62e0-4489fe73e066@gmx.com>
Date:   Wed, 23 Sep 2020 18:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923093133.GJ6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vgnfynEVXBIxDjL5gKofa873v00si57IU"
X-Provags-ID: V03:K1:GV3DMxNi9U/kpTABAHQdlmrO8Hj8UgXyTCnoJ3tvx8Yc0Fxrbx6
 iwlcLSQ0gCTfwRvIWecbN9jbNGK5xmEq0ftL3x6Ga2IQcJKNbIVZwKlyccinTRIdeCDzFGk
 +e1BYn0hMZ9ATkP+VS55wrKIk0+I+KN2aoVxBdotRu238rrKvIruYF+QPDQrrzKBX7FRlSp
 X9QAhblFAbhj2mBoErPbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nEdP/bw3oew=:PKLTQs5ww/FcOoYj74shNq
 t/T6r/1VpSZQnJFYiNg0l7TdD2GBj6j/KBRWrYnSYRj2++/UN1pZ3VYL3KfdiihCK5qmzU692
 5fm+IMDXznYlrts7zWdbQmKSHVvNvY5OqQjIqnkVDbO1GAaSP1DK7NRMk0m/9zB+3lYoGX8VM
 OOzXQMhUa9Np3ZvS5pagKfqbgzrtDz0q0VOOyuzdQjmOHg3kMb7XAmRuHSxG/QoH7yPlMZwDo
 6UBikkXlmuqNicxdnG0AFtNtZ+P4viege9w0i1+YUUMQnXijHP0glJN/SeFqMOJLhE+coF72N
 2Y63zIBRqXK0jjTU0udSCM47DN0UuFADIMhXFJbbbGDtzmF/1oBMXyZpJNM8JBlbMbVTn7Bcz
 jWKIKZy97h4tG9GqSr61kYTyniEkqgj2057mkqHBeDuGUFq2F9VEc5YH6zcZULYH9Bk8mGVYc
 2mLQ/QPH6tox+ReZzGP00Qzp0sJeByezlx78NNUE1y/MKJneWIe8Zge2xdO5ipXs0MgnykU4F
 cLwSXSq3C76eA/vCsyHtyOp8Lrkwxgz9c8ny654oxe45bPHAn2Ne3fQmF36hhvVf1Yd0Z+Vny
 WmoVfoLJ5HcliauduNUzvdU09S0X3621WbQVyULVb8ig9or5Onq42Ooml0B4jyvn+TRrehFMD
 2OtUYdTH4ns2pHg/40Vk9POwkYTPfig/tEnT1X4NLKzuFDsr7dx1bDsVK3m/MptSq2AWGJhXd
 XX9zP5b5384uOzO6d7Yo8XzCr+D8vtBztrAn55htJwZJZSjvaIKtnHNR4wglU3XIs8UkZHFC/
 uR7b8iNcL/rXzMFcUrb1S5UNMV2jJQ270wJ16R/ZihKMq3nLWc07hBT/fZfoGCJS9ImcGglQI
 Zc+o2Fn6jrILcjpkVsfG/FqK38M6ppIPA8y61UX8oqr0Q9M174Oispy6P/QKPrWdBIxUqe5Of
 ew6EDKG/YxdBV9A8oBDrxlKc60Jc1C10VIiu/bxZWOTpPMoCTZLXScefsVUUwsI7Fhwe6ni0j
 9e8fgEOrUFqXv6No2Ai24ekUl7H6u8gAV5+a3Ds+UXN+8xu1wxaONGLRbujZ/m+zIkCkHkH+Q
 bnF6pLtoVm0vmv/HVVAQYRXIUWPxASAKXosSnwvVfz7wjWahdDUitOIHnLnMpe7GOzfrR6BBW
 UECRLLTcqmJLX4fR+q7jfLHhS5ES0uBJTqaUkiUh1u437ua+LgYR92YjHT5w58JH9e0f5pplh
 1FavFxYQ0fDUMWDXDc5ImxDD+8ZxmjelWZp1nng==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vgnfynEVXBIxDjL5gKofa873v00si57IU
Content-Type: multipart/mixed; boundary="R1toVwMLlj2OJeGPfzwiLqmw0EA1Uzc5q"

--R1toVwMLlj2OJeGPfzwiLqmw0EA1Uzc5q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/9/23 =E4=B8=8B=E5=8D=885:31, David Sterba wrote:
> On Wed, Sep 23, 2020 at 02:23:18PM +0800, kernel test robot wrote:
>> Hi Qu,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on kdave/for-next]
>> [also build test ERROR on v5.9-rc6 next-20200922]
>> [If your patch is applied to the wrong git tree, kindly drop us a note=
=2E
>> And when submitting patch, we suggest to use '--base' as documented in=

>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Qu-Wenruo/btrfs-fix-f=
alse-alert-caused-by-legacy-btrfs-root-item/20200922-103827
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.gi=
t for-next
>> config: x86_64-randconfig-a014-20200920 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 6=
a6b06f5262bb96523eceef4a42fe8e60ae2a630)
>> reproduce (this is a W=3D1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install x86_64 cross compiling tool for clang build
>>         # apt-get install binutils-x86-64-linux-gnu
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross=
 ARCH=3Dx86_64=20
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    In file included from <built-in>:1:
>>>> ./usr/include/linux/btrfs_tree.h:651:19: error: unknown type name 's=
ize_t'
>>    static __inline__ size_t btrfs_legacy_root_item_size(void)
>>                      ^
>=20
> u32 should be fine here, we use it for all the other item helpers.
>=20
Sure, but I'm a little interested in why it passes in gcc v10.20...

Thanks,
Qu


--R1toVwMLlj2OJeGPfzwiLqmw0EA1Uzc5q--

--vgnfynEVXBIxDjL5gKofa873v00si57IU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9rI1kACgkQwj2R86El
/qgIFAf+P3SmtUwZZiMoYd2ysWauUrTdN8nepLc9bVb1UDnIepQN8QuzuHg0giF6
7nZw8ihlKH3uo2AV0YGgNOW3eNJaU0F2iXT6vWoOd5E5KruuqjEe/7L3m64ygXU3
Khy5eNc3+AGq0jbzDbJaG1PAoUuAqNN4ozXHLHJT6CzEv82b+LVYZVP+rBUsyoiR
sSx/PszSogTc9w70e82h+VlDQY2dPOOg5wPlwaoDB6Bqh+ljcqij2evQzTrgvGdd
KC83ro6SLRNEFTZPUOvMge6ltU+tG7L9e0wWZifZ1jLvsvR2dAcYtAmrSqceoJ0z
GluZ7zMdwDn5zbdOxhRp7kcYkhyu0w==
=rCIk
-----END PGP SIGNATURE-----

--vgnfynEVXBIxDjL5gKofa873v00si57IU--
