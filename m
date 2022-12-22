Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B756540A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Dec 2022 13:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiLVMDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Dec 2022 07:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiLVMDH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Dec 2022 07:03:07 -0500
Received: from out20-74.mail.aliyun.com (out20-74.mail.aliyun.com [115.124.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC152B606
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Dec 2022 03:55:13 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04470089|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00492728-0.000428478-0.994644;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.QbMtD5O_1671710110;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.QbMtD5O_1671710110)
          by smtp.aliyun-inc.com;
          Thu, 22 Dec 2022 19:55:11 +0800
Date:   Thu, 22 Dec 2022 19:55:12 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 1/2] btrfs-progs: fi show: Print missing device for a mounted file system
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <20210910083344.1876661-1-nborisov@suse.com>
References: <20210910083344.1876661-1-nborisov@suse.com>
Message-Id: <20221222195511.A9F8.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

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
> 	devid    2 size 0 used 0 path /dev/loop1 MISSING
> 
> This is a lot more usable output as it presents the user with the id
> of the missing device and its path.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V2:
>  * Removed stars around MISSING
>  cmds/filesystem.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index db8433ba3542..dadd4c82a9b0 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -295,7 +295,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
>  {
>  	int i;
>  	int fd;
> -	int missing = 0;
>  	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
>  	struct btrfs_ioctl_dev_info_args *tmp_dev_info;
>  	int ret;
> @@ -325,8 +324,10 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
>  		/* Add check for missing devices even mounted */
>  		fd = open((char *)tmp_dev_info->path, O_RDONLY);
>  		if (fd < 0) {
> -			missing = 1;
> +			printf("\tdevid %4llu size 0 used 0 path %s MISSING\n",
> +					tmp_dev_info->devid, tmp_dev_info->path);
>  			continue;
> +
>  		}
>  		close(fd);
>  		canonical_path = path_canonicalize((char *)tmp_dev_info->path);
> @@ -339,8 +340,6 @@ static int print_one_fs(struct btrfs_ioctl_fs_info_args *fs_info,
>  		free(canonical_path);
>  	}
> 
> -	if (missing)
> -		printf("\t*** Some devices missing\n");
>  	printf("\n");
>  	return 0;
>  }

Need we also fix print_one_uuid()/print_devices()?

There is
        pr_verbose(LOG_DEFAULT, "\t*** Some devices missing\n");
in print_one_uuid();

sorry that there is yet not a fix here.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/12/22


