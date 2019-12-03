Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E4F110582
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 20:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLCTvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 14:51:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:44028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbfLCTvp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 14:51:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB982B2E3C;
        Tue,  3 Dec 2019 19:51:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2E367DA7D9; Tue,  3 Dec 2019 20:51:39 +0100 (CET)
Date:   Tue, 3 Dec 2019 20:51:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
Subject: Re: [PATCH 0/4][v2] clean up how we mark block groups read only
Message-ID: <20191203195139.GC2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com, wqu@suse.com
References: <20191126162556.150483-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126162556.150483-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 11:25:52AM -0500, Josef Bacik wrote:
> v1->v2:
> - Fixed the typo where I wasn't checking against total_bytes.
> - Added the force check to the read only list addition check at the top.
> - Fixed the comment stating that sinfo_used + num_bytes should be <=
>   total_bytes, that's not the case at all.
> - Added the various reviewed-by's.

I'm applying 1 and 2 to misc-next, 3 and 4 once the comments are
addressed.
