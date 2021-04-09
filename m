Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC483593F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Apr 2021 06:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhDIEdX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 9 Apr 2021 00:33:23 -0400
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:35385 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhDIEdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 00:33:21 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05494806|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00596163-0.000229068-0.993809;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JxFh-fw_1617942764;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JxFh-fw_1617942764)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 09 Apr 2021 12:32:44 +0800
Date:   Fri, 09 Apr 2021 12:32:52 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Fox Chen <foxhlchen@gmail.com>
Subject: Re: [PATCH] btrfs-progs: utils: fix btrfs_wipe_existing_sb probe bug
Cc:     linux-btrfs@vger.kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <20210325131008.105629-1-foxhlchen@gmail.com>
References: <20210325131008.105629-1-foxhlchen@gmail.com>
Message-Id: <20210409123251.86BE.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> btrfs_wipe_existing_sb() misses calling blkid_do_fullprobe() to do
> the real probe. After calling blkid_new_probe() &
> blkid_probe_set_device() to setup blkid_probe context, it directly
> calls blkid_probe_lookup_value(). This results in
> blkid_probe_lookup_value returning -1, because pr->values is empty.
> 
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> ---
>  common/device-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index c860b946..f8e2e776 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -114,7 +114,7 @@ static int btrfs_wipe_existing_sb(int fd)
>  	if (!pr)
>  		return -1;
>  
> -	if (blkid_probe_set_device(pr, fd, 0, 0)) {
> +	if (blkid_probe_set_device(pr, fd, 0, 0) || blkid_do_fullprobe(pr)) {
>  		ret = -1;
>  		goto out;
>  	}
> -- 
> 2.31.0


With this patch,  'mkfs.btrfs -f /dev/nvme0n1 /dev/sdb' output some
error when /dev/nvme0n1 have 2 partitions.
	ERROR: cannot wipe superblocks on /dev/nvme0n1

# blkid
/dev/nvme0n1: PTUUID="93a54ce8-04b2-470b-8c05-31bfcef02f28" PTTYPE="gpt"
/dev/sda1: LABEL="OS_USB" UUID="2b7f4cb9-3dac-443f-8c96-a907b9276942" BLOCK_SIZE="512" TYPE="xfs" PARTUUID="ee58e9d3-01"
/dev/nvme0n1p1: UUID="1d94dc2b-abd1-47df-bf39-ab31cf579d29" UUID_SUB="577542b7-91f5-48d4-a54c-98cbd4525c00" BLOCK_SIZE="4096" TYPE="btrfs" PARTLABEL="primary" PARTUUID="efed009f-8ae6-4567-9cd3-80a57cdcf225"
/dev/nvme0n1p2: PARTLABEL="primary" PARTUUID="fcab66cd-daad-457f-a53c-110592d8941f"
...


Without this patch,  'mkfs.btrfs -f /dev/nvme0n1 /dev/sdb' have some
issue too when /dev/nvme0n1 and /dev/sdb  have some partitions.

some blkid of partition is still left in the output of blkid. 
'blockdev --rereadpt' will let them disappear.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/04/09


