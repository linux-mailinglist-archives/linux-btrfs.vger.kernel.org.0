Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814E725C0A5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgICLzb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 07:55:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgICLyz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 07:54:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 692DAAD04;
        Thu,  3 Sep 2020 11:54:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB02FDA6E0; Thu,  3 Sep 2020 13:53:41 +0200 (CEST)
Date:   Thu, 3 Sep 2020 13:53:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Only require sector size alignment for parent
 eb bytenr
Message-ID: <20200903115341.GT28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200826092643.113881-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826092643.113881-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 26, 2020 at 05:26:43PM +0800, Qu Wenruo wrote:
> @@ -429,8 +429,9 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
>  	}
>  
>  	btrfs_print_leaf((struct extent_buffer *)eb);
> -	btrfs_err(eb->fs_info, "eb %llu invalid extent inline ref type %d",
> -		  eb->start, type);
> +	btrfs_err(eb->fs_info,
> +		  "eb %llu iref 0x%lu invalid extent inline ref type %d",

So I replied to the previous v2 post by accident but now I see that the
0x%lu problem was reported back then and still present in this v2.
