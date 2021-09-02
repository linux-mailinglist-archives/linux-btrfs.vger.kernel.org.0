Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B073FF161
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346288AbhIBQ3m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 12:29:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51950 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346286AbhIBQ3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 12:29:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0761122628;
        Thu,  2 Sep 2021 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630600123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHTuHQ/BvNjCLTZiSzrN5p5UvUlNpb+q4uDufCy1OS0=;
        b=i7huZaBohG4/linEzQSKCfDRLxyDhFznbwYBl189MwhrHxSlzBVl1/WCYN7Ik9mDyBLgxM
        j2Y3n4VRzn43ZSQlpPX1jI2LL28xq4kIs5Wal5Fh/VPyRN/62XFtc0ZE0mdEAHgjZI8KGW
        IjWR0wc6U/2wHQ0RE6JlnQcEdqWW8zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630600123;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zHTuHQ/BvNjCLTZiSzrN5p5UvUlNpb+q4uDufCy1OS0=;
        b=u0kWqgk2o86HYSYGRf5zravGmmZabmo7AZwM2YXLicB7rGeidLPiTqkbPP0nMNoluHF1zX
        pGrAYxGvH1sbizCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 011ABA3BBA;
        Thu,  2 Sep 2021 16:28:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B7329DA72B; Thu,  2 Sep 2021 18:28:41 +0200 (CEST)
Date:   Thu, 2 Sep 2021 18:28:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: sysfs: introduce qgroup global attribute
 groups
Message-ID: <20210902162840.GA3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210831094903.111432-1-wqu@suse.com>
 <20210831094903.111432-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831094903.111432-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 31, 2021 at 05:48:59PM +0800, Qu Wenruo wrote:
> Although we already have info kobject for each qgroup, we don't have
> global qgroup info attributes to show things like qgroup flags.
> 
> Add this qgroups attribute groups, and the first member is qgroup_flags,
> which is a read-only attribute to show human readable qgroup flags.
> 
> The path is:
>  /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags
> 
> The output would look like:
>  ON | INCONSISTENT

So that's another format of sysfs file, we should try to keep them
consistent or follow common practices. The recommended way for sysfs is
to have one file per value, and here it follows the known states.

So eg

/sys/fs/.../qgroups/enabled		-> 0 or 1
/sys/fs/.../qgroups/inconsistent	-> 0 or 1
...

The files can be also writable so rescan can be triggered from sysfs, or
quotas disabled eventually. For the start exporting the state would be
sufficient though.
