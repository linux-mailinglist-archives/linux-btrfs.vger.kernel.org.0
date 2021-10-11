Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6659E428AC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhJKKcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:32:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbhJKKcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:32:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9218A2004C;
        Mon, 11 Oct 2021 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633948212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uZ+S/Qu2X2EaHkoRmTl+MfEwEgC/a3il86uU5b+epI=;
        b=fDGuL+X4OSUlsy1YySIh6NTMULYMTyRKKGl7zs98hTwfwEPbqn4bldN5D8H6rtZ+LUFR2V
        YntAkuQeS0c0ZII9tGQzjTEWyuD3/z8UAtqB5oEArV+Q8B7TALtitoCvtkc1aC6r6jGeem
        yHXOWk98DjPIJc98Z16kfFOO9CdnClM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633948212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uZ+S/Qu2X2EaHkoRmTl+MfEwEgC/a3il86uU5b+epI=;
        b=MKzW199dN28zU/IDAD1fl37I+2GaAZ+AL0CBoGnT5W+Znut0mQE5vECUJARG5Zx6d/KNf3
        U9Nwu43XT4bCV8DQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8B97CA3B8B;
        Mon, 11 Oct 2021 10:30:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EAB6DA704; Mon, 11 Oct 2021 12:29:49 +0200 (CEST)
Date:   Mon, 11 Oct 2021 12:29:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans
 up temporary chunks
Message-ID: <20211011102949.GD9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011094300.97504-1-wqu@suse.com>
 <20211011094300.97504-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011094300.97504-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 05:43:00PM +0800, Qu Wenruo wrote:
> Since current "btrfs filesystem df" command will warn if there are
> multiple profiles of the same type, it's a good way to detect left-over
> temporary chunks.
> 
> This patch will enhance the existing mkfs-tests/001-basic-profiles test
> case to also check for the warning messages, to make sure mkfs.btrfs has
> properly cleaned up all temporary chunks.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/mkfs-tests/001-basic-profiles/test.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
> index b3ba50d71ddc..e44f9344bc6f 100755
> --- a/tests/mkfs-tests/001-basic-profiles/test.sh
> +++ b/tests/mkfs-tests/001-basic-profiles/test.sh
> @@ -11,11 +11,17 @@ setup_root_helper
>  
>  test_get_info()
>  {
> +	tmp_out=$(mktemp --tmpdir btrfs-progs-mkfs-tests-get-info.XXXXXX)
>  	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
>  	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
>  	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
> -	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
> -	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
> +	run_check_stdout "$TOP/btrfs" filesystem df "$TEST_MNT" > "$tmp_out"
> +	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
> +		rm -- "$tmp_out"
> +		_fail "temporary chunks are not properly cleaned up"
> +	fi
> +	rm -- "$tmp_out"
> +	run_check$SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
                 ^
Missing space so the test won't run properly


>  	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
>  	run_check $SUDO_HELPER umount "$TEST_MNT"
>  }
> -- 
> 2.33.0
