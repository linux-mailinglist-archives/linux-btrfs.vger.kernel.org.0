Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D578E432937
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 23:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhJRVow (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 17:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbhJRVot (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 17:44:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E5C06161C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 14:42:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id g5so12230449plg.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Oct 2021 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucZC5BCGNyxrQBEot0+HU8GWXQblK/3JqLzP8t4XKMs=;
        b=K03Dz0r/i4QYoiLUTtVhfsK9BHHphGMbxAICxyfFD97bNWh4QwGEOactJhcSeZKOa2
         mLiLNe1UG3Weh77JXmEHgcpIl3kVHMmmnGYmbqUA+d90cUa3C1hqhqp9Wa5sOCYsBsGw
         GL8R3GyuKbonfBPDaqOauSnKAAc1Pbo59LfKyanvICViW7nCGBIUUBxhSluRz7fvCdfp
         Qo+cxtzvIaQW6ZYOImP0xTh3VosEmiowACZm4R4/2gX+CwqRpyPIn6+Gf8hVY5l3RgPX
         YcL9Ry0Wcc+2I2EslMV8p7byEcCfQHpcd8OJSmrlJS1U/z4J+21I+eV2iJGj7WvyqPfT
         AGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucZC5BCGNyxrQBEot0+HU8GWXQblK/3JqLzP8t4XKMs=;
        b=3eygWTgQEadRLWHmcu8XruZXveJ00alpk9W2cb6PiuPzfPhI73MOT2ba9oMiOe70Yw
         /MwF85EL1yoppzs1oMiJGI8ooj1aIhvxxAREr6MBYEEj9UBnB3YCagh1M4h1GPgLU1Rr
         NBitYSanAXX5/E0iQGBNCkaq6bFno6BwcGl7Kwi7ZQILTYEolNt5tZ6TOkw/8BuLVprv
         opsTwa+KVoBz8Ic0Feo5qj4Vk+LU6gIBGUPj5/F7xodXjjmlVP5vqctBFxUGjHAPaVl0
         sEz56Y4jpU96xaEzZKo3S3E37uxgmF5Z08hSlspYEZ7w24b0gUacE1XMNBeAOqC312cy
         yPBQ==
X-Gm-Message-State: AOAM533s3srUEccG4dR42kxuJPBmTlnTHNZeXgOkPLg4u4IyB3P//L8b
        mUkI+726+duG6Lm0TlOnVgjOnw==
X-Google-Smtp-Source: ABdhPJwN/Ci1gfYE6T31lK4ORssre4o8LzQde4mpZs6xUlZUI8xRyzor3nfQI2YE7Fci9PFJ611F0Q==
X-Received: by 2002:a17:902:ba8e:b0:13e:c690:5acb with SMTP id k14-20020a170902ba8e00b0013ec6905acbmr29561196pls.63.1634593356116;
        Mon, 18 Oct 2021 14:42:36 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:b911])
        by smtp.gmail.com with ESMTPSA id l19sm13583979pff.131.2021.10.18.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 14:42:35 -0700 (PDT)
Date:   Mon, 18 Oct 2021 14:42:34 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH RFC] btrfs-progs: send protocol v2 stub, UTIMES2, OTIME
Message-ID: <YW3qStSa9LiaankG@relinquished.localdomain>
References: <20211018144109.18442-1-dsterba@suse.com>
 <20211018144717.20275-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018144717.20275-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 18, 2021 at 04:47:17PM +0200, David Sterba wrote:
> This is counterpart for the protocol version update.
> 
> - version 2 protocol
> - new protocol command UTIMES2, same as utimes with additional otime
>   data
> - send: add command line options to specify version, compare against
>   current running kernel supported version
> - receive: parse UTIMES2
> - receive: parse OTIME
> 
> TODO:
> 
> - libbtrfs compatibility is missing, ie. this will break anything that
>   uses send stream (snapper), this needs library version update and
>   maybe some ifdefs in the headers
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  cmds/receive-dump.c  | 31 ++++++++++++++++-
>  cmds/receive.c       | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  cmds/send.c          | 66 ++++++++++++++++++++++++++++++++++--
>  common/send-stream.c | 14 ++++++++
>  common/send-stream.h |  5 +++
>  ioctl.h              | 12 +++++--
>  kernel-shared/send.h | 11 +++++-
>  7 files changed, 212 insertions(+), 6 deletions(-)
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 4d123a1f8782..dfb37a502598 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -967,6 +967,83 @@ static int process_utimes(const char *path, struct timespec *at,
>  	return ret;
>  }
>  
> +static int process_utimes2(const char *path, struct timespec *at,
> +			  struct timespec *mt, struct timespec *ct,
> +			  struct timespec *ot, void *user)
> +{
> +	int ret = 0;
> +	struct btrfs_receive *rctx = user;
> +	char full_path[PATH_MAX];
> +	struct timespec tv[2];
> +
> +	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
> +	if (ret < 0) {
> +		error("utimes2: path invalid: %s", path);
> +		goto out;
> +	}
> +
> +	if (bconf.verbose >= 3)
> +		fprintf(stderr, "utimes2 %s\n", path);
> +
> +	tv[0] = *at;
> +	tv[1] = *mt;
> +	ret = utimensat(AT_FDCWD, full_path, tv, AT_SYMLINK_NOFOLLOW);
> +	if (ret < 0) {
> +		ret = -errno;
> +		error("utimes2 %s failed: %m", path);
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/* TODO: Copied from receive-dump.c */
> +static int sprintf_timespec(struct timespec *ts, char *dest, int max_size)
> +{
> +	struct tm tm;
> +	int ret;
> +
> +	if (!localtime_r(&ts->tv_sec, &tm)) {
> +		error("failed to convert time %lld.%.9ld to local time",
> +		      (long long)ts->tv_sec, ts->tv_nsec);
> +		return -EINVAL;
> +	}
> +	ret = strftime(dest, max_size, "%FT%T%z", &tm);
> +	if (ret == 0) {
> +		error(
> +		"time %lld.%ld is too long to convert into readable string",
> +		      (long long)ts->tv_sec, ts->tv_nsec);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +
> +static int process_otime(const char *path, struct timespec *ot, void *user)
> +{
> +	int ret;
> +	struct btrfs_receive *rctx = user;
> +	char full_path[PATH_MAX];
> +
> +	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
> +	if (ret < 0) {
> +		error("otime: path invalid: %s", path);
> +		goto out;
> +	}
> +
> +	if (bconf.verbose >= 3) {
> +		char ot_str[128];
> +
> +		if (sprintf_timespec(ot, ot_str, sizeof(ot_str) - 1) < 0)
> +			goto out;
> +		fprintf(stderr, "otime %s\n", ot_str);
> +	}
> +
> +out:
> +	return 0;
> +}

Are you planning to do anything with otime (e.g., storing it in an
xattr) in the future?

>  static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
> diff --git a/cmds/send.c b/cmds/send.c
> index 1810233137aa..f529f0b0a6a0 100644
> --- a/cmds/send.c
> +++ b/cmds/send.c
> @@ -57,6 +57,8 @@ struct btrfs_send {
>  	u64 clone_sources_count;
>  
>  	char *root_path;
> +	u32 proto;
> +	u32 proto_supported;
>  };
>  
>  static int get_root_id(struct btrfs_send *sctx, const char *path, u64 *root_id)
> @@ -257,6 +259,13 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
>  	memset(&io_send, 0, sizeof(io_send));
>  	io_send.send_fd = pipefd[1];
>  	send->send_fd = pipefd[0];
> +	io_send.flags = flags;
> +
> +	if (send->proto_supported > 1) {
> +		/* Versioned stream supported, requesting default or specific number */
> +		io_send.version = send->proto;
> +		io_send.flags |= BTRFS_SEND_FLAG_VERSION;
> +	}
>  
>  	if (!ret)
>  		ret = pthread_create(&t_read, NULL, read_sent_data, send);
> @@ -267,7 +276,6 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
>  		goto out;
>  	}
>  
> -	io_send.flags = flags;
>  	io_send.clone_sources = (__u64*)send->clone_sources;
>  	io_send.clone_sources_count = send->clone_sources_count;
>  	io_send.parent_root = parent_root_id;
> @@ -275,6 +283,7 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
>  		io_send.flags |= BTRFS_SEND_FLAG_OMIT_STREAM_HEADER;
>  	if (!is_last_subvol)
>  		io_send.flags |= BTRFS_SEND_FLAG_OMIT_END_CMD;
> +
>  	ret = ioctl(subvol_fd, BTRFS_IOC_SEND, &io_send);
>  	if (ret < 0) {
>  		ret = -errno;
> @@ -419,6 +428,33 @@ static void free_send_info(struct btrfs_send *sctx)
>  	sctx->root_path = NULL;
>  }
>  
> +static u32 get_sysfs_proto_supported(void)
> +{
> +	int fd;
> +	int ret;
> +	char buf[32] = {};
> +	char *end = NULL;
> +	u64 version;
> +
> +	fd = sysfs_open_file("features/send_stream_version");
> +	if (fd < 0) {
> +		/* No file is either no version support or old kernel with just v1 */
> +		return 1;
> +	}
> +	ret = sysfs_read_file(fd, buf, sizeof(buf));
> +	close(fd);
> +	if (ret <= 0)
> +		return 1;
> +	version = strtoull(buf, &end, 10);
> +	if (version == ULLONG_MAX && errno == ERANGE)
> +		return 1;
> +	if (version > U32_MAX) {
> +		warning("sysfs/send_stream_version too big: %llu", version);
> +		version = 1;
> +	}
> +	return version;
> +}
> +
>  static const char * const cmd_send_usage[] = {
>  	"btrfs send [-ve] [-p <parent>] [-c <clone-src>] [-f <outfile>] <subvol> [<subvol>...]",
>  	"Send the subvolume(s) to stdout.",
> @@ -447,6 +483,7 @@ static const char * const cmd_send_usage[] = {
>  	"                 does not contain any file data and thus cannot be used",
>  	"                 to transfer changes. This mode is faster and useful to",
>  	"                 show the differences in metadata.",
> +	"--proto N        request maximum protocol version N (default: highest supported by running kernel)",

Can we default to version 1 and provide a way to opt in to the latest
version? I'm concerned with a kernel upgrade suddenly creating a send
stream that the receiving side can't handle. Making this opt-in rather
than opt-out seems safer.
