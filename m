Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5636229F545
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 20:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJ2Tb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 15:31:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54916 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgJ2Tb4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 15:31:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3ACD1B8D9;
        Thu, 29 Oct 2020 19:31:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1DAF8DA7CE; Thu, 29 Oct 2020 20:30:19 +0100 (CET)
Date:   Thu, 29 Oct 2020 20:30:18 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 3/3] btrfs: create read policy sysfs attribute, pid
Message-ID: <20201029193018.GT6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <cover.1603884513.git.anand.jain@oracle.com>
 <52a41497534bdaa301adc57d61ea3632ab65f2c6.1603884513.git.anand.jain@oracle.com>
 <20201029164535.GO6756@twin.jikos.cz>
 <a74b6fdd-55dc-e890-78df-c19d0430b4a2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74b6fdd-55dc-e890-78df-c19d0430b4a2@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 30, 2020 at 03:30:10AM +0800, Anand Jain wrote:
> 
> 
> On 30/10/20 12:45 am, David Sterba wrote:
> > On Wed, Oct 28, 2020 at 09:14:47PM +0800, Anand Jain wrote:
> >> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,
> >> +				       struct kobj_attribute *a,
> >> +				       const char *buf, size_t len)
> >> +{
> >> +	int i;
> >> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
> >> +
> >> +	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
> >> +		if (btrfs_strmatch(buf, btrfs_read_policy_name[i])) {
> > 
> > Does sysfs guarantee that the buf is nul terminated string or that it
> > contains a null at all? Because if not, the skip_space step of strmatch
> > could run out of the buffer.
> > 
> 
> It does
> 
> [  173.555507]  ? btrfs_read_policy_store+0x3e/0x12d [btrfs]
> [  173.555541]  ? kobj_attr_store+0x16/0x30
> [  173.555562]  ? sysfs_kf_write+0x54/0x80
> [  173.555582]  ? kernfs_fop_write+0xfa/0x290
> [  173.555611]  ? vfs_write+0xee/0x2f0
> [  173.555641]  ? ksys_write+0x80/0x170
> [  173.555671]  ? __x64_sys_write+0x1e/0x30
> [  173.555692]  ? do_syscall_64+0x4b/0x80
> [  173.555708]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> static ssize_t kernfs_fop_write(struct file *file, const char __user 
> *user_buf,
>                                  size_t count, loff_t *ppos)
> {
> ::
>          buf[len] = '\0';        /* guarantee string termination */

Ok thanks.
