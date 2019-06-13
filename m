Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A99B5447F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2019 19:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393212AbfFMRDZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jun 2019 13:03:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393210AbfFMRDZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jun 2019 13:03:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 480E2AFA5;
        Thu, 13 Jun 2019 17:03:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D2ACDA897; Thu, 13 Jun 2019 19:04:14 +0200 (CEST)
Date:   Thu, 13 Jun 2019 19:04:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: run delayed iput at unlink time
Message-ID: <20190613170412.GX3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190507172734.93994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507172734.93994-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 07, 2019 at 01:27:34PM -0400, Josef Bacik wrote:
> We have been seeing issues in production where a cleaner script will end
> up unlinking a bunch of files that have pending iputs.  This means they
> will get their final iput's run at btrfs-cleaner time and thus are not
> throttled, which impacts the workload.
> 
> Since we are unlinking these files we can just drop the delayed iput at
> unlink time.  We are already holding a reference to the inode so this
> will not be the final iput and thus is completely safe to do at this
> point.  Doing this means we are more likely to be doing the final iput
> at unlink time, and thus will get the IO charged to the caller and get
> throttled appropriately without affecting the main workload.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Ping for updates.
