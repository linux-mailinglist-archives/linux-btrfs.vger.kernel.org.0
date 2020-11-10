Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4092AC9E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Nov 2020 01:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgKJAyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 19:54:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:43251 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJAyp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 19:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604969681;
        bh=faxa86CDFNT4tppCjFqg1oCxGrbbvNhxln7gShMmuM8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Bsdn2vGN/3uF0lPsGvFjsI/uf+l7OagGdV5Wda5AFhrXw+cKhE/oy2oQZjnX7wvO6
         B6SCE9KABO0dJZ2c5XFSuf0V15+XFOvxASrWMyaLagww8FUA4kgowsP1fDOq6wLbWN
         Hzo4MruRSG4atNlxcf6/WFrgEcYwOW15Vb4K21EY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmDEg-1ju7QO28y8-00iAp2; Tue, 10
 Nov 2020 01:54:41 +0100
Subject: Re: [PATCH 29/32] btrfs: scrub: introduce scrub_page::page_len for
 subpage support
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-30-wqu@suse.com> <20201109181707.GA6756@twin.jikos.cz>
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
Message-ID: <0d129b3e-ddaa-45c5-e200-35d181b91c31@gmx.com>
Date:   Tue, 10 Nov 2020 08:54:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201109181707.GA6756@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CWSTnxCK3PVrOVhol493HU0LOngOSOsm3"
X-Provags-ID: V03:K1:qU7hY3/7mUNbkF9d+JT2fWmKT5Vwx47cwprUQONzOWc34pmhmgF
 C5EHd6LHhYxccKW1V7FCbnONnMXpJne9EniWmvMFF/OEa/Wn1N6ef8mmE/b2xwqNhetRRQl
 WF08rgQu0VflbEe+sTigE7+h5posizB89faAwN9RPDFlkYc4ovhZUTEQHydtxF90SnwqpU6
 vbB1PWP8ZQzxZFFM84EfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mLubhvmtp1k=:JTldFk5913kUTynC0PjHkF
 BkRE4jo6nY+pqpKI/H0Uollez9qwi7qqC7i+epIebnkuDxFUGbdsSqIDSULe8vFzLlQYNR0vv
 FZSM/qESPhQrm00wKnyJ9b6MEmpk4bpyEIYxefMqTlsr37T+U0xz11xVmqCbKP9U1E6fR4l7a
 ENLaGnQq2ZM/X8aFxrzOawdUBFs3AJOUyaBUOVKeRbZ5jTzk1cUV41Pd3ZlmT9PwtBG5XhgCO
 5BgIpJ/+hG07hNuyf91HlrXpkCABGK18LLOgnrf7sD7YKY6GZIdArIwvyspfVAyWPX7mOxoZ9
 ypxcaEh85JR7s/0ZBdaY6h6EAx6OWKK7cYYfLcwONbm9tbrhtCfgwpQGSj6edQL3FQQmPJXc/
 K9xoBFiOHDvBIoA4FmLdAZ6IH9iFxVNOkkYbwtdnM7MfyNvNOhbiC+jU+2DCGrWqovoZFtJHo
 B79cu+++KHOMIlD05NhAKXLeIqxZsbTJh0lGI38uyXzhRhcveoWuRmxfOMqAg8VeBi4p2sRGs
 5zixk2QNcOWtj8i+cuPycbDMkXKCEvGAnP2BE6sIdG5xckmxs3izTpb1vCs0aEUu3YwFNrMf+
 H18Qy6rBegdZxzqHZPFcchiG5+tGAlEJJNQt/QmAzLKgpUIPBc/AkD8coCNgmSE7jrQCXcw04
 XLCJrOBL73LVZMdiYv0Xid82AOytM7/LSchmD76wlTN7k1pxPESmNnlJdW/Wuo38ZsV6lYF3F
 gZ9zyfyxeTKYhpKPxWw1k/lT8YhKBS25ELjww2dfsQNTeB0+yr8/emgKcMHx8DL3Eopwf+1wz
 KU8xXfHx5HRaSTO8+12usgA7Aahs7ccnIvhsr7v50p7vKSNMPj0CtfTcnZrQGydNN3qEsP3QQ
 SB1v2ONmcWvBUxx9H3mQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CWSTnxCK3PVrOVhol493HU0LOngOSOsm3
Content-Type: multipart/mixed; boundary="68qbH5T2B5OPrZJXcM7aGbemd5qmCci1b"

--68qbH5T2B5OPrZJXcM7aGbemd5qmCci1b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/11/10 =E4=B8=8A=E5=8D=882:17, David Sterba wrote:
> On Tue, Nov 03, 2020 at 09:31:05PM +0800, Qu Wenruo wrote:
>> --- a/fs/btrfs/scrub.c
>> +++ b/fs/btrfs/scrub.c
>> @@ -72,9 +72,15 @@ struct scrub_page {
>>  	u64			physical_for_dev_replace;
>>  	atomic_t		refs;
>>  	struct {
>> -		unsigned int	mirror_num:8;
>> -		unsigned int	have_csum:1;
>> -		unsigned int	io_error:1;
>> +		/*
>> +		 * For subpage case, where only part of the page is utilized
>> +		 * Note that 16 bits can only go 65535, not 65536, thus we have
>> +		 * to use 17 bits here.
>> +		 */
>> +		u32	page_len:17;
>> +		u32	mirror_num:8;
>> +		u32	have_csum:1;
>> +		u32	io_error:1;
>>  	};
>=20
> The embedded struct is some relic so this can be cleaned up further.
> Mirror_num can become u8. The page length size is a bit awkward, 17 is
> the lowest number to contain the size up to 64k but there's still some
> space left so it can go up to 22 without increasing the structure size.=

>=20
> Source:
>=20
> struct scrub_page {
>         struct scrub_block      *sblock;
>         struct page             *page;
>         struct btrfs_device     *dev;
>         struct list_head        list;
>         u64                     flags;  /* extent flags */
>         u64                     generation;
>         u64                     logical;
>         u64                     physical;
>         u64                     physical_for_dev_replace;
>         atomic_t                refs;
>         u8                      mirror_num;
>         /*
>          * For subpage case, where only part of the page is utilized No=
te that
>          * 16 bits can only go 65535, not 65536, thus we have to use 17=
 bits
>          * here.
>          */
>         u32     page_len:20;
>         u32     have_csum:1;
>         u32     io_error:1;
>         u8                      csum[BTRFS_CSUM_SIZE];
>=20
>         struct scrub_recover    *recover;
> };
>=20
> pahole:
>=20
> struct scrub_page {
>         struct scrub_block *       sblock;               /*     0     8=
 */
>         struct page *              page;                 /*     8     8=
 */
>         struct btrfs_device *      dev;                  /*    16     8=
 */
>         struct list_head           list;                 /*    24    16=
 */
>         u64                        flags;                /*    40     8=
 */
>         u64                        generation;           /*    48     8=
 */
>         u64                        logical;              /*    56     8=
 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         u64                        physical;             /*    64     8=
 */
>         u64                        physical_for_dev_replace; /*    72  =
   8 */
>         atomic_t                   refs;                 /*    80     4=
 */
>         u8                         mirror_num;           /*    84     1=
 */
>=20
>         /* Bitfield combined with previous fields */
>=20
>         u32                        page_len:20;          /*    84: 8  4=
 */
>         u32                        have_csum:1;          /*    84:28  4=
 */
>         u32                        io_error:1;           /*    84:29  4=
 */
>=20
>         /* XXX 2 bits hole, try to pack */
>=20
>         u8                         csum[32];             /*    88    32=
 */
>         struct scrub_recover *     recover;              /*   120     8=
 */
>=20
>         /* size: 128, cachelines: 2, members: 16 */
>         /* sum members: 125 */
>         /* sum bitfield members: 22 bits, bit holes: 1, sum bit holes: =
2 bits */
> };
>=20
Thanks, looks indeed much better.

Would go this direction.

Thanks,
Qu


--68qbH5T2B5OPrZJXcM7aGbemd5qmCci1b--

--CWSTnxCK3PVrOVhol493HU0LOngOSOsm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl+p5M0ACgkQwj2R86El
/qg3sAf/cZymNLwEtAXSNENGJo4Bla1d67tQIlY13EJjAmaSrONzLPUieLAhinwv
8RbsI9euUIgdVDT/hRTpq+/yxFwKpO6jghx+mCkpsmZDz7Idp+3bzo2n/TkIpVMN
F/FG/YbUpW/iUJLk2T84kpZpmM+9kfEQAHF6N+Ex0DJxjAkFoYSU7PvTLSh0jnaP
sd4Tpp+0GFOxs60pOY+i3QJZ/xxZXFzkExe8+0Wg5xzTzJUOf5dDdVywdsTj8nNn
KzJBqRwTb9ng4OPErKldYIukW8Hz+WEPwHwaQDuKXPWyUI3cjdn4jd0yY1ZEXCnS
g0D9v08thSjqnlugZdMDwc7jMthe/w==
=BY9+
-----END PGP SIGNATURE-----

--CWSTnxCK3PVrOVhol493HU0LOngOSOsm3--
