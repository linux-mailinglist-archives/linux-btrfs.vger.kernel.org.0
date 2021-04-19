Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE436483E
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbhDSQbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 12:31:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42077 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhDSQbm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 12:31:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 754805C014E;
        Mon, 19 Apr 2021 12:31:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 19 Apr 2021 12:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=v4QheYH05tEAhwvmUp4wBXgPZ/3
        DplB9W7Hkdb6chSc=; b=qatwvuQKTYqbVfXcBmXcHemDvxfpIlfLlGMgj/9QMjN
        IZJcbEJKJzYd16K/pKPORV+SXBYx+F3FcWd1mnS0d6DUiWOzFDhqBamds3o3POE9
        Gml16wgfYt4eWAvef9J3G/1GyhJ3Gf7w9d3FLjhIz4q4TrJMBNsTEY+zg50GKjRC
        jpkHoPQ/wgyqPEXP3JynmNJwz2zeSgkOqTPj2abMbq8RR9GR8otpAm0354oYpj3K
        Td+HGut/LgdxqRQehTHTmhaCX5w0emQTSg5wybnyr6mf9iMliPMgWfxy6RyMc8Qd
        0G0GOCDwQQT7DWCkuk1Rauwv+KK7Dksjl0IgqOnndGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=v4QheY
        H05tEAhwvmUp4wBXgPZ/3DplB9W7Hkdb6chSc=; b=Vbon58MKIf/wEf250nqWrC
        EAO2Aupjnmkdl1Dz9sQwf+7UL2fWBP24a2WF8yqa8jK/UfaS5bbqkRSaIBKC81p5
        RwelRZOQu0DzeKGCTjROqXGrhlof5daLbsWOLmOknmzHfX8BcFE+yuQNZ0t/0VXM
        aQUrLomPK2Vk84xyXdeYOBZ5uDT/kl8F2mYACFSR3p+JWl2CVA6HykGz7kPhuS7D
        EaA+IghVwKHl/WYup6X+wSPtP3XDTPDF9Vb1YWsPg/CQ6UkbddPPwpgopbltS+B5
        i0qO4qEpUCoRuYd91VQj7RLBsvAQZX6CTAUeTC4ozj0xseEJPPGG70OTKb1GyO9g
        ==
X-ME-Sender: <xms:ULB9YKRONoAr-UDLieXGPvHeBN4MnZDpqpU-dFaPdrUWD2v3LGFnew>
    <xme:ULB9YCW0qkvUiLjQd1RBixvO74l6W6BHzSZVSOqbfGFMJxWiH5ivWMFQtH0NHf-Je
    cKOgtJLf2TEiPZuWa8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudevleekieetleevieeuhfduhedtiefgheekfeefgeelvdeuveeggfduueevfeenucfk
    phepvddtjedrheefrddvheefrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ULB9YLfGwUQoxaBc3L4OkMDDxv2kpTq8ZJzYHNQzS_C5XHc8_KNHXQ>
    <xmx:ULB9YGK7Sk9dFeCEptKC7GM3VYPfOOY5Rd9YSl_eXAfmln4XwVcvCA>
    <xmx:ULB9YIwEBCPfPKijwickrKLHjTQKEjBbfhS7oLNRbmDBd66hlZJF-Q>
    <xmx:ULB9YEkMNXqNHtUSuY5k6lLTErW4P-SgDpf673RDJ2jvkCnGEXOZ3A>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBD7B24005D;
        Mon, 19 Apr 2021 12:31:11 -0400 (EDT)
Date:   Mon, 19 Apr 2021 09:31:10 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: mkfs: only output the warning if the
 sectorsize is not supported
Message-ID: <YH2wTkX/coo94uTF@zen>
References: <20210419064512.92213-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419064512.92213-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 19, 2021 at 02:45:12PM +0800, Qu Wenruo wrote:
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
> ---
> changelog:
> v2:
> - Introduce new helper to open global feature file
> - Extra the supported sectorsize check into its own function
> - Do proper token check other than strstr()
> - Fix the bug that we're passing @page_size to check
> ---
>  common/fsfeatures.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-
>  common/utils.c      | 15 ++++++++++++++
>  common/utils.h      |  1 +
>  3 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
> index 569208a9e5b1..6641c44dfa45 100644
> --- a/common/fsfeatures.c
> +++ b/common/fsfeatures.c
> @@ -327,8 +327,50 @@ u32 get_running_kernel_version(void)
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
> +	     this_char = strtok_r(NULL, ",", &save_ptr)) {

Based on the example file contents in the comment, I would expect " " as
the delimeter for looping through the supported sizes, not ",".

> +		if (!strncmp(this_char, sectorsize_buf, strlen(sectorsize_buf)))
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
> @@ -340,7 +382,12 @@ int btrfs_check_sectorsize(u32 sectorsize)
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
