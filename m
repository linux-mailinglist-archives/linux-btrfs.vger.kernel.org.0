Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF9A5C6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2019 20:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfIBSw3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Sep 2019 14:52:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:35464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726906AbfIBSw2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Sep 2019 14:52:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E013EAF7C;
        Mon,  2 Sep 2019 18:52:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D027DA7E3; Mon,  2 Sep 2019 20:52:48 +0200 (CEST)
Date:   Mon, 2 Sep 2019 20:52:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: check/lowmem: Skip nbytes check for
 orphan inodes
Message-ID: <20190902185248.GA2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190902045750.17183-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902045750.17183-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 02, 2019 at 12:57:49PM +0800, Qu Wenruo wrote:
> For orphan inodes, kernel won't update its nbytes and size since it's a
> waste of time.
> 
> So lowmem check can report false alert on some orphan inodes.
> 
> Fix it by checking if the inode is an orphan before
> complaining/repairing its nbytes.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Great, thanks!
