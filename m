Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 342BB19A103
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 23:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgCaVog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 17:44:36 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:52490 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728245AbgCaVog (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 17:44:36 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id JOgTjUQt8MAUpJOgTj0PFX; Tue, 31 Mar 2020 23:44:33 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1585691073; bh=ohw04wA2mUHMalrbBsP5elzx8Go/Y7tUV50bZXCfYZE=;
        h=From;
        b=D+z7Z23kBWkgUtgNMXKrXDXw8VAsqtfg/oVeusq/Utj4LWrbG82IB6JRCxdK2g8r/
         F4Mvt0ppU99D06rbs+/GqGzLfKFUUhcWNTY5+nSsJOvrRPj+BmA5h0D0H5+jgcl3lS
         uYh1oMYtFuUR7irAcTwpFF5WBade1IRi15xdJldXctXyb4Haxh+NlHvaEeJRXn2Y8e
         9FzoUAv+QEWL2LZDrhCgTNoYFvNB5pP5CI75BqwnHUJw1QQvjGC6t6X5Bfwpe2X2bx
         dURtkPzquJh1F3QRRUSu9i9hma28gyaPdDR3ayQauB3Ym6/6gcTT84eewYC1IhwtIG
         ovAuPv3vBJi5g==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=GwDSwHl4fVUIJdfQ4YkA:9
 a=m-oCZ9z6dGNkJnxN:21 a=d1HI2Um4TxgDsxMD:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Eli V <eliventer@gmail.com>, Paul Jones <paul@pauljones.id.au>
Cc:     Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com>
 <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
 <2ff672d4-875b-5242-96d6-1e248e2aa57a@gmail.com>
 <b6f8ec3a-cd58-bbce-fdd6-a5001a92b3b1@libero.it>
Message-ID: <46389af8-0587-3773-8582-d25ea6be778f@libero.it>
Date:   Tue, 31 Mar 2020 23:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b6f8ec3a-cd58-bbce-fdd6-a5001a92b3b1@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAqUzckEwKBm+z9IX26c/6LP0+FK8bmGezvN1dSzWNbVRa1EDjlqNHC2BBXi6W1vDmFITEF88gS0keYnFLzDDeBpK2i9ILoBdB3pHqOwztW27Eu9V/eR
 sxJVJWSC+5HRGIKRlTyKkd9OWYiRSHA/cPGkb1DbEstdP74MN9Fm2zVRz5smoboLgvJyoZI9b8Gv6BTh3G4bfzLB4g759YWSJEKv0CvBJRvOfxyAfDKdrQXy
 QAsE7X0cDgDfZJjSxfG1eOoEq2yOxgZhHDA07vGPqYy68E4CrsiKNsu/v0CjLEso
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/31/20 10:08 PM, Goffredo Baroncelli wrote:
> On 3/31/20 7:09 PM, Andrei Borzenkov wrote:
>> 31.03.2020 20:01, Eli V пишет:
>>>
>>> Another option is to put the 12TB drives in an mdadm RAID, and then
>>> use the mdadm raid & the ssd for btrfs RAID1 metadata, with SINGLE
>>> data on the the array.
>>
>> How do you restrict specific device for metadata only?
> 
> I never tried, but I don't think that it would be so complicated.
> 
> When BTRFS has to allocate a new chunk, it collects all the available
> free spaces on the disks; it sorts all these free spaces on the basis of
> criterion like the largest contiguous area and how the disk is full
> and pick the top one.
> 
> It could be sufficient to add another criteria to the sorting algorithm,
> something like that
> - if the chunk is a metadata one, an SSD has an higher priority
> - if the chunk is a data one, an SSD has a lower priority
> 
> So the metadata will have an higher likelihood to be on the SSD,
> instead the data will have an higher  likelihood to be a NON SSD disk.
> 
> Of course this is a soft constraint, when a kind of disk is full, it will
> be possible to use the other kind, only with a lower priority.
> 

This is only to give an idea. In order to enable the feature, it must be mounted
with the flag ssd_metadata:

# mount -o ssd_metadata /dev/sdX /mnt/test

(don't try at home !)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2e9f938508e9..0f3c09cc4863 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1187,6 +1187,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_SSD_METADATA	(1 << 29)
  
  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c6557d44907a..d0a5cf496f90 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -346,6 +346,7 @@ enum {
  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
  	Opt_ref_verify,
  #endif
+	Opt_ssd_metadata,
  	Opt_err,
  };
  
@@ -416,6 +417,7 @@ static const match_table_t tokens = {
  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
  	{Opt_ref_verify, "ref_verify"},
  #endif
+	{Opt_ssd_metadata, "ssd_metadata"},
  	{Opt_err, NULL},
  };
  
@@ -853,6 +855,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  			btrfs_set_opt(info->mount_opt, REF_VERIFY);
  			break;
  #endif
+		case Opt_ssd_metadata:
+			btrfs_set_and_info(info, SSD_METADATA,
+					"enabling ssd_metadata");
+			break;
  		case Opt_err:
  			btrfs_info(info, "unrecognized mount option '%s'", p);
  			ret = -EINVAL;
@@ -1369,6 +1375,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
  #endif
  	if (btrfs_test_opt(info, REF_VERIFY))
  		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, SSD_METADATA))
+		seq_puts(seq, ",ssd_metadata");
  	seq_printf(seq, ",subvolid=%llu",
  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
  	seq_puts(seq, ",subvol=");
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a8b71ded4d21..43bb5d98a8cb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4758,6 +4758,67 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
  	return 0;
  }
  
+/*
+ * sort the devices in descending order by rotational,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+	const int nrot_a = test_bit(QUEUE_FLAG_NONROT,
+			&(bdev_get_queue(di_a->dev->bdev)->queue_flags));
+
+	const int nrot_b = test_bit(QUEUE_FLAG_NONROT,
+			&(bdev_get_queue(di_b->dev->bdev)->queue_flags));
+
+	/* metadata -> non rotational first */
+	if (nrot_a && !nrot_b)
+		return -1;
+	if (!nrot_a && nrot_b)
+		return 1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+/*
+ * sort the devices in descending order by !rotational,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_data(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+	const int nrot_a = test_bit(QUEUE_FLAG_NONROT,
+			&(bdev_get_queue(di_a->dev->bdev)->queue_flags));
+	const int nrot_b = test_bit(QUEUE_FLAG_NONROT,
+			&(bdev_get_queue(di_b->dev->bdev)->queue_flags));
+
+	/* data -> non rotational last */
+	if (nrot_a && !nrot_b)
+		return 1;
+	if (!nrot_a && nrot_b)
+		return -1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+
+
  static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
  {
  	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -4917,9 +4978,17 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
  	/*
  	 * now sort the devices by hole size / available space
  	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
-
+	if (((type & BTRFS_BLOCK_GROUP_DATA) &&
+	     (type & BTRFS_BLOCK_GROUP_METADATA)) ||
+	    !btrfs_test_opt(info, SSD_METADATA))
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info, NULL);
+	else if (type & BTRFS_BLOCK_GROUP_DATA)
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info_data, NULL);
+	else
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info_metadata, NULL);
  	/*
  	 * Round down to number of usable stripes, devs_increment can be any
  	 * number so we can't use round_down()


>>
>>> Currently, this will make roughly half of the
>>> meta data lookups run at SSD speed, but there is a pending patch to
>>> allow all the metadata reads to go to the SSD. This option is, of
>>> course, only useful for speeding up metadata operations. It can make
>>> large btrfs filesystems feel much more responsive in interactive use
>>> however.
>>>
>>
> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
