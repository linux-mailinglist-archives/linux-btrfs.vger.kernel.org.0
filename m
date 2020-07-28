Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41259230B6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgG1N0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 09:26:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:39391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729896AbgG1N0z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 09:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1595942808;
        bh=IiRfIcKzQfdvY11XDuLI6KUkfWVzYcgDiAHfzYmxPc0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BJf8j/S/i6c8gS+Q7zMCjZk9HyjhEcsw0aTQIhmIHIDulpjO2q9EIxHwrG5FymgCd
         3yTKZFUxtNbnMwZJATOg7NB8gb58XyPDz5mVxrUc7l/YXGEoMDEQSatnGhWmtSrD6B
         Ck/UN9oV9uWHdAXKG/aptOhLZj5jnsdsW2JfrreQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfUo-1jtmrn1XFA-00B6sh; Tue, 28
 Jul 2020 15:26:48 +0200
Subject: Re: [PATCH] btrfs: inode: Fix NULL pointer dereference if inode
 doesn't need compression
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Luciano Chavez <chavez@us.ibm.com>
References: <20200728083926.19518-1-wqu@suse.com>
 <20200728131920.GU3703@twin.jikos.cz>
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
Message-ID: <c0e68f16-a55b-bf4c-47fe-289f83210847@gmx.com>
Date:   Tue, 28 Jul 2020 21:26:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728131920.GU3703@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Dgt1xkh6wd7Syk99xcp2WhEsQlVwWrtM3"
X-Provags-ID: V03:K1:Ajr87W4OsC7gPhMV4hlo+0UV82kxY950srcy6810606WoeS8fXg
 ee8zCLElPROdlPfoWzAaFQiK7j0Qpif7MX2q+n27B35lcqyDB+Qyab9B3p89Lo4dgCWw5jh
 wjNrnUnyBIGNy45z3l4Cnrm6NrTPMKOYLweG8+UWP/xyZ78W+VgzPot97b1IRFfhM6W5BHA
 8N4LSublVYxAspvhuAzGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZFwu3BsM7M=:DJ4YFO2N7Co0N6GsjauMdT
 kXUskdAmZ9zY0bkZKoNn9JEN/qfBHNKMKNA1tqZzKUvxUWm0Shm9gbjz/RYxR9LLRRs8nJZgl
 Uq6nPRgQxg9vG3BsbsVoydBEQbIxc0ZVtVobX7mpM/Tyy2PyRve4h/86U3X1AoHaYf2YHn2LK
 3CVo0a1QUStAaSoBe7n8jcwJ7ZsmOCg1cIWMIhbPMdQ2LWM/9MSqFNEDk5EDuiEx4dgGE+X2P
 RRyNCRd9eX0a6Edk2gOhShbyse4+euW0jQ16o8vCVextbNCsDLRXZGmulo+mIM7xkU3BnEFEz
 rtEa+pSmF2H48ux3V0kDxixDQU+S7ksoMomLGo0lRIBQIENAWzHwr2QzgUpgcmNMpumWEraMx
 o2pey9ODSqz1+n1tad14Sgaeg7ILMCYa4EcOyXF8y4XGi+4eqeXfEsPwvctzcc4ChGSGZNx8b
 h3OtObRimTWfQw1mfhQY7jNEZgS7I6TtwLw4JRLq9DtzzueyRKUMcaKHQzbmqC62yx6JTS2QX
 nel4mHTo35cMo1HIKmsOHDSJQU3/6/w3sdgskSFteoXWHb5LACgZqMFjiaUstrYl+uzBgkV3m
 +ED0k/Eh0hYIuEOtieHDu2oh5T1cH8QCSWHuTSTfgfBwnHYWt4LJCjdKVsY7J61XKV18NER6h
 FZ0CffdQqffKWERzxD5owfR1uxAbltpwyzkVeJ5txndX2ZOtOTf/65XJ8jBwOlXSwFcHUz/w+
 o+s4vMcTbxplfjynKSW9hZDs3FVXE2SxlwqThsI+MHDsqNxNaXNC1wlkhY61HURj4FIWu7KGH
 I+jrKHGduMR4lNGD2NCoItPTYf4guVGtFeXbeQ9Xje+XRTXlEGYbaSERSC6BYCxBNvIkZrLp9
 FiaGLomV7jTMiTT1BpLunAv3jNcVg7n3wwzNVxEeOmP9ELjLru1jzWHTaS80tj8/E6poubwz+
 dcW5yLYHqQ7ROwcZGS9dukBWs4RMf5QxTnIdyMRlCNg8M+kkq6PjzkbXG52Jk55dbEBrf1BdY
 DdcK3ElHQK5IJLFJj9YtejUEKZGhE+1uxCt2retAThSVzpWMqPqHsOLOMvs1+Oe3qej9TJ3Kn
 cJQAvigoRntZcM63XniBhDXDF68W2gXqaxzumk2gposLZ8Z+UIKo+BEcvndRAw6++KN+0SB83
 BZ5oJcA/R3TaPFcRVqp/Vxm72450N2rLI0Pb3NWLS1dZkOvdFmOPd/UzCEuNjlhrRMmIqfJ+m
 Rw9pyhz/aI7G5U2+m4wB7yOopUAeCOzK8TkjlEA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dgt1xkh6wd7Syk99xcp2WhEsQlVwWrtM3
Content-Type: multipart/mixed; boundary="AeXngupi4x3tbwPripNa2Y82uufr4NrGI"

--AeXngupi4x3tbwPripNa2Y82uufr4NrGI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/28 =E4=B8=8B=E5=8D=889:19, David Sterba wrote:
> On Tue, Jul 28, 2020 at 04:39:26PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a bug report of NULL pointer dereference caused in
>> compress_file_extent():
>>
>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>   LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
>>   Workqueue: btrfs-delalloc btrfs_delalloc_helper [btrfs]
>>   NIP [c008000006dd4d34] compress_file_range.constprop.41+0x75c/0x8a0 =
[btrfs]
>>   LR [c008000006dd4d1c] compress_file_range.constprop.41+0x744/0x8a0 [=
btrfs]
>>   Call Trace:
>>   [c000000c69093b00] [c008000006dd4d1c] compress_file_range.constprop.=
41+0x744/0x8a0 [btrfs] (unreliable)
>>   [c000000c69093bd0] [c008000006dd4ebc] async_cow_start+0x44/0xa0 [btr=
fs]
>>   [c000000c69093c10] [c008000006e14824] normal_work_helper+0xdc/0x598 =
[btrfs]
>>   [c000000c69093c80] [c0000000001608c0] process_one_work+0x2c0/0x5b0
>>   [c000000c69093d10] [c000000000160c38] worker_thread+0x88/0x660
>>   [c000000c69093db0] [c00000000016b55c] kthread+0x1ac/0x1c0
>>   [c000000c69093e20] [c00000000000b660] ret_from_kernel_thread+0x5c/0x=
7c
>>   ---[ end trace f16954aa20d822f6 ]---
>>
>> [CAUSE]
>> For the following execution route of compress_file_range(), it's
>> possible to hit NULL pointer dereference:
>>
>>  compress_file_extent()
>>  |- pages =3D NULL;
>>  |- start =3D async_chunk->start =3D 0;
>>  |- end =3D async_chunk =3D 4095;
>>  |- nr_pages =3D 1;
>>  |- inode_need_compress() =3D=3D false; <<< Possible, see later explan=
ation
>>  |  Now, we have nr_pages =3D 1, pages =3D NULL
>>  |- cont:
>>  |- 		ret =3D cow_file_range_inline();
>>  |- 		if (ret <=3D 0) {
>>  |-		for (i =3D 0; i < nr_pages; i++) {
>>  |-			WARN_ON(pages[i]->mapping);	<<< Crash
>>
>> To enter above call execution branch, we need the following race:
>>
>>     Thread 1 (chattr)     |            Thread 2 (writeback)
>> --------------------------+------------------------------
>>                           | btrfs_run_delalloc_range
>>                           | |- inode_need_compress =3D true
>>                           | |- cow_file_range_async()
>> btrfs_ioctl_set_flag()    |
>> |- binode_flags |=3D        |
>>    BTRFS_INODE_NOCOMPRESS |
>>                           | compress_file_range()
>>                           | |- inode_need_compress =3D false
>>                           | |- nr_page =3D 1 while pages =3D NULL
>>                           | |  Then hit the crash
>>
>> [FIX]
>> This patch will fix it by checking @pages before doing accessing it.
>> This patch is only designed as a hot fix and easy to backport.
>>
>> More elegant fix may make btrfs only check inode_need_compress() once =
to
>> avoid such race, but that would be another story.
>=20
> Yeah it gets mistakenly called twice.
>=20
>> Fixes: 4d3a800ebb12 ("btrfs: merge nr_pages input and output parameter=
 in compress_pages")
>=20
> How does this patch cause the bug?
>=20
Sorry, I should explain more on that.

In fact it takes me quite some time to find the proper culprit.

Before that commit, we have @nr_pages_ret initialized to 0 in
compress_file_extent().

If inode_need_compress() returned false in that function, we continue to
the same inline file extent insert,.

But in free_pages_out: tag, we use @nr_pages_nr to free pages, which is
still 0, as it only get initialized to proper values after
btrfs_compress_pages() call, which we skipped due to
inode_need_compress() returned false.

Then free_pages_out: tag will not execute the WARN_ON() and put_pages()
calls, just skip to kfree(pages). And kfree() can handle NULL pointers
without any problem.

Thus a completely sane looking cleanup in fact caused the NULL pointer
dereference regression for race cases.

Thanks,
Qu


--AeXngupi4x3tbwPripNa2Y82uufr4NrGI--

--Dgt1xkh6wd7Syk99xcp2WhEsQlVwWrtM3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8gJ5MACgkQwj2R86El
/qjvrQf/Silj67Gkj1Znp7uy+srFpAZbJp3zXM/UfPayiYR3jccbD11QjON+UUu6
hem8GZbup1i4+JuZ3Me/QbG7Tm+03D0HIL45dojJjNghP9aK7wnFOX6qwmCoQ+Qd
kSCGiIDjiBx9+bg1tew9yWtXixE8Efdm9Ew4w/hiF6d/lZS3WTf1k0HEzEtnj3f9
6s5Rn0OQSvFKApb5qRIHRQO7cfWp/b61gw3WrWFYTUIZZjXFVZtkIT4PMmjVVq4p
16UEOb6jQR5oWxt2dTzMSDG+p+XvYFQ/V2iH53IfpHXuZC4EvTdxynuWBHVCltbR
DNz9gpSgIvZtqoAKwdpXs7mEZWBRag==
=GisL
-----END PGP SIGNATURE-----

--Dgt1xkh6wd7Syk99xcp2WhEsQlVwWrtM3--
