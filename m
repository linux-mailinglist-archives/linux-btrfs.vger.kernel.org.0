Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8822998B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGVNrv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 09:47:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgGVNrv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 09:47:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CC25AED7;
        Wed, 22 Jul 2020 13:47:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0195DDA70B; Wed, 22 Jul 2020 15:47:23 +0200 (CEST)
Date:   Wed, 22 Jul 2020 15:47:23 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: move the chunk_mutex in btrfs_read_chunk_tree
Message-ID: <20200722134723.GU3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200717191229.2283043-1-josef@toxicpanda.com>
 <20200717191229.2283043-3-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717191229.2283043-3-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 17, 2020 at 03:12:28PM -0400, Josef Bacik wrote:
> An argument could be made that we don't even need the chunk_mutex here
> as it's during mount, and we are protected by various other locks.
> However we already have special rules for ->device_list_mutex, and I'd
> rather not have another special case for ->chunk_mutex.

Yeah, we can keep the lock there, eg. for the case when some helper
asserts the lock is held.
