Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C2319357B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 02:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZB7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 21:59:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:39931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbgCZB7p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 21:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585187980;
        bh=R612dwK/ZEIZ8Gc9vN6spAfIbNpp0QBsEcwfbfG4l+o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VPqI2dMFmewVTAX7OHAcIt1oKWBb/lZqTn3D8PVrn251tsMiB2DN0hhLT99v93Xw8
         wqBN21lqzVeJKJUSDPh/OVp4hEl8Ru37x9di2vxlzwQFn6awT0I8A7I1p9Vy6dNW6j
         tCcU4vK0HWZmBplEgtCq309i5Yaivqqf5wkoFCnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wlv-1jOOTC3385-012HPs; Thu, 26
 Mar 2020 02:59:40 +0100
Subject: Re: [PATCH 1/4] btrfs-progs: Add missing fields to btrfs_raid_array[]
 for raid1c[34].
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <20200325201042.190332-1-kreijack@libero.it>
 <20200325201042.190332-2-kreijack@libero.it>
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
Message-ID: <484bec80-2469-b638-b80b-8811a0e8e9ff@gmx.com>
Date:   Thu, 26 Mar 2020 09:59:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200325201042.190332-2-kreijack@libero.it>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+otY3IIaL4tSnlZSABwzCAqXGhMayTsZ3j5J8mzvCRJIjOciXf3
 sZhQCXY5I7Cy0iW/2J6UoTIrAKDIdWaqof8SMfxVQ90IltNATdCbhoCYEleNjWXy5PpkuM7
 oh1OTAuHw8nTO4JdcMt9lYnIVDuFSpJLHLiyWV7KvseTyNMBWHdvr7oUjMJQo8kkG0K/N7G
 W7u8aaF4FANkzosbksp7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oYBtsA3tUVY=:y/pCE3XMGJX/Y1usaJTKrG
 z2VfFsuZyPbWhd3nOgW3lhm0DWv3hPCJIWA/mqeuBvn35MBwibm4bFJ6v/xCGKZuerzkMt5zS
 fPNM0kytdvmkXtutv+KQ8bWn/uJlxsZDX78tvHIz8xVU5KXUCeTzu0B9wtj8EqRo3B2HiZpKK
 8PEwi/2+wlg4agFwoVs3yuVfh6RNLbEYuaiLWcqlmH2SOiG+ndwvspBY/YQ3g2T/mzoNd7RPA
 HgMspHTRYHPr1xypO7Q9pFkxqhiIeE1emNUyv6eu26042n52EJCl8oNXtHIvVNcGoZHmSSFRI
 XbITWhnw3/9jLZgqWx02iQXHN61WesLn3LVjidhj7Yytq7nMB08K1EkqhspUuDb0vX1jb7xhE
 163QKel5SkSximNZAV3p7sYSut+Sn4qyYw83vI+za9EZisS6kcwOH1lTymO39IRdr1bEo2Pto
 XWcaaGAPLX5mTQqwAQXxzs/1l/QiZ3u0reZd7BLrXau7Fygkb7NHdfe7L4ho9tvp+jcPpDMJd
 Ggw94yR88lO8ocRMr8SG4dHD7tgt9YqcjUHb4ve9DbfwA74FIwo/TIc/bvJrQZzToMePBho/7
 1Au/AputvpYKTQRbJ1MeHP8/jFQlA1/NVHrhGTpP2dnpRHASQvMaKbEibBpjhVV2I7lRHVL7m
 E1S4xprdteseqR5wnbbPRnWqulLioRrxRm/5weCjH769Ii6Buic/7EgUce+VEPqIhx76FKkOH
 U8lRxCfq8IgXsJ26YcTNqTgLKAGzJ59EU0Y9fr4ZUlISpWFzBrtdaVXUcPKJP4P9onQqjyQyO
 mWLtNpR4xplKs/BC/vcg9Is+K7/2gNKh8cUiFQLPicy0lOmtWWywGWVDqyny7RtyRdFsKoaaU
 O7digOf3W6tvFT9vMACgYwjaT7xK+0AOjaXMMCH0hQKB8TEL/lzeebrbkSHkMpt2169F0FXTt
 DazorkEzasE+yi1YwbZT5aT3HvXLxvuYX4Mvt/QY35EcxrtWbYaLiYKVcnEA3/8KHLaQ3tvYl
 u/JWcZQbHys+OJW0FfZKwUuhwdTUlaCmOaD7zAZHsrITXiLhzyjy26ihpqT15d5gvvItV7E52
 BP9vSb2x5idbprkVhZNER7qGvqn8zOfEuWGGQD82h5IQn0ryo4DRzO5tspTQ+uoZF8ZIKs6yj
 8M2Vj/5e+y5ZTDDg295ExBamW8fiHgxoTzSg/55K+b0h+EfvF8kWiNn1APx33uxSQDTZKklb+
 8o1nY6p2nlLS50sMt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/26 =E4=B8=8A=E5=8D=884:10, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  volumes.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/volumes.c b/volumes.c
> index b46bf598..9e37f986 100644
> --- a/volumes.c
> +++ b/volumes.c
> @@ -65,6 +65,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR=
_RAID_TYPES] =3D {
>  		.tolerated_failures =3D 2,
>  		.devs_increment	=3D 3,
>  		.ncopies	=3D 3,
> +		.raid_name	=3D "raid1c3",
> +		.bg_flag	=3D BTRFS_BLOCK_GROUP_RAID1C3,

Since you're here, mind to also add .mindev_error?

Thanks,
Qu
>  	},
>  	[BTRFS_RAID_RAID1C4] =3D {
>  		.sub_stripes	=3D 1,
> @@ -74,6 +76,8 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR=
_RAID_TYPES] =3D {
>  		.tolerated_failures =3D 3,
>  		.devs_increment	=3D 4,
>  		.ncopies	=3D 4,
> +		.raid_name	=3D "raid1c4",
> +		.bg_flag	=3D BTRFS_BLOCK_GROUP_RAID1C4,
>  	},
>  	[BTRFS_RAID_DUP] =3D {
>  		.sub_stripes	=3D 1,
>
