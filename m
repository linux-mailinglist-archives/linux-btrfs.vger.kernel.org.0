Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A05B1B0EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 09:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfEMHLe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 03:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfEMHLe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 03:11:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 309E720C01;
        Mon, 13 May 2019 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557731493;
        bh=JHz55aj1jOXjRyLpFMa6q/x5TIErYcVd6rB/qLKbI+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsTFJpxDlRqld1mSKmfzxVPckOCDOPWTXySJxIYWS6hTv9/JjQvr4L0fksi5bW8Y1
         6G9WCmHtvK8cRkL08gZ1WGb0DVRxpo+8/w22X+TTk1iI7meSibIGfRfHrvm1ibV4XE
         OvyfWlKygzA4OSX2WW8YMUMmKjVzxirK5J5ufKYE=
Date:   Mon, 13 May 2019 09:11:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: btrfs: Fix error path kobject memory leak
Message-ID: <20190513071131.GD2868@kroah.com>
References: <20190513033912.3436-1-tobin@kernel.org>
 <20190513033912.3436-2-tobin@kernel.org>
 <132a9723-98c4-24ea-c04d-ec41124aa5f9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <132a9723-98c4-24ea-c04d-ec41124aa5f9@suse.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 08:59:56AM +0300, Nikolay Borisov wrote:
> 
> 
> On 13.05.19 г. 6:39 ч., Tobin C. Harding wrote:
> > If a call to kobject_init_and_add() fails we must call kobject_put()
> > otherwise we leak memory.
> > 
> > Calling kobject_put() when kobject_init_and_add() fails drops the
> > refcount back to 0 and calls the ktype release method.
> > 
> > Add call to kobject_put() in the error path of call to
> > kobject_init_and_add().
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  fs/btrfs/extent-tree.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index c5880329ae37..5e40c8f1e97a 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -3981,8 +3981,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
> >  				    info->space_info_kobj, "%s",
> >  				    alloc_name(space_info->flags));
> >  	if (ret) {
> > -		percpu_counter_destroy(&space_info->total_bytes_pinned);
> > -		kfree(space_info);
> > +		kobject_put(&space_info->kobj);
> 
> If you are only fixing kobject-related code then why do you delete
> correct code as well? percpu_counter_Destroy is needed to dispose of the
> percpu state which might have been allocated in percpu_counter_init
> based on whether CONFIG_SMP is enabled or not? Also, the call to kfree
> is required.

Both of those will happen in space_info_release() when the kobject is
properly disposed of with this last put to the kobject reference.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
