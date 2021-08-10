Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DE53E8608
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbhHJWYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 18:24:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:49347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhHJWYp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 18:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628634259;
        bh=Eu4CMGvhXV0TU78vUeDJKA7P3O4ZlD1rA4nE9r00Rwg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bz/r/H35CQyTF1UO0BYF85FkCuBZR9BvoNcD60xj+TwkbH5EvxiAoOITfOQ9EzjZF
         bHEW7+x9BAJYQh4lkUYX+vyKvzkSb40iwfELGKjhVF63JNchbcr6HvYMtgXhOGM7qf
         JslHwQxNfab89BcWxJYCgwYbqGv9A3P7g1PyB6m8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQgC-1mzku22pns-00vMy4; Wed, 11
 Aug 2021 00:24:19 +0200
Subject: Re: Trying to recover data from SSD
To:     Konstantin Svist <fry.kun@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <67691486-9dd9-6837-d485-30279d3d3413@gmail.com>
 <46f3b990-ec2d-6508-249e-8954bf356e89@gmx.com>
 <CADQtc0=GDa-v_byewDmUHqr-TrX_S734ezwhLYL9OSkX-jcNOw@mail.gmail.com>
 <04ce5d53-3028-16a3-cc1d-ee4e048acdba@gmx.com>
 <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1c066a71-bc66-3b12-c566-bac46d740960@gmx.com>
Date:   Wed, 11 Aug 2021 06:24:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7f42b532-07b4-5833-653f-bef148be5d9a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RWFbkLeSt4i1NUvg6xVZ5C8P8YuaHySC3AU+QBsNyPyDsJ54ujb
 w48Gy1F/pxoIOK90CaWwk1udoM77Xwnmb4XsYmxGr1mMIRMXUGjizychKFbO8hyjZpRFLai
 nmLO/SuMAUGHqegHDHG7tE/7+6tFE2sQr//Pp0IRSGwDpCwPNyVAFnVwC+sXj05gHH5ZZ3d
 IwUDwUysYnM+M3+va+zfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bTMBJOYxJ/c=:JuWyt37RFNLe2BPVpoHyn8
 //Jv3seXmwj0X/0jb9iIszN9oHBaVUDVOmbBMawSdQI8+oPX1/elvTVaX8GaQxkcX7kHBN16o
 m+UsB0TJ2sfOkDZRSzndpy4OqAInYP2ZoDYjEXH60GIKgUZdLiv8gNbSFIjsZaWwhUXNq20AG
 HKjM8U+VrKCgoW2utjVffHNBCbM/jlCmKFXuaSaIGZzNhIKSgD6eI9lRv2skQp0MBgleZivdN
 gllvl/mTujXVtzFmwlhEl5w2hz1+TrVQJO5H9gFjh0eJGEakhNhTOj9shJOC3lm4Iul7xzRrz
 0fBBn3tVnOPbTBqPXVikSV9ow/VBVJmabnmAk6Re0pzf18MbtfVaLaYdIaRIV+tMQAxRvviZw
 WopwS/uT3DFDW2+0Q6VHnslJCQt9a3qzHx4UZOidlJTOEGPi1ArbTqXTJBAnhPeqBpczp3UQm
 aUvzPjUFUTrXVLoAiujh+b9LVeoPDQHdzZ/pPBxe+V9Fp72v4jssMpyT4cJXW5EOdKeewRi8x
 QZR1BBOvMaVVajy8p/i1O67/f1cwt4yuwGdwoKidRnM4cwOq5pqaZ7KSF38l4p4/7NCHj23y7
 Zlv1oy2sA5mfF9IUDwllCy5axBTOFpdKcXau4EUxO9lXq4NcbsPq1h9x3odtl4cDsATi0U4pT
 tMOHs6tTi8InKP1E/K9u+mG1LOjLI+xgjjNfXS6v5tTlSF2JGvrNZzyOlEi82sep1SX/eUhTD
 xjrosztcGPnzE9UkfGpErMHlWUCnh8vJjW5ZZLNKgNrv2b5Ye48qsCetiK+ghONGuWTsqeKwS
 adB8shJIHd1MZ4qons5rsJMamOsV6OowhBsIitP5NSOIve22HzSWN9nPI37I1TiywI3iz2lfQ
 oD6Q3I76IgUzd3jHukhQaIy8tPOl05L/ZPVHjINWGIp3vlAuzKZ/d49fK30Yn1Ag1t7OhuWQV
 Yjpw320aCB6Af7TsJGObqT0cao4DGIg7aMfM5T9R1UR8yc4aftDjUComniS5FABRjpCvdjHo6
 K1dr22cb43xo/jnHCigf9w4c1q9FEGoWXWDjapeuU8/61RfTxyScm/E1mCbmvDYr7fmBzbtG9
 l0mJcaY7ZPlLXm06e6b8mAj443YWwdEPFJy9YowErIXTFHW+hYfnkjN/Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/11 =E4=B8=8A=E5=8D=8812:12, Konstantin Svist wrote:
>
>>> I don't know how to do that (corrupt the extent tree)
>>
>> There is the more detailed version:
>> https://lore.kernel.org/linux-btrfs/744795fa-e45a-110a-103e-13caf597299=
a@gmx.com/
>
>
> So, here's what I get:
>
>
> # btrfs ins dump-tree -t root /dev/sdb3 |grep -A5 'item 0 key (EXTENT_TR=
EE'
>
>  =C2=A0=C2=A0=C2=A0 item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 i=
temsize 439
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 generation 166932 root_dirid 0 by=
tenr 786939904 level 2 refs 1
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lastsnap 0 byte_limit 0 bytes_use=
d 50708480 flags 0x0(none)
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 uuid 00000000-0000-0000-0000-0000=
00000000
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 drop key (0 UNKNOWN.0 0) level 0
>  =C2=A0=C2=A0=C2=A0 item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 item=
size 439
>
>
> # btrfs-map-logical -l 786939904 /dev/sdb3
>
> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
> checksum verify failed on 952483840 wanted 0x00000000 found 0xb6bde3e4
> bad tree block 952483840, bytenr mismatch, want=3D952483840, have=3D0
> ERROR: failed to read block groups: Input/output error
> Open ctree failed
>
>
>
> Sooooo.. now what..?
>
With v5.11 or newer kernel, mount it with "-o rescue=3Dall,ro".

Thanks,
Qu
