Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655F841DA44
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351157AbhI3MyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:54:01 -0400
Received: from zaphod.cobb.me.uk ([213.138.97.131]:60354 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351051AbhI3MyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:54:00 -0400
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 00DDA9B7C9; Thu, 30 Sep 2021 13:52:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1633006337;
        bh=YZRz6VuEK/Mhz8sYBrw9DJWs6LHe/NGimgMZkTSJKQs=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=Eyel5/TiCMTY9XMXHPZABkk1EWrEk6p5tQMxbENS04+34+uOrnoLYvRPfnicz9rG8
         yQonc2fcWCWnTg3v19a5/XskpFF7L0VKEUUwEp2FwO1m7zDZOFnGmibyDlf0iZUgEK
         5lmFsFilg+mbE+3DjCSfIrbyFcQqZkx2hsBB6sbDxmQYmeBH84uiPWtSkbrTY9cpMW
         DpS2W0mSyv+gi7/OMPd3/x1yERsZbb8HQswKTYfe8ktBvKEBnn+ydM8EvtjilUYXE6
         yIzI5V/SRHLRPfgLwKS1HliGlxU2NoeFxqtPohS5QIPiY236X7OvpaSy2wjAde7txN
         927QcEh3X/9PA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.0 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 88DA19B7C9;
        Thu, 30 Sep 2021 13:47:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1633006036;
        bh=YZRz6VuEK/Mhz8sYBrw9DJWs6LHe/NGimgMZkTSJKQs=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=NcsYIlxLWTO0GsWGyUnxTE0OXlNO5oz2oV5zY7gpb+szhEaBS3dwh06GPs3h9kPbe
         RoACYaxREyd/mC+rhRci1CkH612ePf3TbvJqJ68kK4z+DTGMdkgi9px+Zq3KXawYaY
         mEsky6K1YfJvSFmQIVoZaxeI/LM4tmZqD1yzsthRJOzzENvKQqA85MCorfmhLgO1WP
         xB7vP+8SvbSnMAClxM4dvBR6FspX9tYy3sAAgGL7P8kJT5sMxzSLF2RAvaeUPhrjQH
         pmbbf2mLoqZxKh9V00gI2tANLT/iMZQXzUTmG+qTtrKx2bt9JyKEzF4gXyx0H3TVDx
         ZnfhJMn6W4VIw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 45FE62A3B45;
        Thu, 30 Sep 2021 13:47:16 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210930114855.39225-1-wqu@suse.com>
 <20210930114855.39225-2-wqu@suse.com>
Subject: Re: [PATCH v2 1/2] btrfs-progs: receive: fallback to buffered copy if
 clone failed
Message-ID: <933152a1-e37e-192c-734b-77f5f1735c8b@cobb.uk.net>
Date:   Thu, 30 Sep 2021 13:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210930114855.39225-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/09/2021 12:48, Qu Wenruo wrote:
> [BUG]
> There are two very basic send streams:
> (a/m/ctime and uuid omitted)
> 
>   Stream 1: (Parent subvolume)
>   subvol   ./parent_subv           transid=8
>   chown    ./parent_subv/          gid=0 uid=0
>   chmod    ./parent_subv/          mode=755
>   utimes   ./parent_subv/
>   mkfile   ./parent_subv/o257-7-0
>   rename   ./parent_subv/o257-7-0  dest=./parent_subv/source
>   utimes   ./parent_subv/
>   write    ./parent_subv/source    offset=0 len=16384
>   chown    ./parent_subv/source    gid=0 uid=0
>   chmod    ./parent_subv/source    mode=600
>   utimes   ./parent_subv/source
> 
>   Stream 2: (snapshot and clone)
>   snapshot ./dest_subv             transid=14 parent_transid=10
>   utimes   ./dest_subv/
>   mkfile   ./dest_subv/o258-14-0
>   rename   ./dest_subv/o258-14-0   dest=./dest_subv/reflink
>   utimes   ./dest_subv/
>   clone    ./dest_subv/reflink     offset=0 len=16384 from=./dest_subv/source clone_offset=0
>   chown    ./dest_subv/reflink     gid=0 uid=0
>   chmod    ./dest_subv/reflink     mode=600
>   utimes   ./dest_subv/reflink
> 
> But if we receive the first stream with default mount, then remount to
> nodatasum, and try to receive the second stream, it will fail:
> 
>  # mount /mnt/btrfs
>  # btrfs receive -f ~/parent_stream /mnt/btrfs/
>  At subvol parent_subv
>  # mount -o remount,nodatasum /mnt/btrfs
>  # btrfs receive -f ~/clone_stream /mnt/btrfs/
>  At snapshot dest_subv
>  ERROR: failed to clone extents to reflink: Invalid argument
>  # echo $?
>  1
> 
> [CAUSE]
> Btrfs doesn't allow clone source and destination files have different
> NODATASUM flags.
> This is to prevent a data extent to be owned by both NODATASUM inode and
> regular DATASUM inode.
> 
> For above receive operations, the clone destination is inheriting the
> NODATASUM flag from mount option, while the clone source has no
> NODATASUM flag, thus preventing us from doing the clone.
> 
> [FIX]
> Btrfs send/receive doesn't require the underlying inode has the same
> flags (thus we can send from compressed extent and receive on a
> non-compressed filesystem).
> 
> So here we add a new command line option, '--clone-fallback', to allow
> btrfs-receive to fall back to buffered write to copy data from the
> source file.
> 
> Since such behavior can result much less clone operations, which may not
> be what the end users really want, and can hide bugs in send stream.
> Thus this behavior must be explicitly specified by the new option.
> 
> And we will output a warning message each time such fallback is
> triggered if the user wants extra debug output.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-receive.asciidoc | 12 ++++++
>  cmds/receive.c                       | 62 ++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-receive.asciidoc
> index e4c4d2c0bf3d..9c934a399a9c 100644
> --- a/Documentation/btrfs-receive.asciidoc
> +++ b/Documentation/btrfs-receive.asciidoc
> @@ -65,6 +65,18 @@ dump the stream metadata, one line per operation
>  +
>  Does not require the 'path' parameter. The filesystem remains unchanged.
>  
> +--clone-fallback::
> +when clone opeartions fail, attempt to directly copy the data instead.
> ++
> +When the source and destination filesystems have different sector sizes, or
> +when source and destination files have differnt 'nodatacow' and/or 'nodatasum'

typo: "different"

> +flags (can be set per-file or through mount options), clone operations can fail.
> ++
> +This option makes the receive process attempt to manually copy data from the
> +source to the destination file when a clone operation fails (caused by above
> +reasons). When this happens, extents will end up not being shared
> +between the files, thus will take up more space.

Send/receive and the storage savings available by storing snapshots are
important btrfs features for many sysadmins. I think the documentation
needs to be a bit clearer.

1) It says that the fallback happens when the clone operation fails
"caused by above reasons". Is that right? Is it **only** those cases
that can cause EINVAL error? In the earlier email discussion there was
mention of different compression settings - would that cause a problem?
What about new features like the VerifyFS stuff being worked on (I have
no idea - just choosing a work-in-progress item as an example). If these
are the only two cases, I think there needs to be a code comment in the
kernel code that returns this error that if any other cases are
introduced the documentation for --clone-fallback needs to be updated.

2) In any case, "caused by above reasons" sounds a bit unnatural to me
(native English speaker). I would suggest replacing "(caused by above
reasons)" with "in this way".

3) And maybe add another sentence: "A warning message will be displayed
when this happens, if the --verbose option is in effect".

> +
>  -q|--quiet::
>  (deprecated) alias for global '-q' option
>  
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 48c774cea587..31746d571016 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -76,6 +76,8 @@ struct btrfs_receive
>  	struct subvol_uuid_search sus;
>  
>  	int honor_end_cmd;
> +
> +	bool clone_fallback;
>  };
>  
>  static int finish_subvol(struct btrfs_receive *rctx)
> @@ -705,6 +707,44 @@ out:
>  	return ret;
>  }
>  
> +static int buffered_copy(int src_fd, int dst_fd, u64 src_offset, u64 len,
> +			 u64 dest_offset)
> +{
> +	unsigned char buf[SZ_32K];
> +	u64 copied = 0;
> +	int ret = 0;
> +
> +	while (copied < len) {
> +		u32 copy_len = min_t(u32, ARRAY_SIZE(buf), len - copied);
> +		u32 written = 0;
> +		ssize_t read_size;
> +
> +		read_size = pread(src_fd, buf, copy_len, src_offset + copied);
> +		if (read < 0) {
> +			ret = -errno;
> +			error("failed to read source file: %m");
> +			return ret;
> +		}
> +
> +		/* Write the buffer to dest file */
> +		while (written < read_size) {
> +			ssize_t write_size;
> +
> +			write_size = pwrite(dst_fd, buf + written,
> +					read_size - written,
> +					dest_offset + copied + written);
> +			if (write_size < 0) {
> +				ret = -errno;
> +				error("failed to write source file: %m");
> +				return ret;
> +			}
> +			written += write_size;
> +		}
> +		copied += read_size;
> +	}
> +	return ret;
> +}
> +
>  static int process_clone(const char *path, u64 offset, u64 len,
>  			 const u8 *clone_uuid, u64 clone_ctransid,
>  			 const char *clone_path, u64 clone_offset,
> @@ -788,8 +828,17 @@ static int process_clone(const char *path, u64 offset, u64 len,
>  	ret = ioctl(rctx->write_fd, BTRFS_IOC_CLONE_RANGE, &clone_args);
>  	if (ret < 0) {
>  		ret = -errno;
> -		error("failed to clone extents to %s: %m", path);
> -		goto out;
> +		if (ret != -EINVAL || !rctx->clone_fallback) {
> +			error("failed to clone extents to %s: %m", path);
> +			goto out;
> +		}
> +
> +		if (bconf.verbose >= 2)
> +			warning(
> +		"failed to clone extents to %s, fallback to buffered write",

I think this message needs to tell the user how many bytes which they
expected to be cloned are now being duplicated. Something like "failed
to clone NNNNNN bytes to FILE, fallback to copying data".

Graham

> +				path);
> +		ret = buffered_copy(clone_fd, rctx->write_fd, clone_offset,
> +				    len, offset);
>  	}
>  
>  out:
> @@ -1197,6 +1246,8 @@ static const char * const cmd_receive_usage[] = {
>  	"                 this file system is mounted.",
>  	"--dump           dump stream metadata, one line per operation,",
>  	"                 does not require the MOUNT parameter",
> +	"--clone-fallback when clone operations fail, attempt to directly copy"
> +	"                 the data instead"
>  	"-v               deprecated, alias for global -v option",
>  	HELPINFO_INSERT_GLOBALS,
>  	HELPINFO_INSERT_VERBOSE,
> @@ -1238,11 +1289,13 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
>  	optind = 0;
>  	while (1) {
>  		int c;
> -		enum { GETOPT_VAL_DUMP = 257 };
> +		enum { GETOPT_VAL_DUMP = 257, GETOPT_VAL_CLONE_FALLBACK };
>  		static const struct option long_opts[] = {
>  			{ "max-errors", required_argument, NULL, 'E' },
>  			{ "chroot", no_argument, NULL, 'C' },
>  			{ "dump", no_argument, NULL, GETOPT_VAL_DUMP },
> +			{ "clone-fallback", no_argument, NULL,
> +				GETOPT_VAL_CLONE_FALLBACK},
>  			{ "quiet", no_argument, NULL, 'q' },
>  			{ NULL, 0, NULL, 0 }
>  		};
> @@ -1286,6 +1339,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
>  		case GETOPT_VAL_DUMP:
>  			dump = 1;
>  			break;
> +		case GETOPT_VAL_CLONE_FALLBACK:
> +			rctx.clone_fallback = true;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> 

