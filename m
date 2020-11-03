Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186432A3770
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 01:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKCAGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Nov 2020 19:06:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:60987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgKCAGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Nov 2020 19:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604361979;
        bh=nkxkJafDZBXHqtt338UjYsqWGmJW8lyLGVNxTSKxmXI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GVuAOTSCf9wpCYdrM+ZTxJ8P4hGFbu1AdfQXam/Qm952aaCR4t7gtBZP9djQEiIw0
         nNwAD+iD6ijmCaBfbf44VTDVIk+yXMpIbE3PfvWj6SKlopO66vx1tMNiJzmaL6l76y
         T2GoeLR6WHuKeXHDhqwWOUynQe3AAxts76K7Y8e0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbAgq-1k2asU3suu-00bZVe; Tue, 03
 Nov 2020 01:06:19 +0100
Subject: Re: [PATCH v4 00/68] btrfs: add basic rw support for subpage sector
 size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201021062554.68132-1-wqu@suse.com>
 <20201102145624.GB6756@twin.jikos.cz>
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
Message-ID: <1573fb7c-a54b-c1e1-1b60-8306db85a87d@gmx.com>
Date:   Tue, 3 Nov 2020 08:06:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102145624.GB6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eYk8jbVEjw9wfXU3uwHQXP1SmAvE36cwn"
X-Provags-ID: V03:K1:KiUl1pJbQWGnZ6MrMssj3kQsxp600RmqqptuBwcXpXMu+wMizga
 wTIJpL0WZgEf3AvZwrz9XKzKIEa8TPNzBF2rb33bh/UHZOr7fD/RvA5zEyMmmejozJBdcUA
 u0Eh9Mq1DFYt+dYLBta1UwdlDVN8hf2cQ+qUiXS5383V/TFsNYn49wmRsf58TCDK2uSdYc6
 SyIo2PBeNa5u5NOU7lpSA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ITEbXoYe1A=:RKZPMV1a92OxDVYcKfPJgS
 zCfJuDYbVnklwz0G9zhAPLjSjXMau4oTIZdrA5MQDBPpoaPV9srERPCqZaa9HEz+Bf1jdb8GB
 0CWzYYPM346+CKIKtraNOZs1tMFyE/oYP/WSiGSuastizG5n50YFr6BsVk3c9g572jb92Eg9n
 pdJFyIk85dNRjh9mUxV6XurtcogIKGk1C08nvNGx27yyeoEd9xG8Bmgm/iA0U6n28RmnHbuBl
 7d47P2Q21rJnV7gg8KBM9C4Nt6PiJMh634R2jpAnkNaI9KAFhqP2DOa1AKvDhjJOo7bO+L95H
 +Atlj/NHe4puBfXmwIPw/Vrs+Q008WYPda+v873ZeQhsxrjICW7EOhbhNvFgvBg8GQFlTBGLF
 4Kkp5JbZqRwB1iQpEiHsuXYoHklF8Ry+4RA4sr9VvF/KvXmMRZknGQ8xr7GHFqzMOhFLV9hVd
 gSWmmgzl562TMVZ+FbH6Lsb72J8U/Q4ZIaDM8tYk1TDR/ZiaEuGJfx/REjtOKfpnmhtJ347Lt
 4x7i0DqKsXiMWZqS/4dQ7s8jekT3nieQDt8t1xU6vs7/0GzS4RfPWxoqtzh+udXjd9ni3tObP
 93wIrvmGCpZ37wVf8PRrHLicekdedZjJRScpa4yzgGbW92qBC0a0jSnxZQmvVJc9sskZnRoQa
 e5kcNQqTXp/6fDx92pp8LXRECfmNFChcZp7FVCoLzss7CKYB7tyU/w9Ehe+f0zTJf0KAvQVw7
 xpMKRNcqAiq3rrB2x+QCcpdkg/wJIpnTb2jSBvPZSGBQEBK0mHjKKbNPDWjpWN2RjA8I8v8f5
 VM4nhsXBOzzUOjlW2qMWoSILEktZ4rTgyEjrvU+Uc5qLgWMxCKg/RhHo2YMlge7kxQpIlR1vS
 CppYq6dQkb1UizURVM3Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eYk8jbVEjw9wfXU3uwHQXP1SmAvE36cwn
Content-Type: multipart/mixed; boundary="USQT7OruuQA3V5YzsSa3rf3tFi6wYAWIe"

--USQT7OruuQA3V5YzsSa3rf3tFi6wYAWIe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/2 =E4=B8=8B=E5=8D=8810:56, David Sterba wrote:
> On Wed, Oct 21, 2020 at 02:24:46PM +0800, Qu Wenruo wrote:
>> Patches can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage_data_fullpage_write
>>
>> Qu Wenruo (67):
>=20
> So far I've merged
>=20
>       btrfs: extent_io: fix the comment on lock_extent_buffer_for_io()
>       btrfs: extent_io: update the comment for find_first_extent_bit()
>       btrfs: extent_io: sink the failed_start parameter to set_extent_b=
it()
>       btrfs: disk-io: replace fs_info and private_data with inode for b=
trfs_wq_submit_bio()
>       btrfs: inode: sink parameter start and len to check_data_csum()
>       btrfs: extent_io: rename pages_locked in process_pages_contig()
>       btrfs: extent_io: only require sector size alignment for page rea=
d
>       btrfs: extent_io: rename page_size to io_size in submit_extent_pa=
ge()
>=20
> to misc-next.  This is from the first 20, the easy and safe changes.
> There are few more that need more explanation or another look.
>=20
That's great.

BTW, for next update, I should rebase all patches to current misc-next
right?
Especially to take advantage of things like sectorsize_bits.

BTW, for next round patches, should I send all the patches in a huge
batch, or just send the safe refactors (with comments addresses)?

THanks,
Qu


--USQT7OruuQA3V5YzsSa3rf3tFi6wYAWIe--

--eYk8jbVEjw9wfXU3uwHQXP1SmAvE36cwn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+gnvcACgkQwj2R86El
/qiRhwf/RaxeIruoywXx6mFEKeHREQ9yBVosX8ub8Ax6trUXl0nMfl5D8HqZIIPH
0uwciXEGiz9LbHnFVzKVMzMOwFQs5s+o/K+whtnJaO+ChiuScIrT14ovubxDW5eG
DNAvIuPLu9mP9p0pGt0+hVq77GFTVmYYIjiZHqMl9WU+OUTKfmxtiJ5pRnPRmzDz
uWDKdPNOJLSO+Z7DLlmUXYtVR4nueN1mXN7tiOEZT3kFxRqfnbFqTj+MdXB7jX0x
3o4JZtOD8PQQQKNkhhRPH4ENcDAB7oX3ORKMW1h/UdAvvRL37cUq1uuGCBDRmAXe
BYrvN7Dh4U2KUtbIQkXSolUTp0x0Pw==
=H46e
-----END PGP SIGNATURE-----

--eYk8jbVEjw9wfXU3uwHQXP1SmAvE36cwn--
