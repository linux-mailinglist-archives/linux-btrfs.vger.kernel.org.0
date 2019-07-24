Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69272C9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGXKvw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 06:51:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfGXKvw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 06:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EF71AF9F
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jul 2019 10:51:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB152DA808; Wed, 24 Jul 2019 12:52:28 +0200 (CEST)
Date:   Wed, 24 Jul 2019 12:52:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: misc-test/034: Avoid debug log populating
 stdout
Message-ID: <20190724105228.GH2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190724050705.29313-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724050705.29313-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 24, 2019 at 01:07:05PM +0800, Qu Wenruo wrote:
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
> Revert to echo "$*" >> "$RESULTS" to remove the noise.

Yes to remove the noise but the idea was to avoid manual redirections to
$RESULTS, so we need a new helper or adjust _log.
