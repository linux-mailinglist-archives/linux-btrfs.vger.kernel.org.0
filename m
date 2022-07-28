Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4585583E25
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiG1L6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiG1L57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 07:57:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72617691D0
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 04:57:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 311BF20BE4;
        Thu, 28 Jul 2022 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659009475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4DNVS8A82foZXzbSIeMtfpxaX0n+pClvZ4w7lUuuQE=;
        b=M6BOzBxYrIaboGX9Il6F7zIzTZEw7xQcOHRDDVYLbScUhZ7OYwtMxM8ShH/uvq2+hz5vpe
        +UEO/mVoI1JXZFEJZoUynt8yfbjN9I5kYsY8kxRfMtQ9EyEy0J5UyC9ZwP8vVkmaxTR9rd
        /rCu6l495L3m5f85Kw9T9JNosBxU0Bk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659009475;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V4DNVS8A82foZXzbSIeMtfpxaX0n+pClvZ4w7lUuuQE=;
        b=sZBBI5p1A6OJPYaCWKq9XLWp3Gai81aZ3LBr1UzZ+KmzAo51fqJXHH91ay6lwHG4MYTD8u
        LmPLEAQn2qBFYkCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7F9B13A7E;
        Thu, 28 Jul 2022 11:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FtXDM8J54mJYGgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 28 Jul 2022 11:57:54 +0000
Date:   Thu, 28 Jul 2022 13:52:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: receive: add support for fs-verity
Message-ID: <20220728115256.GC13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Boris Burkov <boris@bur.io>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <0854817808a21d1f54910a33c966584c17147893.1658965607.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0854817808a21d1f54910a33c966584c17147893.1658965607.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 27, 2022 at 04:48:21PM -0700, Boris Burkov wrote:
> Process an enable_verity cmd by running the enable verity ioctl on the
> file. Since enabling verity denies write access to the file, it is
> important that we don't have any open write file descriptors.
> 
> This also revs the send stream format to version 3 with no format
> changes besides the new commands and attributes.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  cmds/receive-dump.c  | 10 +++++
>  cmds/receive.c       | 52 ++++++++++++++++++++++++
>  common/send-stream.c | 16 ++++++++
>  common/send-stream.h |  3 ++
>  fsverity.h           | 94 ++++++++++++++++++++++++++++++++++++++++++++

Why do you copy the UAPI kernel file? It's available as linux/fsverity.h
so we should use it. I'd understand to supply own file as fallback in
case we want to build it on older distros where it's not available, but
then the whole fsverity support won't be available.

I don't know what is the lowest version so we might add some runtime
check in case it's not available for the case when a stream with verity
records is received on kernel without verity support.

I'd rather not make verity support optinal during build if the fallback
header works.

>  kernel-shared/send.h | 13 +++++-
>  6 files changed, 186 insertions(+), 2 deletions(-)
>  create mode 100644 fsverity.h
> 
> diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
> index 92e0a4c9a..5d68ecbca 100644
> --- a/cmds/receive-dump.c
> +++ b/cmds/receive-dump.c
> @@ -344,6 +344,15 @@ static int print_fileattr(const char *path, u64 attr, void *user)
>  	return PRINT_DUMP(user, path, "fileattr", "fileattr=0x%llu", attr);
>  }
>  
> +static int print_enable_verity (const char *path, u8 algorithm, u32 block_size,
> +				int salt_len, char *salt,
> +				int sig_len, char *sig, void *user)
> +{
> +	return PRINT_DUMP(user, path, "enable_verity",
> +			  "algorithm=%u block_size=%u salt_len=%d sig_len=%d",
> +			  algorithm, block_size, salt_len, sig_len);
> +}
> +
>  struct btrfs_send_ops btrfs_print_send_ops = {
>  	.subvol = print_subvol,
>  	.snapshot = print_snapshot,
> @@ -369,4 +378,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
>  	.encoded_write = print_encoded_write,
>  	.fallocate = print_fallocate,
>  	.fileattr = print_fileattr,
> +	.enable_verity = print_enable_verity,
>  };
> diff --git a/cmds/receive.c b/cmds/receive.c
> index aec324587..8ff5e3b10 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -63,6 +63,8 @@
>  #include "common/path-utils.h"
>  #include "stubs.h"
>  

No newline

> +#include "fsverity.h"
> +
>  struct btrfs_receive
>  {
>  	int mnt_fd;
> @@ -1333,6 +1335,55 @@ static int process_fileattr(const char *path, u64 attr, void *user)
>  	return 0;
>  }
>  
> +static int process_enable_verity(const char *path, u8 algorithm, u32 block_size,
> +				 int salt_len, char *salt,
> +				 int sig_len, char *sig, void *user)
> +{
> +	int ret;
> +	struct btrfs_receive *rctx = user;
> +	char full_path[PATH_MAX];
> +	struct fsverity_enable_arg verity_args = {
> +		.version = 1,
> +		.hash_algorithm = algorithm,
> +		.block_size = block_size,
> +	};
> +	if (salt_len) {
> +		verity_args.salt_size = salt_len;
> +		verity_args.salt_ptr = (__u64)salt;
> +	}
> +	if (sig_len) {
> +		verity_args.sig_size = sig_len;
> +		verity_args.sig_ptr = (__u64)sig;
> +	}
> +	int ioctl_fd;
> +
> +	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
> +	if (ret < 0) {
> +		error("write: path invalid: %s", path);
> +		goto out;
> +	}
> +
> +	ioctl_fd = open(full_path, O_RDONLY);
> +	if (ioctl_fd < 0) {
> +		ret = -errno;
> +		error("cannot open %s for verity ioctl: %m", full_path);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Enabling verity denies write access, so it cannot be done with an
> +	 * open writeable file descriptor.
> +	 */
> +	close_inode_for_write(rctx);
> +	ret = ioctl(ioctl_fd, FS_IOC_ENABLE_VERITY, &verity_args);
> +	if (ret < 0)
> +		fprintf(stderr, "Failed to enable verity on %s: %d\n", full_path, ret);
> +
> +	close(ioctl_fd);
> +out:
> +	return ret;
> +}
> +
>  static struct btrfs_send_ops send_ops = {
>  	.subvol = process_subvol,
>  	.snapshot = process_snapshot,
> @@ -1358,6 +1409,7 @@ static struct btrfs_send_ops send_ops = {
>  	.encoded_write = process_encoded_write,
>  	.fallocate = process_fallocate,
>  	.fileattr = process_fileattr,
> +	.enable_verity = process_enable_verity,
>  };
>  
>  static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
> diff --git a/common/send-stream.c b/common/send-stream.c
> index 96d1aa218..1a0c0a5b0 100644
> --- a/common/send-stream.c
> +++ b/common/send-stream.c
> @@ -353,6 +353,12 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
>  	char *xattr_name = NULL;
>  	void *xattr_data = NULL;
>  	void *data = NULL;
> +	u8 verity_algorithm;
> +	u32 verity_block_size;
> +	int verity_salt_len;
> +	void *verity_salt = NULL;
> +	int verity_sig_len;
> +	void *verity_sig = NULL;
>  	struct timespec at;
>  	struct timespec ct;
>  	struct timespec mt;
> @@ -537,6 +543,16 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
>  		TLV_GET_U64(sctx, BTRFS_SEND_A_SIZE, &tmp);
>  		ret = sctx->ops->update_extent(path, offset, tmp, sctx->user);
>  		break;
> +	case BTRFS_SEND_C_ENABLE_VERITY:
> +		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
> +		TLV_GET_U8(sctx, BTRFS_SEND_A_VERITY_ALGORITHM, &verity_algorithm);
> +		TLV_GET_U32(sctx, BTRFS_SEND_A_VERITY_BLOCK_SIZE, &verity_block_size);
> +		TLV_GET(sctx, BTRFS_SEND_A_VERITY_SALT_DATA, &verity_salt, &verity_salt_len);
> +		TLV_GET(sctx, BTRFS_SEND_A_VERITY_SIG_DATA, &verity_sig, &verity_sig_len);
> +		ret = sctx->ops->enable_verity(path, verity_algorithm, verity_block_size,
> +					       verity_salt_len, verity_salt,
> +					       verity_sig_len, verity_sig, sctx->user);
> +		break;
>  	case BTRFS_SEND_C_END:
>  		ret = 1;
>  		break;
> diff --git a/common/send-stream.h b/common/send-stream.h
> index b5973b66f..6649b55b9 100644
> --- a/common/send-stream.h
> +++ b/common/send-stream.h
> @@ -60,6 +60,9 @@ struct btrfs_send_ops {
>  	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
>  			 void *user);
>  	int (*fileattr)(const char *path, u64 attr, void *user);
> +	int (*enable_verity)(const char *path, u8 algorithm, u32 block_size,
> +			     int salt_len, char *salt,
> +			     int sig_len, char *sig, void *user);
>  };
>  
>  int btrfs_read_and_process_send_stream(int fd,
> diff --git a/fsverity.h b/fsverity.h
> new file mode 100644
> index 000000000..291ab4db9
> --- /dev/null
> +++ b/fsverity.h
> @@ -0,0 +1,94 @@
> +#ifndef _UAPI_LINUX_FSVERITY_H
> +#define _UAPI_LINUX_FSVERITY_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +#define FS_VERITY_HASH_ALG_SHA256	1
> +#define FS_VERITY_HASH_ALG_SHA512	2
> +
> +struct fsverity_enable_arg {
> +	__u32 version;
> +	__u32 hash_algorithm;
> +	__u32 block_size;
> +	__u32 salt_size;
> +	__u64 salt_ptr;
> +	__u32 sig_size;
> +	__u32 __reserved1;
> +	__u64 sig_ptr;
> +	__u64 __reserved2[11];
> +};
> +
> +struct fsverity_digest {
> +	__u16 digest_algorithm;
> +	__u16 digest_size; /* input/output */
> +	__u8 digest[];
> +};
> +
> +/*
> + * Struct containing a file's Merkle tree properties.  The fs-verity file digest
> + * is the hash of this struct.  A userspace program needs this struct only if it
> + * needs to compute fs-verity file digests itself, e.g. in order to sign files.
> + * It isn't needed just to enable fs-verity on a file.
> + *
> + * Note: when computing the file digest, 'sig_size' and 'signature' must be left
> + * zero and empty, respectively.  These fields are present only because some
> + * filesystems reuse this struct as part of their on-disk format.
> + */
> +struct fsverity_descriptor {
> +	__u8 version;		/* must be 1 */
> +	__u8 hash_algorithm;	/* Merkle tree hash algorithm */
> +	__u8 log_blocksize;	/* log2 of size of data and tree blocks */
> +	__u8 salt_size;		/* size of salt in bytes; 0 if none */
> +#ifdef __KERNEL__
> +	__le32 sig_size;
> +#else
> +	__le32 __reserved_0x04;	/* must be 0 */
> +#endif
> +	__le64 data_size;	/* size of file the Merkle tree is built over */
> +	__u8 root_hash[64];	/* Merkle tree root hash */
> +	__u8 salt[32];		/* salt prepended to each hashed block */
> +	__u8 __reserved[144];	/* must be 0's */
> +#ifdef __KERNEL__
> +	__u8 signature[];
> +#endif
> +};
> +
> +/*
> + * Format in which fs-verity file digests are signed in built-in signatures.
> + * This is the same as 'struct fsverity_digest', except here some magic bytes
> + * are prepended to provide some context about what is being signed in case the
> + * same key is used for non-fsverity purposes, and here the fields have fixed
> + * endianness.
> + *
> + * This struct is specific to the built-in signature verification support, which
> + * is optional.  fs-verity users may also verify signatures in userspace, in
> + * which case userspace is responsible for deciding on what bytes are signed.
> + * This struct may still be used, but it doesn't have to be.  For example,
> + * userspace could instead use a string like "sha256:$digest_as_hex_string".
> + */
> +struct fsverity_formatted_digest {
> +	char magic[8];			/* must be "FSVerity" */
> +	__le16 digest_algorithm;
> +	__le16 digest_size;
> +	__u8 digest[];
> +};
> +
> +#define FS_VERITY_METADATA_TYPE_MERKLE_TREE	1
> +#define FS_VERITY_METADATA_TYPE_DESCRIPTOR	2
> +#define FS_VERITY_METADATA_TYPE_SIGNATURE	3
> +
> +struct fsverity_read_metadata_arg {
> +	__u64 metadata_type;
> +	__u64 offset;
> +	__u64 length;
> +	__u64 buf_ptr;
> +	__u64 __reserved;
> +};
> +
> +#define FS_IOC_ENABLE_VERITY	_IOW('f', 133, struct fsverity_enable_arg)
> +#define FS_IOC_MEASURE_VERITY	_IOWR('f', 134, struct fsverity_digest)
> +#define FS_IOC_READ_VERITY_METADATA \
> +	_IOWR('f', 135, struct fsverity_read_metadata_arg)
> +
> +#endif /* _UAPI_LINUX_FSVERITY_H */
> diff --git a/kernel-shared/send.h b/kernel-shared/send.h
> index 0236d9fd8..db1bec19f 100644
> --- a/kernel-shared/send.h
> +++ b/kernel-shared/send.h
> @@ -102,8 +102,10 @@ enum btrfs_send_cmd {
>  	BTRFS_SEND_C_ENCODED_WRITE	= 25,
>  	BTRFS_SEND_C_MAX_V2		= 25,
>  
> +	BTRFS_SEND_C_ENABLE_VERITY	= 26,
> +	BTRFS_SEND_C_MAX_V3		= 26,
>  	/* End */
> -	BTRFS_SEND_C_MAX		= 25,
> +	BTRFS_SEND_C_MAX		= 26,
>  };
>  
>  /* attributes in send stream */
> @@ -170,8 +172,15 @@ enum {
>  	BTRFS_SEND_A_ENCRYPTION		= 31,
>  	BTRFS_SEND_A_MAX_V2		= 31,
>  
> +	/* Version 3 */
> +	BTRFS_SEND_A_VERITY_ALGORITHM	= 32,
> +	BTRFS_SEND_A_VERITY_BLOCK_SIZE	= 33,
> +	BTRFS_SEND_A_VERITY_SALT_DATA	= 34,
> +	BTRFS_SEND_A_VERITY_SIG_DATA	= 35,
> +	BTRFS_SEND_A_MAX_V3		= 35,
> +
>  	/* End */
> -	BTRFS_SEND_A_MAX		= 31,
> +	BTRFS_SEND_A_MAX		= 35,
>  };
>  
>  #endif
> -- 
> 2.37.1
