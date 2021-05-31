Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7223959E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 May 2021 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhEaLr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 May 2021 07:47:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:50667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231464AbhEaLry (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 May 2021 07:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622461572;
        bh=1Tg2N83KSGvQ5i5I/YRQSE5MJVj2iLpYUjw95/sV6iw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kHCsjmuLTT/qRvEon8Vgn9FGboEFwjx2yqah112W21lI/2Kw3XkRtt6ussics9AfZ
         981Z+7utnCHi94FKxGw7OzHhNy7484Qz7SfcOaq5mciFN9mO4bKqnvz/HgVKl26NBJ
         pq7dinJHHfL6EjMEKsWSa15tJAUs5c1rw9QiIo8Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1lkwHt44Xm-008NUx; Mon, 31
 May 2021 13:46:12 +0200
Subject: Re: [PATCH] btrfs: Promote debugging asserts to full-flegded checks
 in validate_super
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Cc:     syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
References: <20210531092601.107452-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <2013caf9-efaa-1fda-fe04-3bf01829c9af@gmx.com>
Date:   Mon, 31 May 2021 19:46:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210531092601.107452-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KB6VPhioKVyxZwy7zhbaRM0x3rs2H8gPvjzyIJZm9E/pxiSA6QX
 TvcHLTfC60C5P1HSMzbuwH8Lu74bZzUvf7W4IZ3LsCYg7d3OuM1ZtxItoufE3mmzSIh+ZlD
 ZGLQ6kh+60PP9dJM7282pnasgDmfCWBaFVt26xa+s9YyvVnOjkdnlmns0H/CpX4bOVVagoa
 C6egxAfrxp/dkRu5Sw0mA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yIJlHe/RNcc=:MyEsG9PRJcwbvfvmUCKh96
 AxVXy3ctJEGazCmxLPTzpWfxDiKGaBmvFC8w/t5iJwUOMoawLb+h/M3DKZIPmXvnc13hbItcK
 tl7YYsvX7urO9PKp7x8VXI/r2hhecK4huh6+T8B5qm7aVC14Z+0rfvugZEr0gv+5zJ5WdpSxE
 RzXQAWxSLqSVfKKBm0bcGM6XUJMompC9KEmTVNrmvbcQG67q8AGPwyzCJyE297WyHSsyFae06
 Nxj2exWpSeQU3GNNh/LRNDs748JWwybue89TYPwJc8bginMB/LZhvxRAgIGC1t1CgPQlkgZ2T
 H7s4JOou1hBdly8GtcOlGS/BFzwg3JD4FaSJLVBAUjaw0Cp+ucO3pvB/OgGL6Z2d4sArhq8zc
 AZhcRuqJ0DYsZXzx/oBzxHTolJ3AQOpgsN44IG9YfxDnFbWr2bY1OApCOFUsRP4VQlHyYjuYS
 ocWh+D3DaWx0+dkmDwusWK9sfIFqZGQb1OVx94miOwfbRp7Fo2rIdBYR/r4Y603jFMoriPsAn
 izV2q8ILiAjd/tFejfSsiddEW8QmCx/MQFfnHfGPzIYaWqrnx7L65PqTjIhOkE+nj7JFq7Djk
 qhuPOGk5vqJ34X/ebaiLZjcnfJwiXz9lR6/SyUijdHsiyEnOef3s/9exwT+yoSSfXgchtew8L
 /SuEkkJH2N3Lnjh2uR8NgMQcslu/iGKiCgtA8EDWDIdRpU/mvvGvahyZHyiO4FVeF41/jGpxC
 S3rBOQr0uo1vt03YtwaCKft/QdAYLfq+nH4kRjqwPccDwq/I5TcUnMb3z8e9Uhd1jaAyu64ZV
 c9NV8lY9tO00+ws3n+DKvAPaxOFAnnD3YZD4HJAm9AT6B8aaCjI71S4gFjOFFJb6rbExE1pIf
 jlas3qk9SBhRcZsTFg8HX4oXoi8gSB+SuwZkFNe0V/aQyW4tXYJNriw9AovQ5IzAztmUAwWdN
 d8C6NOAckM39hPgypfAfcyp7QtxSmkzzNvziryY/q4uoKUGWwyyuKyAdtYjRhYqF14bDnBSsT
 HMCyYTJaQLJnJXG2vqpZocISRud9LE/0xDoq2m0uZ33NMghncIgwVzfTtoj6FYo3lfwXL5nn9
 G+/KcYQgAdwFcn4UEFvmn5KbmrLhPQcEv3mmoVQf/0nsnn5hfmc2bUJJxgsG7G1JB2xA9P2TI
 LmDhIDcQ/31+3vbkC6bWd8eQ4+l4cTWnNHXCOIu9sAE/yH839CJKKRSmq5d71Oq2oXHPw88qx
 v0ysCmy9Bh0zsIqTB
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=885:26, Nikolay Borisov wrote:
> Syzbot managed to trigger this assert while performing its fuzzing.
> Turns out it's better to have those asserts turned into full-fledged
> checks so that in case buggy btrfs images are mounted the users gets
> an error and mounting is stopped. Alternatively with CONFIG_BTRFS_ASSERT
> disabled such image would have been erroneously allowed to be mounted.
>
> Reported-by: syzbot+a6bf271c02e4fe66b4e4@syzkaller.appspotmail.com
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 21 +++++++++++++--------
>   1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 99757939f8b0..cff694fe87d3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2648,6 +2648,19 @@ static int validate_super(struct btrfs_fs_info *f=
s_info,
>   		ret =3D -EINVAL;
>   	}
>
> +	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
> +		       BTRFS_FSID_SIZE)) {
> +		btrfs_err(fs_info, "superblock fsid doesn't match fsid of fs_devices"=
);
> +		ret =3D -EINVAL;
> +	}
> +
> +	if (btrfs_fs_incompat(fs_info, METADATA_UUID) &&
> +	    memcmp(fs_info->fs_devices->metadata_uuid,
> +		   fs_info->super_copy->metadata_uuid,	BTRFS_FSID_SIZE)) {
> +		btrfs_err(fs_info, "superblock's metadata uuid doesn't match metadata=
 uuid of fsdevices");
> +		ret =3D -EINVAL;
> +	}
> +
>   	if (memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
>   		   BTRFS_FSID_SIZE) !=3D 0) {
>   		btrfs_err(fs_info,
> @@ -3279,14 +3292,6 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>
>   	disk_super =3D fs_info->super_copy;
>
> -	ASSERT(!memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
> -		       BTRFS_FSID_SIZE));
> -
> -	if (btrfs_fs_incompat(fs_info, METADATA_UUID)) {
> -		ASSERT(!memcmp(fs_info->fs_devices->metadata_uuid,
> -				fs_info->super_copy->metadata_uuid,
> -				BTRFS_FSID_SIZE));
> -	}
>
>   	features =3D btrfs_super_flags(disk_super);
>   	if (features & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
>
