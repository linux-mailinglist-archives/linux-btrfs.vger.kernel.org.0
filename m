Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE59F3DCB47
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Aug 2021 12:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhHAKwx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 06:52:53 -0400
Received: from out20-1.mail.aliyun.com ([115.124.20.1]:60425 "EHLO
        out20-1.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbhHAKww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 06:52:52 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08332312|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0651404-0.00151182-0.933348;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Ktosi2l_1627815163;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Ktosi2l_1627815163)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sun, 01 Aug 2021 18:52:43 +0800
Date:   Sun, 1 Aug 2021 18:52:43 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: remove results .dmesg on each run
Message-ID: <YQZ8+whfXorZo5ZK@desktop>
References: <d6f40b516a57f9f899e67fad39088e0ddbe087db.1627590729.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f40b516a57f9f899e67fad39088e0ddbe087db.1627590729.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 29, 2021 at 04:32:20PM -0400, Josef Bacik wrote:
> I recently added dmesg files to my nightly fstests summary page and
> noticed I was getting .dmesg files from runs that happened previously.
> This is because we don't remove the .dmesg file in the results directory
> when we go to run the test, so fstests results would show a test having
> failed with dmesg errors when it actually hadn't failed.  Fix this by
> removing the .dmesg file when we are going to run a test.

I didn't get it, the $seqres.dmesg file being checked is generated after
each test, I didn't see how the stale $seqres.dmesg being used.

_check_dmesg()
{
	......
        _dmesg_since_test_start | $filter >$seqres.dmesg
        egrep -q -e "kernel BUG at" \
             -e "WARNING:" \
             -e "\bBUG:" \
             -e "Oops:" \
             -e "possible recursive locking detected" \
             -e "Internal error" \
             -e "(INFO|ERR): suspicious RCU usage" \
             -e "INFO: possible circular locking dependency detected" \
             -e "general protection fault:" \
             -e "BUG .* remaining" \
             -e "UBSAN:" \
             $seqres.dmesg
	......
}

Did I miss anything?

Thanks,
Eryu

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  check | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/check b/check
> index bb7e030c..2021cb21 100755
> --- a/check
> +++ b/check
> @@ -809,6 +809,7 @@ function run_section()
>  
>  		# really going to try and run this one
>  		rm -f $seqres.out.bad
> +		rm -f $seqres.dmesg
>  
>  		# check if we really should run it
>  		_expunge_test $seqnum
> -- 
> 2.26.3
