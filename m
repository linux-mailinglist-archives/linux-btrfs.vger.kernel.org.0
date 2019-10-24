Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB02E3056
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 13:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438969AbfJXL1A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 07:27:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:40291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436501AbfJXL1A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 07:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571916418;
        bh=10WnrywkCfVtbzbt9LmddijxJPzkyIOut0j+8al2r9I=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fI8hTkGc/HVxqM7AOBnz15RNkl/8CGC5uHn3lwebZ8bLkr4ncM90PZ5R4WaSrxU4v
         oujFpXWhlqjmx0bSmkSIHVSRdWkRL1UXwHWIL1sR2/9mR4L2ZrEkOSV26agDmCKeGS
         mXh1ezmg95LXX67DcO3h01b6Ym4XG/jExf+LrNeg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MtOGa-1i9m990dTi-00uob3; Thu, 24
 Oct 2019 13:26:58 +0200
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Christian Pernegger <pernegger@gmail.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <CAKbQEqG35D_=8raTFH75-yCYoqH2OvpPEmpj2dxgo+PTc=cfhA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com>
 <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com>
 <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com>
 <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com>
 <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com>
 <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
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
Message-ID: <d16e0ce7-23c9-3d0c-ef60-25aa7076fbdf@gmx.com>
Date:   Thu, 24 Oct 2019 19:26:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZTZLBQfIC7Tqpqy3yc1FT2p1NsAXDeCAn"
X-Provags-ID: V03:K1:/MJ+l+1zpZJHrC2xLb+14f9nu/XPmienZ0IF8SKYm9MnLCWt5hI
 I6Ak169gtDItI0aO9Fw/wtehsLgtlwvgydHTh8gxKRBqX5MQtso29j1Unl1UL6xQw1fHvTl
 Y4GzBojn+UHLvf9UZQx9kAc3bRe6XX6Z8BOjPMYV6jPn3hlrHUk4AgHXDf04pALAnE0dmqu
 o7Y7PLRjxZdkRl/Vjdq5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mlo81TJfjAM=:wVO6NVDX7TENShM4OuQbxK
 nEbIt9MUW/23Gs8HLBvz8EMZXa8tRv2ULESjPmmGbL2icG2ez4DredLNGcGodmlQfHh7ZUUQ4
 UkdVOGIXZHd5b2pezB7GLGMebtUunNxe8JmTsPV4H4VTfTuymGjKmg2buGFwyM2XzK+vE13U/
 J1cuQakdGWxYlM+v0pGc54v7NnZ7gx4C+pXwia417u/nMpl5nqsM2sQkQ0NxCJD2Wok4YIers
 cnRhT58tAZvGXRSJvpzLPAgejgpealiruA5pnU8y8Pld/W8jqH3vC8qH6jBf8KHl8MiBzp7DE
 qYOjqGPzUGCWEfus+UIm8jAwc89okAiFmalhyC7VR+oJOyf2zZAszUFeaXrEsrLCslO6SVzGH
 t7HsCT2NrJokD8O4v7DpVwmLbfM+WTPMWcLKu867bCOVrvIb2X1wczAkHi+dqsr0d3vzgcztC
 MGeSkw+ADCJzzjChrSUw++4F4iCQl3F48c9oJwDYzqmKmpiEopiqhMKttVAMz/Q6z1W712weF
 E1FCbvQyZeyJyFI72fJYo4pullWvymUXab3FF2x2OSMB76ENb5or6WZxfg5o667K3eRRLDlhY
 EmLv1a735Vyy/+ORd/eAfuon4X0EwhI6Y7SBz/YuR+VsTfagqmVpRkYFXiz9pn1AXtZoo78CR
 eSu0zzVA90FWUgrENX91hhi9dv9oQ3EwBHvZszcP6mSzpjQzTqUjDEJR8hTDhFlCyW/8BjudG
 t1kEHTX1OX7AKlUSxP294M7TsO05KIZp2A3AP6Dw5hKl8EqL3lXCa0EAeBmrHK6oUQmBHLPn8
 xbqmnCNgBtWSHkSss34/9TDjM7rVYy55oaqdwxfBpBUWiHDq3qI8SSvdzgazWWLTxq4OGIA9/
 hAoebFUjHJqaL2oLMaIgQZW0PsB4gjl9+bPmYTpeVZXgApAa5vJUSAP4gh09p7IbogDfqCTSt
 ppbE21BFxih6Ib20QPSwegmPB+aEkgSDpaDcQbzdoWCYgPShHaezZTGi7AStuQcPG+5To/JQp
 TsRj7JGkIGFpchBHe4AaShUrlasRSISIO1GQYWUphkqAwNKKt2UScT9FnxCo+sdCryDitfdrR
 k3SjFGRtjakmaNSYqvDvHxfASHWpsQRSNW9fHD1oFZDZzGjR3zVDTtBpKOYQff5vricckVxvz
 td5yEKhUjkydtosHBOyB+FxvyaV6z5uBVKHm/aKcl6rps8eCAiMlbtFaUVcTDcTrWSB0Fj3vF
 VCe9UccefQKSc1he5S6TI9SwuL7BxJq5/QU3SObR+js4Zwmmo9ajgoq5+8w4=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZTZLBQfIC7Tqpqy3yc1FT2p1NsAXDeCAn
Content-Type: multipart/mixed; boundary="SfUPKrjcDRJlixxUCKmKMvhlejsBbC7DZ"

--SfUPKrjcDRJlixxUCKmKMvhlejsBbC7DZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/24 =E4=B8=8B=E5=8D=886:41, Christian Pernegger wrote:
> I must admit, this discussion is going (technical) places I don't know
> anything about, and much as I enjoy learning things, I'd rather not
> waste your time (go make btrfs better! :-p). When all is said and done
> I'm just a user. I still don't understand how (barring creatively
> defective hardware, which is of course always in the cards) a crash
> that looked comparatively benign could lead to an fs that's not only
> unmountable but unfixable; how metadata that's effectively a single
> point of failure could not have backup copies designed in that are
> neither stale nor left to the elements, seems awfully fragile -- but I
> can accept it. Repair is out.
>=20
> Recovery it is, then. I'd like to try and build this rescue branch of
> yours. Does it have to be the whole thing, or can btrfs alone be built
> against the headers of the distro kernel somehow, or can the distro
> kernel source be patched with the rescue stuff? Git wasn't a thing the
> last time I played with kernels, a shove in the right direction would
> be appreciated.

Since you're using v5.0 kernel, it's pretty hard to just compile the
btrfs module.
As there are 3 kernel updates between them.

Before compiling the kernel, you need a working toolchain.
Please refer to your distro (you'll see this line for a lot of times)

For Archlinux example, you need:
# pacman -S base-devel bc ncurse

I'd recommend to the following ways to compile the kernel:
$ cd kernel-src/
$ make localmodeconfig
$ make -j12

This would  compile the kernel, with all your current loaded kernel
compiled as module.
Then you need to copy the kernel, install the modules, and the most
important part, generate initramfs, then guide your boot loader to the
new kernel.

# cp arch/x86/boot/bzImage /boot/vmlinuz-new
# make modules_install

For initramfs creation, you need to refer to your distro.
I can only give you an example about Archlinux:

# cat > /etc/mkinitcpio.d/custom.preset <<EOF
ALL_config=3D"/etc/mkinitcpio.conf"
ALL_kver=3D"/boot/vmlinuz-custom"

PRESETS=3D('default')

#default_config=3D"/etc/mkinitcpio.conf"
default_image=3D"/boot/initramfs-custom.img"
EOF

# mkinitcpio -p custom

For bootloader, also please refer to your distro.
But I guess it's less a problem than compiling the kernel.

Then you can boot into the new kernel, then try mount it with -o
"resuce=3Dskip_bg,ro".

And record the dmesg, if anything went wrong.

>=20
> Relapse prevention. "Update everything and pray it's either been fixed
> or at least isn't triggered any more" isn't all to
> confidence-inspiring. Desktop computers running remotely current
> software will crash from time to time, after all, if not amdgpu then
> something else. At which point we're back at "a crash shouldn't have
> caused this". If excerpts from the damaged image are any help in
> finding the actual issue, I can keep it around for a while.
>=20
> Disaster recovery. What do people use to quickly get back up and
> running from bare metal that integrates well with btrfs (and is
> suitable just for a handful of machines)?
>=20
> Cheers,
> C.
>=20
> P.S.: MemTest86 hasn't found anything in (as yet) 6 passes, nothing
> glaringly wrong with the RAM.

This doesn't look like a RAM corruption at all. So don't bother that.

Thanks,
Qu
>=20


--SfUPKrjcDRJlixxUCKmKMvhlejsBbC7DZ--

--ZTZLBQfIC7Tqpqy3yc1FT2p1NsAXDeCAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2xinwACgkQwj2R86El
/qhlUQgAmUcBGT6/rrePc7yBRr/wE/YF0UtJKilGnhn7/stvxw9U5oCuM5IZrKJP
fDQhLYo1qm6pIie3Wts5rW3uBLAVNfIzjTqdfGwIJ0x+VoSnF4vkPn8/Wx4emheO
Dll8xUu29FXTdwP10NNoizo7N1K/d1RN4L6QbfoutbzqYAor81aY5g2cpjGrrNWi
eadOPjthQmCG5syaLKqEFdtjn/LqNCAZSOrfKPo7G8WdwdVo0bEYn6vVA4IvXLgt
upQv8Mj9QJ42O2P/qQUXd9p1eLIcbG+3JJyUK0j8GBjv7SbsnExxFWfyEa7ykVhJ
Om0SlO4JKsPwUO5eIG4B8rYDz8aUvA==
=7yxk
-----END PGP SIGNATURE-----

--ZTZLBQfIC7Tqpqy3yc1FT2p1NsAXDeCAn--
