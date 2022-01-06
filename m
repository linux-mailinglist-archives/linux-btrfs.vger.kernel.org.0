Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B661848668F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbiAFPLx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 10:11:53 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46218 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiAFPLw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 10:11:52 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A5877210E7;
        Thu,  6 Jan 2022 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641481911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpxvJOOndxqvvx+GBU2TEAxlAHgAkkMrfNIhd0bTHEY=;
        b=XqUVy9wiLh2Z3iOATLwOmuk7pEKG/xwLJkmnitkGefOBugzWHAT4EW+RXfkXL2voSC+C3E
        jKTCxw8i6NsD3OvTqNc8RdHh7t9D6ezCew3XnNeqdY6vniRCasFH7zDUJf9MCqffCikd+/
        GOZhGHU1TgF5oy3X0t8EHxfnmYVdOAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641481911;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DpxvJOOndxqvvx+GBU2TEAxlAHgAkkMrfNIhd0bTHEY=;
        b=+IC3Bp/reT7aYwbEr00ZUtFAUpSJG/eGhA5CrP3mynGuSBjFsfeJw8pYbZDe14kkTb2nam
        wyMND4uLUl7AgKAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 9E21AA3B83;
        Thu,  6 Jan 2022 15:11:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4F633DA799; Thu,  6 Jan 2022 16:11:21 +0100 (CET)
Date:   Thu, 6 Jan 2022 16:11:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/1] btrfs: reuse existing pointers from btrfs_ioctl
Message-ID: <20220106151121.GE14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
References: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
 <74fcaf5f-13f9-dfa0-0576-8a6da3cc8060@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fcaf5f-13f9-dfa0-0576-8a6da3cc8060@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 05:30:20PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/1/5 16:30, Sahil Kang wrote:
> > This is a small cleanup that reuses some of the existing pointers and
> > removes the duplicated dereferencing.
> 
> Some quick glance indeed shows that we have pretty inconsistent
> arguments for a lot of ioctls, mostly switching between file/inode.
> 
> So the cleanup looks good to me.

Agreed.

> But I also find that, there are ioctl sub-routines that requires file as
> it needs to call mnt_want_write_file().

I've noticed there are some calls to file_mnt_user_ns that use the file.

> I know I'm asking for too much, but maybe it's a good idea to separate
> those ioctl sub-routines into two types:
> 
> - Those write ioctls which need @file to do mnt_want_write_file() check
>    So they can use the existing @file argument as usual
> 
> - Those read-only ioctls which don't need @file at all
>    Then pass @inode/@root to those functions.
>    (Personally speaking I prefer to pass @inode and let sub-routines to
>     handle the root grabbing)

The main switch function btrfs_ioctl extracts all the pointers so I'd
suggest to pass only the one that the ioctl callbacks need, ie. not an
inode if it's just for the root pointer.
