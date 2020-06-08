Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB6A1F1374
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 09:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgFHHUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 03:20:04 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34684 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgFHHUD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 03:20:03 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49gPlj6mnnz2d;
        Mon,  8 Jun 2020 09:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1591600802; bh=7CF+1CKdNm8GCNllAMRnvG5Hsms6sYmngULDLO19SUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/lR8Y7pNw0mEDNs0XSoA4ehD9wqllx15RHoJjvctujCCxVZe0/haB3FsosZVJD1C
         KPeYwNRTQtLy6iGav97H7yT3JyEDSXpG1nQg8aU+LJVEdb4aaE37ZmInl4J25iB/ve
         mEw0pHJ8eCuzgs98AaoUzmGZRQDLe9/Of+mofln78xc5X6qifpiBnBy/nO4fS3ASxq
         BytRiWnIcPV2HnFtwmnfclnaJTnNji+VYp3BVRSMZhtE3119N7UZD0SJT7tlmBRAvt
         NMrVOnDD9rYzAdGxcAet9xudGxQ0Zpdlz3l1bUd/LF/cPJrgD0fjeqltGs2uyE0ABi
         YopzLZbhvCKHA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 8 Jun 2020 09:20:00 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: qgroup: catch reserved space leakage at
 unmount time
Message-ID: <20200608072000.GA6516@qmqm.qmqm.pl>
References: <20200607072512.31721-1-wqu@suse.com>
 <20200607072512.31721-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200607072512.31721-3-wqu@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 07, 2020 at 03:25:12PM +0800, Qu Wenruo wrote:
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c |  6 ++++++
>  fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/qgroup.h  |  2 +-
>  3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index f8ec2d8606fd..48d047e64461 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4058,6 +4058,12 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>  	ASSERT(list_empty(&fs_info->delayed_iputs));
>  	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
>  
> +	if (btrfs_qgroup_has_leak(fs_info)) {
> +		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
> +		     KERN_ERR "BTRFS: qgroup reserved space leaked\n");
> +		btrfs_err(fs_info, "qgroup reserved space leaked\n");
> +	}

This looks like debugging aid, so:

if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
	btrfs_check_qgroup_leak(fs_info);

would be more readable (WARN() pushed to the function).

Best Regards,
Micha³ Miros³aw
