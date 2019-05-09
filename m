Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21618BB0
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 16:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIO0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 10:26:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:42674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfEIO0U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 10:26:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D3466ABD4;
        Thu,  9 May 2019 14:26:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46A47DA8DC; Thu,  9 May 2019 16:27:16 +0200 (CEST)
Date:   Thu, 9 May 2019 16:27:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: run delayed iput at unlink time
Message-ID: <20190509142714.GT20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190507172734.93994-1-josef@toxicpanda.com>
 <7147863c-dfe0-573c-18cc-f9284fd30f39@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7147863c-dfe0-573c-18cc-f9284fd30f39@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 08, 2019 at 10:15:16AM +0300, Nikolay Borisov wrote:
> > +	if (!list_empty(&inode->delayed_iput)) {
> > +		spin_lock(&fs_info->delayed_iput_lock);
> > +		if (!list_empty(&inode->delayed_iput)) {
> > +			list_del_init(&inode->delayed_iput);
> > +			spin_unlock(&fs_info->delayed_iput_lock);
> > +			iput(&inode->vfs_inode);
> > +			if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
> > +				wake_up(&fs_info->delayed_iputs_wait);
> > +		} else {
> > +			spin_unlock(&fs_info->delayed_iput_lock);
> > +		}
> > +	}
> 
> OTOH this really feels like a hack and this stems from the fact that
> iput is rather rudimentary. Additionally you are essentially opencoding
> the body of btrfs_run_delayed_iputs. I was going to suggest to introduce
> a new helper factoring out the common code but it will get ugly due to
> the spin lock being dropped before doing the iput.

Yeah this should be in a helper, something like

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3286,6 +3286,26 @@ void btrfs_add_delayed_iput(struct inode *inode)
                wake_up_process(fs_info->cleaner_kthread);
 }
 
+static void run_delayed_iput_now(struct inode *inode)
+{
+       list_del_init(&inode->delayed_iput);
+       spin_unlock(&fs_info->delayed_iput_lock);
+       iput(&inode->vfs_inode);
+       if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
+               wake_up(&fs_info->delayed_iputs_wait);
+       spin_lock(&fs_info->delayed_iput_lock);
+}
+
+void btrfs_run_delayed_iput_now(struct inode *inode)
+{
+       spin_lock(&fs_info->delayed_iput_lock);
+       if (list_empty(&inode->delayed_iput))
+               goto out_unlock;
+       run_delayed_iput_now(inode);
+out_unlock:
+       unspin_lock(&fs_info->delayed_iput_lock);
+}
+
 void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 {
 
@@ -3295,12 +3315,8 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 
                inode = list_first_entry(&fs_info->delayed_iputs,
                                struct btrfs_inode, delayed_iput);
-               list_del_init(&inode->delayed_iput);
-               spin_unlock(&fs_info->delayed_iput_lock);
-               iput(&inode->vfs_inode);
-               if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
-                       wake_up(&fs_info->delayed_iputs_wait);
-               spin_lock(&fs_info->delayed_iput_lock);
+
+               run_delayed_iput_now(inode);
        }
        spin_unlock(&fs_info->delayed_iput_lock);
 }
---

The delayed_iput_lock is not that contended so that the first check needs to be
done unlocked. There are only list manipulations in the critical section.

The above does one unnecessary lock/unlock in case the standalone
delayed iput is called, I don't see a cleaner way now.
