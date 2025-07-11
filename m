Return-Path: <linux-btrfs+bounces-15462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFDFB01713
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 11:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E94171F96
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097A2192E1;
	Fri, 11 Jul 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbMDzqi5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E41B87F2;
	Fri, 11 Jul 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224481; cv=none; b=m7JYkvozniN4CiXaq2OH4R0ph4e6eMYggAvf1DnhAkuXThKGcHseogAjOJqVtOir+wRNG2gStyD1R3XRWZAOOLW1lLMW0rECPXyjNxuV3vVGLitn39zG2YCl9mTiM4hb3ER6L4ltR/sQw36Sr20BS/710X7QTcfQJ7gRW1lqRqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224481; c=relaxed/simple;
	bh=i0ZnovuwVKB0s5VYjupZwD14GoAl1RKnPg4DS46zFmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn6ID4faslIwDQa8i2DOf9sXJUfeHtntxs614DCkXNJ6qqeoddG9Z3PXxgoIJVtytnbcG9tX7bjrk4GMVv8kw05H6cni9o7Le8kTHaS1QaYKE2nUDF/aICUNki1I09fzxD7koMQ8ICxlmK44brljQgtDyB0DykKOvFRcslZxxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbMDzqi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24861C4CEEF;
	Fri, 11 Jul 2025 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224478;
	bh=i0ZnovuwVKB0s5VYjupZwD14GoAl1RKnPg4DS46zFmY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UbMDzqi5N/X0EnzHuetplXI+VXx12p0bHw1HtHXaQnE+20Jxw+TZMwieGyBzEeCPf
	 jeP5CvrRw+cOGMzv1Q4++tMZfl3uGa1gGRF4b1fTv2P1BcFzDbYqd4ZdaQJz1p/hLp
	 F6nWFY40vtTIXaTrdEIM8i7HJ5YixEKqAjaqjV+ArXbTl9Wrujsmz604b71dHhRn2i
	 vXFp3bDQALjPwPMZpP6EYDLfqP7J4VGWAp5AXe0LQ8gp1a7nYk2ac1ZyM5IbjYBSd5
	 zplkZu8dT4OdVAgp9N0q33TJE2O8IiuttBn6yrR0Fqf9xWc/IY5iobVVkVXZvn2K1Z
	 /CMCjwQ7s0kww==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so3735665a12.3;
        Fri, 11 Jul 2025 02:01:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCFZhept4bPTax8Gp39v17OxUV5661HuofoPeBsRWE/rumYGBobTMry72VMHrEOIM2RNstVAfz@vger.kernel.org
X-Gm-Message-State: AOJu0YySVNY9giICCT3tT9TPbFoJZ9XiXDdWd14m9Y/rDXyxQhRPL8UL
	Qsmh5eCMPVhIG6Xz8dWVEDmkKO7Q8OP2LWhR0n66Gf44EKIleJ45OQ+iELv+cSxeADbWvdSGTQN
	+QJ1LZDr/InmSSSv6vTTEL3J1IhyejqA=
X-Google-Smtp-Source: AGHT+IF7noKfu3+NaZ4K1TU+qVwSNTcmwNz46Rfqk4JgIWBF5FJ5ezlacF1P9OANba2bhavZ0GCnddiIbSCDwAF9kvM=
X-Received: by 2002:a17:907:2d2b:b0:ae6:e32c:9544 with SMTP id
 a640c23a62f3a-ae6fcc2143dmr265853566b.43.1752224476496; Fri, 11 Jul 2025
 02:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711084305.183675-1-wqu@suse.com>
In-Reply-To: <20250711084305.183675-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 11 Jul 2025 10:00:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H51U5qbZfArUJVm20zLp2pk7rN5V3ZUw-Rv=vh34oyMwA@mail.gmail.com>
X-Gm-Features: Ac12FXzGP61lP6nE4fH07Mmeuzg-oXYByJEQCThLWmiD75RSNFjwkDdnRXuscK8
Message-ID: <CAL3q7H51U5qbZfArUJVm20zLp2pk7rN5V3ZUw-Rv=vh34oyMwA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/282: use timed writes to make sure scrub has
 enough run time
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [FAILURE]
> Test case btrfs/282 still fails on some setup:
>
>     output mismatch (see /opt/xfstests/results//btrfs/282.out.bad)
>     --- tests/btrfs/282.out     2025-06-27 22:00:35.000000000 +0200
>     +++ /opt/xfstests/results//btrfs/282.out.bad        2025-07-08 20:40:=
50.042410321 +0200
>     @@ -1,3 +1,4 @@
>      QA output created by 282
>      wrote 2147483648/2147483648 bytes at offset 0
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     +scrub speed 2152038400 Bytes/s is not properly throttled, target is =
1076019200 Bytes/s
>     ...
>     (Run diff -u /opt/xfstests/tests/btrfs/282.out /opt/xfstests/results/=
/btrfs/282.out.bad  to see the entire diff)
>
> [CAUSE]
> Checking the full output, it shows the scrub is running too fast:
>
> Starting scrub on devid 1
> scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
> Scrub started:    Tue Jul  8 20:40:47 2025
> Status:           finished
> Duration:         0:00:00 <<<
> Total to scrub:   2.00GiB
> Rate:             2.00GiB/s
> Error summary:    no errors found
> Starting scrub on devid 1
> scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
> Scrub started:    Tue Jul  8 20:40:48 2025
> Status:           finished
> Duration:         0:00:01
> Total to scrub:   2.00GiB
> Rate:             2.00GiB/s
> Error summary:    no errors found
>
> The original run takes less than 1 seconds, making the scrub rate
> calculation very unreliable, no wonder the speed limit is not able to
> properly work.
>
> [FIX]
> Instead of using fixed 2GiB file size, let the test create a filler for
> 4 seconds with direct IO, this would more or less ensure the scrub will
> take 4 seconds to run.
>
> With 4 seconds as run time, the scrub rate can be calculated more or
> less reliably.
>
> Furthermore since btrfs-progs currently only reports scrub duration in
> seconds, to prevent problems due to 1 second difference, enlarge the
> tolerance to +/- 25%, to be extra safe.
>
> On my testing VM, the result looks like this:
>
> Starting scrub on devid 1
> scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
> Scrub started:    Fri Jul 11 09:13:31 2025
> Status:           finished
> Duration:         0:00:04
> Total to scrub:   2.72GiB
> Rate:             696.62MiB/s
> Error summary:    no errors found
> Starting scrub on devid 1
> scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
> Scrub started:    Fri Jul 11 09:13:35 2025
> Status:           finished
> Duration:         0:00:08
> Total to scrub:   2.72GiB
> Rate:             348.31MiB/s
> Error summary:    no errors found
>
> However this exposed a new failure mode, that if the storage is too
> fast, like the original report, that the initial 4 seconds write can
> fill the fs and exit early.
>
> In that case we have no other solution but skipping the test case.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changelog:
> v2:
> - Fix several typos
> - Fix a copy-n-paste error in the cleanup function
> - Unset the pid after the timed write is finished
> - Remove an unnecessary sync after deleting the original filler
> - Add the requirement for data checksum
> ---
>  tests/btrfs/282     | 60 +++++++++++++++++++++++++++++++++++++++------
>  tests/btrfs/282.out |  3 +--
>  2 files changed, 53 insertions(+), 10 deletions(-)
>
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> index 3b4ad9ea..e3bce0fe 100755
> --- a/tests/btrfs/282
> +++ b/tests/btrfs/282
> @@ -9,13 +9,25 @@
>  . ./common/preamble
>  _begin_fstest auto scrub
>
> +_cleanup()
> +{
> +       [ -n "$filler_pid" ] && kill "$filler_pid" &> /dev/null
> +       wait
> +}
> +
>  . ./common/filter
>
>  _wants_kernel_commit eb3b50536642 \
>         "btrfs: scrub: per-device bandwidth control"
>
> -# We want at least 5G for the scratch device.
> -_require_scratch_size $(( 5 * 1024 * 1024))
> +# For direct IO without falling back to buffered IO.
> +_require_odirect
> +_require_chattr C
> +# For data checksum verification during scrub
> +_require_btrfs_no_nodatasum
> +
> +# We want at least 10G for the scratch device.
> +_require_scratch_size $(( 10 * 1024 * 1024))
>
>  # Make sure we can create scrub progress data file
>  if [ -e /var/lib/btrfs ]; then
> @@ -36,9 +48,38 @@ if [ ! -f "${devinfo_dir}/scrub_speed_max" ]; then
>         _notrun "No sysfs interface for scrub speed throttle"
>  fi
>
> -# Create a 2G file for later scrub workload.
> -# The 2G size is chosen to fit even DUP on a 5G disk.
> -$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 2G" $SCRATCH_MNT/file | _fi=
lter_xfs_io
> +# Create a NOCOW file and do direct IO for 4 seconds to measure the perf=
ormance.
> +#
> +# The only way to reach real disk performance is direct IO without falli=
ng back
> +# to buffered IO, thus requiring NOCOW.
> +touch $SCRATCH_MNT/filler
> +chattr +C $SCRATCH_MNT/filler
> +$XFS_IO_PROG -d -c "pwrite -b 128K 0 1E" "$SCRATCH_MNT/filler" >> $seqre=
s.full 2>&1 &
> +filler_pid=3D$!
> +sleep 4
> +kill $filler_pid
> +wait
> +unset filler_pid
> +
> +# Make sure we still have some space left, if we hit ENOSPC, this means =
the
> +# storage is too fast and the filler didn't reach full 4 seconds write b=
efore
> +# hitting ENOSPC. In that case we have no reliable way to calculate scru=
b speed
> +# but skip the run.
> +_pwrite_byte 0x00 0 1M $SCRATCH_MNT/foobar >> $seqres.full 2>&1
> +if [ $? -ne 0 ]; then
> +       _notrun "Storage too fast, unreliable scrub speed"
> +fi
> +
> +# But above NOCOW file has no csum, thus it won't really cause much
> +# verification workload. Use the filesize of above run to re-create a fi=
le with data
> +# checksums.
> +size=3D$(_get_filesize $SCRATCH_MNT/filler)
> +rm $SCRATCH_MNT/filler
> +
> +# Recreate one with checksums.
> +touch $SCRATCH_MNT/filler
> +chattr -C $SCRATCH_MNT/filler
> +$XFS_IO_PROG -c "pwrite -i /dev/urandom 0 $size" $SCRATCH_MNT/filler >> =
$seqres.full
>
>  # Writeback above data, as scrub only verify the committed data.
>  sync
> @@ -77,12 +118,15 @@ $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seq=
res.full
>  speed=3D$($BTRFS_UTIL_PROG scrub status --raw $SCRATCH_MNT | grep "Rate:=
" |\
>              $AWK_PROG '{print $2}' | cut -f1 -d\/)
>
> -# We gave a +- 10% tolerance for the throttle
> -if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
> -     "$speed" -lt "$(( $target_speed * 9 / 10))" ]; then
> +# The expected runtime should be 4 and 8 seconds, and since the runtime
> +# accuracy is only 1 second, give it a +/- 25% tolerance
> +if [ "$speed" -gt "$(( $target_speed * 5 / 4 ))" -o \
> +     "$speed" -lt "$(( $target_speed * 3 / 4 ))" ]; then
>         echo "scrub speed $speed Bytes/s is not properly throttled, targe=
t is $target_speed Bytes/s"
>  fi
>
> +echo "Silence is golden"
> +
>  # success, all done
>  status=3D0
>  exit
> diff --git a/tests/btrfs/282.out b/tests/btrfs/282.out
> index 8d53e7eb..9e837650 100644
> --- a/tests/btrfs/282.out
> +++ b/tests/btrfs/282.out
> @@ -1,3 +1,2 @@
>  QA output created by 282
> -wrote 2147483648/2147483648 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Silence is golden
> --
> 2.50.0
>
>

