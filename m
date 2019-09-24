Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E337ABC49D
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 11:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfIXJP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 05:15:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:45613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbfIXJP6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 05:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569316552;
        bh=EGyaIJH0Q9SavyEItv0Hqxeaa3fVeHojFhemihO8oyM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=hWpH6Z3HH3x5u4uYWuhXQCRdz6nplxk4wkKcrTfCOWTyUoXoIZkD+AC3AEh8ULbD2
         iTfObKw75yH/lHqC1HP2gPhIlzoRwMwxrQDNWBCDTpHg9TkR1WV9N2qMBXW5DximwS
         3hGiyfQne9Haht3xMCWnB3Ifp9s909gpqqELAZ/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7iCg-1i8eLa07ec-014mmt; Tue, 24
 Sep 2019 11:15:52 +0200
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: Fix reserved data space leak if we
 have multiple reserve calls
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190916120239.12570-1-wqu@suse.com>
 <20190916120239.12570-2-wqu@suse.com>
 <dd942faa-e3b4-fc96-6678-3f4513c67731@suse.com>
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
Message-ID: <09c8a889-ead0-c447-2b1f-e2b6f29afdac@gmx.com>
Date:   Tue, 24 Sep 2019 17:15:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <dd942faa-e3b4-fc96-6678-3f4513c67731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nHPcDAo80Ps4eWp5n7A3Wd8XQRct4q/OJyfJa+g8ag1H4FAg3VV
 P8msdl1gExhhaDHf8ZL9WtCjAqB2LsHR02GnZp1ix/v2zo2AO57ZQXy+Fz9XthxVxXfHojI
 hhRoPd55MwbzTaSOei012zBgr3OLgCb9ehsr/mcw8FAYjJqzUb4u9LXSdxOaCX4R8VbPREJ
 L/kFs/AnQJ+pFWS3itaNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w4Y3EoswFvM=:z8rKeyxq984T7bvWalm28k
 glDWc0YA/2I7cxEVyPfYdPCHVxh3nZH6v7jkEWoDVqgIdo2iAPw/qPWwfYHPsNAy92ylH+D6J
 AAZIfFyKM679TLJLgjPnx7QXHimL3ypvN84FA7ocnar+5yq9T/7peOy/TFLbT9xA7fcGXHjkg
 gwzFyE6IDlR3WpB6rBi0CL8eCezreN8Jf2lHUrckDnd8KRg3z6SSshmtY7sPn8xhwlypzaWHt
 NXaMB2/Yi/Y4FlrwNZ3GcRywN3AhruScJShV/jFT3dIcM0ZBQr9UXkPIM51of3aAwYe7YUPQn
 cNID0+PJlJoujmxzvUxT4kYNWtjOO/FokUlOir4doUI3iUp+dQvRNilh6J+HVkb5yP45aJJSC
 F8hqQpAiCOUnMUJW8UWj7AD8yHoXf60P5YY89UIdhjQwbMh5xAdgaX7YeZZ09KNBXIVX7W8GM
 3TPsK0PGLL5z3RDoOeoVMuCwjoGjCOeJXAopKXWpv+QyaXLFGrkr3cmMptmfICICTV6ZX04Kb
 1aUPjir/QL/aIWxPKC7rYPYSkuGkUD8HVWRMmlIUuNYqT15QP3/9ODNqeQj3H9kZ2v1xe9aGL
 fuOEghY5Vmy7EeDuJpz+ro9iFxW12+mZWaMjZithoxfUScgPW5Dg4jRlWvlFPtZyJAUUpO9SX
 x0YiNZoz+FmQiPXVnRP8agpFOT6V4Tv+wEHzfVC9pWiEUmabMRzN75U0AdO3urOe7A32el94i
 kZ4UAZIfMVyJXYhi730MFJe2+Nn2ZyOBvlT9/rsUF381xX6b7xDPRESOR/PRcn7tomQj+OYyV
 rhrb54hYnIX0xR1c2HX05IMAotqKSwwfG7WeP+Sx1TD57Wo55ctvU0OzbdRO0obetvhIZ4Iy9
 rvG1FLGx/zMFkuikMyZdoir0X5l+arxbd14s8pZqGbfWhTto+/jYREHnONF7hHAfSa1Sbtaox
 p5g0tFkeGonkQqCBxvg1v8r4mocL7tyU7EIgE/MLUCtyoDpGpdNT2fiCP/yLKiUYIMCjIZLne
 rH7mZHlTDjpAvdTz8ip6cg2SDzBj72pTzQt0iMFJRvIoEcQ2QfKUKd+yZ4ReIHgD5rMCWRT7X
 fi3dZV9mPhvOpTvgVr2UtxWvFfdkF1s6DmVjeH9lslmEfeezDeHXLumk79zBmhSqlpDiFpRb3
 uq6/0DBalfzwjVi/Kk606Vnxi7vm3JIf1U7hbUv/VqdxC92DgCNPi8Md5f0nfxLPJqRAVbi4F
 bYrDevpUALaOvLe1XE3Jnoq6QCG8bahZp9f+OTw54nxHm5zxbR8mvvgOLg38=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/24 =E4=B8=8B=E5=8D=885:12, Nikolay Borisov wrote:
>
>
> On 16.09.19 =D0=B3. 15:02 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> The following script can cause btrfs qgroup data space leak:
>>
>>   mkfs.btrfs -f $dev
>>   mount $dev -o nospace_cache $mnt
>>
>>   btrfs subv create $mnt/subv
>>   btrfs quota en $mnt
>>   btrfs quota rescan -w $mnt
>>   btrfs qgroup limit 128m $mnt/subv
>>
>>   for (( i =3D 0; i < 3; i++)); do
>>           # Create 3 64M holes for latter fallocate to fail
>>           truncate -s 192m $mnt/subv/file
>>           xfs_io -c "pwrite 64m 4k" $mnt/subv/file > /dev/null
>>           xfs_io -c "pwrite 128m 4k" $mnt/subv/file > /dev/null
>>           sync
>>
>>           # it's supposed to fail, and each failure will leak at least =
64M
>>           # data space
>>           xfs_io -f -c "falloc 0 192m" $mnt/subv/file &> /dev/null
>>           rm $mnt/subv/file
>>           sync
>>   done
>>
>>   # Shouldn't fail after we removed the file
>>   xfs_io -f -c "falloc 0 64m" $mnt/subv/file
>
> Was this sent as a separate fstest case?

Yep.

https://patchwork.kernel.org/patch/11145871/

Thanks,
Qu

>
> <snip>
>
