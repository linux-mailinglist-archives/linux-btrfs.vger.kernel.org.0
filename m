Return-Path: <linux-btrfs+bounces-14143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125ABABE8A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 02:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4A64A6C48
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 00:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1B847B;
	Wed, 21 May 2025 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L3G9h7TY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61794B1E6D
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747788336; cv=none; b=UF12JpEVYeiWL6yUpy4QVHPlVCzC4dcEJI+Cfatfgp6WC2gZcJkmObGGHtMQfAe0cnGeQ9O6x9V7h/4zAXJFp7sbm5kHzmT72JTOyi7Nt2THSmA3iifD8dbVD0OhE2fwSx1Rysf6PXuSktVyk5PBV7rE+G6T/eBVXTn5jyRY46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747788336; c=relaxed/simple;
	bh=NcN/8lIXrwVGdzkOunf2VIuEnGzFeNJUngfv/lYjOFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c390imCzVEUQdy3D4axv/aPDu1iSw0eGd8xAbC6D7LgJMKf/uxe6PS5U9LeKbHJXZ/Pmf0EKUteE1SVVtBRa61+3HNtn3FS7z748H+oOjUQILb6SnPMV6hJ3ewD8Wq6FpTKs0Xan29/g5VDBP8SoCnAIbj2f2+68z/02x7l0JcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L3G9h7TY; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747788327; x=1748393127; i=quwenruo.btrfs@gmx.com;
	bh=O6jhYfTruq43OMK9VsxRn91RVt1se95ma2sivZuwEhM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L3G9h7TYyBSuUuIIh0AJ/CSDiabFeObRoD0ZhdiJvh2iuDsurR1MBAwc3ObcKcSv
	 K4tpYCjGh9fTN2pxkbjUvqkonj1+CLHaUAkc372VkxPPnhoSlM3FV6MiG/W8L44FY
	 TSPsCWKZyFSyuVbh/3nldzd4h9tP7dyQ8QCfO2k1SivyqUcaMmW8WEGmQKruxz5Ey
	 qNN02Zzu3ZatmDivPCjIsN4ekRd6MWHSM3kYugT005+HeQbmg6X9PrZ+iCrBddOVd
	 mxKqFpTRmKWE+VL5AJy6bAVqHeL7MUBefqb18vgsUu+ZcZxLrDLgstur88wYsStzu
	 A35U9IEX5UV7nH0owA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1utNNd2qWR-00ZwSf; Wed, 21
 May 2025 02:45:27 +0200
Message-ID: <80208aaa-2fa0-4f38-8d1c-90a35d9843be@gmx.com>
Date: Wed, 21 May 2025 10:15:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] [RESEND] btrfs-progs: add slack space for mkfs
 --shrink
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: Mark Harmstone <maharmstone@fb.com>
References: <60e0cc5d215e79ba47b2484aad89a726812049b6.1743463442.git.loemra.dev@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <60e0cc5d215e79ba47b2484aad89a726812049b6.1743463442.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4S2VvBGjPOCgthvJb/INk3GJgHyccREBbbQKwZffw4cSh+3mXRU
 A8ExjfLzIeh/qudrRdMI0wfkq+XD+Tlgp9qfZKJF99y1iEXLClrHsb08bw58i3JMJulWjmn
 PxLt8ToE5MF5c3q6HM2cIVEzknt2UaAnD5MvCiDpbBsq0g8lVhjHuxyTaK/pWWX8LGSs5yt
 p/pjY2VRJvPiA3hius2/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:61K03FueCNo=;1nmG2n6MFYQ0MWYMDza1GdOrIj1
 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
 1QPY=



=E5=9C=A8 2025/5/17 03:05, Leo Martins =E5=86=99=E9=81=93:
> This patch adds a flag `--shrink-slack-size SIZE` to the mkfs.btrfs
> allowing users to specify slack when shrinking the filesystem.
> Previously if you wanted to use --shrink and include extra space in the
> filesystem you would need to use btrfs resize, however, this requires
> mounting the filesystem which requires CAP_SYS_ADMIN.

Or create the initial fs with shrink, check how large the fs is, then=20
re-create a file with extra space, then create the same fs without=20
=2D-shrink option.

If you're not happy with two runs, just calculate the size of the source=
=20
directory, add 20% (already very conservative) for metadata, then adds=20
the slack space, finally create fs without shrink.

Neither solution requires root privilege.


I'm not a super huge fan of the shrink slack idea, especially it may not=
=20
work as you expected.

The shrink itself is already chunk based, meaning there may be as large=20
as 1GiB free space for data/metadata already.

Furthermore even with slack space reserved, the next RW mount may easily=
=20
cause extra chunk allocation to take up the whole slack space.
And if that allocation is for metadata, it may appear that there is no=20
slack space at all soon after a RW mount.

Mind to explain the use case with more details?
And I'm also wondering how the feature is working for other filesystems?

I see no shrink like options in mkfs.ext4 nor mkfs.xfs, if you guys can=20
handle ext4/xfs without shrinking, why not doing the same for btrfs?

Thanks,
Qu

>=20
> The new syntax is:
> `mkfs.btrfs --shrink --shrink-slack-size SIZE`
>=20
> Where slack size is an argument specifying the desired
> free space to add to a shrunk fs. If not provided, the default
> slack size is 0.
>=20
> V3:
> - warn if block device size < fs size
> V2:
> - change --shrink[=3DSLACK SIZE] to --shrink-slack-size SIZE
> - check for slack size alignment
> - fix formatting
> - remove new_size > device size warning message
>=20
>=20
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> Reviewed-by: Mark Harmstone <maharmstone@fb.com>
> ---
>   mkfs/main.c    | 26 +++++++++++++++++++++++++-
>   mkfs/rootdir.c | 23 ++++++++++++++++++++++-
>   mkfs/rootdir.h |  2 +-
>   3 files changed, 48 insertions(+), 3 deletions(-)
>=20
> diff --git a/mkfs/main.c b/mkfs/main.c
> index dc73de47..715e939c 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -461,6 +461,8 @@ static const char * const mkfs_usage[] =3D {
>   	OPTLINE("", "- default - the SUBDIR will be a subvolume and also set =
as default (can be specified only once)"),
>   	OPTLINE("", "- default-ro - like 'default' and is created as read-onl=
y subvolume (can be specified only once)"),
>   	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to=
 minimal size"),
> +	OPTLINE("--shrink-slack-size SIZE",
> +		"(with --shrink) include extra slack space after shrinking (default 0=
)"),
>   	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
>   	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
>   	"",
> @@ -1173,6 +1175,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	int i;
>   	bool ssd =3D false;
>   	bool shrink_rootdir =3D false;
> +	u64 shrink_slack_size =3D 0;
>   	u64 source_dir_size =3D 0;
>   	u64 min_dev_size;
>   	u64 shrink_size;
> @@ -1217,6 +1220,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		int c;
>   		enum {
>   			GETOPT_VAL_SHRINK =3D GETOPT_VAL_FIRST,
> +			GETOPT_VAL_SHRINK_SLACK_SIZE,
>   			GETOPT_VAL_CHECKSUM,
>   			GETOPT_VAL_GLOBAL_ROOTS,
>   			GETOPT_VAL_DEVICE_UUID,
> @@ -1247,6 +1251,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			{ "quiet", 0, NULL, 'q' },
>   			{ "verbose", 0, NULL, 'v' },
>   			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
> +			{ "shrink-slack-size", required_argument, NULL,
> +			  GETOPT_VAL_SHRINK_SLACK_SIZE },
>   			{ "compress", required_argument, NULL,
>   				GETOPT_VAL_COMPRESS },
>   #if EXPERIMENTAL
> @@ -1383,6 +1389,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   			case GETOPT_VAL_SHRINK:
>   				shrink_rootdir =3D true;
>   				break;
> +			case GETOPT_VAL_SHRINK_SLACK_SIZE:
> +				shrink_slack_size =3D arg_strtou64_with_suffix(optarg);
> +				break;
>   			case GETOPT_VAL_CHECKSUM:
>   				csum_type =3D parse_csum_type(optarg);
>   				break;
> @@ -1430,6 +1439,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   		ret =3D 1;
>   		goto error;
>   	}
> +	if (shrink_slack_size > 0 && !shrink_rootdir) {
> +		error("the option --shrink-slack-size must be used with --shrink");
> +		ret =3D 1;
> +		goto error;
> +
> +	}
>   	if (!list_empty(&subvols) && source_dir =3D=3D NULL) {
>   		error("option --subvol must be used with --rootdir");
>   		ret =3D 1;
> @@ -2108,8 +2123,17 @@ raid_groups:
>  =20
>   		if (shrink_rootdir) {
>   			pr_verbose(LOG_DEFAULT, "  Shrink:           yes\n");
> +			if (shrink_slack_size > 0) {
> +				pr_verbose(
> +					LOG_DEFAULT,
> +					"  Shrink slack:           %llu (%s)\n",
> +					shrink_slack_size,
> +					pretty_size(shrink_slack_size));
> +			}
>   			ret =3D btrfs_mkfs_shrink_fs(fs_info, &shrink_size,
> -						   shrink_rootdir);
> +						   shrink_rootdir,
> +						   shrink_slack_size);
> +
>   			if (ret < 0) {
>   				errno =3D -ret;
>   				error("error while shrinking filesystem: %m");
> diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
> index 19273947..5634d8c2 100644
> --- a/mkfs/rootdir.c
> +++ b/mkfs/rootdir.c
> @@ -17,6 +17,8 @@
>    */
>  =20
>   #include "kerncompat.h"
> +#include <linux/fs.h>
> +#include <sys/ioctl.h>
>   #include <sys/stat.h>
>   #include <sys/xattr.h>
>   #include <dirent.h>
> @@ -52,6 +54,7 @@
>   #include "common/root-tree-utils.h"
>   #include "common/path-utils.h"
>   #include "common/rbtree-utils.h"
> +#include "common/units.h"
>   #include "mkfs/rootdir.h"
>  =20
>   #define LZO_LEN 4
> @@ -1924,9 +1927,10 @@ err:
>   }
>  =20
>   int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_=
ret,
> -			 bool shrink_file_size)
> +			 bool shrink_file_size, u64 slack_size)
>   {
>   	u64 new_size;
> +	u64 blk_device_size;
>   	struct btrfs_device *device;
>   	struct list_head *cur;
>   	struct stat file_stat;
> @@ -1954,6 +1958,14 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs=
_info, u64 *new_size_ret,
>   		return -EUCLEAN;
>   	}
>  =20
> +	if (!IS_ALIGNED(slack_size, fs_info->sectorsize)) {
> +		error("slack size %llu not aligned to %u",
> +				slack_size, fs_info->sectorsize);
> +		return -EUCLEAN;
> +	}
> +
> +	new_size +=3D slack_size;
> +
>   	device =3D list_entry(fs_info->fs_devices->devices.next,
>   			   struct btrfs_device, dev_list);
>   	ret =3D set_device_size(fs_info, device, new_size);
> @@ -1968,6 +1980,15 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs=
_info, u64 *new_size_ret,
>   			error("failed to stat devid %llu: %m", device->devid);
>   			return ret;
>   		}
> +		if (S_ISBLK(file_stat.st_mode)) {
> +			ioctl(device->fd, BLKGETSIZE64, &blk_device_size);
> +			if (blk_device_size < new_size) {
> +				warning("blkdev size %llu (%s) is smaller than fs size %llu (%s)",
> +					blk_device_size,
> +					pretty_size(blk_device_size), new_size,
> +					pretty_size(new_size));
> +			}
> +		}
>   		if (!S_ISREG(file_stat.st_mode))
>   			return ret;
>   		ret =3D ftruncate(device->fd, new_size);
> diff --git a/mkfs/rootdir.h b/mkfs/rootdir.h
> index b32fda5b..1eee3824 100644
> --- a/mkfs/rootdir.h
> +++ b/mkfs/rootdir.h
> @@ -52,6 +52,6 @@ int btrfs_mkfs_fill_dir(struct btrfs_trans_handle *tra=
ns, const char *source_dir
>   u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_=
dev_size,
>   			u64 meta_profile, u64 data_profile);
>   int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_=
ret,
> -			 bool shrink_file_size);
> +			 bool shrink_file_size, u64 slack_size);
>  =20
>   #endif


