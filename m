Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE23F2C68
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 14:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhHTMqC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 08:46:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38374 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhHTMqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 08:46:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 23F2820159;
        Fri, 20 Aug 2021 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629463523;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rI3dxgVKpfvq+OnPnj13U7DxAhtcO/GYTmYdTz7nD78=;
        b=q9nyNp9zqD3Hevo6v/SoZU440byXGkPqnE+wDmjTKylTq1B92PvHxFyfCiAeWQ3q5hmjxu
        9kOFIs1Iz+zoD3TCcjYpt25DYEpJLaIUZ0+ar0VUl4eSw2npEfpJScrYPru4IPWlCySMo8
        23lhtg64l3ilwl6aVEgv/Tq9Om6PVZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629463523;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rI3dxgVKpfvq+OnPnj13U7DxAhtcO/GYTmYdTz7nD78=;
        b=2xbPxigxOeBwZzKdwV6Z+yRniXynKAGWteg1W+jPn1iZ2kKgk6i1Tzn7DVNQEQVSAKrMa1
        Cj7+1RG0F9JdAkDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1A4F1A3B84;
        Fri, 20 Aug 2021 12:45:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C3F0DA892; Fri, 20 Aug 2021 14:42:25 +0200 (CEST)
Date:   Fri, 20 Aug 2021 14:42:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: tests: also check subpage warning for
 type 2 test cases
Message-ID: <20210820124225.GQ5047@twin.jikos.cz>
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
>  	[ $? -eq 0 ] && _fail "btrfs check should have detected corruption"
>  
> +	cat "$tmp_output" >> "$RESULTS"
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

Applied with the following fixup

--- a/tests/common
+++ b/tests/common
@@ -422,15 +422,17 @@ check_dm_target_support()
 check_image()
 {
        local image
+       local tmp_output
 
        tmp_output=$(mktemp --tmpdir btrfs-progs-test-check-image.XXXXXX)
 
        image=$1
        echo "testing image $(basename $image)" >> "$RESULTS"
        "$TOP/btrfs" check "$image" &> "$tmp_output"
-       [ $? -eq 0 ] && _fail "btrfs check should have detected corruption"
-
+       ret=$?
        cat "$tmp_output" >> "$RESULTS"
+       [ "$ret" -eq 0 ] && _fail "btrfs check should have detected corruption"
+
        # Also make sure no subpage related warnings
        check_test_results "$tmp_output" "$testname"
 
@@ -439,7 +441,7 @@ check_image()
 
        # Also make sure no subpage related warnings for the repaired image
        check_test_results "$tmp_output" "$testname"
-       rm -f "$tmp_output"
+       rm -f -- "$tmp_output"
 }
 
 # Extract a usable image from packed formats
