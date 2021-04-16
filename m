Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA11362711
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbhDPRnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 13:43:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43856 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243431AbhDPRm7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 13:42:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9ADCB2F0;
        Fri, 16 Apr 2021 17:42:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CF163DA790; Fri, 16 Apr 2021 19:40:15 +0200 (CEST)
Date:   Fri, 16 Apr 2021 19:40:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/3] btrfs-progs: image: enlarge the output file if no
 tree modification is needed for restore
Message-ID: <20210416174015.GG7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <20210326125047.123694-1-wqu@suse.com>
 <20210326125047.123694-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326125047.123694-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 26, 2021 at 08:50:46PM +0800, Qu Wenruo wrote:
> [BUG]
> If restoring dumpped image into a new file, under most cases kernel will
> reject it:
> 
>  # mkfs.btrfs -f /dev/test/test
>  # btrfs-image /dev/test/test /tmp/dump
>  # btrfs-image -r /tmp/dump ~/test.img
>  # mount ~/test.img /mnt/btrfs
>  mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>  # dmesg -t | tail -n 7
>  loop0: detected capacity change from 10592 to 0
>  BTRFS info (device loop0): disk space caching is enabled
>  BTRFS info (device loop0): has skinny extents
>  BTRFS info (device loop0): flagging fs with big metadata feature
>  BTRFS error (device loop0): device total_bytes should be at most 5423104 but found 10737418240
>  BTRFS error (device loop0): failed to read chunk tree: -22
>  BTRFS error (device loop0): open_ctree failed
> 
> [CAUSE]
> When btrfs-image restores an image into a file, and the source image
> contains only single device, then we don't need to modify the
> chunk/device tree, as we can reuse the existing chunk/dev tree without
> any problem.
> 
> This also means, for such restore, we also won't do any target file
> enlarge. This behavior itself is fine, as at that time, kernel won't
> check if the device is smaller than the device size recorded in device
> tree.
> 
> But later kernel commit 3a160a933111 ("btrfs: drop never met disk total
> bytes check in verify_one_dev_extent") introduces new check on device
> size at mount time, rejecting any loop file which is smaller than the
> original device size.
> 
> [FIX]
> Do extra file enlarge for single device restore.
> 
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  image/main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/image/main.c b/image/main.c
> index 24393188e5e3..9933f69d0fdb 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -2706,6 +2706,49 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
>  		close_ctree(info->chunk_root);
>  		if (ret)
>  			goto out;
> +	} else {
> +		struct btrfs_root *root;
> +		struct stat st;
> +		u64 dev_size;
> +
> +		if (!info) {
> +			root = open_ctree_fd(fileno(out), target, 0, 0);
> +			if (!root) {
> +				error("open ctree failed in %s", target);
> +				ret = -EIO;
> +				goto out;
> +			}
> +
> +			info = root->fs_info;
> +
> +			dev_size = btrfs_stack_device_total_bytes(
> +					&info->super_copy->dev_item);
> +			close_ctree(root);
> +			info = NULL;
> +		} else {
> +			dev_size = btrfs_stack_device_total_bytes(
> +					&info->super_copy->dev_item);
> +		}
> +
> +		/*
> +		 * We don't need extra tree modification, but if the output is
> +		 * a file, we need to enlarge the output file so that
> +		 * newer kernel won't report error.
> +		 */
> +		ret = fstat(fileno(out), &st);
> +		if (ret < 0) {
> +			error("failed to stat result image: %m");
> +			ret = -errno;
> +			goto out;
> +		}
> +		if (S_ISREG(st.st_mode)) {
> +			ret = ftruncate64(fileno(out), dev_size);

This truncates the file unconditionally, so if the file is larger than
required, I don't think it's necessary to do it.
