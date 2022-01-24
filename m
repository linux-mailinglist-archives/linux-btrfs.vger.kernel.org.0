Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B608499088
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 21:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350418AbiAXUBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 15:01:02 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58604 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359136AbiAXT40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 14:56:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87C4D218E2;
        Mon, 24 Jan 2022 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643054185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZNefG1/mRTouCOvvEp9qwcrO52bTYFuA5rGc58D7Q4=;
        b=W5c/cMmedhiG+HE2qr+1SwOpYTcGikSlFhwEZkYvIEuO1HwYpm4kG8E8Yw40uB9VaqhTiQ
        tuC7YOrTnaDR+dtiRLZyMv4TKtOZ66dswEIiHuFkNlaEESIJtZbQJxM/hzHCF1VnxdiX9m
        pRdxbotQvxJRY18gwgQYu2pOLgoJReI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643054185;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZNefG1/mRTouCOvvEp9qwcrO52bTYFuA5rGc58D7Q4=;
        b=kIhMKime3S3YOfaJcNsD3IX7FmWGn/15iCb7RCcpz5088/WfJ+UnFnwc7DovzRMFNd6ogV
        JuAaN45ehfUxnzCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7AA96A3B81;
        Mon, 24 Jan 2022 19:56:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9245DDA7A3; Mon, 24 Jan 2022 20:55:45 +0100 (CET)
Date:   Mon, 24 Jan 2022 20:55:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: move QUOTA_ENABLED check to rescan_should_stop
 from btrfs_qgroup_rescan_worker
Message-ID: <20220124195545.GG14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220113151618.2149736-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113151618.2149736-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 13, 2022 at 05:16:18PM +0200, Nikolay Borisov wrote:
> Instead of having 2 places that short circuit the qgroup leaf scan have
> everything in the qgroup_rescan_leaf function. In addition to that, also
> ensure that the inconsistent qgroup flag is set when rescan_should_stop
> returns true. This both retains the old behavior when -EINTR was set
> in the body of the loop and at the same time also extends this behavior when
> scanning is interrupted due to remount or unmount operations.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.
