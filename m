Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB50E484C7C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbiAEC3x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 21:29:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49135 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237084AbiAEC3x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Jan 2022 21:29:53 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 82EC35C0115;
        Tue,  4 Jan 2022 21:29:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Jan 2022 21:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Sj2RCDJ+B3I7dnia6sC1RZdyZmW
        vebIpUx8dfpBV+Rg=; b=srzzuuvrhYnvis3WDTMZr9v01FwmvxyTcCg/5o6qqPi
        02EDS2GWKgfGCFhZBr8ch4yhZJteyu1VITIFXiByYz46gXfEPBQNSzuo03bOoCem
        THbh68ozYVUBFzxf5c3tqO3s92l1dToVKX+HNyjrTPMsoVDIg6JvTktQkIuIrvTw
        oaT4f39u1/FiGdUY7jf3HZ8eU/4AHC4OcFRu96JksJt8SHPNAcW4k3fj5xkxynud
        tZXVmMGrzl1FY6X0UizXwXgPbF3+0sVNyZyigYdjEAX7gCJ7LY0W/F7ZQTyh5x+8
        YkISXYQZLsUNCW/A6waemNbl/IxOTqZdN41yZgZQHRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Sj2RCD
        J+B3I7dnia6sC1RZdyZmWvebIpUx8dfpBV+Rg=; b=YLEO7AOGtkhnR/btN9fhF8
        ThMu1tEJqigXNH6D4oUJ+i5p8jegXV8mytrCf6Hpe+AOvoUoftwt0mdyq2MGB4/L
        x7b9FKaTY6FguPtn6cHOZQbTqvj+39t+JrTB4Q7Oq+tg2C+TkYPKSbVVMrTiPur0
        qbBk2sUwGxpAEFpL+bWqcaXA5qIhz/qEljDdgU80O3+nn2k12keCM4qkaepIVVve
        k4RqAEpxWpaBpgm0hMyTJbOdsF0CjEdLP1+VbLKQajPKR1lys6q9ce9rzrEmJ6ZF
        43ZefqDPFjGLdInUl/e7eTzin6E6rg8yFYIkUgMM1sCr3134XqR63yh0rdNc7KvQ
        ==
X-ME-Sender: <xms:nwLVYQ8XUjouxrWaQMK9X3mo5RU0FTn3e5V9AE0-ZXoeQBgGZF-dBg>
    <xme:nwLVYYtndSERVgsBCzCWxaheJDN2A3rtC5OO7-MHcHDD_p1gCoMKNtvdMkTxXYzKh
    HG7nSMWuxojBYwWMk4>
X-ME-Received: <xmr:nwLVYWBQiK9NP3G3_rMQ1MVZYU-yyQSRCYSmOKoLLP3_vNxFtBsrCnSv7nVyQDa1WKYve2yoRz9pWhyA_0ZzVXgpDnFleQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephf
    fgveejteegtdelhedtiedvkedvtdfgveelledtjeffveekgeefleeuleejudevnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:nwLVYQflo9LggWUuzqovJLFCmzYgU78meakxPRqTsAhb8-Guqh5kFg>
    <xmx:nwLVYVOSRGAMpf9lEdZs0zCHENRibG92C_z04pjA53_TQ8_MDAQuJA>
    <xmx:nwLVYal7E_g4Xt3Ma6k5ZmZV7ndLojVi3SaIaDDpO3RsBq227tUCRA>
    <xmx:oALVYY33kxYiEoEEiM8xB3OfrhVc8fp_Ij1C0EFHeEn935N9x-zGQQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jan 2022 21:29:51 -0500 (EST)
Date:   Tue, 4 Jan 2022 18:29:49 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH 1/2] btrfs-progs: new "allocation_hint" property.
Message-ID: <YdUChLjZz80FS5u4@zen>
References: <cover.1639766708.git.kreijack@inwind.it>
 <21fcdf5d4186555b743190e62ad3011c08aaad9b.1639766708.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21fcdf5d4186555b743190e62ad3011c08aaad9b.1639766708.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 07:47:04PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> Handle the property allocation_hint of a btrfs device. Below
> an example of use:
> 
> $ # set a new value
> $ sudo btrfs property set /dev/vde allocation_hint DATA_ONLY

I applied this patchset to the master branch of
git://github.com/kdave/btrfs-progs.git
and this command failed with something like "not a btrfs object".

However, it worked fine as:
$ sudo btrfs property set -t device /dev/DEV allocation_hint DATA_ONLY

I can't think of a reason I would hit this error and you wouldn't, since
that check is relatively old, but figured I would mention it.

> 
> $ # get the current value
> $ sudo btrfs property get /dev/vde allocation_hint
> devid=4, path=/dev/vde: allocation_hint=DATA_ONLY
> 
> The following values are availables:
> - DATA_ONLY
> - PREFERRED_DATA (default)
> - PREFERRED_METADATA
> - METADATA_ONLY
> 
> Root privileges are required.
> 
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  cmds/property.c       | 204 ++++++++++++++++++++++++++++++++++++++++++
>  kernel-shared/ctree.h |  13 +++
>  2 files changed, 217 insertions(+)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index 59ef997c..e6a38ee1 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -22,6 +22,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/xattr.h>
> +#include <sys/sysmacros.h>
>  #include <uuid/uuid.h>
>  #include <btrfsutil.h>
>  #include "cmds/commands.h"
> @@ -30,6 +31,7 @@
>  #include "common/open-utils.h"
>  #include "common/utils.h"
>  #include "common/help.h"
> +#include "common/path-utils.h"
>  
>  #define XATTR_BTRFS_PREFIX     "btrfs."
>  #define XATTR_BTRFS_PREFIX_LEN (sizeof(XATTR_BTRFS_PREFIX) - 1)
> @@ -232,6 +234,202 @@ out:
>  	return ret;
>  }
>  
> +static int btrfs_find_devid_and_mnt(const char *devpath, int *devid,
> +				    char *path, int maxpath)
> +{
> +	int ret, i, fd;
> +	DIR *dir;
> +	struct stat stdevpath;
> +	struct btrfs_ioctl_fs_info_args fi_args;
> +	struct btrfs_ioctl_dev_info_args dev_info;
> +
> +	ret = get_btrfs_mount(devpath, path, maxpath);
> +	if (ret)
> +		return ret;
> +
> +	fd = btrfs_open_dir(path, &dir, 1);
> +	if (fd < 0)
> +		return fd;
> +
> +	ret = stat(devpath, &stdevpath);
> +	if (ret) {
> +		error("cannot stat '%s'", devpath);
> +		goto out;
> +	}
> +
> +	ret = ioctl(fd, BTRFS_IOC_FS_INFO, &fi_args);
> +	if (ret < 0) {
> +		if (errno == EPERM)
> +			return -errno;
> +		error("cannot get filesystem info: %m");
> +		ret = -10;
> +		goto out;
> +	}
> +
> +	for (i = 0 ; i <= fi_args.max_id ; i++) {
> +		struct stat st;
> +
> +		memset(&dev_info, 0, sizeof(dev_info));
> +		ret = get_device_info(fd, i, &dev_info);
> +		if (ret == -ENODEV)
> +			continue;
> +		if (ret) {
> +			error("cannot get info about device devid=%d", i);
> +			goto out;
> +		}
> +
> +		if (!dev_info.path)
> +			/* missing devices */
> +			continue;
> +
> +		ret = stat((char *)dev_info.path, &st);
> +		if (ret) {
> +			error("cannot stat '%s'", devpath);
> +			goto out;
> +		}
> +
> +		if (major(st.st_rdev) == major(stdevpath.st_rdev) &&
> +		    minor(st.st_rdev) == minor(stdevpath.st_rdev)) {
> +			*devid = dev_info.devid;
> +			ret = 0;
> +			goto out;
> +		}
> +	}
> +
> +	ret = -12;
> +
> +out:
> +	close_file_or_dir(fd, dir);
> +	return ret;
> +}
> +
> +static struct ull_charp_pair_t {
> +	u64		value;
> +	const char	*descr;
> +} allocation_hint_description[] = {
> +	{BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA, "PREFERRED_METADATA"},
> +	{BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY, "METADATA_ONLY"},
> +	{BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA, "PREFERRED_DATA"},
> +	{BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY, "DATA_ONLY"},
> +	{0, NULL}
> +};
> +
> +static int prop_allocation_hint(enum prop_object_type type,
> +				const char *object,
> +				const char *name,
> +				const char *value,
> +				bool force)
> +{
> +	int ret, devid, fd, fd2;
> +	char path[PATH_MAX];
> +	DIR *dir;
> +	u8 fsid[BTRFS_UUID_SIZE];
> +	char fsid_str[BTRFS_UUID_UNPARSED_SIZE];
> +	char sysfs_file[PATH_MAX];
> +	char filename[PATH_MAX];
> +	int i;
> +	u64 v, devtype;
> +	char buf[1024];
> +
> +	ret = btrfs_find_devid_and_mnt(object, &devid, path, sizeof(path));
> +	if (ret)
> +		return -5;
> +
> +	fd = btrfs_open_dir(path, &dir, 1);
> +	if (fd < 0)
> +		return fd;
> +
> +	ret = get_fsid_fd(fd, fsid);
> +	if (ret < 0)
> +		goto out;
> +
> +	uuid_unparse(fsid, fsid_str);
> +	sprintf(filename, "devinfo/%d/allocation_hint", devid);
> +
> +	/* build /sys/fs/btrfs/<UUID>/devinfo/<DEVID>/type */
> +	ret = path_cat3_out(sysfs_file, "/sys/fs/btrfs", fsid_str, filename);
> +	if (ret < 0)
> +		goto out;
> +
> +	fd2 = open(sysfs_file, O_RDONLY);
> +	if (fd2 < 0) {
> +		error("'allocation_hint' property not available or accessible.");
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	ret = read(fd2, buf, sizeof(buf) - 1);
> +	close(fd2);
> +	if (ret < 0) {
> +		error("Unable to read the 'allocation_hint' property.");
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	buf[sizeof(buf) - 1] = 0;
> +	devtype = strtoull(buf, NULL, 0);
> +
> +	if (!value) {
> +		/* READ */
> +		for (i = 0 ; allocation_hint_description[i].descr ; i++)
> +			if (devtype == allocation_hint_description[i].value)
> +				break;
> +		if (allocation_hint_description[i].descr)
> +			printf("devid=%d, path=%s: allocation_hint=%s\n",
> +				devid, object,
> +				allocation_hint_description[i].descr);
> +		else
> +			printf("devid=%d, path=%s: allocation_hint=unknown:%llu\n",
> +				devid, object,
> +				devtype);
> +		ret = 0;
> +	} else {
> +		/* WRITE */
> +		for (i = 0 ; allocation_hint_description[i].descr ; i++)
> +			if (!strcmp(value, allocation_hint_description[i].descr))
> +				break;
> +
> +		if (allocation_hint_description[i].descr) {
> +			v = allocation_hint_description[i].value;
> +		} else if (sscanf(value, "%llu", &v) != 1) {
> +			error("Invalid value '%s'\n", value);
> +			ret = -3;
> +			goto out;
> +		} 
> +		if (v & ~BTRFS_DEV_ALLOCATION_HINT_MASK) {
> +			error("Invalid value '%s'\n", value);
> +			ret = -3;
> +			goto out;
> +		}
> +
> +		devtype &= ~BTRFS_DEV_ALLOCATION_HINT_MASK;
> +		devtype |= (v & BTRFS_DEV_ALLOCATION_HINT_MASK);
> +
> +		fd2 = open(sysfs_file, O_RDWR);
> +		if (fd2 < 0) {
> +			error("'allocation_hint' property not available or accessible for updating.");
> +			ret = -errno;
> +			goto out;
> +		}
> +
> +		sprintf(buf, "%llu", devtype);
> +
> +		ret = write(fd2, buf, strlen(buf));
> +		close(fd2);
> +		if (ret < 0) {
> +			error("Unable to update 'allocation_hint' property.");
> +			ret = -errno;
> +			goto out;
> +		}
> +
> +	}
> +
> +	ret = 0;
> +out:
> +	close_file_or_dir(fd, dir);
> +	return ret;
> +}
> +
>  const struct prop_handler prop_handlers[] = {
>  	{
>  		.name ="ro",
> @@ -254,6 +452,12 @@ const struct prop_handler prop_handlers[] = {
>  		.types = prop_object_inode,
>  		.handler = prop_compression
>  	},
> +	{
> +		.name = "allocation_hint",
> +		.desc = "hint to store the data/metadata chunks",
> +		.types = prop_object_dev,
> +		.handler = prop_allocation_hint
> +	},
>  	{NULL, NULL, 0, 0, NULL}
>  };
>  
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index 966490d3..adc869fe 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -213,6 +213,19 @@ struct btrfs_mapping_tree {
>  	struct cache_tree cache_tree;
>  };
>  
> +/* btrfs chunk allocation hints */
> +#define BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT    2
> +#define BTRFS_DEV_ALLOCATION_HINT_MASK ((1ULL << \
> +	       BTRFS_DEV_ALLOCATION_HINT_BIT_COUNT) - 1)
> +/* preferred metadata chunk, but data chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_METADATA        (1ULL)
> +/* only metadata chunk are allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_METADATA_ONLY     (2ULL)
> +/* only data chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_DATA_ONLY         (3ULL)
> +/* preferred data chunk, but metadata chunk allowed */
> +#define BTRFS_DEV_ALLOCATION_HINT_PREFERRED_DATA    (0ULL)
> +
>  #define BTRFS_UUID_SIZE 16
>  struct btrfs_dev_item {
>  	/* the internal btrfs device id */
> -- 
> 2.34.1
> 
