Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105B7228437
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgGUPuh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 11:50:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgGUPuh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 11:50:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AA33AE57;
        Tue, 21 Jul 2020 15:50:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 09B62DA70B; Tue, 21 Jul 2020 17:50:10 +0200 (CEST)
Date:   Tue, 21 Jul 2020 17:50:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/2] btrfs: don't WARN_ON() if we abort a transaction
 with -EROFS
Message-ID: <20200721155010.GM3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200721152428.9934-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721152428.9934-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 11:24:27AM -0400, Josef Bacik wrote:
> If we got some sort of corruption via a read and call
> btrfs_handle_fs_error() we'll set BTRFS_FS_STATE_ERROR on the fs and
> complain.  If a subsequent trans handle trips over this it'll get -EROFS
> and then abort.  However at that point we're not aborting for the
> original reason, we're aborting because we've been flipped read only.
> We do not need to WARN_ON() here.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

1 and 2 added to misc-next, thanks.
