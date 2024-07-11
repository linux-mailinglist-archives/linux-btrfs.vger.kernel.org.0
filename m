Return-Path: <linux-btrfs+bounces-6406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B94792F234
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 00:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7F11C2225D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 22:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957751A01B3;
	Thu, 11 Jul 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gjWH4Pcy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D509E145B09
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 22:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720737842; cv=none; b=hEYKBkAsduU9KyxOZYXWpCUDcSwF2tjgGBdprIQOYXg7S9+B4AMVRoDOKYM5S353MDv7zHXNlJOFMDJ/qegEA8sWhEWRhH/Irl1kaZmRXm43Q9QAtDtMeO5fZMRh5UDAx8rdkxgFIszBXcOQyKu9KPl53s00vVzrUFHvpQBkUBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720737842; c=relaxed/simple;
	bh=oDZ8A7euE+iVJAa78SrbcW3HkzhMh236EqvMQ91K6l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YLDarIpWQiMogxWPZx1vdC/pvGyajdPS46ZTQL7WenICRKpF9O0gh8SCcFJaQdLvYdG4SIDFshY1yHPYxEXAsX4KCdDzGiCpE9/4e73/VK8zgX8iFeZOd5oPhwAXz3vct4jlOBGnOSqQ1MDvCKWlvyJ0e29vS/5H1ExWcLHJSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=gjWH4Pcy; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720737834; x=1721342634; i=quwenruo.btrfs@gmx.com;
	bh=zr4kLnfkKdgip9I0FVWqaxb9aKqsnikcIhp4hoeY9wQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gjWH4PcyyCoqs7wbeDw7d/uM73DT8sSNq1uNqi7I6fFg+d/34QN0zbP1ZvkKrpNf
	 qHKAJ/JP4mllmq4XmUlFapohcIQbIZMAeGO/9pZ8pRd4pnk/38Zj3G3/joe/lIizK
	 XY5XgzY6ziZpwHoTvgSZt+PRb3Yd8Oz34blnLTmQodbeoauwbKj7AxJbJ5YvFP2qo
	 Nh/y2Tvndr8Ssg4Ma/VF7FRoGsvi7+vklBIokNSFJyKzHFnuqzV7C1npTDMyxiKG4
	 OlelHd70VkezJRstTElUFpGdaAaJ5/2RNplBSdQYAQnMUpM5DHbq9CAZ+XFIcuPA6
	 C23KNrGAtl1KVJW4SQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MBUqF-1sewfm3SzH-002ZJB; Fri, 12
 Jul 2024 00:43:54 +0200
Message-ID: <ce67ddb0-a923-4566-b7b9-7726a2095c33@gmx.com>
Date: Fri, 12 Jul 2024 08:13:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs-progs: btrfstune: add ability to remove squotas
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1720732480.git.boris@bur.io>
 <df9f78c02b2d6d1effb4fca36ce76606d2609045.1720732480.git.boris@bur.io>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <df9f78c02b2d6d1effb4fca36ce76606d2609045.1720732480.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:27MfU9d48jemiHXGRX+E2wnnLNPGmccVElXTD31IUwBOcjSUgsn
 /KEilM/FB9i01bwc3voxLaAQsaSoMGWFqZ3mF7M36tdWObQzgnRHTGx2jWD/gFGrGqHwu9E
 3I0Q/eeMikiV6JEh8234Jbk4I8XskD1qm1MeiwBkEFfDaei3ixI6U10y6O46Un/TH6CLkOS
 r5n4tRp6Zamv2sdtf+Gdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:04m9ukP/0kI=;ocNtv2Yj4YlpxgEccOylBM2xRmz
 ElRq024JHinWfj4FO2s+BvvBKlA6CdRIaoJW8II1X2r1DemvXRYXanQaKFUrhOad1BChT3yxk
 oDf6IWSQ5UnSV5oQbjWVPROIDXcLAGn8OBymwHnL5hzeOBS877vPANSUBq3o0C71sbR8pNRcQ
 b9nGuDKIYmHA2MWPRJhW0Cc5K/IUrUXQEtQZWjHGL/xu3Y0egOvdmEbdVgA4S4mSZQfF1crHi
 BxZLT+7llFh3PVhKlGss3TdXQwZJJp9FbNZ4LhOQQFYEPmWIz4Zpt6gRzh847QcBc9NjnHDhI
 xUewVximyzBUg+JQfhubvls7NgCuTvH9dCuiWMWb1bOoRB4OCgeCXML4w7PIExA3bfHnISA4h
 JqsNW1nsxlGAjbuZ/g9/ktvozt3GZgQKOruWmb7eW2BU7KqEcN01lhcBp9xfTYokXQNmePWp+
 wH3Nq4HL+HJNntb17IiSCKzgpcq3MSyLMxCcuyE104MeQVvS0e9gbfD3NynPjdYuz7o6hpFI5
 f1zo5dKsOiWdhSNs/5rTmXi/4my+JKG++dK/fytxGXU2p6m21gRJJmacqwQ85qH8JroLJzdZX
 5kAae5BGu8j1Y/ttZ8dvLY9oNE7zJaZVeZaBHlIUDSCUlXfMGffiH9rsir9HgMs809f6FKKUA
 eNpD7c2KiDAdLZUvVtQA/qhLctDqPO+ZDCUSd6SwnQjc0KASPVesoFxlXrdThP68cJ/QtWKni
 evpSNdcHLt1FWMRpjngbzyeAN5l6UmZb1S3D4NLxzRes2TQx8cdoHveckTcAxvOAx8I0BVG2f
 YfAN/I/9lnCj0vRIl2vMZ+NXWY9UbUw5KxEBDjWxAsAdI=



=E5=9C=A8 2024/7/12 06:48, Boris Burkov =E5=86=99=E9=81=93:
> When simple quotas is enabled, every new data extent gets a special
> inline OWNER_REF item that identifies the owning subvolume. This makes
> simple quotas backwards incompatible with kernels older than v6.7. Even
> if you disable quotas on the filesystem, the OWNER_REF items are
> sprinkled throughout the extent tree and older kernels are unable to
> parse them.
>
> However, it is relatively easy to simply walk the extent tree and remove
> these inline ref items. This gives squota adopters the option to *fully*
> disable squotas on their system and un-set the incompat bit. Add this
> capability to btrfstune, which requires only a little tricky btrfs item
> data shifting.
>
> This functionality was tested with a new unit test, as well as a similar
> but more thorough integration test in fstests
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   .../065-btrfstune-simple-quota/test.sh        |  33 ++++
>   tune/main.c                                   |  16 +-
>   tune/quota.c                                  | 160 ++++++++++++++++++
>   tune/tune.h                                   |   1 +
>   4 files changed, 209 insertions(+), 1 deletion(-)
>   create mode 100755 tests/misc-tests/065-btrfstune-simple-quota/test.sh
>
> diff --git a/tests/misc-tests/065-btrfstune-simple-quota/test.sh b/tests=
/misc-tests/065-btrfstune-simple-quota/test.sh
> new file mode 100755
> index 000000000..d7ccaf4e9
> --- /dev/null
> +++ b/tests/misc-tests/065-btrfstune-simple-quota/test.sh
> @@ -0,0 +1,33 @@
> +#!/bin/bash
> +# Verify btrfstune for enabling and removing simple quotas
> +
> +source "$TEST_TOP/common" || exit
> +source "$TEST_TOP/common.convert" || exit
> +
> +check_experimental_build
> +setup_root_helper
> +prepare_test_dev
> +
> +# Create the fs without simple quota
> +run_check_mkfs_test_dev
> +run_check_mount_test_dev
> +populate_fs
> +run_check_umount_test_dev
> +# Enable simple quotas
> +run_check $SUDO_HELPER "$TOP/btrfstune" --enable-simple-quota "$TEST_DE=
V"
> +run_check_mount_test_dev
> +run_check $SUDO_HELPER dd if=3D/dev/zero of=3D"$TEST_MNT"/file2 bs=3D1M=
 count=3D1
> +run_check_umount_test_dev
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> +
> +# Populate new fs with simple quotas enabled
> +run_check_mkfs_test_dev -O squota
> +run_check_mount_test_dev
> +populate_fs
> +run_check_umount_test_dev
> +# Remove simple quotas
> +run_check $SUDO_HELPER "$TOP/btrfstune" --remove-simple-quota "$TEST_DE=
V"
> +run_check_mount_test_dev
> +run_check $SUDO_HELPER dd if=3D/dev/zero of=3D"$TEST_MNT"/file3 bs=3D1M=
 count=3D1
> +run_check_umount_test_dev
> +run_check $SUDO_HELPER "$TOP/btrfs" check "$TEST_DEV"
> diff --git a/tune/main.c b/tune/main.c
> index cb93d2cb3..6ef8bbe2d 100644
> --- a/tune/main.c
> +++ b/tune/main.c
> @@ -104,6 +104,7 @@ static const char * const tune_usage[] =3D {
>   	OPTLINE("-n", "enable no-holes feature (mkfs: no-holes, more efficien=
t sparse file representation)"),
>   	OPTLINE("-S <0|1>", "set/unset seeding status of a device"),
>   	OPTLINE("--enable-simple-quota", "enable simple quotas on the file sy=
stem. (mkfs: squota)"),
> +	OPTLINE("--remove-simple-quota", "remove simple quotas from the file s=
ystem."),
>   	OPTLINE("--convert-to-block-group-tree", "convert filesystem to track=
 block groups in "
>   			"the separate block-group-tree instead of extent tree (sets the inc=
ompat bit)"),
>   	OPTLINE("--convert-from-block-group-tree",
> @@ -198,6 +199,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   	int ret;
>   	u64 super_flags =3D 0;
>   	int quota =3D 0;
> +	int remove_simple_quota =3D 0;
>   	int fd =3D -1;
>   	int oflags =3D O_RDWR;
>
> @@ -209,7 +211,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
>   		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
>   		       GETOPT_VAL_ENABLE_SIMPLE_QUOTA,
> -
> +		       GETOPT_VAL_REMOVE_SIMPLE_QUOTA,
>   		};
>   		static const struct option long_options[] =3D {
>   			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
> @@ -221,6 +223,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   				GETOPT_VAL_ENABLE_FREE_SPACE_TREE},
>   			{ "enable-simple-quota", no_argument, NULL,
>   				GETOPT_VAL_ENABLE_SIMPLE_QUOTA },
> +			{ "remove-simple-quota", no_argument, NULL,
> +				GETOPT_VAL_REMOVE_SIMPLE_QUOTA},
>   #if EXPERIMENTAL
>   			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
>   #endif
> @@ -288,6 +292,10 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			quota =3D 1;
>   			btrfstune_cmd_groups[QGROUP] =3D true;
>   			break;
> +		case GETOPT_VAL_REMOVE_SIMPLE_QUOTA:
> +			remove_simple_quota =3D 1;
> +			btrfstune_cmd_groups[QGROUP] =3D true;
> +			break;
>   #if EXPERIMENTAL
>   		case GETOPT_VAL_CSUM:
>   			btrfs_warn_experimental(
> @@ -535,6 +543,12 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
>   			goto out;
>   	}
>
> +	if (remove_simple_quota) {
> +		ret =3D remove_squota(root->fs_info);
> +		if (ret)
> +			goto out;
> +	}
> +
>   out:
>   	if (ret < 0) {
>   		fs_info->readonly =3D 1;
> diff --git a/tune/quota.c b/tune/quota.c
> index a14f45307..16b2b3fb6 100644
> --- a/tune/quota.c
> +++ b/tune/quota.c
> @@ -6,6 +6,166 @@
>   #include "common/messages.h"
>   #include "tune/tune.h"
>
> +static int remove_quota_tree(struct btrfs_fs_info *fs_info)
> +{
> +	int ret;
> +	struct btrfs_root *quota_root =3D fs_info->quota_root;
> +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> +	struct btrfs_super_block *sb =3D fs_info->super_copy;
> +	int super_flags =3D btrfs_super_incompat_flags(sb);
> +	struct btrfs_trans_handle *trans;
> +
> +	trans =3D btrfs_start_transaction(quota_root, 0);
> +	ret =3D btrfs_clear_tree(trans, quota_root);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +
> +	ret =3D btrfs_delete_and_free_root(trans, quota_root);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +	fs_info->quota_root =3D NULL;
> +	super_flags &=3D ~BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA;
> +	btrfs_set_super_incompat_flags(sb, super_flags);
> +	btrfs_commit_transaction(trans, tree_root);
> +	return 0;
> +}
> +
> +/*
> + * Given a pointer (ptr) into DATAi (i =3D slot), and an amount to shif=
t,
> + * move all the data to the left (slots >=3D slot) of that ptr to the r=
ight by
> + * the shift amount. This overwrites the shift bytes after ptr, effecti=
vely
> + * removing them from the item data. We must update affected item sizes=
 (only
> + * at slot) and offsets (slots >=3D slot).
> + *
> + * Leaf view, using '-' to show shift scale:
> + * Before:
> + * [ITEM0,...,ITEMi,...,ITEMn,-------,DATAn,...,[---DATAi---],...,DATA0=
]
> + * After:
> + * [ITEM0,...,ITEMi,...,ITEMn,--------,DATAn,...,[--DATAi---],...,DATA0=
]
> + *
> + * Zooming in on DATAi
> + * (ptr points at the start of the Ys, and shift is length of the Ys)
> + * Before:
> + * ...[DATAi+1][XXXXXXXXXXXXYYYYYYYYYYYYYYYYXXXXXXX][DATAi-1]...
> + * After:
> + * ...................[DATAi+1][XXXXXXXXXXXXXXXXXXX][DATAi-1]...
> + * Note that DATAi-1 and smaller are not affected.
> + */
> +static void shift_leaf_data(struct btrfs_trans_handle *trans,
> +			    struct extent_buffer *leaf, int slot,
> +			    unsigned long ptr, u32 shift)
> +{
> +	u32 nr =3D btrfs_header_nritems(leaf);
> +	u32 leaf_data_off =3D btrfs_item_ptr_offset(leaf, nr - 1);
> +	u32 len =3D ptr - leaf_data_off;
> +	u32 new_size =3D btrfs_item_size(leaf, slot) - shift;
> +	for (int i =3D slot; i < nr; i++) {
> +		u32 old_item_offset =3D btrfs_item_offset(leaf, i);
> +		btrfs_set_item_offset(leaf, i, old_item_offset + shift);
> +	}

IIRC you can just handle the memmove inside the item, then let
btrfs_truncate_item() to do all the remaining work.

Although I'm not sure if it's really going to save any code.

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +	memmove_extent_buffer(leaf, leaf_data_off + shift, leaf_data_off, len)=
;
> +	btrfs_set_item_size(leaf, slot, new_size);
> +	btrfs_set_header_generation(leaf, trans->transid);
> +	btrfs_mark_buffer_dirty(leaf);
> +}
> +
> +/*
> + * Iterate over the extent tree and for each EXTENT_DATA item that has =
an inline
> + * ref of type OWNER_REF, shift that leaf to eliminate the owner ref.
> + *
> + * Note: we use a search_slot per leaf rather than find_next_leaf to ge=
t the
> + * needed CoW-ing and rebalancing for each leaf and its path up to the =
root.
> + */
> +static int remove_owner_refs(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_root *extent_root;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_path path =3D { 0 };
> +	int slot;
> +	int ret;
> +
> +	extent_root =3D btrfs_extent_root(fs_info, 0);
> +
> +	trans =3D btrfs_start_transaction(extent_root, 0);
> +
> +	key.objectid =3D 0;
> +	key.type =3D BTRFS_EXTENT_ITEM_KEY;
> +	key.offset =3D 0;
> +
> +search_slot:
> +	ret =3D btrfs_search_slot(trans, extent_root, &key, &path, 1, 1);
> +	if (ret < 0)
> +		return ret;
> +	leaf =3D path.nodes[0];
> +	slot =3D path.slots[0];
> +
> +	while (1) {
> +		struct btrfs_key found_key;
> +		struct btrfs_extent_item *ei;
> +		struct btrfs_extent_inline_ref *iref;
> +		u8 type;
> +		unsigned long ptr;
> +		unsigned long item_end;
> +
> +		if (slot >=3D btrfs_header_nritems(leaf)) {
> +			ret =3D btrfs_next_leaf(extent_root, &path);
> +			if (ret < 0) {
> +				break;
> +			} else if (ret) {
> +				ret =3D 0;
> +				break;
> +			}
> +			leaf =3D path.nodes[0];
> +			slot =3D path.slots[0];
> +			btrfs_item_key_to_cpu(leaf, &key, slot);
> +			btrfs_release_path(&path);
> +			goto search_slot;
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, slot);
> +		if (found_key.type !=3D BTRFS_EXTENT_ITEM_KEY)
> +			goto next;
> +		ei =3D btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
> +		ptr =3D (unsigned long)(ei + 1);
> +		item_end =3D (unsigned long)ei + btrfs_item_size(leaf, slot);
> +		/* No inline extent references; accessing type is invalid. */
> +		if (ptr > item_end)
> +			goto next;
> +		iref =3D (struct btrfs_extent_inline_ref *)ptr;
> +		type =3D btrfs_extent_inline_ref_type(leaf, iref);
> +		if (type =3D=3D BTRFS_EXTENT_OWNER_REF_KEY)
> +			shift_leaf_data(trans, leaf, slot, ptr, sizeof(*iref));
> +next:
> +		slot++;
> +	}
> +	btrfs_release_path(&path);
> +
> +	ret =3D btrfs_commit_transaction(trans, extent_root);
> +	if (ret < 0) {
> +		errno =3D -ret;
> +		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +int remove_squota(struct btrfs_fs_info *fs_info)
> +{
> +	int ret;
> +
> +	ret =3D remove_owner_refs(fs_info);
> +	if (ret)
> +		return ret;
> +
> +	return remove_quota_tree(fs_info);
> +}
> +
>   static int create_qgroup(struct btrfs_fs_info *fs_info,
>   			 struct btrfs_trans_handle *trans,
>   			 u64 qgroupid)
> diff --git a/tune/tune.h b/tune/tune.h
> index 397cfe4f3..a41ba78b7 100644
> --- a/tune/tune.h
> +++ b/tune/tune.h
> @@ -33,5 +33,6 @@ int convert_to_extent_tree(struct btrfs_fs_info *fs_in=
fo);
>   int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum=
_type);
>
>   int enable_quota(struct btrfs_fs_info *fs_info, bool simple);
> +int remove_squota(struct btrfs_fs_info *fs_info);
>
>   #endif

