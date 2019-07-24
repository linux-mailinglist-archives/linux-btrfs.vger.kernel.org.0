Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD78072FFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfGXNef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 09:34:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfGXNef (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 09:34:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 834B5AE32
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2019 13:34:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11491DA808; Wed, 24 Jul 2019 15:35:12 +0200 (CEST)
Date:   Wed, 24 Jul 2019 15:35:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: tests: Avoid debug log populating stdout
Message-ID: <20190724133511.GM2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190724120055.4131-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724120055.4131-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 24, 2019 at 08:00:55PM +0800, Qu Wenruo wrote:
> When running misc-test/034, we got unexpected log output:
>       [TEST/misc]   033-filename-length-limit
>       [TEST/misc]   034-metadata-uuid
>   Checking btrfstune logic
>   Checking dump-super output
>   Checking output after fsid change
>   Checking for incompat textual representation
>   Checking setting fsid back to original
>   Testing btrfs-image restore
> 
> This is caused by commit 2570cff076b1 ("btrfs-progs: test: cleanup misc-tests/034")
> which uses _log facility which also populates stdout.
> 
> Just change _log() to echo "$*" >> "$RESULTS" to fix it.
> Unlike the initial commit, there is no other user of _log, so it
> shouldn't affect other tests.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Applied, thanks. I'll fix up the remaining echo > $RESULTS in tests.
