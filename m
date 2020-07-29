Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6252324C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgG2SkC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 14:40:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgG2SkC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 14:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4256AAC82;
        Wed, 29 Jul 2020 18:40:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B18EEDA882; Wed, 29 Jul 2020 20:39:30 +0200 (CEST)
Date:   Wed, 29 Jul 2020 20:39:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Chris Murphy <chris@colorremedies.com>
Subject: Re: [PATCH][v2] btrfs: don't show full path of bind mounts in subvol=
Message-ID: <20200729183929.GC3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Chris Murphy <chris@colorremedies.com>
References: <20200722151246.3789-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722151246.3789-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 22, 2020 at 11:12:46AM -0400, Josef Bacik wrote:
> Chris Murphy reported a problem where rpm ostree will bind mount a bunch
> of things for whatever voodoo it's doing.  But when it does this
> /proc/mounts shows something like
> 
> /dev/mapper/vg0-lv0 /mnt/test btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo 0 0
> /dev/mapper/vg0-lv0 /mnt/test/baz btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo/bar 0 0
> 
> Despite subvolid=256 being subvol=/roo.  This is because we're just
> spitting out the dentry of the mount point, which in the case of bind
> mounts is the source path for the mountpoint.  Instead we should spit
> out the path to the actual subvol.  Fix this by looking up the name for
> the subvolid we have mounted.  With this fix the same test looks like
> this
> 
> /dev/mapper/vg0-lv0 /mnt/test btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo 0 0
> /dev/mapper/vg0-lv0 /mnt/test/baz btrfs rw,seclabel,relatime,ssd,space_cache,subvolid=256,subvol=/foo 0 0
> 
> Reported-by: Chris Murphy <chris@colorremedies.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - Dropped the RFC.
> - Added examples of before and after.
> 
>  fs/btrfs/super.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 58f890f73650..0e1647c08610 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1367,6 +1367,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  {
>  	struct btrfs_fs_info *info = btrfs_sb(dentry->d_sb);
>  	const char *compress_type;
> +	const char *subvol_name;
>  
>  	if (btrfs_test_opt(info, DEGRADED))
>  		seq_puts(seq, ",degraded");
> @@ -1453,8 +1454,12 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
>  		seq_puts(seq, ",ref_verify");
>  	seq_printf(seq, ",subvolid=%llu",
>  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
> -	seq_puts(seq, ",subvol=");
> -	seq_dentry(seq, dentry, " \t\n\\");
> +	subvol_name = btrfs_get_subvol_name_from_objectid(info,
> +			BTRFS_I(d_inode(dentry))->root->root_key.objectid);
> +	if (subvol_name) {
> +		seq_printf(seq, ",subvol=%s", subvol_name);
> +		kfree(subvol_name);
> +	}

Applied with this fixup

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1476,7 +1476,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
        subvol_name = btrfs_get_subvol_name_from_objectid(info,
                        BTRFS_I(d_inode(dentry))->root->root_key.objectid);
        if (subvol_name) {
-               seq_printf(seq, ",subvol=%s", subvol_name);
+               seq_puts(seq, ",subvol=");
+               seq_escape(seq, subvol_name, " \t\n\\");
                kfree(subvol_name);
        }
        return 0;

and added to misc-next, thanks.
