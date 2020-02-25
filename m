Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF8416B638
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 01:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgBYACZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 19:02:25 -0500
Received: from mout.gmx.net ([212.227.17.21]:44021 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgBYACY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 19:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582588938;
        bh=Ic65jJ6ahJD7wyjpdZujZ3aSZPfm2hmyL+BkVHOi//o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Lpj8CTx7VfK5OPTjE3K01e6hk2nL+RFjJ15J3Vqy96SfAP99gcdI0etMXnh9QIkta
         yqdbDQ13dYZ5equ1WBKYH/d6tg5/NaxftPjXvkK7e9KO4KlH4J0alUnYtOYUcjp1gd
         w9ZYisKea0MsMecS8flOCDJHcRfewdb9QO01P5J4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPokN-1il9w20y1b-00Mqmi; Tue, 25
 Feb 2020 01:02:17 +0100
Subject: Re: [PATCH v5] btrfs: Don't submit any btree write bio if the fs has
 error
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200212061244.26851-1-wqu@suse.com>
 <20200221133559.GG2902@twin.jikos.cz>
 <8e100fed-13ba-febf-14da-452635094aad@suse.com>
 <20200224170615.GZ2902@twin.jikos.cz>
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
Message-ID: <90aa8815-2989-3472-e706-9a3a87f0f13e@gmx.com>
Date:   Tue, 25 Feb 2020 08:02:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224170615.GZ2902@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0TCD7dsxLYauccKZG1zO4Uhph5TbM6wiu"
X-Provags-ID: V03:K1:GuEY6CzpaplfulTzEz8Bt8IXyk9KVAy35+2GVXfCTPVchjETiq9
 KwsPxXTu05vohsXZu+ZN2WtuLJsMKT/puzxPfwXAN3JRar6Iq928jxIs6BgbK4TJU3Arl/A
 NJ+fwesOOHw9R078HLV8J0KlYfNKG6VOkpTJDGAJP8PWvZnrrqfVBquKt6sVKubSK0qiPel
 M2vRbA648+jLsZ3BxIDCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bEEsIumhp5o=:0ZxUh71xzpWeYtlU6QoRAJ
 aFlZgn+TAFalRxFRqGivDRoMHQutUZl1Xu4sVn/H9hebAppWRT2OBW9bADrVoTY5t2XypEysm
 X+tgKtXEq0xtSff72ELWV2Xq4MqMukkgGWrc29EY48lpN7ZJV6Nj7p5TA+HE/X8VR/9i4Yjei
 uHtST1qcbnWFp3XmD2H+BrGpWIqdz97S44Rse8GTWPFTy2UqQG6kVa/KAl4tPk7WPPnhfc3aG
 olWad2+r128EfcJa12JCrAC9CbazURQFDpf9/fmy7gFNn/lIyNSR+zaWCZQkYhV/iEfA7Awf9
 DvvGTQTjOMquursbvaVYRnpNcvogpfIEQfWIFNvNZyCl828EbaJmLfIEniwbYcEQoeaT6sU4H
 1kGpG7k1N/7r06fY/sZh/piQbCr/xtl6hSJzjAUiayBX3HE6mqw0PHEniLsBGWRa6MhEP8YDo
 dGQ+Pfjv2RdONDGmxAOgNbAQ0Z5cz0xaolBQgY8yBl7cVnU1+6Qbe8Lm5V6+F+c9IDA8bjvST
 +A9MNjYU48KOye70eOBkvXL/yqS27PH+jSaQFOtIk7TPJEdVgf/M7Puho4CiXP8iL7UcF+GSC
 yBOOZiQp12t5/NS6xE7rJ5xBojkXKggXz/DKB+ONdndjStzNyn2NmYlCubKhm7z+TlIwHelrE
 efYLd1RNc39PuxsqLlKEZ0glVPDMjnB5In2+R5y4gFszsXQaSF7pZ1E1+LzoYEAoA+KP8GaB/
 yRcleBfA1gUylLXTpyQpBd9KhkFrBr3C+fDR/tiMrUAYTYGat9j4TqPmez9vDCxR93WJfP1Bs
 Gemzbqn6smDfkxKbSHcLorwK/h4lBpYr+AotH8Fl/X9rTn8ociVf2WDt3mEnC19xRfYZBFGXm
 RXmpGYzESHiejnnMHMY7lHPoxku3IdhromBJQjdVs4c3R6ZhJU8no/GlxveiEk5VguIZZ8d1z
 sHo50UKpT7MAZgjMvS7cQd36TEXBKQotFmOUtnKqcaPTezInzP3FXKTxcY/BbgRcdNN3t4i/E
 rgg0fe4L70JtWIPFS4YGhBCKtjhlUbs14rNZTBBdr1CXO2/x3b8O0xGY986vhaTMrLA29TW18
 JlRcLwbuJ04R6twO4aQHNCWuKk9my9Y/ue7kgI3f3zN1Z1cYTwtQrH/KWOIFVfntZdGR5c9xv
 nllQzOOTZz4FStSx0oz57FF2+ffrjkb9XyyitdpayqDFcM2Uxi/tj6wVlZCHOxh8kdqK9SzGp
 77601QOe0XE5Pgssv
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0TCD7dsxLYauccKZG1zO4Uhph5TbM6wiu
Content-Type: multipart/mixed; boundary="e80hRYItKO5RGtaqBmfpG01Vn7AlazKzp"

--e80hRYItKO5RGtaqBmfpG01Vn7AlazKzp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/25 =E4=B8=8A=E5=8D=881:06, David Sterba wrote:
> On Fri, Feb 21, 2020 at 09:40:32PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/2/21 =E4=B8=8B=E5=8D=889:35, David Sterba wrote:
>>> On Wed, Feb 12, 2020 at 02:12:44PM +0800, Qu Wenruo wrote:
>>>> @@ -4036,7 +4037,39 @@ int btree_write_cache_pages(struct address_sp=
ace *mapping,
>>>>  		end_write_bio(&epd, ret);
>>>>  		return ret;
>>>>  	}
>>>> -	ret =3D flush_write_bio(&epd);
>>>> +	/*
>>>> +	 * If something went wrong, don't allow any metadata write bio to =
be
>>>> +	 * submitted.
>>>> +	 *
>>>> +	 * This would prevent use-after-free if we had dirty pages not
>>>> +	 * cleaned up, which can still happen by fuzzed images.
>>>> +	 *
>>>> +	 * - Bad extent tree
>>>> +	 *   Allowing existing tree block to be allocated for other trees.=

>>>> +	 *
>>>> +	 * - Log tree operations
>>>> +	 *   Exiting tree blocks get allocated to log tree, bumps its
>>>> +	 *   generation, then get cleaned in tree re-balance.
>>>> +	 *   Such tree block will not be written back, since it's clean,
>>>> +	 *   thus no WRITTEN flag set.
>>>> +	 *   And after log writes back, this tree block is not traced by
>>>> +	 *   any dirty extent_io_tree.
>>>> +	 *
>>>> +	 * - Offending tree block gets re-dirtied from its original owner
>>>> +	 *   Since it has bumped generation, no WRITTEN flag, it can be
>>>> +	 *   reused without COWing. This tree block will not be traced
>>>> +	 *   by btrfs_transaction::dirty_pages.
>>>> +	 *
>>>> +	 *   Now such dirty tree block will not be cleaned by any dirty
>>>> +	 *   extent io tree. Thus we don't want to submit such wild eb
>>>> +	 *   if the fs already has error.
>>>> +	 */
>>>> +	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
>>>> +		ret =3D flush_write_bio(&epd);
>>>> +	} else {
>>>> +		ret =3D -EUCLEAN;
>>>> +		end_write_bio(&epd, ret);
>>>> +	}
>>>
>>> This replaces one instance of flush_write_bio, would it make sense to=

>>> wrap it to flush_write_bio or some other helper? There might be place=
s
>>> where not handling the fs error state would be acceptable, so eg.
>>>
>>> flush_write_bio =3D as it is now
>>>
>>> flush_write_bio_or_end =3D does the above
>>>
>>
>> I don't believe there are other call sites needs such special handling=
,
>> thus a wrapper only used once doesn't make much sense.
>>
>> Unless we're going to introduce more path for btree writeback, current=

>> one would be good enough I guess.
>=20
> I see, thanks. The steps to reproduce are quite complicated already and=

> expecting crafted data. There's probably more but would need a similarl=
y
> convoluted way of hitting a missing error code fixup.

The reproducer is complex, mostly because we're catching the problem at
the final stage.

In theory we should catch it as early as possible, although we can't
catch it at tree-checker time, we should still be able to catch it at
tree block allocation time.

For create_tree_block() if we get an eb which has refs > 2, then it may
indicate corrupted extent tree.
IIRC I have submitted similar patch before, but not merged due to some
false alert I guess, maybe it's time to verify that patch.

Thanks,
Qu

>=20
> We could add more invariant checks that would catch that something is
> done at a wrong time, like here metadata writeback after everything has=

> been shut down.
>=20


--e80hRYItKO5RGtaqBmfpG01Vn7AlazKzp--

--0TCD7dsxLYauccKZG1zO4Uhph5TbM6wiu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5UZAUACgkQwj2R86El
/qixdAf/QFHjdsXIF5bz5MSWQ/Wq5/dugyRDUAjvUfGgWOei1zP7dsFcYLsJ0kCe
MwKqUxqvidu4lggVqo8ZJ39lVbmzruNOzAVKGzT9rZMOXKB01w8V67ACshXNuLJr
tVxknRRkM/5cyhCs2GnBG3H1ep/S4x5cHKDOplQzJqwJ0aHBNykwyLkQqzTFREJR
3WXafyG1F2XYaEdVtnR4YWCh+XdpE6VwE0zTj75+EBMW9hMRTKku+KWPkyYs7JaN
NOozYCC+gbDIuQELyrus4e4xh2XQfnF12IsGZNqyze0JZnv5H2olkcHAYEt5sM4V
AY23qBiQ/IEKMYclioesLg5chUUUzA==
=TxV9
-----END PGP SIGNATURE-----

--0TCD7dsxLYauccKZG1zO4Uhph5TbM6wiu--
