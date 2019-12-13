Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC8F11E386
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLMMYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 07:24:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:35016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfLMMYD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 07:24:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8360ACF1;
        Fri, 13 Dec 2019 12:24:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B9B57DA82A; Fri, 13 Dec 2019 13:24:01 +0100 (CET)
Date:   Fri, 13 Dec 2019 13:24:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: fix compressed write bio attribution
Message-ID: <20191213122401.GV3929@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <d934383ea528d920a95b6107daad6023b516f0f4.1576109087.git.dennis@kernel.org>
 <b3b4b89e7200237d0407c5f0a1f48d2d3736b5ed.1576109087.git.dennis@kernel.org>
 <20191212181934.GA33645@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212181934.GA33645@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 10:19:34AM -0800, Dennis Zhou wrote:
> From a0569aebde08e31e994c92d0b70befb84f7f5563 Mon Sep 17 00:00:00 2001
> From: Dennis Zhou <dennis@kernel.org>
> Date: Wed, 11 Dec 2019 15:20:15 -0800
> 
> Bio attribution is handled at bio_set_dev() as once we have a device, we
> have a corresponding request_queue and then can derive the current css.
> In special cases, we want to attribute to bio to someone else. This can
> be done by calling bio_associate_blkg_from_css() or
> kthread_associate_blkcg() depending on the scenario. Btrfs does this for
> compressed writeback as they are handled by kworkers, so the latter can
> be done here.
> 
> Commit 1a41802701ec ("btrfs: drop bio_set_dev where not needed") removes
> early bio_set_dev() calls prior to submit_stripe_bio(). This breaks the
> above assumption that we'll have a request_queue when we are doing
> association. To fix this, switch to using kthread_associate_blkcg().

Can be kthread_associate_blkcg used also for submit_extent_page that
calls bio_associate_blkg_from_css indirectly when initializing wbc?

2996                 bio_set_dev(bio, bdev);
2997                 wbc_init_bio(wbc, bio);
2998                 wbc_account_cgroup_owner(wbc, page, page_size);

wbc_init_bio:

	if (wbc)
		bio_associate_blkg_from_css();
