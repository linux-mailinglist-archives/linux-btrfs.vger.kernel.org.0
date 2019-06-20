Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD6404D1C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 17:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfFTPM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 11:12:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:36604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfFTPMZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 11:12:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CBA66AC2C;
        Thu, 20 Jun 2019 15:12:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F0D06DA897; Thu, 20 Jun 2019 17:13:08 +0200 (CEST)
Date:   Thu, 20 Jun 2019 17:13:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH][v2] btrfs: run delayed iput at unlink time
Message-ID: <20190620151308.GK8917@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <20190618145918.12641-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618145918.12641-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 10:59:18AM -0400, Josef Bacik wrote:
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

Added to misc-next, thanks.
