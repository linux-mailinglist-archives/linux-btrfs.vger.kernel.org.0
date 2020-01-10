Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815D813663F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 05:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgAJEf1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 23:35:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:45333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731105AbgAJEf1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 23:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578630916;
        bh=fcZ8crpLSjPvPLZKjiqFjou54D0bAnxse55bPsbQL78=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PNq5CrVu30fClAQEc3NvHxP0suFpwxzq4mvZfttByV6ehYBtYTfb3YKzPkrWQ8QSO
         4K3uckozSNx6DRr7d3sNKo7NlaHst/Z0HCw4r+6zLf4TsurFvNoQNcU+9825ue+1kA
         /SCJ0GVdozdWy2lJORu6WpQHpdMnds3gsICol/S0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Msq6C-1jiYWq0uj2-00tAv6; Fri, 10
 Jan 2020 05:35:16 +0100
Subject: Re: [PATCH 0/4][v2] clean up how we mark block groups read only
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
References: <20191126162556.150483-1-josef@toxicpanda.com>
 <20191203195139.GC2734@twin.jikos.cz>
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
Message-ID: <d4838402-3acd-1fea-6d61-7ff806629e1a@gmx.com>
Date:   Fri, 10 Jan 2020 12:35:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191203195139.GC2734@twin.jikos.cz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WCjrEB8EFYHKaB5hJfHLJSdZxstHCRtmk"
X-Provags-ID: V03:K1:t8i6rOEctFlQWfX92WNDN6kUK/wMZV/g8eiMq9CpQsAHXgT3TGS
 U0KpArRXukWhsYOLLoeJmCE/q7NcdPKKwz9GOwxT1WygLeo9IpbCJM8EnJ//PlzPLHDDErU
 aeTr5R3B1YyTQHxe0P3I03itI+jlgRoE93nZflW2VYR2hSlLCsN+oh5T7LB+4XDivh5JxMP
 rwK7XgWF7UasEEvVROirQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oPCKqawVIpk=:dkgx/9LjXlzQDoR93/NNkr
 tadpWv8HstQeZWIkGM1iCtId24sx+mlwbhq790GKzZpcmrBatZyJVljyT2fz73VpRDTeUAUY4
 CVUK+EylVkTZHSHra/dTLQ2JF9L4dClQki/xHLYFwLvVCP8iTe6udFegq+4XVj+mhoL16tXnU
 LVxs3c7+NnO17w3WcfNQQpDD0rGeDGV5bXFB/FSoQY98Zexzkk+jGPcVuJNp9CTFvir+CluUt
 x1aNkVV88OfaKtOHyT4A1SiYk4cxk12VFZFdVGfM4b7SU7qdZLiU2TcEuJroL4VSbPMzXsGn7
 BLnz8egbghx0M6MEWmHzz0DFpDu9OHF5KwwLZGvxARhBthb9klRyAEhpyqCP38Gv1YqUrrg5G
 +Z+jrg38EUG9V3gvF13PaAASQQhVNSawsOrt5z75fkXGxX+LiHvaTyqZNVIy8VhIr3n1Widjw
 /maRPITKcxjmYIcsZy6Nq5M1KYmN/XeAHzzZw5x0Txif3kiwPw5IEs9sFeDQVrgpRAjz5YPYu
 o+9wQuCPRsxWGtru8Jg9iJM4E6XwJm4oA4zEGy6z9JKETlVSj3C3NtePfPZRsp6D6gLSgtJjL
 41FrnnrWGoDb4cj8hMEJ1PCbYo2qPTJKklweWKrCLCv0mMjmmHy6XudBptOM+wHB8s1qyw5aZ
 iXVBhkUZ2NvuDt7ngm0xQDRIwaom9u2k7d3CgeTMyxUoYosoKpPlpzitpfeCCQ3DfeEwUgTGX
 EGTJjB9btccPTd2D2W8P9vY2CtKZu4yh86Q4GR2PWHw5l/HRY8Gd5yBo1VXaQc4iD9ppZuNtm
 mZT+1BUIt2O/RTqZVfzEFWatypdkhvef/yCKi7qmORszwpAGyS9p0thuoUHWsKQyZO316nVMt
 9wXExUP8ZbpuFDSQEYqkPGNHo6ccUGeHnryVz3FP2QdsULb/02VPr0R6D3/5HEk7wnHU1qHtB
 Hm/icQ89g/iA+Swux9JudlG5mGjTVXveT21n6vx472eUckmShPDj9PwICYIXWh80+YQM6JfLQ
 ZcKwxu92fOrrTQGElf4pQCmhT5TStE0owsbqe/QJr7D0oNHXp0Jb58utKKOqwxjcQnPWQnqPd
 dk2QqCR3rQeNIsmCppBaKsqJzTnJ3zL4aaFOrYZDoSTM96ydHPOZKACcG0/ylutxOu6DROGja
 x7rh7Zo3JKsXNgjJHuFpNC6rhn+NDiuU6nVGKCEvigLgyZnpPJkLf8y+eRpVcC0VVG6dlSCNu
 pFYcBSROkkHN4YejARCxGZRde8M5Ee3bgFNWDHefwxOQfWL/NcmOoswIYGQ8=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WCjrEB8EFYHKaB5hJfHLJSdZxstHCRtmk
Content-Type: multipart/mixed; boundary="oa5Y5vkJoLe0g4mimgehpPHY9zgyG7SzS"

--oa5Y5vkJoLe0g4mimgehpPHY9zgyG7SzS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/12/4 =E4=B8=8A=E5=8D=883:51, David Sterba wrote:
> On Tue, Nov 26, 2019 at 11:25:52AM -0500, Josef Bacik wrote:
>> v1->v2:
>> - Fixed the typo where I wasn't checking against total_bytes.
>> - Added the force check to the read only list addition check at the to=
p.
>> - Fixed the comment stating that sinfo_used + num_bytes should be <=3D=

>>   total_bytes, that's not the case at all.
>> - Added the various reviewed-by's.
>=20
> I'm applying 1 and 2 to misc-next, 3 and 4 once the comments are
> addressed.
>=20
Hi Josef,

Would you mind to update the patchset?

If you're busy I could keep your author and do the misc work of patch 3/4=
=2E

Thanks,
Qu


--oa5Y5vkJoLe0g4mimgehpPHY9zgyG7SzS--

--WCjrEB8EFYHKaB5hJfHLJSdZxstHCRtmk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4X/v0ACgkQwj2R86El
/qh+mAgAkCbxrprM/QVSgB1cPV64SQTrmOHmKF7vtc98T7zV81Z7ptED1GeMRT0N
AWNG3K0ZrmleyoMpIA4jvfRuq80di209a/OcAHtdo++CshA26jqfV9m1C07Qxt1q
DT9pNTbZIAPLLZnwFAgbTd28Ra/vD6jsByjhd5X+Ojy2EymgSPb2ZPjtMPgWGIiX
u+kSXVlnIgFsYs3QgkJr/RvcMYHr1l18bhID++4JKufeTvUgNKP5owHyu04UshPP
tJ7cOn3mSPj00pud891g5Rif9/zEKSTnkxmZSBqhnpab0FspLkqHN/KKem3MrZ2w
XGwSitUFYn9awBn+DWINGjeEXK0ZOw==
=TwNz
-----END PGP SIGNATURE-----

--WCjrEB8EFYHKaB5hJfHLJSdZxstHCRtmk--
