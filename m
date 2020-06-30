Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDA620F9FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbgF3Q6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 12:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:41820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgF3Q6M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 12:58:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CC1DADFF;
        Tue, 30 Jun 2020 16:58:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 45C91DA790; Tue, 30 Jun 2020 18:57:56 +0200 (CEST)
Date:   Tue, 30 Jun 2020 18:57:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200630165756.GB27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200628050715.60961-1-wqu@suse.com>
 <20200628050715.60961-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628050715.60961-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 28, 2020 at 01:07:15PM +0800, Qu Wenruo wrote:
> @@ -1030,6 +1040,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  				btrfs_abort_transaction(trans, ret);
>  				goto out_free_path;
>  			}
> +			ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> +			if (ret < 0) {
> +				btrfs_abort_transaction(trans, ret);
> +				goto out_free_path;
> +			}
>  		}
>  		ret = btrfs_next_item(tree_root, path);
>  		if (ret < 0) {
> @@ -1054,6 +1069,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>  		btrfs_abort_transaction(trans, ret);
>  		goto out_free_path;
>  	}
> +	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
> +	if (ret < 0) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto out_free_path;
> +	}

This adds 2 new transaction abort sites altough I don't think it's
justified, the filesystem is fine. If system is that low on memory it's
gonna be very bad elsewhere too so we don't need to make things worse
jsut because of some missing sysfs entries.

A warning would be better, though in that case the validity of the
kobjects should be double checked where it's accessed.
