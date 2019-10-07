Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94234CE3DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfJGNiJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 09:38:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:38715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfJGNiI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 09:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570455479;
        bh=eeN8pWRgOkaf9cnnP7MpaNsQQWbFxwhlK0YcjZccrAg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gSq0uUW80DHcJ665TzJlUkzTpfTpsCkTIben9VpfnkelPIoiNJWkJ7DLFCkPmkO6G
         BGh0dwFSR0eU6xHbtgPc6clAH/kTDMTzrBwfGXH8n5hbdMC2xcIyaU7CIbdD/aD7aa
         GOh5j7hndLi8J0CZw44i4kqLK1OnlaThzCyeJ2Lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4zAs-1i9wCk2Zgy-010sFC; Mon, 07
 Oct 2019 15:37:59 +0200
Subject: Re: [PATCH 4/5] btrfs: remove identified alien device in
 open_fs_devices
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20191007094515.925-1-anand.jain@oracle.com>
 <20191007094515.925-5-anand.jain@oracle.com>
 <b370fdd7-2d97-877f-88e6-3624205c8617@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b8ffd660-5055-d609-4fcd-169090e7914b@gmx.com>
Date:   Mon, 7 Oct 2019 21:37:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b370fdd7-2d97-877f-88e6-3624205c8617@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YxUj6a/xdduUXMYGDRMsXJw3gYv7P/D78d+kb1hhqtKT3hYkdPj
 WE4uIKnjfqt7rpPJZcjaAloMsW8Gi6yVGj6B98bUsyJQEgTIBEZ1lUotcbFWnSHN3NUL0GS
 cEttGo2GnLm+2AUUSL682i9a8gdO6nrGJENH6p8uVNaz5qklJkwrGk/IpgheqbiZk6T3+ci
 d/s6vxv4Zm+dNUoSxOq2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B26wy+arBgg=:qV4yvz7IkqCEBFdBW/fN9f
 SmWpmrPgGAfrxI4wymQtJqk66Wlf5QuNJWsLRXjrSu85ihy7JTrujJVg969/QeUmVOA3/mN/E
 k5Jh+ZzLABskdbfuYNmb3QVssNZrJNB7kyw2UeoThuEJxpNVVZPSHHN9G8e5ypua15HgU2Gm1
 JUU66w22nkLhjLFRWrSV8PCZMDuiRhOlQJaHEdcdbijA5Iw9pYaUqdiDsG90j7ZAKbV8dnfDN
 PI4sLGx7mgJ99V006+jnQZyA6BbtzOniGuArDukWlXZ1NRuh9LUqaHo3Z5JdqDgjmYVHU/0Ey
 9VbUtVtO8IklXxaOa16XdaNVfT1ZihjenCslBqT8dhphGQo+W3zv7x4OMGWtAhangJ8uxmhup
 maxcTMpGcxmeJblAhsto+ZGwe2NU2u/DsZSHuCMLU6xB/tIBzp/VQjFT0TLU3OdTwwwJqNHgv
 qgstcaHI1KcbrY1h+eBAQgxlO9WiucAhP+Ubb/lQihNgSa7h3h/I1xhs3/krfqBAIZk0WJA9m
 fsxqbgmq0ZAICfM+p/xPL1YNvETbZ0ZsCa6XLWtNLx2nwjST0vQ9jzNLvoaGQOqoTtX9p7gR8
 dSodUVCk/i/aTy1bys8F3jkFxsYlJxa3tkylb2hg/7YhfAc6bOuIVd8HlczKDa8ByvHnwhQ+T
 hz0AfgWVS0dxPAkmRL3COpJbFd63D7HlRRrI4277z/mqKuYUqhNn2CHvmus9/Vk3+paZYjkKr
 /mS9iq7x8SP2BbVR7nPV67IVVV9BjQqC/jj3irIYCsnCxwKmbon5tW9fJ776MnBlnG+mhUrJi
 pYxeVi6Gel1Lsai+Ef6MfCGwdKfrGYJDhFX9ObHAi8a4A49zmu15PGgdncljXp2qCsprqfCqX
 9l7rm2OJTEg8EBaJ/5UXooy+KZO7LE4aEnWfFTGmJPNusTM9+n8LrxlTYTxLj3SXOXFhi7qND
 0db/Ca9krpwRr8w0mCfoeQwEQHgvKvFw4ShUgnB6ZCcfeob0/YIt+VMB7cEmbB6QJr3fYdkvj
 u7oqGy9s/Es7ZvazcblLyftxAobGc8wgIPkh0SiF5zenAiX6bMRCkO1igvJcG2fCb/RKGLIA4
 MIgTWDCNtb0XnRYWD4Jc/oIY/dNxstcOUKvFN0kzkbCfGiGpMMsx/hqWYTNFtYx/OlZ1smXJf
 Q9tXBVYIZ+iFOuUD9nA25/em2Bg0dLdn6F1kkAh9nJYHDjR8lusnE3p8GZz0p4219Rvvb4uVF
 5uecXmFn7cQDWprM6bYUstauqAgrdix1VAQz9vhiQPrsKSDB/gH872X2XwlBZxPRCYKzeQ24d
 OV1zn2H7djPsXf7pt/V+eFJWGwrNLEMt80jAW2c1mTrGj1mlELJSpbz+dur4WwGBJ0VBpewf6
 0prBaeMHnpOKvAz2wL7fpa6ls6ToCGSlrDZfXxOUst7vhxqlEPV3KUEgou3akUTcMwu0RMgFx
 ZK+/n6KudnSHtBtHrk4IPNagXb4mwSG2v/Ys+oa3JYYNJ9NbHYkIFXVwS71AhNmhwv9jxVanp
 N152A3S7U2SFBO2Rw8AFhcNU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/7 =E4=B8=8B=E5=8D=889:30, Nikolay Borisov wrote:
>
>
> On 7.10.19 =D0=B3. 12:45 =D1=87., Anand Jain wrote:
>> Following test case explains it all, even though the degraded mount is
>> successful the btrfs-progs fails to report the missing device.
>>
>>  mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdd && \
>>  wipefs -a /dev/sdd && mount -o degraded /dev/sdc /btrfs && \
>>  btrfs fi show -m /btrfs
>>
>>  Label: none  uuid: 2b3b8d92-572b-4d37-b4ee-046d3a538495
>> 	Total devices 2 FS bytes used 128.00KiB
>> 	devid    1 size 1.09TiB used 2.01GiB path /dev/sdc
>> 	devid    2 size 1.09TiB used 2.01GiB path /dev/sdd
>>
>> This is because btrfs-progs does it fundamentally wrong way that
>> it deduces the missing device status in the user land instead of
>> refuting from the kernel.
>>
>> At the same time in the kernel when we know that there is device
>> with non-btrfs magic, then remove that device from the list so
>> that btrfs-progs or someother userland utility won't be confused.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>  fs/btrfs/disk-io.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 326d5281ad93..e05856432456 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3417,7 +3417,7 @@ int btrfs_read_dev_one_super(struct block_device =
*bdev, int copy_num,
>>  	if (btrfs_super_bytenr(super) !=3D bytenr ||
>>  		    btrfs_super_magic(super) !=3D BTRFS_MAGIC) {
>>  		brelse(bh);
>> -		return -EINVAL;
>> +		return -EUCLEAN;
>
> This is really non-obvious and you are propagating the special-meaning
> of EUCLEAN waaaaaaaay beyond btrfs_open_one_device. In fact what this
> patch does is make the following call chain return EUCLAN:
>
> btrfs_open_one_device <-- finally removing the device in this function
>  btrfs_get_bdev_and_sb <-- propagating it to here
>   btrfs_read_dev_super
>     btrfs_read_dev_one_super <-- you return the EUCLEAN
>
>
> And your commit log doesn't mention anything about that. EUCLEAN
> warrants a comment in this case since it changes behavior in
> higher-level layers.


And, for most case, EUCLEAN should have a proper kernel message for
what's going wrong, the value we hit and the value we expect.

And for EUCLEAN, it's more like graceful error out for impossible thing.
This is definitely not the case, and I believe the original EINVAL makes
more sense than EUCLEAN.

Thanks,
Qu

>
>>  	}
>>
>>  	*bh_ret =3D bh;
>>
