Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5890140B91
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgAQNuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:50:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:53934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgAQNuA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:50:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 74F6BAE17;
        Fri, 17 Jan 2020 13:49:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 79C80DA871; Fri, 17 Jan 2020 14:49:43 +0100 (CET)
Date:   Fri, 17 Jan 2020 14:49:43 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RESEND] btrfs: drop log root for dropped roots
Message-ID: <20200117134943.GD3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200117134401.41440-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117134401.41440-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 08:44:01AM -0500, Josef Bacik wrote:
> If we fsync on a subvolume and create a log root for that volume, and
> then later delete that subvolume we'll never clean up its log root.  Fix
> this by making switch_commit_roots free the log for any dropped roots we
> encounter.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - Nothing has changed for this one, it's just been rebased.

Nothing, despite we asked for some simple updates to the changelog?
