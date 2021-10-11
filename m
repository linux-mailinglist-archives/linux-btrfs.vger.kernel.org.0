Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD042923B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244209AbhJKOmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 10:42:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55310 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244348AbhJKOk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 10:40:56 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ADF9121DA0;
        Mon, 11 Oct 2021 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633963133;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STvQgTJdMpuLP6UAOZiYdfisbM+2iSq+KRA5XhGxja0=;
        b=LReJWDcPG5COb4l8J5sUUbjM6zcY55UQpL9KoN2xejCJ/5nlxKE2IVP5lTF9GF2Re1lTlm
        +L9BXWUe/JuObUMTzfu+PjsAcOkGr+zIGjJdy0AlJgNTJBE36SsdjlJjIcBhYkHvpQpRMP
        d+StS/ksQAN9UQRl8vBDdZqGmOY7z3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633963133;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=STvQgTJdMpuLP6UAOZiYdfisbM+2iSq+KRA5XhGxja0=;
        b=Pw+peGW1uX7/evmyx2brVYw/L7FcAj5OEIlwneAfGWQ2eB509RFtq1Zr8cM0GCueeADnNC
        fkmH54q89Hgo4zDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A6790A3B84;
        Mon, 11 Oct 2021 14:38:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 81122DA781; Mon, 11 Oct 2021 16:38:30 +0200 (CEST)
Date:   Mon, 11 Oct 2021 16:38:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs-progs: mfks-tests: make sure mkfs.btrfs
 cleans up temporary chunks
Message-ID: <20211011143830.GK9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211011120650.179017-1-wqu@suse.com>
 <20211011120650.179017-4-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011120650.179017-4-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 08:06:50PM +0800, Qu Wenruo wrote:
> Since current "btrfs filesystem df" command will warn if there are
> multiple profiles of the same type, it's a good way to detect left-over
> temporary chunks.
> 
> This patch will enhance the existing mkfs-tests/001-basic-profiles test
> case to also check for the warning messages, to make sure mkfs.btrfs has
> properly cleaned up all temporary chunks.
> 
> There is a special workaround newly implemented in test_get_info(), as
> recent kernel introduced single device RAID0 support, which is no
> different than SINGLE.
> 
> But for single device RAID0, kernel may choose to preallocate new chunks
> with SINGLE profile, causing false alerts.
> 
> Work around this kernel bug by mounting the btrfs read-only to prevent
> preallocating new chunks.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/mkfs-tests/001-basic-profiles/test.sh | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/mkfs-tests/001-basic-profiles/test.sh b/tests/mkfs-tests/001-basic-profiles/test.sh
> index b3ba50d71ddc..0be199749864 100755
> --- a/tests/mkfs-tests/001-basic-profiles/test.sh
> +++ b/tests/mkfs-tests/001-basic-profiles/test.sh
> @@ -11,10 +11,22 @@ setup_root_helper
>  
>  test_get_info()
>  {
> +	tmp_out=$(mktemp --tmpdir btrfs-progs-mkfs-tests-get-info.XXXXXX)

Local variables should be declared

	local tmp_out

>  	run_check $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1"
>  	run_check $SUDO_HELPER "$TOP/btrfs" check "$dev1"
> -	run_check $SUDO_HELPER mount "$dev1" "$TEST_MNT"
> -	run_check "$TOP/btrfs" filesystem df "$TEST_MNT"
> +
> +	btrfs ins dump-tree -t chunk "$dev1" >> "$RESULTS"

Using $RESULTS is not recommended, the same can be achieved by

	run_check btrfs...

Also you should run the "$TOP/btrfs" binary and use the full name of the
subcommands, ie. 'inspect-internal'.

> +	# Work around a kernel bug that kernel will treat SINGLE and single
> +	# device RAID0 as the same.
> +	# Thus kernel may create new SINGLE chunks, causing extra warning
> +	# when testing single device RAID0.
> +	run_check $SUDO_HELPER mount -o ro "$dev1" "$TEST_MNT"
> +	if grep -q "Multiple block group profiles detected" "$tmp_out"; then
> +		rm -- "$tmp_out"
> +		_fail "temporary chunks are not properly cleaned up"
> +	fi
> +	rm -- "$tmp_out"

So to be able to run the testsuite on unfixed kernels the workaround
makes sense.

>  	run_check $SUDO_HELPER "$TOP/btrfs" filesystem usage "$TEST_MNT"
>  	run_check $SUDO_HELPER "$TOP/btrfs" device usage "$TEST_MNT"
>  	run_check $SUDO_HELPER umount "$TEST_MNT"
> -- 
> 2.33.0
