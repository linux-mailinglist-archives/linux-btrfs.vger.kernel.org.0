Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972E01B0F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 09:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfEMHMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 03:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfEMHMX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 03:12:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF10720578;
        Mon, 13 May 2019 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557731543;
        bh=fREUUL8hSLeUSppJuEINaQ1tuE1nAJUXuGDTwpM4ZOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXVYBTnfGPjLTUxRLLD8GaPFDbHWpO9D3YC+BAvqCYqdusHffXl6XWKy+O9ntL8B0
         iMn9KvFcG3RPfUzN87zzkrUIhV2QMKec2gh2OphTyorrl3VSLXFY7GGew9bGC0h4ca
         YyhsZnscaHYG60ROPIy8cxw4MgmcO2Fb/K0brHf8=
Date:   Mon, 13 May 2019 09:12:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: btrfs: Don't leak memory when failing add fsid
Message-ID: <20190513071221.GE2868@kroah.com>
References: <20190513033912.3436-1-tobin@kernel.org>
 <20190513033912.3436-3-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513033912.3436-3-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 01:39:12PM +1000, Tobin C. Harding wrote:
> A failed call to kobject_init_and_add() must be followed by a call to
> kobject_put().  Currently in the error path when adding fs_devices we
> are missing this call.  This could be fixed by calling
> btrfs_sysfs_remove_fsid() if btrfs_sysfs_add_fsid() returns an error or
> by adding a call to kobject_put() directly in btrfs_sysfs_add_fsid().
> Here we choose the second option because it prevents the slightly
> unusual error path handling requirements of kobject from leaking out
> into btrfs functions.
> 
> Add a call to kobject_put() in the error path of kobject_add_and_init().
> This causes the release method to be called if kobject_init_and_add()
> fails.  open_tree() is the function that calls btrfs_sysfs_add_fsid()
> and the error code in this function is already written with the
> assumption that the release method is called during the error path of
> open_tree() (as seen by the call to btrfs_sysfs_remove_fsid() under the
> fail_fsdev_sysfs label).
> 
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  fs/btrfs/sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 5a5930e3d32b..2f078b77fe14 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -825,7 +825,12 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
>  	fs_devs->fsid_kobj.kset = btrfs_kset;
>  	error = kobject_init_and_add(&fs_devs->fsid_kobj,
>  				&btrfs_ktype, parent, "%pU", fs_devs->fsid);
> -	return error;
> +	if (error) {
> +		kobject_put(&fs_devs->fsid_kobj);
> +		return error;
> +	}
> +
> +	return 0;
>  }
>  
>  int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
