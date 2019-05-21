Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2A24B09
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfEUJAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 05:00:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbfEUJAG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 05:00:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D5FEAF8C;
        Tue, 21 May 2019 09:00:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A863DA86B; Tue, 21 May 2019 11:01:03 +0200 (CEST)
Date:   Tue, 21 May 2019 11:01:03 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, "Erhard F ." <erhard_f@mailbox.org>
Subject: Re: [PATCH] btrfs: correct zstd workspace manager lock to use
 spin_lock_bh()
Message-ID: <20190521090103.GH3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Erhard F ." <erhard_f@mailbox.org>
References: <20190517231626.85614-1-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517231626.85614-1-dennis@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 17, 2019 at 07:16:26PM -0400, Dennis Zhou wrote:
> The btrfs zstd workspace manager uses a background timer to reclaim
> not recently used workspaces. I dumbly call spin_lock() from this
> context which I should have caught with lockdep but.. This deadlock was
> reported in [1]. The fix is to switch the zstd wsm lock to use
> spin_lock_bh().
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203517
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: David Sterba <dsterba@suse.com>

Added to 5.2-rc queue, thanks.
