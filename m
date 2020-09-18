Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15927003E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIROxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 10:53:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgIROxK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 10:53:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A56AAB306;
        Fri, 18 Sep 2020 14:53:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 248C5DA6E0; Fri, 18 Sep 2020 16:51:56 +0200 (CEST)
Date:   Fri, 18 Sep 2020 16:51:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com,
        josef@toxicpanda.com, anand.jain@oracle.com
Subject: Re: [PATCH] btrfs: fix overflow when copying corrupt csums
Message-ID: <20200918145155.GG6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com,
        josef@toxicpanda.com, anand.jain@oracle.com
References: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 11:49:31PM +0900, Johannes Thumshirn wrote:
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -587,15 +587,15 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
>  
>  	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
>  		u32 val;
> -		u32 found = 0;
> +		u8 found[BTRFS_CSUM_SIZE] = { };
>  
>  		memcpy(&found, result, csum_size);

3x shame on us all giving it a reviewed-by: there are two buffer
overflows but the patch fixes just one.

'found' is filled from from the result

>  		read_extent_buffer(eb, &val, 0, csum_size);

and what about 'val' that's read from eb as well?

Funny is that no copying needs to be done at all, we can use 'result'
directly and also use the fact that checksum is at the beginning of the
first eb page and we can just set the pointer for the message.
