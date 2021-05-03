Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A32371E8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhECR16 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 13:27:58 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49955 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231337AbhECR16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 13:27:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A97335C0165;
        Mon,  3 May 2021 13:27:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 May 2021 13:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wRSLINPIf1aEYduPxyDZNlXhbhw
        pR78qGVJgxGkYqbQ=; b=SvIHT/KLuiHl/UIpSIIrC6/7lzC/eU3BQoSthpOiJR+
        fPy8BlCBBeiPX4TiebAyvM2T+VgkxGtexGqeDkjfKzxQS/Mea3DTCbRkNRZgRcPv
        RGgU1sUEIAJyfgv3IhCMdrMO+KFy2Ks3p1oXy268eJx6SJFUVMrIdHFHjLmR3usH
        +vxy1AHoa+xQIWIQ5jgoBKUY8CayCWEp9KVYXucWrRIWMXPgg/2zdNkGdoOoseDo
        I1GArsjSlbfriKaD8Oh7Qep8LZ7BNbUWm9/64uWEhjo5lT1E8aBe2N6as/Vn1+xn
        EzFpR8MwTqZf+bkW63X6ozIF9yxCh0fFIdCGjDK7Xtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wRSLIN
        PIf1aEYduPxyDZNlXhbhwpR78qGVJgxGkYqbQ=; b=lySJXC7MtaqP2GOr0cLSQp
        r93buss2ajovnhbGCuB11lOwE8x1WZuOStcQToXW4CGd4qESJE7Af0jOqBfONHQ2
        x/eC+mZb3gKnuzKsxAZ7KiOZQgY+rbztPJKrL2YuFhBEkb1EjCXcQvYQ/Y5m8gwc
        Gx6zoUta516k9D+auc8Tv7CHBWNxm6kGPiReslZnj0LvKwMT3vHPlOwJCuumyVJw
        SDOlmXXUZNKu84eF5gM5Oln2qEQl9JyxHOs9C11UDcGC7v/a9YKe//JJPeW25PoW
        juJ+U8sDbmOATYYRtJBQhjI7iy4pG1d2pzwZu4/Pe/VXwqRa6pdtfbzNnQ/OaTtw
        ==
X-ME-Sender: <xms:aDKQYIQG1dqmtvW_VSD4XXetvhwaUmJEg7r7WAZCLKwbIS4kK3CzvA>
    <xme:aDKQYFx6NFL068YcBvCVrL7QIT0dAWMs-1NyE6jRuBMDLrri28IDHoX4YW8ylk2xb
    NnS4DOkK6OdACSQVlc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucfk
    phepvddtjedrheefrddvheefrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:aDKQYF0Zd7K3TZ3zpXcBmXt0pEvGxn1X5ToeCidM7_SEZrh08sY0Bg>
    <xmx:aDKQYMDGHkp_v5xhiXqfejO2oLNFPcylGKU05FwqRSvUqActOAhHnQ>
    <xmx:aDKQYBjk7ip_Pvmt5v4YI_jZuPknJ0e6Zr2WtBtcQj8bBNjl2LKndQ>
    <xmx:aDKQYLcc03PjGDv4TlYSrgGJtYKxE_rPfDQ5YZ5WlvE-s8Tziaf-xg>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 13:27:04 -0400 (EDT)
Date:   Mon, 3 May 2021 10:27:03 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <YJAyZ5GT+KPrEXB+@zen>
References: <20210420073036.243715-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420073036.243715-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 03:30:36PM +0800, Qu Wenruo wrote:
> Currently mkfs.btrfs will output a warning message if the sectorsize is
> not the same as page size:
>   WARNING: the filesystem may not be mountable, sectorsize 4096 doesn't match page size 65536
> 
> But since btrfs subpage support for 64K page size is comming, this
> output is populating the golden output of fstests, causing tons of false
> alerts.
> 
> This patch will make teach mkfs.btrfs to check
> /sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
> size is supported.
> 
> Then only output above warning message if the sector size is not
> supported.
> 
> This patch will also introduce a new helper,
> sysfs_open_global_feature_file() to make it more obvious which global
> feature file we're opening.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> changelog:
> v2:
> - Introduce new helper to open global feature file
> - Extra the supported sectorsize check into its own function
> - Do proper token check other than strstr()
> - Fix the bug that we're passing @page_size to check
> v3:
> - Fix the wrong delim for the next runs of strtok_r()
> - Also check the terminal '\0' to handle cases like "4096" and "40960"
>   This is not really needed, as the is_power_of_2() has already ruled
>   out such cases.
>   But just to be extra sure.
> ---
>  common/fsfeatures.c | 54 ++++++++++++++++++++++++++++++++++++++++++++-
>  common/utils.c      | 15 +++++++++++++
>  common/utils.h      |  1 +
>  3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 569208a9e5b1..0c638b3af15e 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -327,8 +327,55 @@ u32 get_running_kernel_version(void)
>  
>  	return version;
>  }
> +
> +/*
> + * The buffer size should be strlen("4096 8192 16384 32768 65536"),
> + * which is 28, then we just round it up to 32.
> + */
> +#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
> +
> +/*
> + * Check if the current kernel supports given sectorsize.
> + *
> + * Return true if the sectorsize is supported.
> + * Return false otherwise.
> + */
> +static bool check_supported_sectorsize(u32 sectorsize)
> +{
> +	char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> +	char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
> +	char *this_char;
> +	char *save_ptr = NULL;
> +	int fd;
> +	int ret;
> +
> +	fd = sysfs_open_global_feature_file("supported_sectorsizes");
> +	if (fd < 0)
> +		return false;
> +	ret = sysfs_read_file(fd, supported_buf, SUPPORTED_SECTORSIZE_BUF_SIZE);
> +	close(fd);
> +	if (ret < 0)
> +		return false;
> +	snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
> +		 "%u", sectorsize);
> +
> +	for (this_char = strtok_r(supported_buf, " ", &save_ptr);
> +	     this_char != NULL;
> +	     this_char = strtok_r(NULL, " ", &save_ptr)) {
> +		/*
> +		 * Also check the terminal '\0' to handle cases like
> +		 * "4096" and "40960".
> +		 */
> +		if (!strncmp(this_char, sectorsize_buf,
> +			     strlen(sectorsize_buf) + 1))
> +			return true;
> +	}
> +	return false;
> +}
> +
>  int btrfs_check_sectorsize(u32 sectorsize)
>  {
> +	bool sectorsize_checked = false;
>  	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
>  
>  	if (!is_power_of_2(sectorsize)) {
> @@ -340,7 +387,12 @@ int btrfs_check_sectorsize(u32 sectorsize)
>  		      sectorsize);
>  		return -EINVAL;
>  	}
> -	if (page_size != sectorsize)
> +	if (page_size == sectorsize)
> +		sectorsize_checked = true;
> +	else
> +		sectorsize_checked = check_supported_sectorsize(sectorsize);
> +
> +	if (!sectorsize_checked)
>  		warning(
>  "the filesystem may not be mountable, sectorsize %u doesn't match page size %u",
>  			sectorsize, page_size);
> diff --git a/common/utils.c b/common/utils.c
> index 57e41432c8fb..e8b35879f19f 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -2205,6 +2205,21 @@ int sysfs_open_fsid_file(int fd, const char *filename)
>  	return open(sysfs_file, O_RDONLY);
>  }
>  
> +/*
> + * Open a file in global btrfs features directory and return the file
> + * descriptor or error.
> + */
> +int sysfs_open_global_feature_file(const char *feature_name)
> +{
> +	char path[PATH_MAX];
> +	int ret;
> +
> +	ret = path_cat_out(path, "/sys/fs/btrfs/features", feature_name);
> +	if (ret < 0)
> +		return ret;
> +	return open(path, O_RDONLY);
> +}
> +
>  /*
>   * Read up to @size bytes to @buf from @fd
>   */
> diff --git a/common/utils.h b/common/utils.h
> index c38bdb08077c..d2f6416a9b5a 100644
> --- a/common/utils.h
> +++ b/common/utils.h
> @@ -169,6 +169,7 @@ char *btrfs_test_for_multiple_profiles(int fd);
>  int btrfs_warn_multiple_profiles(int fd);
>  
>  int sysfs_open_fsid_file(int fd, const char *filename);
> +int sysfs_open_global_feature_file(const char *feature_name);
>  int sysfs_read_file(int fd, char *buf, size_t size);
>  
>  #endif
> -- 
> 2.31.1
> 
