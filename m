Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB5283298
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgJEIyZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 04:54:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:36361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgJEIyZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 04:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601888062;
        bh=X/AnM2wzb2FqwEURz+1HdDkIdR+eiLuCmmteOp8Orbs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=j9ucpodz1pOlF7keKCOYDsGa96BqN6M7Ap/xT3zQFyVOnKGy09BbaAlkg98VYhXrE
         BS0nTlkHpnwaYnC5KbVnPPA6BuTRkBUDmAwk1qrr/XNENZV8ESXAFFbFOUC4PuP2BF
         QVdxNfaofAslrBVcb9tohcovEXhhjjVAp5EsB6vE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvK4Z-1kh1dX0KUj-00rGOT; Mon, 05
 Oct 2020 10:54:22 +0200
Subject: Re: ERROR... please contact btrfs developers
To:     Eric Levy <ericlevy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA++hEgx2x=HjjUR=o2=PFHdQSFSqquNffePTVUqMNs19sj_wcQ@mail.gmail.com>
 <c2d13609-564d-1e3b-482a-0af65532b42b@gmx.com>
 <CA++hEgwsLH=9-PCpkR4X2MEqSwwK6ZMhpb+YEB=ze-kOJ8cwaQ@mail.gmail.com>
 <CA++hEgzbFsf6LgPb+XJbf-kkEYEy0cYAbaF=+m3pbEdSd+f62g@mail.gmail.com>
 <CA++hEgzRkz+qQQf_+YBX2r5bBiNvtexiguPG99jBzVM6JhtPzg@mail.gmail.com>
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
Message-ID: <eb1060b8-8316-0866-141d-70498222db9a@gmx.com>
Date:   Mon, 5 Oct 2020 16:54:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA++hEgzRkz+qQQf_+YBX2r5bBiNvtexiguPG99jBzVM6JhtPzg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ncw5kIrCyxRDcH9J7lVLWJ4IQ3p5dYFnw"
X-Provags-ID: V03:K1:kqhGimJugQyf8PcDtwDsyuTvi3gY8T91U+nkAaqznsUZr49BiT/
 0ecjHTSUdQvxe2ujFcb0ZMfsbv+bCEPvuhcaDuRBpeglTvZBKzJrGcI3dUWe1RCDcVkXXUN
 Vr3mh13gIdQO8e4kUgvCiim59ZkCdpD+pZxWaBehDZVVxciHOeHN0gS3aotfs2GOxIUROBX
 4uP2lJTDt3DvdjG+i7cjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3GTrbUAb5h0=:pQy4Bq9ZxNSqeY/5Aca8Nc
 FoNnqTLmzQcGJwepLoH60dQN98f9jIezg/kIhcAJ+opHnjnT0T4uXwLv6wTKjBtJukDhtK6Yo
 oaYZqK32gKKD3fSy9zly3WI4RzJtB2Um5uSBKsttCtTlbWGzh7G5aBwfktpy5g11kQegY4AO7
 0OX3ZzjeX7ZWxXyQR7i4YeYbvCE1fIgdv24RmOIMhoD5CNXYY8nFQ5tyP4qU6lofW1amhRa/X
 Ecnyp0r6wwa2ayx9+MMBFl/sF95roZJyhzTsfoLjuBqDetfFw+mmy0OynnbzTKr5WOVWphEKi
 JJNeKkkcI9Eq+5R8iUnQkFRg41XLQiHo6cWFKHDCNheiF3iDW69azdKlkS9Gd43yyWITWAss7
 rpVUrphjCOCRNSDucOo5a31WeKgjrIZ+czRbVYWJ1kFHdzXEC6m1O9rzJhvyvpbj8ogD+psT0
 SY4AR7ZFzNJs3vijM2w9Lw0fkBIoRPsqpH/Q2I6SwNy5i/Q2u6pUrZQUw8z2Yc8FzIAdAPaiR
 X4+a7x+6MAvMpGIp0PXXd502tyNq/DVVhwJ2+49vhnW/Q5jUATCKKwruSZq2o/DLNqcoM9lQg
 yjkkHpofjmu8BTWB4wBN8CZtThzyoH9ADSYczW6drfe11zjEh0P69hqfIZXWxUr/GPLM3xekJ
 6ud529KfShORzeKjlm5sQY/Z+tN/X2s9OHBUK9YD44IyXb/fO9mAod0PZXJykF4hSB2wmVwKF
 rpgb59wTV/lv2cXrB98FQltQ3ssUtX0b2vBujNZsH5KQ2P9CSKOKmuBOJGRWJJBaK18CFX87F
 QHF4q0DqajwDopQ/VDN0aq3TmgQSmxrTny88sedRqlIBbr1t0vGamfKaqecL62eMtOLr6rdpd
 4EwUlkH7TiQfJabQHU9moVlDfwQB3Fs5rNUCWGB2m50CNyaSvQqKLhFeY+CzzzL+y4RzMh5mB
 rrN2K24XydIilEAEgiwcJhhNoHzVgpXQj6WhpJNIkioOt2biVR+JXIkNch/A9AxyzONsbgeY1
 XIZUSpC5271m5w8fTwgGRBVPr9yyAb8X/cvzXPLN4Z56xNpHw7oAJsiVFR8cfsTT+0XkGbBZT
 AblGP3+cgquvibyZ0sVR1WsRV9C4m+Vkp/++sMYonQCpp2TiIn94LyrUAXjGOVa/g/lnbFoNm
 3F/mEzZ//7SK5lktkNupD8XBy+kCbmKPp4HCZ/NLW+ZDwVZR5dg7mHY9sz+W2n6jkp6+9xWVd
 Mse5lPnncjMHPVDkh6CdF+36Io5N3MHDx+WFkCg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ncw5kIrCyxRDcH9J7lVLWJ4IQ3p5dYFnw
Content-Type: multipart/mixed; boundary="D13mNfcZ8yGmf0CtcONq9MlHKf93MheCq"

--D13mNfcZ8yGmf0CtcONq9MlHKf93MheCq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/10/5 =E4=B8=8B=E5=8D=884:25, Eric Levy wrote:
> I freed considerable space by destroying the swap file and old
> snapshots. The usage is down to 86% of the total volume, as reported
> by df. Nevertheless, I get the same message, "No space left";
Yeah, it's really hard to free enough space to free one data block group.=


E.g. if one data block group sized 10G, has just 4K used by a file.
Then the whole 10G can't be freed for metadata usage.
Btrfs can still utilize the remaining (10G - 4K) space, but only for
data, not metadata.

Thus it's really really hard to free enough continous space to free a
full data block group.

BTW, btrfs fi usage output would definitely help in this case.

Thanks,
Qu

>=20
> [279314.876489] BTRFS info (device sda5): relocating block group
> 518463160320 flags metadata
> [279372.777369] BTRFS: error (device sda5) in
> btrfs_drop_snapshot:5428: errno=3D-28 No space left
>=20
>=20
> On Mon, Oct 5, 2020 at 3:58 AM Eric Levy <ericlevy@gmail.com> wrote:
>>
>> Well, I see the complaint about limited disk space. I suppose it is a
>> surprise to me that disk usage causes this problem, because the mount
>> was fully functional under kernel versions 5.3.x.
>>
>> Is the best solution simply to free disk space? If so, then the act
>> would have to fall in the time window during which the mount retains
>> RW state.


--D13mNfcZ8yGmf0CtcONq9MlHKf93MheCq--

--Ncw5kIrCyxRDcH9J7lVLWJ4IQ3p5dYFnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl963zsACgkQwj2R86El
/qjPEgf/VOLlWrpcI1sfs0LXdRQwSbjfMQ6QAze2TImuF4VdjG/tVtlaDwxLY79T
Mkp3Qn+F+FOXLSjUOAt9A9FwPD3rvHofgJXpcdHR6uIeVsh7fJ0sv80aci3UeAtw
uVC4oxihJ4mdMUHSh8m86VIf+g3oIoi2Ji7aElPKS974njkUwQsfecwy+cxnvzEp
+afpfm3rcKh+afoRgGkWFLRanp3BXxbWAfJZyPkHlUYbk+ueSpB1DVrbMtEGmiZW
G8y9Ocrtg0ZuvWc0moJjM5lYCNPUv+f5YcnPE8SJGUKEREyuuX4sEkaBeRGkpEnP
nQEkno+o0/mK/T+G8r0WPsLvuyxHhg==
=xa8Y
-----END PGP SIGNATURE-----

--Ncw5kIrCyxRDcH9J7lVLWJ4IQ3p5dYFnw--
