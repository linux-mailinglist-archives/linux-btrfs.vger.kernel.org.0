Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B12077E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 17:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404351AbgFXPto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 11:49:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37650 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404187AbgFXPto (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 11:49:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D282DAD09;
        Wed, 24 Jun 2020 15:49:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D0775DA79B; Wed, 24 Jun 2020 17:49:30 +0200 (CEST)
Date:   Wed, 24 Jun 2020 17:49:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Jiachen YANG <farseerfc@gmail.com>
Subject: Re: [PATCH 2/2] btrfs-progs: tests/convert: Add test case to make
 sure we won't allocate dev extents beyond device boundary
Message-ID: <20200624154930.GU27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Jiachen YANG <farseerfc@gmail.com>
References: <20200624115527.855816-1-wqu@suse.com>
 <20200624115527.855816-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624115527.855816-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 24, 2020 at 07:55:27PM +0800, Qu Wenruo wrote:
> Add a test case to check if the converted fs has device extent beyond
> boundary.
> 
> The disk layout of source ext4 fs needs some extents to make them
> allocated at the very end of the fs.
> The script is from the original reporter.
> 
> Also, since the existing convert tests always uses 512M as device size,
> which is not suitable for this test case, make it to grab the existing
> device size to co-operate with this test case.
> 
> Reported-by: Jiachen YANG <farseerfc@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/common.convert                         | 14 ++++++++-
>  tests/convert-tests/017-fs-near-full/test.sh | 30 ++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100755 tests/convert-tests/017-fs-near-full/test.sh
> 
> diff --git a/tests/common.convert b/tests/common.convert
> index f24ceb0d6a64..0c918387758d 100644
> --- a/tests/common.convert
> +++ b/tests/common.convert
> @@ -53,6 +53,16 @@ convert_test_preamble() {
>  	echo "creating test image with: $@" >> "$RESULTS"
>  }
>  
> +get_test_file_size() {
> +	local path="$1"
> +	local ret
> +
> +	ret=$(ls -l "$path" | cut -f5 -d\ )

Parsing ls output is quite fragile, and we have 'stat --format=%s'.
