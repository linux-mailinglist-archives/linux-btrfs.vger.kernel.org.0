Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDC2DD684
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgLQRqZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 12:46:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgLQRqZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 12:46:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8C58ACA5;
        Thu, 17 Dec 2020 17:45:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A88F4DA83A; Thu, 17 Dec 2020 18:44:03 +0100 (CET)
Date:   Thu, 17 Dec 2020 18:44:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: fix transaction leak and crash after RO
 remount caused by qgroup rescan
Message-ID: <20201217174403.GW6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <cover.1607940240.git.fdmanana@suse.com>
 <21e034b59ba97c7f39086e77e08250dcad172717.1607940240.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e034b59ba97c7f39086e77e08250dcad172717.1607940240.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 10:10:45AM +0000, fdmanana@kernel.org wrote:
> +static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
> +{
> +	return btrfs_fs_closing(fs_info) ||
> +		test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
> +}
> +
>  static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  {
>  	struct btrfs_fs_info *fs_info = container_of(work, struct btrfs_fs_info,
> @@ -3198,6 +3204,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  	struct btrfs_trans_handle *trans = NULL;
>  	int err = -ENOMEM;
>  	int ret = 0;
> +	bool stopped = false;
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -3210,7 +3217,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  	path->skip_locking = 1;
>  
>  	err = 0;
> -	while (!err && !btrfs_fs_closing(fs_info)) {
> +	while (!err && !(stopped = rescan_should_stop(fs_info))) {
>  		trans = btrfs_start_transaction(fs_info->fs_root, 0);
>  		if (IS_ERR(trans)) {
>  			err = PTR_ERR(trans);
> @@ -3253,7 +3260,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  	}
>  
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	if (!btrfs_fs_closing(fs_info))
> +	if (!stopped)
>  		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
>  	if (trans) {
>  		ret = update_qgroup_status_item(trans);
> @@ -3272,7 +3279,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  
>  	btrfs_end_transaction(trans);
>  
> -	if (btrfs_fs_closing(fs_info)) {
> +	if (stopped) {

Thinking aloud, this is slightly different as it uses the cached status
of fs_closing but there is mutex lock/unlock or transaction start/end
between the checks so the status could change.

But as the flow goes, we want to get fresh status in the while loop.
Once it stops because of the fs_closing or remount request, the
following code does the qgroup status update, wakeups, even tough this
means one more transaction. Remount needs to sync anyway and this should
be no problem.
