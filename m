Return-Path: <linux-btrfs+bounces-15187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17342AF06F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jul 2025 01:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2448485EFC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7DD302CAE;
	Tue,  1 Jul 2025 23:30:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out28-68.mail.aliyun.com (out28-68.mail.aliyun.com [115.124.28.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DB72601
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412601; cv=none; b=N3VmWKhtSdld5LpditD/oNzODWJ9+3oycNnmNOQ0s/vwxsAxBKK794PuA0I6ZtP4bbeNGQGuoPqMYKPa9y+/50Jp1oBu4S7EmwdHkqY2kU+QbhFlAudiV8ujT27x/a7vBii0+QniLZpVFof/aMhUIjWFSNBhhj+wIzXiOssC+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412601; c=relaxed/simple;
	bh=F5En6XYWNa9GVY/BANIyhXcFrdYUL132AUj+NkxvSZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=poJj2VelK5n6YFGbdOdDs1myP3/r7mwLQddvZMN6yXCl8vKyB50iGbQ4hSAdcpxVi4yCnUTZSSLFmjPv0GSRoM/ZZnc6/CUAb7cEB1zTo2BWyTorruZpcW8IpeqDZEY5u6UaadJm9dLdj4Qnqp4wIUENUdpTh5hALWpTgWAtd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.dbcSRYH_1751412586 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 02 Jul 2025 07:29:46 +0800
Date: Wed, 02 Jul 2025 07:29:47 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: dsterba@suse.cz
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Cc: David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
In-Reply-To: <20250630164328.GL31241@twin.jikos.cz>
References: <20250630162130.GK31241@twin.jikos.cz> <20250630164328.GL31241@twin.jikos.cz>
Message-Id: <20250702072946.6BE5.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

> On Mon, Jun 30, 2025 at 06:21:30PM +0200, David Sterba wrote:
> > On Mon, Jun 30, 2025 at 10:24:57AM +0800, Wang Yugui wrote:
> > > Hi,
> > > 
> > > > The RCU protected string is only used for a device name, and RCU is used
> > > > so we can print the name and eventually synchronize against the rare
> > > > device rename in device_list_add().
> > > > 
> > > > We don't need the whole API just for that. Open code all the helpers and
> > > > access to the string itself.
> > > > 
> > > > Notable change is in device_list_add() when the device name is changed,
> > > > which is the only place that can actually happen at the same time as
> > > > message prints using the device name under RCU read lock.
> > > > 
> > > > Previously there was kfree_rcu() which used the embedded rcu_head to
> > > > delay freeing the object depending on the RCU mechanism. Now there's
> > > > kfree_rcu_mightsleep() which does not need the rcu_head and waits for
> > > > the grace period.
> > > > 
> > > > Sleeping is safe in this context and as this is a rare event it won't
> > > > interfere with the rest as it's holding the device_list_mutex.
> > > > 
> > > > Straightforward changes:
> > > > 
> > > > - rcu_string_strdup -> kstrdup
> > > > - rcu_str_deref -> rcu_dereference
> > > > - drop ->str from safe contexts
> > > > 
> > > > Historical notes:
> > > > 
> > > > Introduced in 606686eeac45 ("Btrfs: use rcu to protect device->name")
> > > > with a vague reference of the potential problem described in
> > > > https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .
> > > > 
> > > > The RCU protection looks like the easiest and most lightweight way of
> > > > protecting the rare event of device rename racing device_list_add()
> > > > with a random printk() that uses the device name.
> > > > 
> > > > Alternatives: a spin lock would require to protect the printk
> > > > anyway, a fixed buffer for the name would be eventually wrong in case
> > > > the new name is overwritten when being printed, an array switching
> > > > pointers and cleaning them up eventually resembles RCU too much.
> > > > 
> > > > The cleanups up to this patch should hide special case of RCU to the
> > > > minimum that only the name needs rcu_dereference(), which can be further
> > > > cleaned up to use btrfs_dev_name().
> > > > 
> > > 
> > > There is still rcu warning when 'make  W=1 C=1'
> > > 
> > > /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21: warning: incorrect type in argument 1 (different address spaces)
> > > /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    expected void const *objp
> > > /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    got char const [noderef] __rcu *name
> > > 
> > > static void btrfs_free_device(struct btrfs_device *device)
> > > {
> > >     WARN_ON(!list_empty(&device->post_commit_list));
> > >     /* No need to call kfree_rcu(), nothing is reading the device name. */
> > > L405:    kfree(device->name);
> > > 
> > > do we need rcu_dereference here?
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -402,7 +402,7 @@ static void btrfs_free_device(struct btrfs_device *device)
> > >  {
> > >         WARN_ON(!list_empty(&device->post_commit_list));
> > >         /* No need to call kfree_rcu(), nothing is reading the device name. */
> > > -       kfree(device->name);
> > > +       kfree(rcu_dereference(device->name));
> > 
> > I got notified by the build bots (not CCed to the mailinglis) about
> > this. The dereference is not needed, the comment says why. The checkers
> > do not distinguish the context, some of them are safe like when the
> > device is being set up and not yet accessible by other processes, and at
> > deletion time, like here.
> > 
> > As we want to keep the __rcu annotation the rcu dereference is the
> > easiest workaround.
> 
> I can't seem to reproduce the warning with the command, I'm going to apply this
> fixup:

steps to reproduce the warning:
1) install https://kojipkgs.fedoraproject.org/packages/sparse/0.6.4/
2) make btrfs module(kernel 6.16) with the commands
#uname_r=$(uname -r)
uname_r=$(ls /boot/vmlinuz-6.16.* 2>/dev/null)
uname_r=${uname_r##/boot/vmlinuz-}
pwd_dir=$(pwd)
make -C /lib/modules/${uname_r}/build M=${pwd_dir} modules -j 20 W=1 C=1 CF="-Wnocontext"


Then we can see other 4 warnings.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb91a7b..5080ab2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -699,7 +699,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (!device->name)
 		return -EINVAL;
 
-	ret = btrfs_get_bdev_and_sb(device->name, flags, holder, 1,
+	ret = btrfs_get_bdev_and_sb(rcu_dereference(device->name), flags, holder, 1,
 				    &bdev_file, &disk_super);
 	if (ret)
 		return ret;
@@ -1061,7 +1061,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 		 * uuid mutex so nothing we touch in here is going to disappear.
 		 */
 		if (orig_dev->name)
-			dev_path = orig_dev->name;
+			dev_path = rcu_dereference(orig_dev->name);
 
 		device = btrfs_alloc_device(NULL, &orig_dev->devid,
 					    orig_dev->uuid, dev_path);
@@ -1436,7 +1436,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
 
 		list_for_each_entry(device, &fs_devices->devices, dev_list) {
 			if (device->bdev && (device->bdev->bd_dev == devt) &&
-			    strcmp(device->name, path) != 0) {
+			    strcmp(rcu_dereference(device->name), path) != 0) {
 				mutex_unlock(&fs_devices->device_list_mutex);
 
 				/* Do not skip registration. */
@@ -2197,7 +2197,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device->name);
+	update_dev_time(rcu_dereference(device->name));
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/07/02



