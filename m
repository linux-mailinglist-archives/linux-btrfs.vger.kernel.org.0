Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8282719C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jul 2019 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbfGWNwz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Jul 2019 09:52:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfGWNwy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Jul 2019 09:52:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28098AEB8;
        Tue, 23 Jul 2019 13:52:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E7AF1DA7D5; Tue, 23 Jul 2019 15:53:30 +0200 (CEST)
Date:   Tue, 23 Jul 2019 15:53:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2 RESEND Rebased] btrfs-progs: add readmirror policy
Message-ID: <20190723135330.GC2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190626083402.1895-1-anand.jain@oracle.com>
 <20190626083723.2094-1-anand.jain@oracle.com>
 <20190626083723.2094-2-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083723.2094-2-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 26, 2019 at 04:37:23PM +0800, Anand Jain wrote:
> This sets the readmirror=<parm> as a btrfs.<attr> extentded attribute.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  props.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/props.c b/props.c
> index 3a498bd9e904..1d1a2c7f9d14 100644
> --- a/props.c
> +++ b/props.c
> @@ -178,6 +178,53 @@ out:
>  	return ret;
>  }
>  
> +static int prop_readmirror(enum prop_object_type type, const char *object,
> +			   const char *name, const char *value)
> +{
> +	int fd;
> +	int ret;
> +	char buf[256] = {0};
> +	char *xattr_name;
> +	DIR *dirstream = NULL;
> +
> +	fd = open_file_or_dir3(object, &dirstream, value ? O_RDWR : O_RDONLY);
> +	if (fd < 0) {
> +		ret = -errno;
> +		error("failed to open %s: %m", object);
> +		return ret;
> +	}
> +
> +	xattr_name = alloc_xattr_name(name);
> +	if (IS_ERR(xattr_name)) {
> +		error("failed to alloc xattr_name %s: %m", object);
> +		return PTR_ERR(xattr_name);
> +	}
> +
> +	ret = 0;
> +	if (value) {
> +		if (fsetxattr(fd, xattr_name, value, strlen(value), 0) < 0) {
> +			ret = -errno;
> +			error("failed to set readmirror for %s: %m", object);
> +		}
> +	} else {
> +		if (fgetxattr(fd, xattr_name, buf, 256) < 0) {
> +			if (errno != ENOATTR) {
> +				ret = -errno;
> +				error("failed to get readmirror for %s: %m",
> +				      object);
> +			}
> +		} else {
> +			fprintf(stdout, "readmirror=%.*s\n", (int) strlen(buf),
> +				buf);
> +		}
> +	}
> +
> +	free(xattr_name);
> +	close_file_or_dir(fd, dirstream);
> +
> +	return ret;
> +}
> +
>  const struct prop_handler prop_handlers[] = {
>  	{"ro", "Set/get read-only flag of subvolume.", 0, prop_object_subvol,
>  	 prop_read_only},
> @@ -185,5 +232,7 @@ const struct prop_handler prop_handlers[] = {
>  	 prop_object_dev | prop_object_root, prop_label},
>  	{"compression", "Set/get compression for a file or directory", 0,
>  	 prop_object_inode, prop_compression},
> +	{"readmirror", "set/get readmirror policy for filesystem", 0,
> +	 prop_object_root, prop_readmirror},

For some unknown reason the object type for filesystem-wide props is
called prop_object_root, which is correct, but it got me confused first.

So the most reliable way to set it is

  $ btrfs prop set -t filesystem /path readmirror <VALUE>

and

  $ btrfs prop set /path readmirror <VALUE>

will auto-detect the object type by /path, but I'm not sure what exactly
does it do in case it's a mount point but not the toplevel subvolume.
