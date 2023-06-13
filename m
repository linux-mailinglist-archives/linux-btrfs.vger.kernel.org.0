Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8180672E015
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjFMKuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242044AbjFMKtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:49:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7A2E55
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686653383; x=1687258183; i=quwenruo.btrfs@gmx.com;
 bh=YFokjr8tma/ItH3rQjJGW/sDYl4/6Np7r8rBXX49qts=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=rfbfzOv9JG2W/sxH8el4z3LM0jE3/rBcUPDQKljfw8V5lEK4GyugJVOz2h3AM2gYIZ3uOal
 R4mUYVyrGnaim8Rlh2q9gceBYk3j47bYHSa3hmLJS4nCzWKFWFcxM1g9+RES+5DMqwgK12tuy
 G2+KMn5i3waWWKUcMw5xERMxZK+ygw+HUYvWV+qy3PdOmGTVgZcoNQuTvpw/91o7i7RZJtnix
 qdP3jzlwqZbU6k8udq6QlH+RENqbMd+77oSP21yZT+sVdjb2ScrelfpEECBQiyoZOf8veUdUy
 zCqs4tWWCthNfJ2xiYnbyunuaD7SlZq/7remASi5lVaIkNM2ICtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkYc0-1piFIX0bPC-00m1KW; Tue, 13
 Jun 2023 12:49:43 +0200
Message-ID: <d476640a-d6e7-2add-e440-f82e4fe2a8c7@gmx.com>
Date:   Tue, 13 Jun 2023 18:49:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/7] btrfs-progs: factor out btrfs_scan_argv_devices
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686484067.git.anand.jain@oracle.com>
 <e635739e6aa18e70036ddcf63019cf0e4d4493b0.1686484067.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <e635739e6aa18e70036ddcf63019cf0e4d4493b0.1686484067.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i3wuCOWjdiz6iHKWkBpLwyi28EsKpW8h8X/GeMht/NnpGrfpmkm
 IYz6F2iIjjeuJtFxYbl14L6eNbECYkZHWtvWM6HHUy/4EotZXIPsgIoTSUik25Pldf4rjZv
 rrEhNMzw7u9WRkO0aJ12LtRT1m4AK6TKEzoP99e8gVNzYVs/hqHfW+5p44srR2UL8Ga9Gj5
 RlAncLCfANtGlibthgI4A==
UI-OutboundReport: notjunk:1;M01:P0:xdLmntyPLbE=;yhDPw9kfdLpxR8K0CfXUUs88+16
 jD89lD/QfvR3EDI93h43tAnnPgjVr7juxLhzqbEqTvDhp3qw5p4MmK/P9P+t7/Zy3T4uYgIgG
 x2oAPDvvZkPjQ2FJBMzRylrVpvwLBt1HlTUBo0MjxqwO9UDgwAUEtQHhDfRsfjBohadE9U904
 /sVxi9olrKC8eUCorE6R/gF1yvI3V1/kvg1ydb9hChgu60Q8ER7PLLJxfrmWaO4mfi86FxGgP
 6t1sBhw1nR9Mvnkp4aVxuPt+q8HIvn6py2k5ktP+rgSR/sm6OYhl3Ii5QidO9HAX5XKBZlfFZ
 3IgOO/yToHqDwltDbtF+yyZSYf8o4QATC85OaVYa3H9COIepY+yaGOeROdaWgkcL+Aa+cOVx0
 7IvUXirxGap6R3KcqfU84WYWb6F3wxarbqauD3IzHtZRnSNpUWUSl9dNGh24SdYTj96MTh2+g
 oXLCXxy2r7eNaDmbNpBgFITq2yXRXnAu+9ubgzYwD0ajIBV7fCTbogLyCeH1zM1/UZenUcM9s
 fO2twg0Ko74k0zpK+FWVY7bnK5wT4h5rdO5Ifpy9uzNHt7BM1l0CNYmXlVywIwNPM6EDHw3OY
 JnRa0CflXIMWf3zp4gMKDY7lQjgD2BBqkFewKu0uFo/z04i2Fb3Vkzy8pM8MeKc5nP2A5jLjh
 hhbZQCFaiK7KRPe7D+xAJ83sRoumsi5zJUYBu0h4qkvf8p+vIit0Eu9Bhuyx9EL27/Cc4Tsku
 +rrdrJsqwLcIDI1T8p8LZqU9zKRGjbQrsqfaJqzmwpb9+TZoZXg/OUvLWCVoDdFG1Uk6jwCxD
 CnV9iO0P+w0d0rt3aZxYleNRoWMa+m3803NS+E9pZ59sd1kULS5Q3OKLp5wNL70DsmDv8Knh/
 batklcHsJRpWSWlJifZwtEGeMMdhgYEiIbNJlc3qs/LV4GdO5zMlaN0O9O8OE8XH1jnxN77ll
 QH7asXlWwYj2Z8KU0N2iDlxt3Ik=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/13 18:26, Anand Jain wrote:
> To prepare for handling command line given devices factor out
> btrfs_scan_argv_devices().

Is there something wrong with the thread?

This patch is showing 5/7 but the next is only 6/6.

The same problem happens to your tune patchset too, which seems worse,
as what I got is 1/5, 1/1, 3/5, 3/5 and 5/5.

Thanks,
Qu
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3: Rename args of btrfs_scan_argv_devices()
>      Rename factored out function name from btrfs_scan_sdin_devices()
>       to btrfs_scan_argv_devices()
>
>   cmds/inspect-dump-tree.c | 37 +++----------------------------------
>   common/device-scan.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>   common/device-scan.h     |  1 +
>   3 files changed, 44 insertions(+), 34 deletions(-)
>
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index 1d2a785ac5c3..50b792bbc4e7 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -327,7 +327,6 @@ static int cmd_inspect_dump_tree(const struct cmd_st=
ruct *cmd,
>   	bool roots_only =3D false;
>   	bool root_backups =3D false;
>   	int traverse =3D BTRFS_PRINT_TREE_DEFAULT;
> -	int dev_optind;
>   	u64 block_bytenr;
>   	struct btrfs_root *tree_root_scan;
>   	u64 tree_id =3D 0;
> @@ -455,39 +454,9 @@ static int cmd_inspect_dump_tree(const struct cmd_s=
truct *cmd,
>   	if (check_argc_min(argc - optind, 1))
>   		return 1;
>
> -	dev_optind =3D optind;
> -	while (dev_optind < argc) {
> -		int fd;
> -		struct btrfs_fs_devices *fs_devices;
> -		u64 num_devices;
> -
> -		ret =3D check_arg_type(argv[optind]);
> -		if (ret !=3D BTRFS_ARG_BLKDEV && ret !=3D BTRFS_ARG_REG) {
> -			if (ret < 0) {
> -				errno =3D -ret;
> -				error("invalid argument %s: %m", argv[dev_optind]);
> -			} else {
> -				error("not a block device or regular file: %s",
> -				       argv[dev_optind]);
> -			}
> -		}
> -		fd =3D open(argv[dev_optind], O_RDONLY);
> -		if (fd < 0) {
> -			error("cannot open %s: %m", argv[dev_optind]);
> -			return -EINVAL;
> -		}
> -		ret =3D btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
> -					    &num_devices,
> -					    BTRFS_SUPER_INFO_OFFSET,
> -					    SBREAD_DEFAULT);
> -		close(fd);
> -		if (ret < 0) {
> -			errno =3D -ret;
> -			error("device scan %s: %m", argv[dev_optind]);
> -			return ret;
> -		}
> -		dev_optind++;
> -	}
> +	ret =3D btrfs_scan_argv_devices(optind, argc, argv);
> +	if (ret)
> +		return ret;
>
>   	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
>
> diff --git a/common/device-scan.c b/common/device-scan.c
> index 515481a6efa9..68b94ecd9d77 100644
> --- a/common/device-scan.c
> +++ b/common/device-scan.c
> @@ -500,3 +500,43 @@ int btrfs_scan_devices(int verbose)
>   	return 0;
>   }
>
> +int btrfs_scan_argv_devices(int dev_optind, int dev_argc, char **dev_ar=
gv)
> +{
> +	int ret;
> +
> +	while (dev_optind < dev_argc) {
> +		int fd;
> +		u64 num_devices;
> +		struct btrfs_fs_devices *fs_devices;
> +
> +		ret =3D check_arg_type(dev_argv[dev_optind]);
> +		if (ret !=3D BTRFS_ARG_BLKDEV && ret !=3D BTRFS_ARG_REG) {
> +			if (ret < 0) {
> +				errno =3D -ret;
> +				error("invalid argument %s: %m",
> +				      dev_argv[dev_optind]);
> +			} else {
> +				error("not a block device or regular file: %s",
> +				       dev_argv[dev_optind]);
> +			}
> +		}
> +		fd =3D open(dev_argv[dev_optind], O_RDONLY);
> +		if (fd < 0) {
> +			error("cannot open %s: %m", dev_argv[dev_optind]);
> +			return -EINVAL;
> +		}
> +		ret =3D btrfs_scan_one_device(fd, dev_argv[dev_optind], &fs_devices,
> +					    &num_devices,
> +					    BTRFS_SUPER_INFO_OFFSET,
> +					    SBREAD_DEFAULT);
> +		close(fd);
> +		if (ret < 0) {
> +			errno =3D -ret;
> +			error("device scan %s: %m", dev_argv[dev_optind]);
> +			return ret;
> +		}
> +		dev_optind++;
> +	}
> +
> +	return 0;
> +}
> diff --git a/common/device-scan.h b/common/device-scan.h
> index f805b489f595..0d0f081134f2 100644
> --- a/common/device-scan.h
> +++ b/common/device-scan.h
> @@ -58,5 +58,6 @@ int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsi=
d_hash[],
>   		int fd, DIR *dirstream);
>   void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
>   int test_uuid_unique(const char *uuid_str);
> +int btrfs_scan_argv_devices(int dev_optind, int argc, char **argv);
>
>   #endif
