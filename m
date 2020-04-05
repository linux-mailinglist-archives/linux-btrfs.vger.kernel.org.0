Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267FD19E9E6
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDEI0m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 04:26:42 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:51623 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbgDEI0m (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 04:26:42 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id L0c2jLXg66Q7RL0c2jMMfh; Sun, 05 Apr 2020 10:26:39 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1586075199; bh=GuWUdcKk6Vtx+ezlQyPyD9p0I+VKm0h4Cu94APRx1+I=;
        h=From;
        b=mSB/UmVWjZKFSfcTz0mdpn1DXGdC5NbDdpwQkjp1ieG30pCsYT1ArHLP+gcXjLNDC
         TpYbluUtZT3qaPNkId/o9FH3Nr4ThhCTU/0uUkXjq8s1voPy2sVLx60ShMD7XJ50af
         AaWXFZy6OhuP0wv+1Jq5hLXHjzRzGQndfGAGMDO9PTgweJQDMQQSbOEwAY0YbWJ0vV
         ziOhRFkjHs3JhZhkfBgc1rke3QU4ZwW0knY4VkV/U0cWVQIJSJgzE+u37HJ9ToocO+
         c6VALoLDMPF3VIhzOsGtVZK9D2P+ez08cT4HyoZeLwzcdfF2wSvFq4LOPYI7xrSL9+
         a57yt7DVtFB8g==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=SUZbtVg7ItgD6HU_gz4A:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: [RFC][PATCH V3] btrfs: ssd_metadata: storing metadata on SSD
Date:   Sun,  5 Apr 2020 10:26:35 +0200
Message-Id: <20200405082636.18016-1-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLfFHoahbHwyEmaQTMhT6tzbeu1o9HdX7yD8kbRrpJUdueIrP8tk5pOkYAVx2pwMsxQ4IcQMl9tJ/eQw85O9rJOAVIERyBuFbl3pCdxMZNMwbwMoGAiF
 lnCHro1zg3JNFlQYgJ+6V1kJ/G4avBPPhgdhdrd8OYYPbKUCfssKjZTVrcttdYJNYPFoNizNh9a4wbr3J8D32a93L+wMm9qkqRf4XtPBc3TYG0TFclEoMyfC
 3d2RU/SilDjcNyKX03nc9EMNM7uvxqUbXsX+1Y7xhYBRtuZJD0LdP63r/XlIj5TtGBaG4aG8+MXBcd2gW21mEQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi all,

This is an RFC; I wrote this patch because I find the idea interesting
even though it adds more complication to the chunk allocator.

The core idea is to store the metadata on the ssd and to leave the data
on the rotational disks. BTRFS looks at the rotational flags to
understand the kind of disks.

This new mode is enabled passing the option ssd_metadata at mount time.
This policy of allocation is the "preferred" one. If this doesn't permit
a chunk allocation, the "classic" one is used.

Some examples: (/dev/sd[abc] are ssd, and /dev/sd[ef] are rotational)

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

Changelog:
v1: - first issue
v2: - rebased to v5.6.2
    - correct the comparison about the rotational disks (>= instead of >)
    - add the flag rotational to the struct btrfs_device_info to
      simplify the comparison function (btrfs_cmp_device_info*() )
v3: - correct the collision between BTRFS_MOUNT_DISCARD_ASYNC and
      BTRFS_MOUNT_SSD_METADATA.

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



