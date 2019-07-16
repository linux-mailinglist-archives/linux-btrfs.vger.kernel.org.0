Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABADB6A037
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfGPB11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 21:27:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:38049 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730607AbfGPB11 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 21:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563240413;
        bh=MROHeWDAxlSdsRtiwIL+y4l4I3nikPdZ9wLxlO3OYVI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=klwUmbwXBeh/fhEaZAodni6S/nCmJDJIrkYU3xfyCQFrVqiZQ5lE//uHiF6kRlI/S
         QfFMnH/rPb/84TDKnXNknMLDbpn67HYufh5wa3yWSZqlZ+rJbwQecxkPmaswB+Cg73
         6miZqHBrPvUXrdkB5ghewXLmmRkTEjC/FrnaO36k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0LcBvB-1iCJj73EdJ-00jawt; Tue, 16
 Jul 2019 03:26:53 +0200
Subject: Re: [PATCH] btrfs-progs: add verbose option to btrfs device scan
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20190715144241.1077-1-anand.jain@oracle.com>
 <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
Message-ID: <e8aaa2cf-3e10-4ff9-dabe-c6192583e93c@gmx.com>
Date:   Tue, 16 Jul 2019 09:26:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <4f150d66-0c4d-b0f2-4cf9-9bc1194d83e9@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5bX6E5xa/AqS3rMeR2jvhenUE3gGTmiizOxh2mAk745p6V/WLW
 APQRIgM1UojPjpCCXiiT7+rpLyV7PUSnaFENJajHzmUeHHzUXqnFBsItZdz+C0xkHD9X3J1
 9BiJ37i0M7oqCc7fON+saP5gzjUGcpZ7BIIyr5Tus80/9QjYwUEZvUYwL9Y0gaDZziqXJ/6
 eR2WYDzcZb1WkpoD3bb8g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ohhWWGpjhCg=:4tOELA3eY9dAzTFiKU4JZA
 nY54Cor4/SKAHesbuw1KDrIHkT3qisBINGRi2QGJrUF5QotcH3vaYsFf7Y2P0dTCSj/rR1pks
 jLzhSPg6rBEtiCcSF0Gd1Dz+6QN5uXkmheup08lwMYUTwGk4QwfpO2W6gP24lLJMGMATFigZG
 /H4LYLX/RC0AenGg0001/30gTPmi6YAFRU5tmj7K140dfde0MCm5xhjUpcaBnNEtW3DpCBZ0o
 ttkpdkiv6wgwuwgzemK++2BlkrF28IGZ+bfQOk5O+tK3N752ViS5ManKvX8IyHcN+XKxU8ZTh
 Bfz+rZ4KeEEBCaq/ygdYuilXdV1VBJy6uc4/iUv6ModKWw8WS8dnR63tWpi7nYv8j6ST4HVM/
 49fiYLVjFbw/KH/O7uqCTLaWqATmJda9dcT2x+MJKI3zfekcD8fbObLzXZvAhgMTjqUmeKGJx
 vaQg3HM7kZWrZsxhsYENis5T7bb4sTi4RBxwRkDdzUlIGFN3T5UWFMyqiJJjVOrp1+5lbH7iB
 RotelgxAY+tjlDYX3lOdLyAFdOktazNX0RmCwPia+LPaz4dyYgCy7CP3ewOFhOJ5+tpGN9srj
 GqyJ1I/5Ebd+iqhK1eSyJKk/jgkUsrIDQiC2fW7dPlsqy4lMP+Mw+ZodQwA5+L5H2GmBryfQQ
 Tk3hapcyYHMrdOfpc15GLKzSsfSGzWTwLQCKYkInspJmx4aWldhIJTy1TSyeb5tBLGdsAfZRc
 mJSmaYZ5B1sv09FP7Dz99BuXMFNnW6alg8ul89JhhoWMxxqk/f78sMcRHqYyS591Kh/pTQHOZ
 ClvRmRDpD85dIP2kpMiR4vSQM5PafeNalaGehjRi9xerGbvtA5OioA/wzZmrT0wlAlzfNCfpY
 7YmIbUHsPlzmejGT40mDp2mfQDSIkDsOJOoyzy+q/F03wDaJKkaRSmXJL7Iou7FyTxePpiZNZ
 eA6hwbs6vNaDgGD6fTM7WRgoaVnt9DbeWcPtySExKTtKtWCLEqpxEweswGXbbmpBleXe5Av+Y
 yp9tJ2wxT8LQQAAUDGfgxE7vD7zDhuydsIMqtu8xA+if06YlbDz/84CVWzp4CQZ1ew5NwMmpS
 dOaR0HApogcOFe+LRApNKvijNbY5AOYpx4/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/15 =E4=B8=8B=E5=8D=8811:09, Nikolay Borisov wrote:
>
>
> On 15.07.19 =D0=B3. 17:42 =D1=87., Anand Jain wrote:
>> To help debug device scan issues, add verbose option to btrfs device sc=
an.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>
> I fail to see what this patch helps for. We get the path in case of
> errors, in case of success what good could the path be ?

AFAIK it would provide an easy way to debug blkid related bug.

E.g. scan only works on some devices and misses some devices.

So it makes sense to me, although "debug" would be more suitable in this
case.

Thanks,
Qu
>
>
>> ---
>>  cmds/device.c        | 8 ++++++--
>>  cmds/filesystem.c    | 2 +-
>>  common/device-scan.c | 4 +++-
>>  common/device-scan.h | 2 +-
>>  common/utils.c       | 2 +-
>>  disk-io.c            | 2 +-
>>  6 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/cmds/device.c b/cmds/device.c
>> index 24158308a41b..2fa13e61f806 100644
>> --- a/cmds/device.c
>> +++ b/cmds/device.c
>> @@ -313,6 +313,7 @@ static int cmd_device_scan(const struct cmd_struct =
*cmd, int argc, char **argv)
>>  	int all =3D 0;
>>  	int ret =3D 0;
>>  	int forget =3D 0;
>> +	int verbose =3D 0;
>
> nit: make it a bool.
>
>>
>>  	optind =3D 0;
>>  	while (1) {
>> @@ -323,7 +324,7 @@ static int cmd_device_scan(const struct cmd_struct =
*cmd, int argc, char **argv)
>>  			{ NULL, 0, NULL, 0}
>>  		};
>>
>> -		c =3D getopt_long(argc, argv, "du", long_options, NULL);
>> +		c =3D getopt_long(argc, argv, "duv", long_options, NULL);
>>  		if (c < 0)
>>  			break;
>>  		switch (c) {
>> @@ -333,6 +334,9 @@ static int cmd_device_scan(const struct cmd_struct =
*cmd, int argc, char **argv)
>>  		case 'u':
>>  			forget =3D 1;
>>  			break;
>> +		case 'v':
>> +			verbose =3D 1;
>> +			break;
>>  		default:
>>  			usage_unknown_option(cmd, argv);
>>  		}
>> @@ -354,7 +358,7 @@ static int cmd_device_scan(const struct cmd_struct =
*cmd, int argc, char **argv)
>>  			}
>>  		} else {
>>  			printf("Scanning for Btrfs filesystems\n");
>> -			ret =3D btrfs_scan_devices();
>> +			ret =3D btrfs_scan_devices(verbose);
>>  			error_on(ret, "error %d while scanning", ret);
>>  			ret =3D btrfs_register_all_devices();
>>  			error_on(ret,
>> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
>> index 4f22089abeaa..37b23af36847 100644
>> --- a/cmds/filesystem.c
>> +++ b/cmds/filesystem.c
>> @@ -746,7 +746,7 @@ devs_only:
>>  		else
>>  			ret =3D 1;
>>  	} else {
>> -		ret =3D btrfs_scan_devices();
>> +		ret =3D btrfs_scan_devices(0);
>>  	}
>>
>>  	if (ret) {
>> diff --git a/common/device-scan.c b/common/device-scan.c
>> index 2c5ae225f710..bea201b351f0 100644
>> --- a/common/device-scan.c
>> +++ b/common/device-scan.c
>> @@ -351,7 +351,7 @@ void free_seen_fsid(struct seen_fsid *seen_fsid_has=
h[])
>>  	}
>>  }
>>
>> -int btrfs_scan_devices(void)
>> +int btrfs_scan_devices(int verbose)
>>  {
>>  	int fd =3D -1;
>>  	int ret;
>> @@ -380,6 +380,8 @@ int btrfs_scan_devices(void)
>>  			continue;
>>  		/* if we are here its definitely a btrfs disk*/
>>  		strncpy_null(path, blkid_dev_devname(dev));
>> +		if (verbose)
>> +			printf("blkid: btrfs device: %s\n", path);
>>
>>  		fd =3D open(path, O_RDONLY);
>>  		if (fd < 0) {
>> diff --git a/common/device-scan.h b/common/device-scan.h
>> index eda2bae5c6c4..8017a27511b9 100644
>> --- a/common/device-scan.h
>> +++ b/common/device-scan.h
>> @@ -29,7 +29,7 @@ struct seen_fsid {
>>  	int fd;
>>  };
>>
>> -int btrfs_scan_devices(void);
>> +int btrfs_scan_devices(int verbose);
>>  int btrfs_register_one_device(const char *fname);
>>  int btrfs_register_all_devices(void);
>>  int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
>> diff --git a/common/utils.c b/common/utils.c
>> index ad938409a94f..36ce89a025f1 100644
>> --- a/common/utils.c
>> +++ b/common/utils.c
>> @@ -277,7 +277,7 @@ int check_mounted_where(int fd, const char *file, c=
har *where, int size,
>>
>>  	/* scan other devices */
>>  	if (is_btrfs && total_devs > 1) {
>> -		ret =3D btrfs_scan_devices();
>> +		ret =3D btrfs_scan_devices(0);
>>  		if (ret)
>>  			return ret;
>>  	}
>> diff --git a/disk-io.c b/disk-io.c
>> index be44eead5cef..4f52a29700ab 100644
>> --- a/disk-io.c
>> +++ b/disk-io.c
>> @@ -1085,7 +1085,7 @@ int btrfs_scan_fs_devices(int fd, const char *pat=
h,
>>  	}
>>
>>  	if (!skip_devices && total_devs !=3D 1) {
>> -		ret =3D btrfs_scan_devices();
>> +		ret =3D btrfs_scan_devices(0);
>>  		if (ret)
>>  			return ret;
>>  	}
>>
