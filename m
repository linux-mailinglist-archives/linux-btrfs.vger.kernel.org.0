Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717EABB9A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbfIWQcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 12:32:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732770AbfIWQcj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 12:32:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20F8DAE6D;
        Mon, 23 Sep 2019 16:32:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15FD5DA871; Mon, 23 Sep 2019 18:32:58 +0200 (CEST)
Date:   Mon, 23 Sep 2019 18:32:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: ctree: Reduce one indent level for
 btrfs_search_old_slot()
Message-ID: <20190923163258.GK2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190910074019.23158-1-wqu@suse.com>
 <20190910074019.23158-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910074019.23158-3-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 10, 2019 at 03:40:18PM +0800, Qu Wenruo wrote:
> Pretty much the same refactor for btrfs_search_slot().

Please write something more sensible than that next time, this changelog
makes sense for a short period of time when the patches are in the
mailing list and the context is obvious, but once the patch is merged
the reference to "same thing as in some funrction" does not help.
