Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FD832F022
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhCEQco (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 11:32:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231270AbhCEQc2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Mar 2021 11:32:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9CB9ACCF;
        Fri,  5 Mar 2021 16:32:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 547FEDA79B; Fri,  5 Mar 2021 17:30:31 +0100 (CET)
Date:   Fri, 5 Mar 2021 17:30:31 +0100
From:   David Sterba <dsterba@suse.cz>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: Fix checksum output for "checksum verify
 failed"
Message-ID: <20210305163031.GZ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210227200702.11977-1-davispuh@gmail.com>
 <20210303191843.6878-1-davispuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303191843.6878-1-davispuh@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 03, 2021 at 09:18:44PM +0200, Dāvis Mosāns wrote:
> Currently only single checksum byte is outputted.
> This fixes it so that full checksum is outputted.
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
> ---
>  kernel-shared/disk-io.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
> index 6f584986..10b2421e 100644
> --- a/kernel-shared/disk-io.c
> +++ b/kernel-shared/disk-io.c
> @@ -160,10 +160,30 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
>  	return -1;
>  }
>  
> +int btrfs_format_csum(u16 csum_type, u16 csum_size, const char *data, char *output)
> +{
> +	int i;
> +	int position = 0;
> +	int direction = 1;
> +	if (csum_type == BTRFS_CSUM_TYPE_CRC32 ||
> +		csum_type == BTRFS_CSUM_TYPE_XXHASH) {
> +		position = csum_size - 1;
> +		direction = -1;
> +	}

Per the discussion, I've dropped the direction variable and added the
"0x" prefix. The csum_size does not need to be passed, though it's
available in the caller's context. The type should be enough and then
the function can find the size independently.

Updated patch added to devel, thanks.
