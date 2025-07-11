Return-Path: <linux-btrfs+bounces-15443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2054B014C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F25F3BE78A
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26A41EEA47;
	Fri, 11 Jul 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC2ibe2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EB3197A6C;
	Fri, 11 Jul 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219229; cv=none; b=MB4MV41HNgOCuOk1cfmp2bBEDAM/OU5y1sm0NWth/hgyl3NTWey5fWgzj+pD900KiH8bq1JoebcL96GRF/DZwYsJQUfrjhVRQjwGA9VvT+vYTUhlRkeVumsoqXILs2oG8orzeKf0JE5G4XsxbQS/0GSTcIV2W8AeDBAkIAOvEas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219229; c=relaxed/simple;
	bh=CYtGTAhtNrI42JhrJoEIbRLaYFKoCeDHV58kZkJmLyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjH5j5MtyhhAet8EgDGUzw0dE3mHmd/iI7JI/F1GIi6L6ThtgKhAtI2I8x7HRCBkPTUnc9gEPIYyw3Z1spcFANM2KMofaMZalSXKInDml+ToXj3M55lhvdJdv5Dak7VCjAEze3y3abIDvX54ZTpyFaXp4Lp1PinIO2S6d3zDP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC2ibe2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21EAC4CEF5;
	Fri, 11 Jul 2025 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752219228;
	bh=CYtGTAhtNrI42JhrJoEIbRLaYFKoCeDHV58kZkJmLyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tC2ibe2L3unt0MKG5vOS8bmFWl9Dnk7+kldjtFGi1Faoi6K/KtHpIVaKknZvtCewS
	 4YHPAMIIebdlVCCHwI8nYigj2dbQJ3oWiR8KHwRC73Np+6VaQhD8NlJoa+takTbrBb
	 NBQZog4Yhi26hkcdreMPNFO0j2uhU2wSU00Vwxx03LazySFFaBxfH0G2my/wG19QlX
	 5RslAcUsPqhbEi1r2oCxNHiV9RHFYg64lrmGVgHA6+yZP+/cqr2RO8LZLHpNuKwX+9
	 h1AuQI1MgMh03RcjvyjOy1xTsoV8MQNNO6DeyCsNQ+fbTpcu0jt10+3jStlfgjFOvL
	 33tPkWIbTyYow==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6088d856c6eso3418550a12.0;
        Fri, 11 Jul 2025 00:33:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6XRap9PHcDgwJrVDtDasV5XtTvtnTmoI/TjwpR09XCikcbIAcGsyBLtK3HEuRVQIF09y8FkvO@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPlu0WSNgHhBXdxpgT1NCPttgw/OcGLsm5UbtGJ/2eu9tbVfq
	t1XvgVq8gmXmAMjX2XNLw95tGHy7MSxtlrketrMLJAvXsCQh1b1u55lwQ59zznO5azsC62tBzKN
	VFw0rhIuXc/korGJvA2AVIiCgrnacMBI=
X-Google-Smtp-Source: AGHT+IFTZDk3cqpJAeZn38I94qHSwKa01LvL0jXwvVe7rQpWijhuQDNFtSQ/qYJJa4zzewSOymXtnV+AtQYMGbzSs84=
X-Received: by 2002:a17:906:478a:b0:ae0:ad5c:4185 with SMTP id
 a640c23a62f3a-ae70131bae6mr124581066b.57.1752219227341; Fri, 11 Jul 2025
 00:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710235146.136358-1-wqu@suse.com>
In-Reply-To: <20250710235146.136358-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 11 Jul 2025 08:33:10 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4Vb7tLrMBnXcgGJqdrsgqDHzeMj+sj+3=R6zMeHdF7aA@mail.gmail.com>
X-Gm-Features: Ac12FXwo4RsLbDbw9chVwFTkqmxYhQgrqTATXAJO0hfAVwy7vaHItbMmyH6IHB4
Message-ID: <CAL3q7H4Vb7tLrMBnXcgGJqdrsgqDHzeMj+sj+3=R6zMeHdF7aA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/282: use timed writes to make sure scrub has enough
 run time
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:52=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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
> take 4 seoncds to run.

seoncds -> seconds

>
> With 4 seconds as run time, the scrub rate can be calculated more or
> less reliably.
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
> ---
>  tests/btrfs/282     | 48 ++++++++++++++++++++++++++++++++++++++++-----
>  tests/btrfs/282.out |  3 +--
>  2 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/tests/btrfs/282 b/tests/btrfs/282
> index 3b4ad9ea..39d2d8c0 100755
> --- a/tests/btrfs/282
> +++ b/tests/btrfs/282
> @@ -9,13 +9,19 @@
>  . ./common/preamble
>  _begin_fstest auto scrub
>
> +_cleanup()
> +{
> +       [ -n "$mount_pid" ] && kill $mount_pid &> /dev/null

I think you meant $filler_pid and $mount_pid is copy-pasted from some
other test.

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
> +# We want at least 10G for the scratch device.
> +_require_scratch_size $(( 10 * 1024 * 1024))
>
>  # Make sure we can create scrub progress data file
>  if [ -e /var/lib/btrfs ]; then
> @@ -36,9 +42,39 @@ if [ ! -f "${devinfo_dir}/scrub_speed_max" ]; then
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

We should now:

unset filler_pid

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
> +# checksum.
> +size=3D$(_get_filesize $SCRATCH_MNT/filler)
> +rm $SCRATCH_MNT/filler
> +# Make sure the file is deleted.
> +sync

I'm confused about the sync - we shouldn't need that to ensure the
file is deleted.
Even if extents are pinned by the time we want to write more data,
the enospc flushing mechanism will commit the transaction and unpin
extents.

Also since we are using chattr and direct IO, the test should ideally have:

_require_odirect
_require_chattr C

> +
> +# Recreate one with COW thus checksum.

checksum -> checksums

The rest looks fine, thanks.


> +touch $SCRATCH_MNT/filler
> +chattr -C $SCRATCH_MNT/filler
> +$XFS_IO_PROG -c "pwrite -i /dev/urandom 0 $size" $SCRATCH_MNT/filler >> =
$seqres.full
>
>  # Writeback above data, as scrub only verify the committed data.
>  sync
> @@ -83,6 +119,8 @@ if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o =
\
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

