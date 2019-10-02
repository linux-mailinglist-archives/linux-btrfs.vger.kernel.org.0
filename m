Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E5C86F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2019 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfJBLF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Oct 2019 07:05:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:44126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbfJBLF7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Oct 2019 07:05:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26433AD35;
        Wed,  2 Oct 2019 11:05:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E5F8DA88C; Wed,  2 Oct 2019 13:06:15 +0200 (CEST)
Date:   Wed, 2 Oct 2019 13:06:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add device scanned-by process name in the scan
 message
Message-ID: <20191002110615.GK2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570012248-16099-1-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 02, 2019 at 06:30:48PM +0800, Anand Jain wrote:
> Its very helpful if we had logged the device scanner process name
> to debug the race condition between the systemd-udevd scan and the
> user initiated device forget command.
> 
> This patch adds scanned-by process name to the scan message.

Then PID should be printed as well, otherwise ok.

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 788271649726..2c4c89bfafd1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1011,11 +1011,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>  		*new_device_added = true;
>  
>  		if (disk_super->label[0])
> -			pr_info("BTRFS: device label %s devid %llu transid %llu %s\n",
> -				disk_super->label, devid, found_transid, path);
> +			pr_info("BTRFS: device label %s devid %llu transid %llu %s scanned-by %s\n",
> +				disk_super->label, devid, found_transid, path, current->comm);
>  		else
> -			pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s\n",
> -				disk_super->fsid, devid, found_transid, path);
> +			pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s scanned-by %s\n",

			pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s(%d)\n",

I'm not sure if %di si the right specifier for pid, the format name(pid)
can be seen in other messages.
