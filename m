Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155663DCBAF
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Aug 2021 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhHAMmW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 08:42:22 -0400
Received: from out20-37.mail.aliyun.com ([115.124.20.37]:43058 "EHLO
        out20-37.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhHAMmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 08:42:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08502337|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0517154-0.00492451-0.94336;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Ktq3u3n_1627821723;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Ktq3u3n_1627821723)
          by smtp.aliyun-inc.com(10.147.41.121);
          Sun, 01 Aug 2021 20:42:03 +0800
Date:   Sun, 1 Aug 2021 20:42:02 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/204: fail if the mkfs fails
Message-ID: <YQaWmtw5/OoXm26Z@desktop>
References: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1cd52ce8954e5aee1fc0a4baf5c75ef7d2635a.1627590942.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 04:35:53PM -0400, Josef Bacik wrote:
> My nightly fstests runs on my Raspberry Pi got stuck trying to run
> generic/204.  This boiled down to mkfs failing to make the scratch
> device that small with the subpage blocksize support, and thus trying to
> fill a 1tib drive with tiny files.  On one hand I'd like to make

So the underlying disk is 1TB in size, and we ended up using this 1T
filesystem when _scratch_mkfs_sized failed?

But we have done _try_wipe_scratch_devs before each test to make sure we
don't use previous scratch dev accidently (just like this case), and the
subsesquent _scratch_mount will fail and fail the whole test. So it's
not clear to me what caused the failure you hit.

Thanks,
Eryu

> _scratch_mkfs failures automatically fail the test, but I worry about
> cases where a test may be checking for an option and need to do
> something different with failures, so for now simply fail if we can't
> make our tiny-fs in generic/204.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/generic/204 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index a3dabb71..b5deb443 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
>  
>  SIZE=`expr 115 \* 1024 \* 1024`
> -_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
> +_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
> +	|| _fail "mkfs failed"
>  cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  _scratch_mount
>  
> -- 
> 2.26.3
