Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B820F7AFC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2019 19:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfG3RZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 13:25:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:45352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbfG3RZD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 13:25:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 215E7AC91
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 17:25:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E433CDA808; Tue, 30 Jul 2019 19:25:36 +0200 (CEST)
Date:   Tue, 30 Jul 2019 19:25:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] btrfs: create structure to encode checksum type
 and length
Message-ID: <20190730172536.GF28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <944b685765a68c3389888159d3fe228c2e78eb22.1564046812.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <944b685765a68c3389888159d3fe228c2e78eb22.1564046812.git.jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 25, 2019 at 11:33:49AM +0200, Johannes Thumshirn wrote:
> Create a structure to encode the type and length for the known on-disk
> checksums. Also add a table and a convenience macro for adding the
> checksum types to the table.
> 
> This makes it easier to add new checksums later.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  fs/btrfs/ctree.h | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index da97ff10f421..099401f5dd47 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -82,9 +82,15 @@ struct btrfs_ref;
>   */
>  #define BTRFS_LINK_MAX 65535U
>  
> -/* four bytes for CRC32 */
> -static const int btrfs_csum_sizes[] = { 4 };
> -static const char *btrfs_csum_names[] = { "crc32c" };
> +#define BTRFS_CHECKSUM_TYPE(_type, _size, _name) \
> +	[_type] = { .size = _size, .name = _name }

I think the macro initializer might be an overkill here, there are only
3 items to initialize.

> +
> +static const struct btrfs_csums {
> +	u16		size;
> +	const char	*name;
> +} btrfs_csums[] = {
> +	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_CRC32, 4, "crc32c"),
> +};
>  
>  #define BTRFS_EMPTY_DIR_SIZE 0
>  
> @@ -2373,13 +2379,13 @@ static inline int btrfs_super_csum_size(const struct btrfs_super_block *s)
>  	/*
>  	 * csum type is validated at mount time
>  	 */
> -	return btrfs_csum_sizes[t];
> +	return btrfs_csums[t].size;
>  }
>  
>  static inline const char *btrfs_super_csum_name(u16 csum_type)
>  {
>  	/* csum type is validated at mount time */
> -	return btrfs_csum_names[csum_type];
> +	return btrfs_csums[csum_type].name;
>  }

This has been in the code already, but shouldn't the btrfs_csums table
be declared in ctree.h and defined in eg. in ctree.c? As ctree.h is
included by everything we have multiple copies of it in the .o files.
