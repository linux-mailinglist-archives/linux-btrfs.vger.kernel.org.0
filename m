Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D281A0141
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfH1MG3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 08:06:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfH1MG3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 08:06:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B34CDAF0D;
        Wed, 28 Aug 2019 12:06:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 04D2ADA809; Wed, 28 Aug 2019 14:06:50 +0200 (CEST)
Date:   Wed, 28 Aug 2019 14:06:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] Btrfs: add ioctl for directly writing compressed
 data
Message-ID: <20190828120650.GZ2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1565900769.git.osandov@fb.com>
 <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78747c3028ce91db9856e7fbd98ccbb2609acdc6.1565900769.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:06PM -0700, Omar Sandoval wrote:
>  #define BTRFS_IOC_SEND_32 _IOW(BTRFS_IOCTL_MAGIC, 38, \
>  			       struct btrfs_ioctl_send_args_32)
> +
> +struct btrfs_ioctl_compressed_pwrite_args_32 {
> +	__u64 offset;		/* in */
> +	__u32 compressed_len;	/* in */
> +	__u32 orig_len;		/* in */
> +	__u32 compress_type;	/* in */
> +	__u32 reserved[9];
> +	compat_uptr_t buf;	/* in */
> +} __attribute__ ((__packed__));
> +
> +#define BTRFS_IOC_COMPRESSED_PWRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 63, \
> +				 struct btrfs_ioctl_compressed_pwrite_args_32)

Note that the _32 is a workaround for a mistake in the send ioctl
definitions that slipped trhough. Any pointer in the structure changes
the ioctl number on 32bit and 64bit.

But as the raw data ioctl is new there's point to copy the mistake. The
alignment and width can be forced eg. like

> +	void __user *buf;	/* in */

	union {
		void __user *buf;
		__u64 __buf_alignment;
	};

This allows to user buf as a buffer without casts to a intermediate
type.
