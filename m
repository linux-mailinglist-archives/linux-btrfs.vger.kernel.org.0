Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5067A20B046
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 13:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgFZLO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 07:14:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgFZLO0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 07:14:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D746AC7A;
        Fri, 26 Jun 2020 11:14:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0F8DDAA08; Fri, 26 Jun 2020 13:14:10 +0200 (CEST)
Date:   Fri, 26 Jun 2020 13:14:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200626111410.GC27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
 <20200625202120.GZ27795@twin.jikos.cz>
 <5b2a9ae4-115c-28dd-affa-92b238929a15@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b2a9ae4-115c-28dd-affa-92b238929a15@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 26, 2020 at 07:21:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/6/26 上午4:21, David Sterba wrote:
> > On Fri, Jun 19, 2020 at 09:59:46AM +0800, Qu Wenruo wrote:
> >> This patch will add the following sysfs interface:
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rfer
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/excl
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_rfer
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/max_excl
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/lim_flags
> >>  ^^^ Above are already in "btrfs qgroup show" command output ^^^
> >>
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_data
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_pertrans
> >> /sys/fs/btrfs/<UUID>/qgroups/<qgroup_id>/rsv_meta_prealloc
> >>
> >> The last 3 rsv related members are not visible to users, but can be very
> >> useful to debug qgroup limit related bugs.
> > 
> > I think debugging should not be the only usecase. The qgroups
> > information can be accessed via ioctls or parsing output of the 'btrfs
> > qgroup' commands. For that reason I suggest to pick better names of the
> > fields, rfer, excl are not self explanatory and we can't change them in
> > the structures. But we can for the sysfs interface.
> 
> Sure, I would go "reference" and "exclusive" then.

Yes please.

> Although for rsv_* they are really for debug purpose, do they need
> rename too?

I've checked the sysfs directory where the reserves global reserve is
exported and '_rsv' is used so I think it's fine for qgoups too.

> >>  	u64 new_refcnt;
> >> +
> >> +	/*
> >> +	 * Sysfs kobjectid
> >> +	 */
> >> +	struct kobject kobj;
> >> +	struct completion kobj_unregister;
> > 
> > Why do you add the unregister completion to each qgroup? There's a
> > pattern where the parent directory wait's until all its
> > files/directories are released but I'm not sure if we need it here.
> 
> It looks like I'm a little paranoid here.
> Since for qgroup we always release all qgroups then the parent
> directory, the wait is not needed in theory.

Then let's remove it to save the bytes.

The wait/completion is used only for kobjects that are embedded into
other structures:

$ grep 'struct kobject[^*]*$' *.h
space-info.h:   struct kobject kobj;
volumes.h:      struct kobject devid_kobj;
volumes.h:      struct kobject fsid_kobj;

$ grep complete sysfs.c
        complete(&fs_devs->kobj_unregister);
        complete(&device->kobj_unregister);

The space infos are handled in another way.

> > 
> > The size of each qgroup would increase by about 100 bytes, which is not
> > much but it adds up.
> > 
> >>  };
> >>  
> ...
> >> +#define QGROUP_ATTR(_member)						\
> >> +static ssize_t btrfs_qgroup_show_##_member(struct kobject *qgroup_kobj,	\
> >> +				      struct kobj_attribute *a, char *buf) \
> >> +{									\
> >> +	struct kobject *fsid_kobj = qgroup_kobj->parent->parent;	\
> >> +	struct btrfs_fs_info *fs_info = to_fs_info(fsid_kobj);		\
> >> +	struct btrfs_qgroup *qgroup = container_of(qgroup_kobj,		\
> >> +			struct btrfs_qgroup, kobj);			\
> >> +	u64 val;							\
> >> +									\
> >> +	spin_lock(&fs_info->qgroup_lock);				\
> >> +	val = qgroup->_member;						\
> >> +	spin_unlock(&fs_info->qgroup_lock);				\
> >> +	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);		\
> >> +}									\
> >> +BTRFS_ATTR(qgroup, _member, btrfs_qgroup_show_##_member)
> > 
> > The macros need to follow the patterns we already have in sysfs.c,
> > please have a look at eg. global_rsv_size_show or SPACE_INFO_ATTR. It
> > reads the main pointers and calls btrfs_show_u64.
> 
> Oh, that's great, no need to bother the locking part.
> 
> But do I really need to follow the to_space_info() macro? Those macros
> really bothers me, as it's not that clear what we're converting from.

From should be always the kobject. Add helpers that will make the code
straightforward, ie. not necessary to declare 3 variables if this could
be hidding in the helper. And the helper does not need to be a macro,
static inline is fine too.

> >> +static struct kobj_type qgroup_ktype = {
> >> +	.sysfs_ops = &kobj_sysfs_ops,
> >> +	.release = qgroup_release,
> >> +	.default_groups = qgroup_groups,
> >> +};
> >> +
> >> +/*
> >> + * Needed string buffer size for qgroup, including tailing \0
> >> + *
> >> + * This includes U48_MAX + 1 + U16_MAX + 1.
> > 
> > What is U48_MAX?
> 
> For qgroup id, the upper 16 bits are for level and the the lower 48 bit
> are for subvolume id.
> So here we use U48 here.

Yeah I know about the 16/48 split, but there's no such type as u48.

> But since the define is unused, it shouldn't be a problem any more.
> 
> > 
> >> + * U48_MAX in dec can be 15 digits at, and U16_MAX can be 6 digits.
> >> + * Rounded up to 32 to provide some buffer.
> >> + */
> >> +#define QGROUP_STR_LEN	32
> > 
> > Unused define
> > 
> >> +int btrfs_sysfs_add_one_qgroup(struct btrfs_fs_info *fs_info,
> >> +				struct btrfs_qgroup *qgroup)
> >> +{
> >> +	struct kobject *qgroups_kobj = fs_info->qgroup_kobj;
> >> +	int ret;
> >> +
> >> +	init_completion(&qgroup->kobj_unregister);
> >> +	ret = kobject_init_and_add(&qgroup->kobj, &qgroup_ktype, qgroups_kobj,
> >> +			"%u_%llu", (u16)btrfs_qgroup_level(qgroup->qgroupid),
> > 
> > %u does not match u16
> 
> But my compiler doesn't complain about this.

That is very weak argument. There are several things just on that line
that would take time to explain why they work and touch parts of C that
are not considered trivial. That compiler can deal with that is great,
but we as humans reading the code would appreciate if the code is clear
not not depending on C language subtleties.

- btrfs_qgroup_level returns u64
- is type cast to a narrower type, the cast will basically do & 0xFFFF
  but we know there's no information loss 64bit -> 16bit from how the
  value is calculated in btrfs_qgroup_level
- the u16 type is narrower than int and appears in variable argument
  list of printf, so there's type promotion to int
- the format is unsigned int, so the (signed) int value is cast to
  unsigned and we get the correct result in the end

Now compare to:

- btrfs_qgroup_level returns u16 (without cast)
- printf format is %hu

The format matches the data.
