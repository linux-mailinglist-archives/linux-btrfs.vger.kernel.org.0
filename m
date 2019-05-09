Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 105F518BC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 16:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfEIOa4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 May 2019 10:30:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44376 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbfEIOaz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 May 2019 10:30:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB9F7ABD4;
        Thu,  9 May 2019 14:30:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 508C8DA8DC; Thu,  9 May 2019 16:31:53 +0200 (CEST)
Date:   Thu, 9 May 2019 16:31:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add comments on locking of several device-related
 fields
Message-ID: <20190509143153.GU20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190507142428.6531-1-nborisov@suse.com>
 <20190509135550.GS20156@twin.jikos.cz>
 <f66548de-3f42-9c07-06c3-c4c9c6b1e4fc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f66548de-3f42-9c07-06c3-c4c9c6b1e4fc@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 09, 2019 at 05:12:16PM +0300, Nikolay Borisov wrote:
> 
> 
> On 9.05.19 г. 16:55 ч., David Sterba wrote:
> > On Tue, May 07, 2019 at 05:24:28PM +0300, Nikolay Borisov wrote:
> >> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >> ---
> >>  fs/btrfs/volumes.h | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> >> index 3b97e8092ba7..514799362244 100644
> >> --- a/fs/btrfs/volumes.h
> >> +++ b/fs/btrfs/volumes.h
> >> @@ -52,8 +52,8 @@ struct btrfs_io_geometry {
> >>  #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
> >>  
> >>  struct btrfs_device {
> >> -	struct list_head dev_list;
> >> -	struct list_head dev_alloc_list;
> >> +	struct list_head dev_list; /* device_list_mutex */
> >> +	struct list_head dev_alloc_list; /* chunk mutex */
> >>  	struct list_head post_commit_list; /* chunk mutex */
> > 
> > Please update the documentation in the comment 'Device locking' in
> > volumes.c
> 
> Right the only thing that is missing from the Device Locking comment is
> the mention of post_commit_list. However, dev_list and dev_alloc_list
> are essentially "the other side" of btrfs_fs_devices::alloc_list  hence
> I've added them as inline comments. I think it makes more sense to those
> small comments next to the variables at least as a remainder.

Ok.
