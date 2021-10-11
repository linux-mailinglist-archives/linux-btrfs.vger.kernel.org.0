Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8688B428AE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 12:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhJKKmj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 06:42:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhJKKmh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 06:42:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 58C5A2203C;
        Mon, 11 Oct 2021 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633948837;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNuC/gS/OmKfQW6bLafFM+LskUu0tOj8HNO5VSqsM2Q=;
        b=o1z9v6An03UlSUd/7oCbepRE9e/B3RjV+zEOWocD29iIHE5ai9GqLppgzuW/nRiKMCnaph
        pm0PL+lJ7CyT4D0Psvk/MAa/z/fClPybKRyGAk4LNLfgf+u0rFMJsAyXeEpPs308YsFCUJ
        kDR0GTgNWHk5kfMrGK2a8uRU7ZF4JoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633948837;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SNuC/gS/OmKfQW6bLafFM+LskUu0tOj8HNO5VSqsM2Q=;
        b=baMzafb8hfv3ZYJNgYelkekex821uyzD9sgqF3kkhZDRWTPcfcJjDeUEi11FA79qM92tZg
        YNcK1nzoQuKX6zCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 52AC7A3B84;
        Mon, 11 Oct 2021 10:40:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 49407DA735; Mon, 11 Oct 2021 12:40:14 +0200 (CEST)
Date:   Mon, 11 Oct 2021 12:40:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs cleans
 up temporary chunks
Message-ID: <20211011104013.GF9286@twin.jikos.cz>
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
>  	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
>  	run_check $SUDO_HELPER umount "$TEST_MNT"

This still fails in case mkfs/001-basic-tests with '-d raid0 -m raid0'

====== RUN CHECK root_helper mount /dev/loop0 .../btrfs-progs/tests/mnt
====== RUN CHECK .../btrfs-progs/btrfs filesystem df .../btrfs-progs/tests/mnt
WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
WARNING:   Metadata: single, raid0
WARNING:   System: single, raid0
Data, raid0: total=204.75MiB, used=0.00B
System, raid0: total=8.00MiB, used=0.00B
System, single: total=32.00MiB, used=16.00KiB
Metadata, raid0: total=204.75MiB, used=128.00KiB
Metadata, single: total=208.00MiB, used=0.00B
GlobalReserve, unknown: total=3.25MiB, used=0.00B
temporary chunks are not properly cleaned up
test failed for case 001-basic-profiles

