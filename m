Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6CA6D9D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfICQJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 12:09:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45758 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728679AbfICQJX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 12:09:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9EF9AE74;
        Tue,  3 Sep 2019 16:09:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1B30BDA876; Tue,  3 Sep 2019 18:09:43 +0200 (CEST)
Date:   Tue, 3 Sep 2019 18:09:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: fix zstd compression test on a kernel
 without ztsd support
Message-ID: <20190903160942.GE2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190903122721.9865-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903122721.9865-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 03, 2019 at 02:27:21PM +0200, Johannes Thumshirn wrote:
> The test-case 'misc-tests/025-zstd-compression' is failing on a kernel
> without zstd compression support.
> 
> Check if zstd compression is supported by the kernel and if not skip the
> test-case.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/misc-tests/025-zstd-compression/test.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/misc-tests/025-zstd-compression/test.sh b/tests/misc-tests/025-zstd-compression/test.sh
> index 22795d27500e..f9ff1d089fd5 100755
> --- a/tests/misc-tests/025-zstd-compression/test.sh
> +++ b/tests/misc-tests/025-zstd-compression/test.sh
> @@ -6,6 +6,11 @@ source "$TEST_TOP/common"
>  check_prereq btrfs
>  check_global_prereq md5sum
>  
> +if ! [ -f "/sys/fs/btrfs/features/compress_zstd" ]; then
> +       _not_run "kernel does not support zstd compression feature"

Sorry, I misled you with this check. The test needs to detect zstd
support in 'btrfs restore'. The only thing I see right now is to grep
for zstd in output of 'ldd', because unlike for btrfs-convert, the help
does not list the optional features.
