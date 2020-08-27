Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8792253BD5
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgH0CTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 22:19:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:36817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgH0CTm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 22:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598494778;
        bh=dQrYifHOeA9DcHdpvbFx+23JwGHCe8nKeR/YKKWPSq8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ljzC33abiOp5gCwHtZJmm+/uVtH6g3Md/s1tEOIQ5lpT5u7g7fuge4g3fwwTM4W83
         aoCCPUpUjR+NkocmFEaQeaS99fXP+CHLj0F12elP8VmU3mWD9qyYmF3gatwLeEEcR+
         nbNWSfUs8ZmI7ys+zYw4leTssj6zzZY0sp6l4ELI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M2f5Z-1kBOUg31wN-004EdX; Thu, 27
 Aug 2020 04:19:38 +0200
Subject: Re: Log corruption/failure to mount during powerfail+deletes
To:     "Ellis H. Wilson III" <ellisw@panasas.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>
References: <33a0b9bc-8cd7-803a-2322-54014703d263@panasas.com>
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
Message-ID: <7715d58d-4a89-8c0b-c6ac-b7f6c52f6335@gmx.com>
Date:   Thu, 27 Aug 2020 10:19:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <33a0b9bc-8cd7-803a-2322-54014703d263@panasas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H55KFAbtAc75zJCnj14NtmNkstxokUXNJ"
X-Provags-ID: V03:K1:OtuVaZA5m1jyB5RDo5hiUhOaqLiqgaaGymh/gbsJxMQeUWQaguK
 FbSK5OGy71tZ56YUda48vuipfakJoxjfShlCLDQBkBGqODE5XYab15B+YPiW+1Aj3rhbra7
 EtGuUWmrsIsZPV5MkLg6iDaMIuuVTl+xnbs2Bk1Lv1Hd0PYM/a9oIsKXIqbPWqmjZn3RVOx
 rO+oAi52QF7OFjW1rvUHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:um8ulQGHJVY=:I86j2MA/2A4Fl65i/jehcT
 6lQSBDMeEK3u701b5yKDb/2lVvP7nfQeca6sHWS6dvsc01mXR/QCtLJUpBGWMMeucUoQPnQuR
 tDAqCfPnOu/yymVxeo/fQYBGB9IWoYT7vxYJXtyc2o1APMAZiGFikpq5/MGv3H3LhzwYxplAw
 1u6nD8Agq+NsVebOeqtdhZWfMyW8aWQkW5V1i3kf5k/+IYntCQL+xw/GuS8+qJkxzeM+1BUVP
 6fZnRXYJtTwS9eVsDVAQFRZV6Smtw+yerw+C1lymO+HCvZnMYCD9WtL6Key+zImY9xvdDSu7x
 j1VhcgCPKP6CZxDk27YqtXWUL+9qku7qCMySsNu7YWPHICSTX4G47YOhC/p7Tz4FwLkB3rN1H
 k5aG65xlE7oqq0yLLV26zwIpz2Bmf6m43CSIr5hPoJQI4mkNjdbRGfbx5mls/Ou5RHBJRdoVh
 aF7FU5vSaMDi/E8hAv4odpQizU8WVFzbCIMMU6rdgi3d1m3PGfk0437Rjm4OjjXbyHqdsFisA
 gS2S/CIbdxLOKHF5JgVwnHn/G5vamcohIRZck6Zx+kaUqTDnQJ/CKZOIQuJ8atQKeMqU/LLee
 iBrIKJNaa37HcwWkVXHR2xd3LP60AKpMzrri1baIOGc5457LkMZ5fHRXtnaUecUi8hdf009h1
 aQ8qV2CX5VSWtWd1/KZ5Zd3StDpPSRKPRfpuxNyLN83O5NKE6QPT4ySLPbyrbINMe5SAvyXfw
 mG6KJ9R+W7fjfWk3ugiDXoldqfVwB3JhO7FmI0/vbrZ5W60Dn0V/Axh77i3z8BbEkwwqNP+AZ
 2whGjaoQKVNJxgwwulc1uoFIq6Dj+3hSEwPW0xQY2XMVkUUhSCjCYw/e5G3iH3doqKW2u9OXm
 88aigSPXswfrtLpxDsjGq4tbrltLSMWtcDndIug5rGWaFKyWOYij7ZS9wU2GxiT+1FTKJZQ0b
 ojunqNcXFnZqMBtWgDp2NZPWWO4jTOTXIgsjUYi64VYK9SxavJP+4bPO9wT/REytj10gTxwUO
 6Uu9seMLPamXNcRKBeEjevo33CFmKVWjTlHnVa4NQO2nYJVNLw7XyQIDittUDrL7ZOP11jJK8
 VnweL95ygUlxAYbGAu0vZA8bMso0kHwLATRz6liBhpom2w1ick7DK+EPPuqzY5PmaD5w17hGh
 cyg+x5HhmxUCnUl/WSo67oXJ86q1H0NGoQSEHrJVpVSO8QBymHm0RbiwwtthvVbwdF6E/N6rF
 A9tF0BvQTyWnncDFCJFHRwaXo2v7SIkR9BljJyQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H55KFAbtAc75zJCnj14NtmNkstxokUXNJ
Content-Type: multipart/mixed; boundary="xWetwDMiCke9Cr4JEa8Wm87BYRfR7zaKv"

--xWetwDMiCke9Cr4JEa8Wm87BYRfR7zaKv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/8/27 =E4=B8=8A=E5=8D=889:49, Ellis H. Wilson III wrote:
> Hi all,
>=20
> We're experiencing some issues with power-fail testing of BTRFS as
> provided via openSuSE 15.1.=C2=A0 In short, under heavy delete workload=
s and
> injected warm-resets (via ipmitool power reset from remote hosts) we ru=
n
> into a subsequently unmountable filesystem.
>=20
> Logs messages in journald are consistent and show up like this:
>=20
> Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS info (device sdg2): using
> free space tree
> Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS info (device sdg2): has
> skinny extents
> Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS info (device sdg2):
> detected SSD devices, enabling SSD mode
> Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS error (device sdg2): paren=
t
> transid verify failed on 15216132096 wanted 273 found 271
> Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS warning (device sdg2):
> failed to read log tree

Log tree can be skipped/zeroed out to continue mount as usual.
You just lost a very small amount of data in log tree.

If it's not the controller doing something wrong, I guess Filipe would
be interested in investigating the root cause.

My wild guess is commit 4203e9689470 ("btrfs: fix incorrect updating of
log root tree") didn't get backported?

Thanks,
Qu
> Aug 27 01:33:34 4d017e3d41ea37 kernel: BTRFS error (device sdg2):
> open_ctree failed
>=20
> The SuSE-patched kernel for 15.1 is: 4.12.14-lp151.28.59-default
>=20
> The only non-standard option we're using is space_cache=3Dv2.=C2=A0 We =
cannot
> reproduce this behavior on openSuSe 15.0 (4.12.14-lp150.11-default)
> under the same conditions and testing.=C2=A0 btrfs rescue zero-logs doe=
s get
> the filesystem mountable again, but tosses a non-trivial amount of
> recently-written data in the process.
>=20
> I am hopeful this is a known issue and has been fixed in a patch not
> absorbed via the patches applied to 4.12.14 by openSuSE devs, but it's
> been hard trawling through changelists to determine that myself.
>=20
> If anybody recognizes this issue or has suggestions on if or when such =
a
> fix would have come in, I'm all ears.
>=20
> Thanks,
>=20
> ellis


--xWetwDMiCke9Cr4JEa8Wm87BYRfR7zaKv--

--H55KFAbtAc75zJCnj14NtmNkstxokUXNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl9HGDUACgkQwj2R86El
/qixeAgAk4nUETa3az1khUzbVVGRBHB7li8vQ4QNcaBkiyuetwebYCr5BfjaEGkB
sd2v83o6P8pynfNVqlNSeY6yHLD9LoHwyZExiYTuxvQmIgHSj92anES8EwontWvv
2mw7CdAoltnDOu/LYO8HxENXfRtLfXgVrXashSAicZkZSly8cjxxN3/5J+BpjZVB
4a85A72CzUiqsBPw8a3BvFquCjeoSv1jrxKD97kf/NCt/PRR6K9Nno1VXUx2r0w3
oelUFx3tA9rSwXTFUMrw80rzpvYJIbzICgoFIIs3tFmgjqa85nPZMcGhZMHxIrgU
r5YSp6zabz1eHrbQLIt7lHtZHNeteg==
=KkUQ
-----END PGP SIGNATURE-----

--H55KFAbtAc75zJCnj14NtmNkstxokUXNJ--
