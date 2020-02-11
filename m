Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474FE158967
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBKFVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 00:21:22 -0500
Received: from mout.gmx.net ([212.227.17.20]:54787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbgBKFVW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 00:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581398476;
        bh=RbRJDrpuvuaor3espzcmJgLupTlNBWSOQdMLVv5SxlU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=d3g45o4leiiMXLCVddnydSNfJ+ZupxL/dkLX9dQyl967QvS5GadoVE9LKix7olDBZ
         y8rmtCIua2c2aL2vMp8/L+sPzYycfo2CJkzdPRG7BUCehlLXHMgYhfSBtm6UiB2Dxh
         cXwAFDi0x/TSaZadHUNwTn+a8HijvrjSVgu5S2kQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wpt-1jUQ8A0Sd7-012Joa; Tue, 11
 Feb 2020 06:21:15 +0100
Subject: Re: [PATCH 0/4] btrfs: Make balance cancelling response faster
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191203064254.22683-1-wqu@suse.com>
 <20191204163954.GG2734@twin.jikos.cz>
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
Message-ID: <fb81b112-3be5-f86a-3da8-621c1dae6bc1@gmx.com>
Date:   Tue, 11 Feb 2020 13:21:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20191204163954.GG2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pz7eyoph3HfmHrZEzHWjFQBIRf9cEgNME"
X-Provags-ID: V03:K1:xp/TnhvlbLH7f7uO9CaRxLSrm1LDdn1HEK0AE/Wg63JLvPZbZhQ
 c7q50C1xlcCD1yUyosdJGzTgyKKeRVi9BU0GTmYep1x2YH/GcrwAUu648q6Km8JlD5IeG5E
 H0vvOiBq8pIeaLkkETQSzCgE7i/3lFXjlmF/BL/t1V+mkTW+1NJuUH3Y3ClLlIcS6SpKdJ7
 jYEXT1oX3bHgftMvQihLQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XX2skHgsgkc=:auK5FcBoNZ/t1Ctlxw/Hw3
 A0tRcmSVTXMoyHpEFYXWkIzNBzY+rN7tWdGW1j0s95e7DntWViCA4qy+MwO0gRqoqin8LuAuT
 s6p2deITbl6UO80DOSN2orM2JFEpKIyZis2L1yzLRE6NQf6J33B4IVMI+0njJz4CXag+0Z1ch
 AsW5iZRwRsG0/QETwbid1X5FQL11jvpz5n9MKsUeQtA16d93MqEFItwgvk9qqLvjZX8sd3ljN
 b3FsM3uMlMMVmyjCnL2srwBk3m3XXr4UiuisvlxQsaJgynETd0fm1Xrh7HKTeiFAL/IkWiMiW
 VuGtsVl5kN2d8RB3LKSKN4tW0NRCS43mfldv4wNWU4JIz1+UvQgJknctTQeutjN1MRA6t4mb2
 no8POnZzhrnpLlWWm2AF4lF7PnVtpJmyEvURO6NYSnW+sSEUtYI8LkzxPaSVOXB9DjQrb6v42
 bfKdnVKr7P6QZkXasx6NxS37XhsuuvLNV7v3ZpJIBSxepLcGoM2TQrQL10EWjm/7YjpWVHfFq
 hudodZ8seSv2Qn4iB1+/H1NpsQM7bKH/W8Wjjejs+KAa4GZcDWmq5l8Qcy574DOzEq3Fh+A3h
 287npG1eF5bepgvbUwn5SHNY2nufmE7xo0OODNJVH2RK3IVlsXYJ8nJ6esMCfIcWT2sFyxCH9
 /ncJhxFTtuyomiZVIpS725/5GnCmOAsmjwB8j/nVWm14AbwlhOqYi7JFxsDU4V4BKoWjkedVc
 Js6cXzco4QFfMorbWYpuVtpsjxjENPPXBXIgULhq7bRF5zO+wCT4hN9tC8gLUy+fDIiVKVXFZ
 QFen9r2NtFr+h52Xdd6/HGanZ4ureRnXTEEBYLZThlNcLqpg6+E6860hH5jtFy0XZx0x3kqZl
 ALu4hgceTlJSDKHWVtD+4+ajpwiLH1s0VtBUQL3Jx53ycHzCnxcnkTCl5lc5JRq4JhYolEQCy
 TL0f7E2ognLr2+DYN3sIMqmY+1p1IOVrRc9egKyFllJkk9lCG5Rfp8vVP9j2XU+sgUewcXvci
 5r3JkzCtKfLT/Ih8Pv++yPARJxnYltHn2xOWzqUegR1I6TxbXA+gDfMhTjrB/jmI1GYI+28AW
 XsYQlXYrZ9MVqhBTW4vJXGgkzLD0UcznypeDOlM+DVshrizWKHCA1izJPH9xHOs9yKj+IQ93f
 AzgXEOZEvPV8+rTYLWC2W1QxCSFoPtXtFbH1W/skxpWpJ5aimJakXZLu1QHwws82Q3d9PY8JG
 zmogBIBXd2BR1/NsZ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pz7eyoph3HfmHrZEzHWjFQBIRf9cEgNME
Content-Type: multipart/mixed; boundary="vb2un7HDUdPft7WRiTyulbUNsDI4H6BAP"

--vb2un7HDUdPft7WRiTyulbUNsDI4H6BAP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/5 =E4=B8=8A=E5=8D=8812:39, David Sterba wrote:
> On Tue, Dec 03, 2019 at 02:42:50PM +0800, Qu Wenruo wrote:
>> [PROBLEM]
>> There are quite some users reporting that 'btrfs balance cancel' slow =
to
>> cancel current running balance, or even doesn't work for certain dead
>> balance loop.
>>
>> With the following script showing how long it takes to fully stop a
>> balance:
>>   #!/bin/bash
>>   dev=3D/dev/test/test
>>   mnt=3D/mnt/btrfs
>>
>>   umount $mnt &> /dev/null
>>   umount $dev &> /dev/null
>>
>>   mkfs.btrfs -f $dev
>>   mount $dev -o nospace_cache $mnt
>>
>>   dd if=3D/dev/zero bs=3D1M of=3D$mnt/large &
>>   dd_pid=3D$!
>>
>>   sleep 3
>>   kill -KILL $dd_pid
>>   sync
>>
>>   btrfs balance start --bg --full $mnt &
>>   sleep 1
>>
>>   echo "cancel request" >> /dev/kmsg
>>   time btrfs balance cancel $mnt
>>   umount $mnt
>>
>> It takes around 7~10s to cancel the running balance in my test
>> environment.
>>
>> [CAUSE]
>> Btrfs uses btrfs_fs_info::balance_cancel_req to record how many cancel=

>> request are queued.
>> However that cancelling request is only checked after relocating a blo=
ck
>> group.
>=20
> Yes that's the reason why it takes so long to cancel. Adding more
> cancellation points is fine, but I don't know what exactly happens when=

> the block group relocation is not finished. There's code to merge the
> reloc inode and commit that, but that's only a high-level view of the
> thing.

When cancelled, we still merge the reloc roots with its source (if
possible, as we still do the check for last_snapshot generation).

That means, if balance is canceled halfway, we still merge what is
relocated. Then do the regular cleanup (cleanup the reloc tree).

I see no problem doing faster canceling here.

Or do you have any extra concern?

Thanks,
Qu


--vb2un7HDUdPft7WRiTyulbUNsDI4H6BAP--

--pz7eyoph3HfmHrZEzHWjFQBIRf9cEgNME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5COcUACgkQwj2R86El
/qi5+ggAlvRQynsQRtEKy7W8Dddn3/ZSvEeehUXE2y0QWDRnA2BSjv5abYQiJdAh
B4AVCcOsRgGuubGS5ZzRZrp1c8gqmm3bmKiLMkn7PP0fHSCAywV9F4hOOHVd328C
mlF7KLlgD/HjSD+s94bEbKwlCpe8UjeD15xaKschtjaaL15OWKI3sn97kFJVwE3r
DlM/Se466Q6guuUu1JSx/+LNcpyOVJQ0aGmS6yInC5ZVM3oOjUATL2u2jeZLMrQX
jbG+wyKc4AOYqc39TU3teRHUkYPPjCyBzKe7u2EvUAo3+VCGXsDUvyTjfMzVK1YV
F4zvOGA2CNoh7QrzAk57D9e3aaMhAA==
=FEWr
-----END PGP SIGNATURE-----

--pz7eyoph3HfmHrZEzHWjFQBIRf9cEgNME--
