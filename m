Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3963F0AEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 20:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhHRSPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 14:15:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhHRSPh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 14:15:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 045B51FFDA;
        Wed, 18 Aug 2021 18:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629310500;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+vGQeCzqTu4Tac6tcu1Tm2U2c4m9XDHxw+Z1wp0bwE=;
        b=ehI2i3gt7nz4V8cSz0Bj2P+d6jw9Fhwfr+WN39Jy78ikDc6ubtnYEWuSE/mzuLXHUmG4Mq
        4ozDFETACNXoUyjxfdmNVWDKlCmXQmXFvmpGhWPYOhjVp3Y2pVwrP+KZ3rc38q09yGa7js
        i7SU7ziim5CckOgMNzRzWO5v9zvQnmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629310500;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+vGQeCzqTu4Tac6tcu1Tm2U2c4m9XDHxw+Z1wp0bwE=;
        b=TQvc+nlNHSZFkyhGOG2dnr2aKVxgIgioH090vBClTKE04pFrCRjQ/Zmwm3e6+4BCOY1xNs
        79P46UJyfXj7OECw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F1234A3B9C;
        Wed, 18 Aug 2021 18:14:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A4110DA72C; Wed, 18 Aug 2021 20:12:02 +0200 (CEST)
Date:   Wed, 18 Aug 2021 20:12:01 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: tests: also check subpage warning for
 type 2 test cases
Message-ID: <20210818181200.GW5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210818064420.866803-1-wqu@suse.com>
 <20210818064420.866803-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818064420.866803-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 18, 2021 at 02:44:18PM +0800, Qu Wenruo wrote:
> There are two types of test cases:
> 
> - Type 1 (without test.sh)
> - Type 2 (test.sh, mostly will override check_image())
> 
> For Type 2 tests, we check subpage related warnings of btrfs-check, but
> didn't check it for Type 1 test cases.
> 
> In fact, Type 1 test cases are more important, as they involve repair,
> which can generate new tree blocks, and we want to make sure such new
> tree blocks won't cause subpage related warnings.
> 
> This patch will add the extra check for Type 1 test cases.
> 
> And it will make sure the subpage related warnings are really from this
> test case, to prevent false alerts.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/common | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/common b/tests/common
> index 805a447c84ce..a6f75c7ce237 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -423,13 +423,23 @@ check_image()
>  {
>  	local image
>  
> +	tmp_output=$(mktemp --tmpdir btrfs-progs-test-check-image.XXXXXX)
> +
>  	image=$1
>  	echo "testing image $(basename $image)" >> "$RESULTS"
> -	"$TOP/btrfs" check "$image" >> "$RESULTS" 2>&1
> +	"$TOP/btrfs" check "$image" &> "$tmp_output"

So this captures the output but does not store it into the results file

>  	[ $? -eq 0 ] && _fail "btrfs check should have detected corruption"

and when this fails, we lack that information.
>  

> +	cat "$tmp_output" >> "$RESULTS"

So this should probably go before the 'check' call.

> +	# Also make sure no subpage related warnings
> +	check_test_results "$tmp_output" "$testname"
> +
>  	run_check "$TOP/btrfs" check --repair --force "$image"
> -	run_check "$TOP/btrfs" check "$image"
> +	run_check_stdout "$TOP/btrfs" check "$image" &> "$tmp_output"
> +
> +	# Also make sure no subpage related warnings for the repaired image
> +	check_test_results "$tmp_output" "$testname"
> +	rm -f "$tmp_output"
>  }
>  
>  # Extract a usable image from packed formats
> -- 
> 2.32.0
