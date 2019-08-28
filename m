Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB619A0A5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 21:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH1TTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 15:19:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:38398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726603AbfH1TTb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 15:19:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E0C1AC28
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 19:19:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39A3CDA809; Wed, 28 Aug 2019 21:19:53 +0200 (CEST)
Date:   Wed, 28 Aug 2019 21:19:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] btrfs: create structure to encode checksum type
 and length
Message-ID: <20190828191952.GI2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114834.14789-1-jthumshirn@suse.de>
 <20190826114834.14789-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826114834.14789-3-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 26, 2019 at 01:48:32PM +0200, Johannes Thumshirn wrote:
> Create a structure to encode the type and length for the known on-disk
> checksums.
> 
> This makes it easier to add new checksums later.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> Changes to v2:
> - Really remove initializer macro *doh*
> 
> Changes to v1:
> - Remove initializer macro (David)
> ---
>  fs/btrfs/ctree.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b161224b5a0b..139354d02dfa 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -82,9 +82,12 @@ struct btrfs_ref;
>   */
>  #define BTRFS_LINK_MAX 65535U
>  
> -/* four bytes for CRC32 */
> -static const int btrfs_csum_sizes[] = { 4 };
> -static const char *btrfs_csum_names[] = { "crc32c" };
> +static const struct btrfs_csums {
> +	u16		size;
> +	const char	*name;
> +} btrfs_csums[] = {
> +	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
> +};

In one of the previous iterations, I pointed out that the definition is
in a header, thus each file that includes "ctree.h" (many of them)
has a private copy of the table. With just crc32c it's just a few bytes
that gets lost in the noise but now the table is going to be larger the
impact will be noticeable.
