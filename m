Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CA25C088
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 13:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgICLrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 07:47:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:45570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728623AbgICLqV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 07:46:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CD48AC55;
        Thu,  3 Sep 2020 11:46:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9C2F9DA6E0; Thu,  3 Sep 2020 13:44:55 +0200 (CEST)
Date:   Thu, 3 Sep 2020 13:44:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Only require sector size alignment for parent
 eb bytenr
Message-ID: <20200903114455.GS28318@twin.jikos.cz>
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

0x needs %lx, fixed and added to misc-next, thanks.
