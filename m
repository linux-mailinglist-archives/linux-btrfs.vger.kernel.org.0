Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB831E696C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 May 2020 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405865AbgE1SfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 May 2020 14:35:22 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:56291 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405863AbgE1SfB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 May 2020 14:35:01 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id eNMjjt6vcLNQWeNMjjtDdO; Thu, 28 May 2020 20:34:56 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590690896; bh=MeT8IKvOF1YE9+ats2gv3Ef5Ij2wcUyGZ+yjFUu13wU=;
        h=From;
        b=ucEgtk0M+4vajYAWk+utLsTJ8XoXgYSclq2cZ528F3WxFbYMkUyxfGRy5qHSsHFn0
         L5XfedOXJJx1sK2Nb9eDVxVSgH6Rg0Bw+3rhNReO/0yCMDcUlGc7iqT1N8TUkPuzAD
         ykDojQF8zAXypQAYCt/Yuboi6nlPtUd496iH43kXuHE7fjKpULygDz5JsKoqEdXXZX
         rH1FzhFveb+4pfLC0R9iS45GQ3OOC9FofLtkOGnSNAfFbKBqzDrG6g0Vqkl13R+jsw
         7mbG70rNZdhZatWKUC+d7XRXHwMUvVE/f6cP9oBtzzQgm554EICrlUNjjJkP83n9/B
         /kiUk31PYdd6w==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=oGHPi4WL6aX_hE_2OMgA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Paul Jones <paul@pauljones.id.au>,
        Adam Borowski <kilobyte@angband.pl>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: [RFC][PATCH V4] btrfs: preferred_metadata: preferred device for metadata
Date:   Thu, 28 May 2020 20:34:47 +0200
Message-Id: <20200528183451.16654-1-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNjUEvHcAle8GaOIih/tNbDccaaSbLAYr0AGzrdOr/zAgyLAzTajWwbeDmcNzvfsiK2l9SsN8oZQR8smegpDTv7b7tj2aEjMAO74juz7JhL8fLFn68r0
 1morlNcD6dnguebNMW3wcopN+msamwk2Ig7xgwga42W6nuQyobspkpMzmOI2HaGvLqCkXhHbtvxpjVheNJdf423O62ohHnbecN8wftXM0fL+3PGT2KtV6syJ
 0WY30cMc4D9qB49K2bfRK5QVTq9A+2FuZMcdltCYEZB7Hz2Hqp8RHS/o9fd561XBxgzy08ZiUkTB8a5AVzjM3JS0e7D1k5ltQrufs6B7LZSbTKApfJ87niP6
 +goa0KiFHzY9xyTvPpCr1B2A+i5kK2N6Rd5jMKacaPuC1gNNaXtuXrRTu8hjqj4MVpfxtBxC
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


[the previous patches sets called this mode ssd_metadata]

Hi all,

This is an RFC; I wrote this patch because I find the idea interesting
even though it adds more complication to the chunk allocator.

The initial idea was to store the metadata on the ssd and to leave the data
on the rotational disks. The kind of disk was determined from the rotational
flag. However looking only at the rotational flags is not flexible enough. So
I added a device property called "preferred_metadata" to mark a device
as preferred for metadata.

A separate patches set is sent to extend the "btrfs property" command
for supporting the preferred_metadata device flag. The basic usage is:

    $ # set a new value
    $ sudo btrfs property set /dev/vde preferred_metadata 1
    
    $ # get the current value
    $ sudo btrfs property get /dev/vde preferred_metadata
    devid=4, path=/dev/vde: dedicated_metadata=1

This new mode is enabled passing the option "preferred_metadata" at mount time.
This policy of allocation is the default one. However if this doesn't permit
a chunk allocation, the "classic" one is used.

Some examples: (/dev/sd[abc] are marked as preferred_metadata,
and /dev/sd[ef] are not)

Non striped profile: metadata->raid1, data->raid1
The data is stored on /dev/sd[ef], metadata is stored on /dev/sd[abc].
When /dev/sd[ef] are full, then the data chunk is allocated also on
/dev/sd[abc].

Striped profile: metadata->raid6, data->raid6
raid6 requires 3 disks at minimum, so /dev/sd[ef] are not enough for a
data profile raid6. To allow a data chunk allocation, the data profile raid6
will be stored on all the disks /dev/sd[abcdef].
Instead the metadata profile raid6 will be allocated on /dev/sd[abc],
because these are enough to host this chunk.

The patches set is composed by four patches:

- The first patch adds the ioctl to update the btrfs_dev_item.type field.
The ioctl is generic to handle more fields, however now only the "type"
field is supported.

- The second patch adds the flag BTRFS_DEV_PREFERRED_METADATA which is
used to mark a device as "preferred_metadata"

- The third patch exports the btrfs_dev_item.type field via sysfs files
/sys/fs/btrfs/<UUID>/devinfo/<devid>/type

It is possible only to read the value. It is not implemented the updated
of the value because in btrfs/stsfs.c there is a comment that states:
"We don't want to do full transaction commit from inside sysfs".

- The fourth patch implements this new mode

Changelog:
v4: - renamed ssd_metadata to preferred_metadata
    - add the device property "preferred_metadata"
    - add the ioctl BTRFS_IOC_DEV_PROPERTIES
    - export the btrfs_dev_item.type values via sysfs
v3: - correct the collision between BTRFS_MOUNT_DISCARD_ASYNC and
      BTRFS_MOUNT_SSD_METADATA.
v2: - rebased to v5.6.2
    - correct the comparison about the rotational disks (>= instead of >)
    - add the flag rotational to the struct btrfs_device_info to
      simplify the comparison function (btrfs_cmp_device_info*() )
v1: - first issue

Below I collected some data to highlight the performance increment.

Test setup:
I performed as test a "dist-upgrade" of a Debian from stretch to buster.
The test consisted in an image of a Debian stretch[1]  with the packages
needed under /var/cache/apt/archives/ (so no networking was involved).
For each test I formatted the filesystem from scratch, un-tar-red the
image and the ran "apt-get dist-upgrade" [2]. For each disk(s)/filesystem
combination I measured the time of apt dist-upgrade with and
without the flag "force-unsafe-io" which reduce the using of sync(2) and
flush(2). The ssd was 20GB big, the hdd was 230GB big,

I considered the following scenarios:
- btrfs over ssd
- btrfs over ssd + hdd with my patch enabled
- btrfs over bcache over hdd+ssd
- btrfs over hdd (very, very slow....)
- ext4 over ssd
- ext4 over hdd

The test machine was an "AMD A6-6400K" with 4GB of ram, where 3GB was used
as cache/buff.

Data analysis:

Of course btrfs is slower than ext4 when a lot of sync/flush are involved. Using
apt on a rotational was a dramatic experience. And IMHO  this should be replaced
by using the btrfs snapshot capabilities. But this is another (not easy) story.

Unsurprising bcache performs better than my patch. But this is an expected
result because it can cache also the data chunk (the read can goes directly to
the ssd). bcache perform about +60% slower when there are a lot of sync/flush
and only +20% in the other case.

Regarding the test with force-unsafe-io (fewer sync/flush), my patch reduce the
time from +256% to +113%  than the hdd-only . Which I consider a good
results considering how small is the patch.


Raw data:
The data below is the "real" time (as return by the time command) consumed by
apt


Test description         real (mmm:ss)	Delta %
--------------------     -------------  -------
btrfs hdd w/sync	   142:38	+533%
btrfs ssd+hdd w/sync        81:04	+260%
ext4 hdd w/sync	            52:39	+134%
btrfs bcache w/sync	    35:59	 +60%
btrfs ssd w/sync	    22:31	reference
ext4 ssd w/sync	            12:19	 -45%



Test description         real (mmm:ss)	Delta %
--------------------     -------------  -------
btrfs hdd	             56:2	+256%
ext4 hdd	            51:32	+228%
btrfs ssd+hdd	            33:30	+113%
btrfs bcache	            18:57	 +20%
btrfs ssd	            15:44	reference
ext4 ssd	            11:49	 -25%


[1] I created the image, using "debootrap stretch", then I installed a set
of packages using the commands:

  # debootstrap stretch test/
  # chroot test/
  # mount -t proc proc proc
  # mount -t sysfs sys sys
  # apt --option=Dpkg::Options::=--force-confold \
        --option=Dpkg::options::=--force-unsafe-io \
	install mate-desktop-environment* xserver-xorg vim \
        task-kde-desktop task-gnome-desktop

Then updated the release from stretch to buster changing the file /etc/apt/source.list
Then I download the packages for the dist upgrade:

  # apt-get update
  # apt-get --download-only dist-upgrade

Then I create a tar of this image.
Before the dist upgrading the space used was about 7GB of space with 2281
packages. After the dist-upgrade, the space used was 9GB with 2870 packages.
The upgrade installed/updated about 2251 packages.


[2] The command was a bit more complex, to avoid an interactive session

  # mkfs.btrfs -m single -d single /dev/sdX
  # mount /dev/sdX test/
  # cd test
  # time tar xzf ../image.tgz
  # chroot .
  # mount -t proc proc proc
  # mount -t sysfs sys sys
  # export DEBIAN_FRONTEND=noninteractive
  # time apt-get -y --option=Dpkg::Options::=--force-confold \
	--option=Dpkg::options::=--force-unsafe-io dist-upgrade


BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5





