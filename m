Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDD028DFF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Oct 2020 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388209AbgJNLqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Oct 2020 07:46:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:57636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730661AbgJNLp4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Oct 2020 07:45:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3CD7AC6D;
        Wed, 14 Oct 2020 11:45:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E93E1DA7C3; Wed, 14 Oct 2020 13:44:14 +0200 (CEST)
Date:   Wed, 14 Oct 2020 13:44:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: space-info: fix the wrong trace name for
 bytes_may_use
Message-ID: <20201014114414.GK6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201012065624.80649-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012065624.80649-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 12, 2020 at 02:56:24PM +0800, Qu Wenruo wrote:
> The trace_name for bytes_may_use should be "may_use", "space_info".
> 
> Fixes: f3e75e3805e1 ("btrfs: roll tracepoint into btrfs_space_info_update helper")

This patch reduced all calls to the definition and kept the same output,
ie. the 'space_info' so it was correct and the Fixes does not seem to be
right here. You should explain why the 'may_use' is supposed to be
there.
