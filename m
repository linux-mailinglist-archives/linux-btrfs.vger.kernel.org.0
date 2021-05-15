Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA47381536
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 04:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhEOCnd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 22:43:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:50229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhEOCnc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 22:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621046538;
        bh=6CjLizQilmYGIvyG/cCbdMCgioblCUK/HjVkfH8Zl9Q=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=WgtjNufdjub85JXIsqD82ijaR4rhNydBJzv/jlknZgY+mPScAH2PnjSBMPr6jFjgu
         RkHc2+mLSKZcIypb5CeCC6zLlQqcKKnLCweVWsPsgM46VLbiwUjSdaawknyOo6WHdo
         GwMGNq4+Qda1/JSHy1KWUaEnHbfXOu48k3aRpbpI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MBm1e-1lnDNN3HfI-00CAzM; Sat, 15
 May 2021 04:42:18 +0200
Subject: Re: [PATCH] btrfs-progs: subvolume: destroy associated qgroup when
 delete subvolume
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org
References: <20210515023624.8065-1-realwakka@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <7702abe4-f150-44c0-8328-f62d68f5a56c@gmx.com>
Date:   Sat, 15 May 2021 10:42:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515023624.8065-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CXg8Z02es+ZPuJEV5LFDrpf7d9t0BYSywSc1xRx2Tz9fakzkVlY
 zlDWKy4zVBjgrCW+uv7tlZ0SoGQXSHdYoAuR1Ff7OvhQFvXjHUgxToLg8I+Czi4mytO6ro3
 kuypGqO+Lz4qS79n0O7jG2NnbessHtOtdVfxBogBsZoEjJjfC/fARw0xgTAt5k2oo0XUWTt
 24PVipWFyxbBojOHrKnvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+21jARxLDJc=:pw/RtW2JHLrSxxbtt3+q3g
 lQEB/3KsXO8VkLpAChe1MaaLYxttmj/ZjFuIC2iVYGAvnwByBPfwTBqKJb/VNzrkLwKft6wd7
 U7SFWwjB7SUj/KPGkOymPHhqoXCqoj3b4FQ1U42gNsHFbLZlneIvmESx7H2+khLTVfvSHFJwf
 LqkMzTShjte2UBwShm5OxFk4vD9fR3lNwClC9NHsYdSHppLKDQkoV3hjpG1KbfAlV9hqzPOEb
 v2koo9a4BUMEySn9bIL/2u6wqjVW+d2X5JzO3SvaRMLgNFdJ+l0RCia1VgfST/J28SeR/9ZZx
 8sz+BrNrM6i0NwRmugk/xn1m9ZBxJgf8JYsCQ9bbVgC3IiMNX7Fx7eYp13AOtc5ZoaTMsKw6C
 XHa72i/lKZu0D7f6rJJZXVIKOp8/yB00p+9WhHOfC49L1yaNFYbXP1uws3X2NIXJJTL12sqYG
 K2BwEHXlJJNvrLpGITbdCt72LT5XJrm1HaixoVXW+3FxoBZfMQvVbWJtBB7bgKRXS8DT+GoIm
 RzXYkV4fI3SlkSyhUz85N+EvR1/ACweN4rnCJRQOrER5dG6DZHN/bot1eFXjJsT7/4um91YO3
 9qSXhk4zP8T6e1nMjyFOClE1bmaE74PVw/roeJMbCZ6RMCHWZXVC+Tv8sTghjDf/hpbpU/SUa
 pFaXd2MefKBbSLbTJhdTXdVWh8ZW5mg2zjU+R5Zc8S0ljshGUZLkFV5k+bC7BeBnzkRzEZDKf
 RmHGyjL2MALvTRvtESIxDYVFFOa6Z4sf0jIMm3wmOZv5qdpt9ILpz570eg5bh5SHQRgQxXgwl
 bS/cDWvMh1KhKiv4Ta5m8m/6mq5GmGJDHm3XmJOJMdakgKCGgwkE7YR2sHY2XEU3IGJjLsmGo
 DFpkhemQ8SHd5wiLuJ+VoRJWZTUxwWUeLooxZphZiy5WEMyHqpeBDxuSH6zujG+NB+hQ8Fo2n
 WMfNN621LTFukF2KH5u6kYFNcLLUIh6a/i6AHG+KyFFXuD3eTuQiBb/vB+VTdqUhbSr1NA7hG
 HYCaPnMcLd3uE85keHYg6sXBSSkuCMSct9uP/gOfXhMvRleQMpWIUyaQv5rGxa3AfyowB+u9G
 mpBLcIqJFteFyiNnePY64njIfnFK4PIxtovLiYbSli3BVq4ew9GjXSzsoT9vnjTfvRjh0IBTC
 ruc4kRbuPEy+yoBIK1S+ZdnzOxnUMALKmD6N0i5CD+RV1st2iS9Tl13u6I7CdCFuf4DbyqqEA
 rQYjNLNPOTYuDGIVX
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/15 =E4=B8=8A=E5=8D=8810:36, Sidong Yang wrote:
> This patch adds the options --delete-qgroup and --no-delete-qgroup. When
> the option is enabled, delete subvolume command destroies associated
> qgroup together. This patch make it as default option. Even though quota
> is disabled, it enables quota temporary and restore it after.

No, this is not a good idea at all.

First thing first, if quota is disabled, all qgroup info including the
level 0 qgroups will also be deleted, thus no need to enable in the
first place.

Secondly, there is already a patch in the past to delete level 0 qgroups
in kernel space, which should be a much better solution.

I didn't remember when, but I'm pretty sure I did send out such patch in
the past.

Maybe it's time to revive the patch now.

Thanks,
Qu

>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>
> I wrote a patch that adds command to delete associated qgroup when
> delete subvolume together. It also works when quota disabled. How it
> works is enable quota temporary and restore it. I don't know it's good
> way. Is there any better way than this?
>
>   cmds/subvolume.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>
> diff --git a/cmds/subvolume.c b/cmds/subvolume.c
> index 9bd17808..18c75083 100644
> --- a/cmds/subvolume.c
> +++ b/cmds/subvolume.c
> @@ -239,6 +239,8 @@ static const char * const cmd_subvol_delete_usage[] =
=3D {
>   	"-c|--commit-after      wait for transaction commit at the end of the=
 operation",
>   	"-C|--commit-each       wait for transaction commit after deleting ea=
ch subvolume",
>   	"-i|--subvolid          subvolume id of the to be removed subvolume",
> +	"--delete-qgroup        delete associated qgroup together",
> +	"--no-delete-qgroup     don't delete associated qgroup",
>   	"-v|--verbose           deprecated, alias for global -v option",
>   	HELPINFO_INSERT_GLOBALS,
>   	HELPINFO_INSERT_VERBOSE,
> @@ -266,14 +268,18 @@ static int cmd_subvol_delete(const struct cmd_stru=
ct *cmd,
>   	enum { COMMIT_AFTER =3D 1, COMMIT_EACH =3D 2 };
>   	enum btrfs_util_error err;
>   	uint64_t default_subvol_id =3D 0, target_subvol_id =3D 0;
> +	bool delete_qgroup =3D false;
>
>   	optind =3D 0;
>   	while (1) {
>   		int c;
> +		enum { GETOPT_VAL_DEL_QGROUP =3D 256, GETOPT_VAL_NO_DEL_QGROUP };
>   		static const struct option long_options[] =3D {
>   			{"commit-after", no_argument, NULL, 'c'},
>   			{"commit-each", no_argument, NULL, 'C'},
>   			{"subvolid", required_argument, NULL, 'i'},
> +			{"delete-qgroup", no_argument, NULL, GETOPT_VAL_DEL_QGROUP},
> +			{"no-delete-qgroup", no_argument, NULL, GETOPT_VAL_NO_DEL_QGROUP},
>   			{"verbose", no_argument, NULL, 'v'},
>   			{NULL, 0, NULL, 0}
>   		};
> @@ -295,6 +301,12 @@ static int cmd_subvol_delete(const struct cmd_struc=
t *cmd,
>   		case 'v':
>   			bconf_be_verbose();
>   			break;
> +		case GETOPT_VAL_DEL_QGROUP:
> +			delete_qgroup =3D true;
> +			break;
> +		case GETOPT_VAL_NO_DEL_QGROUP:
> +			delete_qgroup =3D false;
> +			break;
>   		default:
>   			usage_unknown_option(cmd, argv);
>   		}
> @@ -388,6 +400,44 @@ again:
>   		goto out;
>   	}
>
> +	if (delete_qgroup) {
> +		struct btrfs_ioctl_qgroup_create_args args;
> +		memset(&args, 0, sizeof(args));
> +		args.create =3D 0;
> +		args.qgroupid =3D target_subvol_id;
> +
> +		if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
> +			if (errno =3D=3D ENOTCONN) {
> +				struct btrfs_ioctl_quota_ctl_args quota_ctl_args;
> +				quota_ctl_args.cmd =3D BTRFS_QUOTA_CTL_ENABLE;
> +				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &quota_ctl_args) < 0) {
> +					error("unable to enable quota: %s",
> +						  strerror(errno));
> +					goto out;
> +				}
> +
> +				if (ioctl(fd, BTRFS_IOC_QGROUP_CREATE, &args) < 0) {
> +					quota_ctl_args.cmd =3D BTRFS_QUOTA_CTL_DISABLE;
> +					ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args);
> +					error("unable to destroy quota group: %s",
> +						  strerror(errno));
> +					goto out;
> +				}
> +
> +				quota_ctl_args.cmd =3D BTRFS_QUOTA_CTL_DISABLE;
> +				if (ioctl(fd, BTRFS_IOC_QUOTA_CTL, &args) < 0) {
> +					error("unable to disable quota: %s",
> +						  strerror(errno));
> +					goto out;
> +				}
> +			} else {
> +				error("unable to destroy quota group: %s",
> +					  strerror(errno));
> +				goto out;
> +			}
> +		}
> +	}
> +
>   	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
>   		commit_mode =3D=3D COMMIT_EACH ||
>   		(commit_mode =3D=3D COMMIT_AFTER && cnt + 1 =3D=3D argc) ?
> @@ -412,6 +462,7 @@ again:
>   		goto out;
>   	}
>
> +
>   	if (commit_mode =3D=3D COMMIT_EACH) {
>   		res =3D wait_for_commit(fd);
>   		if (res < 0) {
>
