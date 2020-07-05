Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3330A214BA6
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jul 2020 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGEJxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jul 2020 05:53:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:40773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgGEJxn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Jul 2020 05:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593942820;
        bh=LBZtKnPRNHOTzC40ZXShi/o3rYtckPoFuIFIaO2mjRc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YdYr19MPMmybqu2eIwoTuCPSXtBGUHKI6+OL/emmly4AZemD42PwN5A1yxofshMzN
         Qu8PbqNfASdvJADz9UeNAtNodCRnLeJUkqQ0h7JNge8USgERTPJIugoTRjzWUk6lMO
         GV/SdM5B77le32OztSBR5JDKGqQFO8W7T+ZZ/hao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCsQ4-1k0mlX4C4O-008qxB; Sun, 05
 Jul 2020 11:53:40 +0200
Subject: Re: Growing number of "invalid tree nritems" errors
To:     Thilo-Alexander Ginkel <thilo@ginkel.com>,
        linux-btrfs@vger.kernel.org
References: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
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
Message-ID: <90c7edc7-9b1d-294f-5996-9353698cedbe@gmx.com>
Date:   Sun, 5 Jul 2020 17:53:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANvSZQ_5p4JD4v79gFkSRBBvehCDh_Q5bBKeyNi912tr0biNLg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cackIPKGIG13aFW6RNqCzgXHS2kEYyBYD"
X-Provags-ID: V03:K1:jaWIZllIk0B5ZP7R/yNHatZuRlrXWk2fhk9DTZdCJxYqfjKfBc+
 K9Z/tLO1OYXnkGMhZJwS+12jlg5HOOCmphRkYhyfKF/FCrbsUHk+FDom2DrBEvjshLBWXSQ
 yVQXFlq70suthRTjEhRwxF/4OT6yRrj+FtKqb9nR0KWgmE8FYyNZcDLdY+zSBXJjdNJSfxi
 sqIfnoDYi35g4bHUbzidQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Rtc0sO4k2E=:Iao5DT0c1TPm4TydeMQv8e
 DNZhiYxqJvJWsOn5zbDYn/AiNM+yFDOmtnwOqYsxY745CH6XEbmp/bh34vACM9zhilqZNnZJ9
 DcNIfxWWr/WIz/Q2+sIB+utRGH7NLbFci2tGb551pRKx5X5EfQEFyZFJIfo4W+zqiz0k/FZVw
 C6Un3jY3oBq1UQeFy94QtGKmZBeSSEepT96g4rI57d6DYkF8B7S1NF4g/IG3q+b4f/og4pe/9
 a6m/xMeYfRb7YfxsAr2t+ukwfMfZvDRlLKfE7rwttBOe3WGOL5kfA18aii99/vywYG6GH/eZN
 elLhBT2zsJrYOZ2J3P678gUGc6SqgujwhRuB4+kqCqlZD0fk6MSLuyn9+rDYSH8e179EUD6Zo
 TPn61dsi89cNcrjQDQJk9hV7eJZSI9r7wp2ztwXWypGA/a39u9T7d32VF2F4oHgjOPWlA8Tsh
 6OkPUvyf2aZpaLUhvliDHPeOmkhGCSAW5/TinpPmN5rBPkaMOT+6Z7sIBBIZxNhJFeEWwcfPx
 3uhYKN6FycsGSyynk9JszD2dTfgErUKJxvy07kWG/s20cNVza2bm4ZPe9B2ZCDclXbcU5iiDI
 HKwINPufC0H4oJ9GHspZQ6P+uhy0waSR+J8OMwqlENwnxEAjvclYJoNMTPIv9oJhfouWk7yVK
 XHB6/t4pL4BsU70uE2r4SRyNcb2wqepYWrF9kFp265+wCzdZsjDHjzLTjeortiXNbF5Y/A3A1
 G6W64O1o1iA0JP41WwlllMiYHIpGEAksMcJuIuZnKo/EgZKFdBcZwyCPs0LsmROGsc5af19/x
 1U/2hk9Mk1z27pTV02omIhmD5APA3rh5zlSInv/jU2PUA/BkRnTf/L7LRJI0JbGh04nNgzpRJ
 1hM/8rfiZShcpo2TDztsGlgsV3/ahBePkH+cM57iJ3RpzFo9kdA6jndwjhsS+Fm17k1FTCcY+
 04t5sa2ESJfA3gzP4h1f/wXm1evMQ/cXRHPdSSk7NOrL2ndbRYL4xqZRHExPaqZtschYOqweZ
 06h4DASjo4HUYu6lzDP/cR9Cs61uHbTc3IkWNcKaQDD6kjOl83gSz8H76kAOZtjpHZsGqjZM0
 AYDjzRNl8yOnJkGPF0KML4j6xV548qxFHU5LD/qUyA2Hf2+8UwnzFXuVGDES6vE+SgYL4wkQR
 MARF6B6+WYZyRoW6OkOIrgv7PP8FJ7wQvdewpcfhVryw4Kb1gm7Np1OjWawOLEluU1dVY21u5
 3XP1OMflqT/RPS4q2GgXxqFjDM+31TMMKiuQOJA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cackIPKGIG13aFW6RNqCzgXHS2kEYyBYD
Content-Type: multipart/mixed; boundary="CeHvyzNJ5ZYSUFh2udeemQ5ZDE83b9RQk"

--CeHvyzNJ5ZYSUFh2udeemQ5ZDE83b9RQk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/7/5 =E4=B8=8B=E5=8D=884:37, Thilo-Alexander Ginkel wrote:
> Hello everyone,
>=20
> one of our servers just started producing loads of "BTRFS error
> (device dm-0): invalid tree nritems" errors and eventually caught a
> hung task (not sure if those are related):
>=20
> [...]
> [126990.493897] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D201179545600 nritems=3D0 expect >0

This means we got a child tree block whose nritems is 0.

This is not valid for child tree block at all, thus btrfs is warning
about it.

Unfortunately, we didn't output more info about it to further pindown
the problem.

The only good news is, at this stage, nothing wrong has reached disk,
thus the fs should be fine, just as your later btrfs check run shows.


> [127041.504620] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D204159336448 nritems=3D0 expect >0
> [127106.733494] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D233554296832 nritems=3D0 expect >0
> [127125.504302] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D233693298688 nritems=3D0 expect >0
> [127254.512800] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D299654774784 nritems=3D0 expect >0
> [127544.739078] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D435922501632 nritems=3D0 expect >0
> [127544.739190] BTRFS error (device dm-0): invalid tree nritems,
> bytenr=3D435922714624 nritems=3D0 expect >0
> [...]
> [129532.769484] INFO: task kcompactd0:64 blocked for more than 120 seco=
nds.
> [129532.769569]       Tainted: G            E    4.15.0-109-generic #11=
0-Ubuntu
> [129532.769651] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [129532.769749] kcompactd0      D    0    64      2 0x80000000
> [129532.769751] Call Trace:
> [129532.769756]  __schedule+0x24e/0x880
> [129532.769758]  schedule+0x2c/0x80
> [129532.769759]  io_schedule+0x16/0x40
> [129532.769761]  __lock_page+0xff/0x140
> [129532.769763]  ? page_cache_tree_insert+0xe0/0xe0
> [129532.769765]  migrate_pages+0x91f/0xb80
> [129532.769766]  ? __ClearPageMovable+0x10/0x10
> [129532.769768]  ? isolate_freepages_block+0x3b0/0x3b0
> [129532.769769]  compact_zone+0x681/0x950
> [129532.769770]  kcompactd_do_work+0xfe/0x2a0
> [129532.769772]  ? __switch_to_asm+0x35/0x70
> [129532.769773]  ? __switch_to_asm+0x41/0x70
> [129532.769774]  kcompactd+0x86/0x1c0
> [129532.769775]  ? kcompactd+0x86/0x1c0
> [129532.769778]  ? wait_woken+0x80/0x80
> [129532.769780]  kthread+0x121/0x140
> [129532.769781]  ? kcompactd_do_work+0x2a0/0x2a0
> [129532.769782]  ? kthread_create_worker_on_cpu+0x70/0x70
> [129532.769783]  ret_from_fork+0x35/0x40
>=20
> I took the server offline and ran `btrfs check`, which did not bring
> up any errors:
>=20
> # btrfs check -p --check-data-csum /dev/mapper/luks
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/luks
> UUID: b5872f47-c87e-47ac-b036-4f2725cf6dc6
> [1/7] checking root items                      (0:00:20 elapsed,
> 12381226 items checked)
> [2/7] checking extents                         (0:05:38 elapsed,
> 5163753 items checked)
> [3/7] checking free space cache                (0:00:12 elapsed, 376
> items checked)
> [4/7] checking fs roots                        (0:41:33 elapsed,
> 5021296 items checked)
> [5/7] checking csums against data              (0:05:35 elapsed,
> 3911047 items checked)
> [6/7] checking root refs                       (0:00:00 elapsed, 28110
> items checked)
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 292229652480 bytes used, no error found
> total csum bytes: 200196548
> total tree bytes: 84142292992
> total fs tree bytes: 82578096128
> total extent tree bytes: 1175896064
> btree space waste bytes: 24570610642
> file data blocks allocated: 245858725888
>  referenced 202896068608
>=20
> I will be running memtester to make sure the problems are not RAM-relat=
ed.

That would be helpful to rule out RAM related problem.

>=20
> Any ideas?

How producible is this?

If it still shows the same symptom after verifying the RAM, would you
please apply this small debug diff on your kernel?

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c27022f13150..92dd9a3e5644 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -406,8 +406,9 @@ int btrfs_verify_level_key(struct extent_buffer *eb,
int level,
        /* We have @first_key, so this @eb must have at least one item */=

        if (btrfs_header_nritems(eb) =3D=3D 0) {
                btrfs_err(fs_info,
-               "invalid tree nritems, bytenr=3D%llu nritems=3D0 expect >=
0",
-                         eb->start);
+               "invalid tree nritems, bytenr=3D%llu owner=3D%lld nritems=
=3D0
expect >0",
+                         eb->start, btrfs_header_owner(eb));
+               WARN_ON_ONCE(1);
                WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
                return -EUCLEAN;
        }



It would:
- Provide which tree owns the offending tree block
  If it's some essential tree, then it should never be empty, and this
  is really something wrong other than false alerts.

- The call trace of the first encounter
  This may provide some info on how it's happening.

Thanks,
Qu

>=20
> Thanks,
> Thilo
>=20


--CeHvyzNJ5ZYSUFh2udeemQ5ZDE83b9RQk--

--cackIPKGIG13aFW6RNqCzgXHS2kEYyBYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl8BoyAACgkQwj2R86El
/qjgbgf+P5A7Xg/Vlx9ebZ3J9MrqPPam35x4Du75fajL8YH77CkLziG+N29hmdoC
BZ3MdO/zQrIlzyCgt3YdKWDcdboOzRqgs8HifecQhSJrA3lHwyu8WBdvrR5SwUEy
2xAqRYpvTjsXpNzyT1cdrPMhrBJfwUBvj3SDdmwO9G1JzDI0+2VaS3e5djkY3OHs
7gUaO0MMPHwqY4onJ5y+wjnBTS4d4sbCpPCgjNgz9yk6iI8a+KPfs3BWplfnLcCD
Ko/btJPrf1D4h//9VAlb9r5jJVpfn/HZsyBhCkV9w9Vr8W7QDjozddleF1xV+bJr
5az7dITIRZuTUxDML/qnhuQ+0H65OA==
=yHM3
-----END PGP SIGNATURE-----

--cackIPKGIG13aFW6RNqCzgXHS2kEYyBYD--
