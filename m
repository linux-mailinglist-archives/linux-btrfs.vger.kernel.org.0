Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F095116ABF9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBXQqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 11:46:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:34454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgBXQqC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 11:46:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2B87AD19;
        Mon, 24 Feb 2020 16:46:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0BE19DA727; Mon, 24 Feb 2020 17:45:41 +0100 (CET)
Date:   Mon, 24 Feb 2020 17:45:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: Remove the unnecesaary spin lock
 for qgroup_rescan_running|queued
Message-ID: <20200224164541.GY2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200207053821.25643-1-wqu@suse.com>
 <20200207053821.25643-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207053821.25643-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 07, 2020 at 01:38:21PM +0800, Qu Wenruo wrote:
> Those two members are all protected by
> btrfs_fs_info::qgroup_rescan_lock, thus no need for the extra spinlock.

Two members refers to btrfs_fs_info::qgroup_rescan_lock and what else?
Byt the subject it's something 'queued' but I can't find what it's
referring to.
