Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6F4B2CB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 19:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiBKSUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 13:20:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiBKSUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 13:20:46 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D091C13A
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 10:20:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D96B21138;
        Fri, 11 Feb 2022 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644603643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pd+aovPvdK4U3gqLki/2e4CcyN9rWD+qIItUer81GoQ=;
        b=yCQdGLj7dwiGtBWU88KBUAp17qcNRehzhFZ8sg9BHB8aUk8XEPD9QD8YYqrgAgXoNkCttN
        +tlm6AIY7cWPYu2b3Ua+hOlNem/5OxSQnpS3u8cWAmHZfXyuxFrt7UxgtPDH1IwVckYtM3
        xXuMW4mR6xpW0kQwq2UTaLJxxpGmWHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644603643;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pd+aovPvdK4U3gqLki/2e4CcyN9rWD+qIItUer81GoQ=;
        b=/l0xCWB1eGSWDKI+OxvHGmRn+6NmwlBhgIRv7412tSQhtb1i1wLduTMoYnchKvzrGRZEWn
        DqLS1gsxoKkwl6Cw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 82DBBA3B83;
        Fri, 11 Feb 2022 18:20:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7DBB6DA823; Fri, 11 Feb 2022 19:17:01 +0100 (CET)
Date:   Fri, 11 Feb 2022 19:17:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 08/17] btrfs: add definitions + documentation for
 encoded I/O ioctls
Message-ID: <20220211181701.GC12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1644519257.git.osandov@fb.com>
 <b12e9cf224a1737ddb3090cc50e1e0f317cb8b65.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12e9cf224a1737ddb3090cc50e1e0f317cb8b65.1644519257.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 10, 2022 at 11:09:58AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In order to allow sending and receiving compressed data without
> decompressing it, we need an interface to write pre-compressed data
> directly to the filesystem and the matching interface to read compressed
> data without decompressing it. This adds the definitions for ioctls to
> do that and detailed explanations of how to use them.
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  include/uapi/linux/btrfs.h | 132 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 132 insertions(+)
> 
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 1cb1a3860f1d..1a96645243e0 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -869,6 +869,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
>  		__u8 align[7];
>  };
>  
> +/*
> + * Data and metadata for an encoded read or write.
> + *
> + * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
> + * compression). This can be used to read the compressed contents of a file or
> + * write pre-compressed data directly to a file.
> + *
> + * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
> + * preadv/pwritev with additional metadata about how the data is encoded and the
> + * size of the unencoded data.
> + *
> + * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
> + * the metadata fields, and returns the size of the encoded data. It reads one
> + * extent per call. It can also read data which is not encoded.
> + *
> + * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
> + * from the iovecs, and returns the size of the encoded data. Note that the
> + * encoded data is not validated when it is written; if it is not valid (e.g.,
> + * it cannot be decompressed), then a subsequent read may return an error.
> + *
> + * Since the filesystem page cache contains decoded data, encoded I/O bypasses
> + * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
> + */
> +struct btrfs_ioctl_encoded_io_args {
> +	/* Input parameters for both reads and writes. */
> +
> +	/*
> +	 * iovecs containing encoded data.
> +	 *
> +	 * For reads, if the size of the encoded data is larger than the sum of
> +	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
> +	 * ENOBUFS.
> +	 *
> +	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
> +	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
> +	 * increase in the future). This must also be less than or equal to
> +	 * unencoded_len.
> +	 */
> +	const struct iovec __user *iov;
> +	/* Number of iovecs. */
> +	unsigned long iovcnt;
> +	/*
> +	 * Offset in file.
> +	 *
> +	 * For writes, must be aligned to the sector size of the filesystem.
> +	 */
> +	__s64 offset;
> +	/* Currently must be zero. */
> +	__u64 flags;
> +
> +	/*
> +	 * For reads, the following members are output parameters that will
> +	 * contain the returned metadata for the encoded data.
> +	 * For writes, the following members must be set to the metadata for the
> +	 * encoded data.
> +	 */
> +
> +	/*
> +	 * Length of the data in the file.
> +	 *
> +	 * Must be less than or equal to unencoded_len - unencoded_offset. For
> +	 * writes, must be aligned to the sector size of the filesystem unless
> +	 * the data ends at or beyond the current end of the file.
> +	 */
> +	__u64 len;
> +	/*
> +	 * Length of the unencoded (i.e., decrypted and decompressed) data.
> +	 *
> +	 * For writes, must be no more than 128 KiB (this limit may increase in
> +	 * the future). If the unencoded data is actually longer than
> +	 * unencoded_len, then it is truncated; if it is shorter, then it is
> +	 * extended with zeroes.
> +	 */
> +	__u64 unencoded_len;
> +	/*
> +	 * Offset from the first byte of the unencoded data to the first byte of
> +	 * logical data in the file.
> +	 *
> +	 * Must be less than unencoded_len.
> +	 */
> +	__u64 unencoded_offset;
> +	/*
> +	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
> +	 *
> +	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
> +	 */
> +	__u32 compression;
> +	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
> +	__u32 encryption;
> +	/*
> +	 * Reserved for future expansion.
> +	 *
> +	 * For reads, always returned as zero. Users should check for non-zero
> +	 * bytes. If there are any, then the kernel has a newer version of this
> +	 * structure with additional information that the user definition is
> +	 * missing.
> +	 *
> +	 * For writes, must be zeroed.
> +	 */
> +	__u8 reserved[32];

This is 32 bytes, so 4 x u64, that's not bad but for future expanstion
I'd rather add more than less. Now the structure size is 96 bytes, so if
it's 128 bytes then it's a power of two and we'd get 64 reserved bytes.
