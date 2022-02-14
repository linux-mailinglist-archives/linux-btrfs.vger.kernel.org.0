Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA34B5A95
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Feb 2022 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiBNTf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 14:35:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiBNTf3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 14:35:29 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE53F94F8
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 11:35:11 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id g1so11167170pfv.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 11:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z2y5pX3842jo/xKPhLFpUSkD3CAFZ7hvX+Yz02IOqpw=;
        b=T4cCFZknd4G9ITPZBH/lDtJLJudQNNWi5Lshq/PgVl0qNJWCLTovSldK8fb9MIoQP4
         jn1jCp87xSB0R1LeC2Xq/2wfTr7/K6b0P5Ksk9WmbcIc+OJQFy6nNF1a8go9ZwLSHqoU
         piyNNgY4bx+BNujMxZXfyQ2sbitaHE0p6pUkNFb4V/2TXlUNUCzKewCTtOVNBS+O0qSa
         At/qGsjFLh+eRSEZcr6jxwYUGyx0JO8F1DzkGfK+6lJIX+IYZfyEo6EfiJFAyuRznTqV
         P13+8HtaggiHJMdLHSus1+G/1KM0Kmcl1rMWcGwupp25QhkJNM+uP9YWhR+2gkXnW77I
         AW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z2y5pX3842jo/xKPhLFpUSkD3CAFZ7hvX+Yz02IOqpw=;
        b=f6FqFoG1aL0ITqWYiIMEwZ/NC3eh2KTpW2diT8H4ehhbq5YE72c3bRy7n30jSul38I
         5L1/Y1Gr+lkR3qxl9wJ26TOG92xniUr++DALvI6Na3BSkKi9/A4WkmDVGMWi57HZToue
         OVe5K4ozSm4ApI+dA1dfaFG23S23/XHjXa/n1iVs7JbgA+K+XZZLYRWEw7Z8GYsBoYL7
         TTuw5hS8HnAW9RKYr9yoaZVMqKmW/IdxmwTC17GjG4uxsJb9E/BPwFBNc0t3q2QJRtj0
         nqbyUb/z5pEVHVFe5cisjPTShuYJO8aEaNUZsuFF/Isht7Jp1B+qbF4YcerwLrTMkK9n
         +t+w==
X-Gm-Message-State: AOAM5334MTDBn2J36BW2oa97cglanlQWFDq1BS8Nw0tatRJ6mAh+jC3q
        Y7e/vphgi3eEBs1uNs0LZQnW91Dqayu6EA==
X-Google-Smtp-Source: ABdhPJwpwdh91vCQakG7EexwsfXVyVCStonX6FTCiGq/sgKTthYh6T5T72idCKojlMTaoh2x/XmWaQ==
X-Received: by 2002:a17:903:20c4:: with SMTP id i4mr512319plb.68.1644866356624;
        Mon, 14 Feb 2022 11:19:16 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:c729])
        by smtp.gmail.com with ESMTPSA id l7sm587425pfu.90.2022.02.14.11.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:19:16 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:19:15 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v13 08/17] btrfs: add definitions + documentation for
 encoded I/O ioctls
Message-ID: <YgqrM6Kl/KclUU/+@relinquished.localdomain>
References: <cover.1644519257.git.osandov@fb.com>
 <b12e9cf224a1737ddb3090cc50e1e0f317cb8b65.1644519257.git.osandov@fb.com>
 <20220211181701.GC12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211181701.GC12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 07:17:01PM +0100, David Sterba wrote:
> On Thu, Feb 10, 2022 at 11:09:58AM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > In order to allow sending and receiving compressed data without
> > decompressing it, we need an interface to write pre-compressed data
> > directly to the filesystem and the matching interface to read compressed
> > data without decompressing it. This adds the definitions for ioctls to
> > do that and detailed explanations of how to use them.
> > 
> > Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  include/uapi/linux/btrfs.h | 132 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 132 insertions(+)
> > 
> > diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> > index 1cb1a3860f1d..1a96645243e0 100644
> > --- a/include/uapi/linux/btrfs.h
> > +++ b/include/uapi/linux/btrfs.h
> > @@ -869,6 +869,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
> >  		__u8 align[7];
> >  };
> >  
> > +/*
> > + * Data and metadata for an encoded read or write.
> > + *
> > + * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
> > + * compression). This can be used to read the compressed contents of a file or
> > + * write pre-compressed data directly to a file.
> > + *
> > + * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
> > + * preadv/pwritev with additional metadata about how the data is encoded and the
> > + * size of the unencoded data.
> > + *
> > + * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
> > + * the metadata fields, and returns the size of the encoded data. It reads one
> > + * extent per call. It can also read data which is not encoded.
> > + *
> > + * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
> > + * from the iovecs, and returns the size of the encoded data. Note that the
> > + * encoded data is not validated when it is written; if it is not valid (e.g.,
> > + * it cannot be decompressed), then a subsequent read may return an error.
> > + *
> > + * Since the filesystem page cache contains decoded data, encoded I/O bypasses
> > + * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
> > + */
> > +struct btrfs_ioctl_encoded_io_args {
> > +	/* Input parameters for both reads and writes. */
> > +
> > +	/*
> > +	 * iovecs containing encoded data.
> > +	 *
> > +	 * For reads, if the size of the encoded data is larger than the sum of
> > +	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
> > +	 * ENOBUFS.
> > +	 *
> > +	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
> > +	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
> > +	 * increase in the future). This must also be less than or equal to
> > +	 * unencoded_len.
> > +	 */
> > +	const struct iovec __user *iov;
> > +	/* Number of iovecs. */
> > +	unsigned long iovcnt;
> > +	/*
> > +	 * Offset in file.
> > +	 *
> > +	 * For writes, must be aligned to the sector size of the filesystem.
> > +	 */
> > +	__s64 offset;
> > +	/* Currently must be zero. */
> > +	__u64 flags;
> > +
> > +	/*
> > +	 * For reads, the following members are output parameters that will
> > +	 * contain the returned metadata for the encoded data.
> > +	 * For writes, the following members must be set to the metadata for the
> > +	 * encoded data.
> > +	 */
> > +
> > +	/*
> > +	 * Length of the data in the file.
> > +	 *
> > +	 * Must be less than or equal to unencoded_len - unencoded_offset. For
> > +	 * writes, must be aligned to the sector size of the filesystem unless
> > +	 * the data ends at or beyond the current end of the file.
> > +	 */
> > +	__u64 len;
> > +	/*
> > +	 * Length of the unencoded (i.e., decrypted and decompressed) data.
> > +	 *
> > +	 * For writes, must be no more than 128 KiB (this limit may increase in
> > +	 * the future). If the unencoded data is actually longer than
> > +	 * unencoded_len, then it is truncated; if it is shorter, then it is
> > +	 * extended with zeroes.
> > +	 */
> > +	__u64 unencoded_len;
> > +	/*
> > +	 * Offset from the first byte of the unencoded data to the first byte of
> > +	 * logical data in the file.
> > +	 *
> > +	 * Must be less than unencoded_len.
> > +	 */
> > +	__u64 unencoded_offset;
> > +	/*
> > +	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
> > +	 *
> > +	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
> > +	 */
> > +	__u32 compression;
> > +	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
> > +	__u32 encryption;
> > +	/*
> > +	 * Reserved for future expansion.
> > +	 *
> > +	 * For reads, always returned as zero. Users should check for non-zero
> > +	 * bytes. If there are any, then the kernel has a newer version of this
> > +	 * structure with additional information that the user definition is
> > +	 * missing.
> > +	 *
> > +	 * For writes, must be zeroed.
> > +	 */
> > +	__u8 reserved[32];
> 
> This is 32 bytes, so 4 x u64, that's not bad but for future expanstion
> I'd rather add more than less. Now the structure size is 96 bytes, so if
> it's 128 bytes then it's a power of two and we'd get 64 reserved bytes.

That seems reasonable. This changes the ABI (including the ioctl request
number), so we should probably have it finalized soon. Would you like me
to send another version with this change and the others you mentioned,
or will you fix it in for-next?
