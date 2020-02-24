Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0440816AFF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 20:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgBXTIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 14:08:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBXTIs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 14:08:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDEC2AC8F;
        Mon, 24 Feb 2020 19:08:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E62D7DA727; Mon, 24 Feb 2020 20:08:27 +0100 (CET)
Date:   Mon, 24 Feb 2020 20:08:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: drop math for block_reserved which is block_rsv
 size
Message-ID: <20200224190827.GD2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <1580814358-1468-1-git-send-email-anand.jain@oracle.com>
 <f35d657a-bbee-119c-793d-9871d0fc2c65@suse.com>
 <a230e596-887c-51f5-8e4a-e800406774c3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a230e596-887c-51f5-8e4a-e800406774c3@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 04, 2020 at 08:46:04PM +0800, Anand Jain wrote:
> 
> 
> On 2/4/20 7:10 PM, Nikolay Borisov wrote:
> > 
> > 
> > On 4.02.20 г. 13:05 ч., Anand Jain wrote:
> >> In btrfs_update_global_block_rsv the lines
> >>    num_bytes = block_rsv->size - block_rsv->reserved;
> >>    block_rsv->reserved += num_bytes;
> >> imply
> >>    block_rsv->reserved = block_rsv->size;
> >>
> >> Just assign block_rsv->size to block_rsv->reserved instead of the math.
> >>
> >> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> >> ---
> >>   fs/btrfs/block-rsv.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> >> index 6dacde9a7e93..62e0885c1e5d 100644
> >> --- a/fs/btrfs/block-rsv.c
> >> +++ b/fs/btrfs/block-rsv.c
> >> @@ -304,9 +304,9 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
> >>   
> >>   	if (block_rsv->reserved < block_rsv->size) {
> >>   		num_bytes = block_rsv->size - block_rsv->reserved;
> >> -		block_rsv->reserved += num_bytes;
> >>   		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
> >>   						      num_bytes);
> >> +		block_rsv->reserved = block_rsv->size;
> > 
> > Any particular reason why you put the assignment after
> > btrfs_space_info_update_bytes_may_use and not before?
> 
>   Oh. To make it similar to the else if part below.

Makes sense. For cleanup patches, such things can be mentioned in the
changelog, reordering lines may have indirect implications eg. if the
block_rsv would be used in btrfs_space_info_update_bytes_may_use (but it
is not). Patch added to misc-next, thanks.
