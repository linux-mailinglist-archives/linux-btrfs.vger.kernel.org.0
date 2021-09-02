Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E73FEC1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhIBK2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 06:28:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:53301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233716AbhIBK2N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 06:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630578432;
        bh=QpBLU9sew9fn98rY/VIR3FP8U+SeQ0PuWgpmIVFKHDo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PL1Tpxbh3UfHgirAeK61gx88krMm1rfQCsC3g8IwEZLjfvHTpWk85hvXle1B6I4+J
         jxUD9ThoRVSO02vI+j+h+Wy12giXkcTfkKEZQFkNZ11jgHRmwFVDNKhLnERtRVbTvC
         ISGBCCqpflNvVEr5z27xA/yydf18xEeWUi5OHS28=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXtY-1mUZbj36gq-00QQQ7; Thu, 02
 Sep 2021 12:27:12 +0200
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c5930e90-ca5b-4089-6f2e-830af6576baa@gmx.com>
Date:   Thu, 2 Sep 2021 18:27:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210902100643.1075385-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TLZh5xtxsKp0xHutLc4mvoFUZhha/Xxx/KiOxiKOMFaxWpsz7Mh
 jsKvLGqX0fPbwF/Zamn0ny035J1fust3KS6T5j0/tymzSnoxts7j0gmR1ikpwOxjWgfRK6p
 IZjQH4GLjpWMBJZ+phFQN38UMFV+ndKNtEAFPZnpGU6fX/VwAfhS39lWUpI32agLqrmD7cK
 fHANEuA2P/RzmI4EMk5sw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1BV38TSOp+k=:ztAmJPTCIB3w/3isQzAcLr
 tQxCxw7cyn4bq+lprL1oSrGYdaGdbH3V/2ZawUXnFUqQLPG0Uzx2iP7O3NGcvLoPEx73vNtGJ
 q44bYs1tZBTl1H7xWj3YbHIGG+lOE+kEOIyz50/bx/916RBxxMvljDYkMOqes8ZlYYIa6sQmB
 Hs+QE0YZL/N/0iGt/zGz5VFBvpxBuliWEXLjQHFqc+y8nrin2OIXKUyxvn7R4V7tt9hF9lgUx
 VBZXhFkiSmfOUAVzVbJc2TcpiYD2Un9Qmr4qcIGEcIlsp2SwCJlFIqHG559i6R4en37vJsDP4
 bJrh0zNZFPyGpVqFYj3s8NGyHK5XxoxnGOCYUNaLbIJMBgsmeLBtFiQUdsffW7RxRUNE5FqGo
 0rWwrpGbh2kGKW3cx/0KR66X7z45r2KQsdOBr3TfpMvcGz1IgGHjzfOJPtmABGD6xOjwoWcif
 VvJnmdWkmrC2e9b2QX2bZOU8D+sovYKYyeNEP3eoT1HUvnYl+6TzxM/NIKSjiH2xXGHpqebng
 3spVVH06+rSFlMSD4CMiajoJzJKQQSl28DiNLRb5AZ14Wy5AbmJUGGFsgyQjrkvP4ScxEiSeT
 i2TKUEd93gc47+hm8dQ8QVwjOomtLNxIBxa1v+y8FcfpcH/18rhsVOjI2YdlcmvHaxV+sNdxY
 PdnBVKkKB4hS9bVmyT7yBfXA/QVxxuHFRruLYQBfr06DyqHe+jcSh5sk01W4j2SA55yi/2IC+
 xBWG9bhh9Kxk75RsaCplMDAKO146KrHlZrbXyMJtzaLXDAqSGFL70YtRf09SO+BWmZmxkZzu9
 DfhLRpfdFfR2Hi7El+S+qsA4ggf3TRwE6IydT6TQoHZJAS3dahJKwfelJxSQ4RHgrQRhKjVhC
 /1egKsg1ELFIcNyzwuJeKajftX4s2ivMQl7cZmeXzfj5k/oQxDj0KESqPspW0Yd4QQ1EmmrWV
 lrPLniWs9Qk6WGkVDlV7vB8N+b3EO742nwbyiq29L93FuHQbkZ9BM0ikk+ga/2wGCgeKkxL89
 xobcY45ummatjV/7P7wSm1HDdjMHsT5e6is1hsSwcaM2U1PPmX4SLixJOmNCjvNpTh8wqqoAK
 g7OgjwiNGaWKCid9tQIYXqlDUfuImEIbDZgstyugURq+5iNyeQC3NR89w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/2 =E4=B8=8B=E5=8D=886:06, Nikolay Borisov wrote:
> Currently when a device is missing for a mounted filesystem the output
> that is produced is unhelpful:
>
> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	*** Some devices missing
>
> While the context which prints this is perfectly capable of showing
> which device exactly is missing, like so:
>
> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
> 	Total devices 2 FS bytes used 128.00KiB
> 	devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
> 	devid    2 size 0 used 0 path /dev/loop1 ***MISSING***
>
> This is a lot more usable output as it presents the user with the id
> of the missing device and its path.

The idea is pretty awesome.

Just one question, if one device is missing, how could we know its path?
Thus does the device path output make any sense?

Thanks,
Qu
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   cmds/filesystem.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index db8433ba3542..ff13de6ac990 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -295,7 +295,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_a=
rgs *fs_info,
>   {
>   	int i;
>   	int fd;
> -	int missing =3D 0;
>   	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>   	struct btrfs_ioctl_dev_info_args *tmp_dev_info;
>   	int ret;
> @@ -325,8 +324,10 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_=
args *fs_info,
>   		/* Add check for missing devices even mounted */
>   		fd =3D open((char *)tmp_dev_info->path, O_RDONLY);
>   		if (fd < 0) {
> -			missing =3D 1;
> +			printf("\tdevid %4llu size 0 used 0 path %s ***MISSING***\n",
> +					tmp_dev_info->devid,tmp_dev_info->path);
>   			continue;
> +
>   		}
>   		close(fd);
>   		canonical_path =3D path_canonicalize((char *)tmp_dev_info->path);
> @@ -339,8 +340,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_a=
rgs *fs_info,
>   		free(canonical_path);
>   	}
>
> -	if (missing)
> -		printf("\t*** Some devices missing\n");
>   	printf("\n");
>   	return 0;
>   }
>
