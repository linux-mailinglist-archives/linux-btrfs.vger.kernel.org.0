Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B63770787
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfGVRjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 13:39:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:55040 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728860AbfGVRjQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69E67ACD8
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Jul 2019 17:39:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5AA2FDA882; Mon, 22 Jul 2019 19:39:50 +0200 (CEST)
Date:   Mon, 22 Jul 2019 19:39:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/5] btrfs-progs: convert-tests: Skip tests if kernel
 doesn't support subpage sized sector size
Message-ID: <20190722173950.GD22308@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190705072651.25150-1-wqu@suse.com>
 <20190705072651.25150-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705072651.25150-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 05, 2019 at 03:26:51PM +0800, Qu Wenruo wrote:
> Most convert tests needs to mount the converted image, and both reiserfs
> and ext* uses 4k block size, on 32K page size system we can't mount them
> and will cause test failure.
> 
> Skip most of convert tests, except 007-unsupported-block-sizes, which
> should fail on all systems.

Ok agreed, I don't see a better way than to skip the tests. Some of them
can be made to work based on the page size and adjusting the
ext4/reiserfs block sizes.

As this requires hw support to verify that test works, I would rather do
that one by one at the expense that non-4k page testing coverage will be
missing.

I saw some tests were using the assumptions of 4k sectorsize for some
test file generation so to avoid silent breakage, reviewing change to
each test should give some guarantees.

Alternatively, tests can be extended to iterate over the block sizes
from 4k to 64k. But then it's again difficult to see which combinations
make sense and must succeed or not. Oh well.

> --- a/tests/convert-tests/006-large-hole-extent/test.sh
> +++ b/tests/convert-tests/006-large-hole-extent/test.sh
> @@ -11,6 +11,8 @@ source "$TEST_TOP/common.convert"
>  setup_root_helper
>  prepare_test_dev
>  check_prereq btrfs-convert
> +check_prereq_mount_with_sectorsize 4096
> +prepare_test_dev

See, this is an example why the pre-checks should be independent,
requiring to call prepare_test_dev again is quite counter-intuitive and
error prone.

>  check_global_prereq mke2fs
>  
>  default_mke2fs="mke2fs -t ext4 -b 4096"
