Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5A3301035
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 23:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbhAVWnz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 17:43:55 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33318 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728586AbhAVWnh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 17:43:37 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7BAA0950024; Fri, 22 Jan 2021 17:42:53 -0500 (EST)
Date:   Fri, 22 Jan 2021 17:42:53 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH V5] btrfs: preferred_metadata: preferred device for
 metadata
Message-ID: <20210122224253.GI28049@hungrycats.org>
References: <20210117185435.36263-1-kreijack@libero.it>
 <30cd0359-e649-dcc7-e373-4dd778fbf70b@toxicpanda.com>
 <765cec4e-b989-081b-2ad7-e2d1c9cf7f55@libero.it>
 <20210121185400.GH28049@hungrycats.org>
 <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89ee4ab9-64cd-b093-92d2-02eee4997250@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 22, 2021 at 07:31:18PM +0100, Goffredo Baroncelli wrote:
> On 1/21/21 7:54 PM, Zygo Blaxell wrote:
> > On Thu, Jan 21, 2021 at 07:16:05PM +0100, Goffredo Baroncelli wrote:
> > > On 1/20/21 5:02 PM, Josef Bacik wrote:
> > > > On 1/17/21 1:54 PM, Goffredo Baroncelli wrote:
> > > > > 
> > > > > Hi all,
> > > > > 
> > > > > This is an RFC; I wrote this patch because I find the idea interesting
> > > > > even though it adds more complication to the chunk allocator.
> > > > > 
> > > > > The basic idea is to store the metadata chunk in the fasters disks.
> > > > > The fasters disk are marked by the "preferred_metadata" flag.
> > > > > 
> > > > > BTRFS when allocate a new metadata/system chunk, selects the
> > > > > "preferred_metadata" disks, otherwise it selectes the non
> > > > > "preferred_metadata" disks. The intial patch allowed to use the other
> > > > > kind of disk in case a set is full.
> > > > > 
> > > > > This patches set is based on v5.11-rc2.
> > > > > 
> > > > > For now, the only user of this patch that I am aware is Zygo.
> > > > > However he asked to further constraint the allocation: i.e. avoid to
> > > > > allocated metadata on a not "preferred_metadata"
> > > > > disk. So I extended the patch adding 4 modes to operate.
> > > > > 
> > > > > This is enabled passing the option "preferred_metadata=<mode>" at
> > > > > mount time.
> > > > > 
> > > > 
> > > > I'll echo Zygo's hatred for mount options.  The more complicated policy decisions belong in properties and sysfs knobs, not mount options.
> > > > 
> > > I tend to agree. However adding a filesystem property can be done in a second time. I don't think that this a problem. However I prefer to make the patch smaller.
> > > 
> > > Anyway I have to point out that we need a way to change the allocation
> > > policy without changing the metadata otherwise we risk to be in the
> > > loop of exhausting metadata space: - how we can increase the space for
> > > metadata if we don't have space for metadata but I need to allocate
> > > few block of metadata....
> > > 
> > > What I mean is that even if we store the setting as filesystem
> > > properties (and definitely we have to do), we need a way to override
> > > in an emergency scenario.
> > 
> > There are no new issues introduced by this change, thus no requirement
> > for a mount option to deal with new issues.
> > 
> > The same issue comes up when changing RAID profile, or removing devices,
> > or when existing devices simply fill up.  Part of the solution is the
> > global reserve, which ensures we can always create a transaction to modify
> > a few metadata pages.
> > 
> > Part of the solution is a run-time check to ensure we have min_devs for
> > active RAID profiles whenever we change a device policy to reject data
> > or metadata (see btrfs_check_raid_min_devices).  This is currently
> > implemented for the device remove ioctl, and a similar check will
> > be needed for the device property set ioctl for preferred_metadata.
> > That part is missing in v5 of this patch and will have to be added,
> > though even now it works most of the time without.
> > 
> > v5 is also missing changes to the df statvfs code to deal with metadata
> > only devices.  At this stage it's an RFC patch, so that's OK, but it
> > will also need to be fixed.  We presume these will be addressed in future
> > versions.  Again, it works now, but 'df' will give the wrong number.
> > 
> > None of the above requirements is addressed by a mount option, and
> > the mount option adds new requirements that we don't want.
> > 
> > > > And then for the properties themselves, presumably we'll want to
> > > add other FS wide properties in the future.  I'm not against adding
> > > new actual keys and items to the tree itself, but is there a way
> > > we could use our existing property infrastructure that we use for
> > > compression, and simply store the xattrs in the tree root?  It looks
> > > like we're just toggling a policy decision, and we don't actually
> > > need the other properties in the item you've created, so why not
> > > just a btrfs.preferred_metadata property with the value stored in it,
> > > dropped into the tree_root so it can be read on mount?  Thanks,
> > > 
> > > What if the root subvolume is not mounted ?
> > 
> > Same as device add or remove--if the filesystem isn't mounted, you can't
> > make any changes.
> 
> I am referring to a case where a subvolume (id != 5) is mounted but not the root one (id=5).
> The point is that (e.g.) in the current implementation you can use
> 
> $ sudo btrfs property set /dev/vde preferred_metadata 1
> 
> in any case where the filesystem is mounted (doesn't matter which
> subvvolume).
> 
> I like the Josef idea: instead to develop a new api to retrive/change/list/store/delete/create
> some setting, we could use the xattr api which already exists.

Yeah, I've been thinking about that since yesterday and I am now thinking
it's a good idea if we can wave away some problems.  We don't need special
tools to set an xattr, and we can define new schema versions by changing
the attribute name.

My one lingering concern is what happens when the xattr is propagated
to other filesystems, e.g. by backups.  You might have very different
devices on the backup server than on the origin server, and you wouldn't
want this attribute to suddenly make the backup server unusably slow,
nor would you want the entire backup to fail because it can't set this
attribute to the new value on a backup filesystem because some of the
devids don't exist there.

I'm tempted to say "well you shouldn't back up the root subvol of a
btrfs anyway, and if you do, you should explictly exclude this attribute"
and leave it at that, but there's probably someone out there with
working backup scripts that will be broken by this change.

Maybe a compromise solution is to keep the kernel-parsed string encoding,
but store that string in a persistent dev tree item so it doesn't show
up in any subvol's metadata.

> # adding properties
> $ sudo setfattr -n "btrfs.metadata_preferred_disk=aabbcc" -v "mode=1"  /
> $ sudo setfattr -n "btrfs.metadata_preferred_disk=aabbee" -v "mode=1"  /
> $ sudo setfattr -n "btrfs.metadata_preferred" -v "1"  /
> 
> # listing properties and their values
> $ sudo getfattr -d /
> getfattr: Removing leading '/' from absolute path names
> # file: .
> btrfs.metadata_preferred_disk\075aabbcc="mode=1"
> btrfs.metadata_preferred_disk\075aabbee="mode=1"
> btrfs.metadata_preferred="1"
> 
> # removing a properties
> $ sudo setfattr -x "btrfs.metadata_preferred_disk=aabbcc" /

If the specification is a single string blob, then we get atomic updates
for free--no need to figure out the right order of operations if you
suddenly want to flip metadata from devices 1,2,3 to 4,5,6 with raid1c3
metadata.  The kernel would just ACK or NAK the entire new string, and
tools could manipulate the whole string without trying to guess what
might make one order of changes work while another order fails.

Of course we can haggle for a few more weeks about what that string
should look like, but the mechanism of "configure this thing through a
kernel-parsed single string" seems OK.

I was thinking something like:

	-n btrfs.chunk_policy -v only_metadata=1:only_data=3:prefer_metadata=2

for device 1 = NVME, 2 = SSD, 3 = HDD, where the SSD is shared between
data and metadata, or

	-n btrfs.chunk_policy -v only_metadata=7,8:only_data=1,2,3,4,5,6

for a big NVME (7, 8) and HDD (1-6) array with no device sharing.

Any devid not listed in the string gets "prefer_data".

Metadata is allocated on devices listed with "only_metadata" first,
followed by "prefer_metadata" devices, followed by "prefer_data" devices.
No metadata is allocated on "only_data" devices.

Data is allocated on devices listed with "only_data" first, followed by
"prefer_data" devices, followed by "prefer_metadata" devices.  No data
is allocated on "only_metadata" devices.

Devids may be mentioned in the string that do not exist in the filesystem.
This allows us to do 'dev remove' without changing the xattr string at
the same time (though we still would have to prevent 'dev remove' if this
makes it impossible to allocate new chunks of any existing raid profile).

A special devid "default" specifies the policy for devices that are not
otherwise listed.  This can be used to define what happens to new devices
before they are added, e.g.

	-n btrfs.chunk_policy -v only_metadata=1,2:only_data=default

Or, we move away from the "preferred" concept, and specify the device
order explicitly.

In the following syntax, "," separates device IDs, and ":" defines a
boundary between ordering tiers, where we fill every device before ":"
before any device after ":", but we let btrfs do its normal equalizing
fill algorithm with any device between ":".

The special device id "default" can be used to specify where unlisted
devices appear in the order, which might not be at the end.  If a
device is listed by ID for either data or metadata, it is excluded from
"default" in either string.  We might also define other shorthands like
"rotational" later, if some day the btrfs_device::type field ever does
mean anything useful.

The NVME (1), SSD (2), HDD (3) example is:

	-n btrfs.device_fill_order.data     -v 3:2
	-n btrfs.device_fill_order.metadata -v 1:2

i.e. we put data on devid 3 first, then if that is full put data on
devid 2, while we put metadata on devid 1 first, then if that is full
put metadata on devid 2.  We never put metadata on devid 3 or data on
devid 1.  Any devices added to the filesystem don't get chunks at all
until someone changes the device_fill_order policy to say what to do
with the new devices.

The 2xNVME (7, 8) and 6xHDD (1-6) example could be:

	-n btrfs.device_fill_order.data     -v 1,2,3,4,5,6:default
	-n btrfs.device_fill_order.metadata -v 7,8

Note that since devids 7 and 8 are explicitly listed in metadata, they
are not covered by 'default' in data, and no data will be allocated
on devices 7 and 8.  The "," operator does not specify an order, so
btrfs will pick devices from 1-6 according to its equal-fill algorithm.
Any new devices added to the array will be filled with data only after
the existing devices are all full.

The following order might be useful if we add disks 2 at a time, and want
to rotate out the old ones.  We want the data to be preferentially
located on the devices that are added last, starting with devices that
have not been added yet:

	-n btrfs.device_fill_order.data     -v default:5,6:3,4:1,2
	-n btrfs.device_fill_order.metadata -v 7,8

This could also be (ab)used to get narrower stripes than the entire
array in striping profiles.  I'm not sure if that's good or bad.

This is equivalent to the absence of each xattr:

	-n btrfs.device_fill_order.data     -v default
	-n btrfs.device_fill_order.metadata -v default

This is preferred_metadata=soft with metadata on devid 1:

	-n btrfs.device_fill_order.data     -v default:1
	-n btrfs.device_fill_order.metadata -v 1:default

This is preferred_metadata=hard with metadata on devid 1:

	-n btrfs.device_fill_order.data     -v default
	-n btrfs.device_fill_order.metadata -v 1

This is preferred_metadata=metadata with metadata on devid 1, allowing
metadata to overflow onto data devices but not the opposite:

	-n btrfs.device_fill_order.data     -v default
	-n btrfs.device_fill_order.metadata -v 1:default

This is the "laptop with one SSD and one HDD" example, where we want only
metadata on the SSD but we will allow data to overflow from HDD to SSD:

	-n btrfs.device_fill_order.data     -v default:1
	-n btrfs.device_fill_order.metadata -v 1

Obviously we'd want to compile the ordering preferences into an attribute
attached to each device the in-kernel device list, so sort can just order
devices by the value of the attribute.  The attribute would be recomputed
on mount, device add, and changes to the xattr string (dev remove and
dev replace doesn't change the order, though they might require special
cases in the code for other reasons).

> However the xattr requires an inode to attach the .. xattrs. But when we are talking about
> filesystem properties, which is the right inode ? The only stable inode is the '.' of
> the root subvolume. The other inodes may be deleted so are not suitable to store per
> filesystem properties.
> 
> So the point is: what happens if the root subvolume is not mounted ?

It's not an onerous requirement to mount the root subvol.  You can do (*)

	tmp="$(mktemp -d)"
	mount -osubvolid=5 /dev/btrfs "$tmp"
	setfattr -n 'btrfs...' -v... "$tmp"
	umount "$tmp"
	rmdir "$tmp"

any time you need to change the policy, regardless of whether the root
subvol is mounted anywhere else at the time.

> Of course we can tweak the xattr api to deal this case, but doing so is not
> so different than developing a new api, which (I think) is not what Josef suggested.
> 
> > 
> > Note that all the required properties are per-device, so really you just
> > need any open FD on the filesystem.  (I think Josef didn't read that far
> > down).
> > 
> > The per-device policy storage can go in dev_root (tree 4) along with the
> > device stats data, if we don't want to use btrfs_device::type.  You'd still
> > need an ioctl to get to it.
> > 
> > Or maybe I'm misreading Josef here, and his idea is to make the per-device
> > configuration a string blob that can be set by putting an xattr on the
> > root subvol?  I'm not sure that's better, but it'll work.
> > 
> > > Yes we can create a further
> > > api to store/retrive this kind of metadata without mounting the root
> > > subvolume, but doing so in what it would be different than adding a
> > > key to the root fs like the default subvolume ioctl does ?
> > 
> > > > 
> > > > Josef
> > > 
> > > 
> > > -- 
> > > gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> > > Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
> > > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

(*) but don't do exactly that, it will seriously and dangerously confuse
anything that thinks it owns /tmp.  Use some private directory under
/var or /mnt where there is no possibility of some cron job waking up
and deciding it needs to delete everything.
