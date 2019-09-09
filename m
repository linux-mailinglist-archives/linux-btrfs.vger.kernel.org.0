Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23D18ADB24
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfIIO0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 10:26:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:42859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfIIO0X (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568039178;
        bh=3H4PWy51+AtjP7G4yvCqAs/9wClZMyQ1ar0nU6lUfPA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=OzY4zYC4nmQ6Vq2boW+Abera1Y6KnCqkNm38tml68Sc+FC0+mm9oXVLLwNCo66Gnt
         tKfNHUmaSVjDQQtnu4dmD6mT13NZrXlf20zBhqZ0+7COJQvE9IjjHYFWVT5JGfWMot
         vKNW7jYrp7X9aJ6nOlNjxnie8MiBoN2wWi/THVGw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MbOoG-1hoZJc1JCO-00IkkK; Mon, 09
 Sep 2019 16:26:18 +0200
Subject: Re: [PATCH v2 2/6] btrfs-progs: check/common: Introduce a function to
 find imode using INODE_REF
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190905075800.1633-1-wqu@suse.com>
 <20190905075800.1633-3-wqu@suse.com>
 <1b8af49c-97b2-0119-002e-4736380fc6c2@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <d7dcd61e-2c9a-4f1f-3627-f1697433ae02@gmx.com>
Date:   Mon, 9 Sep 2019 22:26:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <1b8af49c-97b2-0119-002e-4736380fc6c2@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:44d3D0sm0WnnXcdDCZFmtu8WC7l3GvfJMrSjNXL4qugDfZKVZ0H
 RLU6aDhetpIsfS5xYxnqSTWPQeqRgZAkBoTmht7FynBXz7KB/uT1wJD5EmYy0DYy7LXBDKT
 prDkahBjZl0gcOguuIIkc6CZXMcAHy2bTSSItkOP8sIVh6RnQ1uaTKWvsosFc/JpHjCNVYJ
 v4oH/an9InC/Ub7+TcTOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yZLo/uW0pcY=:nONT1Bpy/r5ChS/y2wyxrL
 8jQwQd1gK7LXK/sJltgts/+CWzAC4E9NBtqkclhncvir0Sn2UJPJ1CCDgdfSZLEq/vcFLsHh+
 txD6dxdE3Jd1QoPGs4qZJ7f/sy3jeJk1dfwSnFaKhix8q6SU2m9copIF2Le+z/qjpFkiLxDp1
 Q9vLYhEuj2I9xRRRlsD++pqhwCwLbiLeX2Fj+F/nsant0daMVtdxw+R3NVz6c7AN/ftJ0NQQk
 3m0fqDNld3+TFydRMLphytVOfdkj2RSZFIJYoYlgQaPe0jINzGeBT61Kp98KXA+z2j1uoSM0v
 FV2Rj/rPKSWfQ7OHhF2WEv4HyuQ/MblYA4TKilMHB0A+lRnnCxsoyQUMGyY6GNH+hg0WQW83a
 F3sCLX0wuw7V1new9JKu1bwr0GXWV18Q+AHtfiM2YFY9N99Nsc5XzQqtkWJ8P9Sr0tI0JUyNB
 SSHGlDu04Oe6Nbqo7LzR426eHLn7KShX/GZGQmsm7D5Gx0ZW1e3mh9+QvrCK8ulKICvqctF6W
 SbnuS0GmdRCuAPKbsM+C0w94EjLvNWA/UIJFsGeqOPWybFTbxm+fi+Zm7Ln3QQii6/DMEYBgN
 6j1kn0n3wA4j8/+xadXgRJU9dVd4qM6NWZccflufJRQg3zyu98I8gdi7AUfTwyMl9fCP9e1s9
 kD+eNfhqVkuVLcFRMuXUCe656hjIqCrT98U56SGccgKbVQHFbi2i7Q2YVeHoHa3wdXXN81ZHb
 amql1ai7g+kRCqHkxo8oeippRnmJqEdqmtVOegbocZftUUDpBjuEIKZ1qSSw7hdLy+W/bILtv
 29wyaXBRq7Qrgh76yBy3VFZ1H5z+zmsv/poei5dfCSPwc9Eu6wTbJ/52JZ9hYxtV7h2aB2PX0
 WXRh13iaSRaXt6MgffknPCZOmJJM87YWHwfdOrErmiqaG8LPafi/h4plTe7tWlro8amuBmErZ
 fSOznZjd5srvFpm2TQmISM8/ONasP7pei/M3Ra9gB+9a5uR5RTztJIVPk94S+NZ1yQ1PkO+k7
 syEELVUV7SlThxlQpVKHmtKEhT/qUjhSBgv/CjbmCOkXEscs3B723+GzPs6KmIPoggrZ/QCEE
 fnfhrnTeCuj8lJmmBxB0qJQ3591E9L/IHNCZfkbKlyFiwR2P8KgheM6yNhtwiG5XHoOOf4TCP
 q636nJ0uQcSDJ7Zuuco7tpN11Iz5bgYaI2zhlb8LUIwrdvAvEkUTou05rDkWRPOXWKEi6QVUJ
 7h4ua+v7GhS5gf2Qz
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/9 =E4=B8=8B=E5=8D=889:42, Nikolay Borisov wrote:
>
>
> On 5.09.19 =D0=B3. 10:57 =D1=87., Qu Wenruo wrote:
>> Introduce a function, find_file_type(), to find filetype using
>> INODE_REF.
>
> This is confusing, there is not a single reference to INODE_REF in the
> code. I guess you must replace this with DIR_ITEM/DIR_INDEX ?

Don't forget how you get the @dirid @index,@name,@namelen from.

All these info are from INODE_REF item.

But I totally understand your concern, it's sometimes really easy to get
confused about 1) what we are searching for 2) what the search indexes
are from.

Thanks,
Qu

