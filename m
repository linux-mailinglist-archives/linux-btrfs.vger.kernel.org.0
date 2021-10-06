Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7EB42466D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 21:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhJFTGF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 15:06:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57890 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFTGE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 15:06:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 031DF1FEFB;
        Wed,  6 Oct 2021 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633547051;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogFxNzDNSK6ETmIwgG20g5DRT7J+BoEjxxMDFmts4g8=;
        b=ZLzHSKsQzoFRpZCZ69VldRBlxBs4n+S1ckueIN+L96OtIstN3qMqUHgRERM5MWPSJlAN+2
        awcOQQ8mRGQnSAOAd/icxei4VJbQqT8bqIYBL7UAaTkdlR9EdJgOPKo0dc9qOa5z1u8+fQ
        81GcmW0MkbLgJ4m4ANukFCrNJSPm2gA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633547051;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogFxNzDNSK6ETmIwgG20g5DRT7J+BoEjxxMDFmts4g8=;
        b=Tg9L4EQU0k5UALY29ZHzEAtvrOEXLp4bhcPwe6trNWsiiOrVJwn//ylg2yINH4IogTu++Q
        BroDiym0U8YMBJAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E48F3A3B84;
        Wed,  6 Oct 2021 19:04:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 66D4BDA7F3; Wed,  6 Oct 2021 21:03:50 +0200 (CEST)
Date:   Wed, 6 Oct 2021 21:03:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 2/5] btrfs: change error handling for
 btrfs_delete_*_in_log
Message-ID: <20211006190350.GU9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1633465964.git.josef@toxicpanda.com>
 <e26773a5be8c7e52b6379343514c0b7eb46deb0e.1633465964.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26773a5be8c7e52b6379343514c0b7eb46deb0e.1633465964.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 04:35:24PM -0400, Josef Bacik wrote:
> @@ -3565,49 +3565,36 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
>  	btrfs_free_path(path);
>  out_unlock:
>  	mutex_unlock(&dir->log_mutex);
> -	if (err == -ENOSPC) {
> +	if (err < 0 && err != -ENOENT)
>  		btrfs_set_log_full_commit(trans);
> -		err = 0;
> -	} else if (err < 0 && err != -ENOENT) {
> -		/* ENOENT can be returned if the entry hasn't been fsynced yet */
> -		btrfs_abort_transaction(trans, err);

There was a minor conflict with recent Filipe's cleanups simplifying the
error and ENOENT values, in this case the 'err != -ENOENT' was dropped,
so I resolved it by keeping the condition after Filipe's changes so the
final result is

	if (err < 0)
		btrfs_set_log_full_commit(trans)
