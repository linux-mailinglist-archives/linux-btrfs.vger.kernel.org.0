Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3391FBC7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 19:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgFPRMC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 13:12:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:45654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbgFPRMB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 13:12:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30A03B117;
        Tue, 16 Jun 2020 17:12:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18928DA7C3; Tue, 16 Jun 2020 19:11:51 +0200 (CEST)
Date:   Tue, 16 Jun 2020 19:11:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Waiman Long <longman@redhat.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Use kfree() in btrfs_ioctl_get_subvol_info()
Message-ID: <20200616171150.GH27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Waiman Long <longman@redhat.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20200616153159.10691-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616153159.10691-1-longman@redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 16, 2020 at 11:31:59AM -0400, Waiman Long wrote:
> In btrfs_ioctl_get_subvol_info(), there is a classic case where kzalloc()
> was incorrectly paired with kzfree(). According to David Sterba, there
> isn't any sensitive information in the subvol_info that needs to be
> cleared before freeing. So kzfree() isn't really needed, use kfree()
> instead.
> 
> Reported-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>

Added to the devel patch queue, thanks.
