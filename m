Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3334BDB64
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfIYJsw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 05:48:52 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:34665 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfIYJsv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 05:48:51 -0400
Received: by mail-vk1-f196.google.com with SMTP id d126so476708vkb.1;
        Wed, 25 Sep 2019 02:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=C3pD7QgSaSom3lT5YXHrmzSF6OFni/ZLBZy9dAlM7EU=;
        b=n6brwEmW21ulV06P0/kIB394yZn+dL2my3AlGD+pF5QclJfsieYMZBaIN9IlVI2fud
         tTdXgybz8X3m6sZSqhz51ruSPpSabFOaxIKwxgEtvWKrjC7/DRJLloP61LRdLICnlJVd
         jJ3XETKHcc3Muo3sG17W2imMbBoXg5JlRt/c0cRKokhTq70mFKN2R3519YcxbBS8N6yx
         5ao5aiWNIExKreE/+hBXEU9LqI7SDJzlgKdQxOW/dThfIOYrNR4bm0sSOf5P1mGpcjXx
         5etdGlc6DoaZhjd2tKk8S9NS9hfNSCdEYexLMuZ4lp/2HsR949Uhv9jkeaQSDbw6DjLm
         k1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=C3pD7QgSaSom3lT5YXHrmzSF6OFni/ZLBZy9dAlM7EU=;
        b=D4LT+GkpNfjf/CZuHiTigbbXlpGm6pOYMIJBpxvYqw1KeSra/RKHNBhqdx7eSInl6N
         lyl5En8idlfZt99i+fl3wk04b8NhYU5Ewd1dWvXJcLtX93a0GEdNmm88WlxOoz1Hx5q7
         cxbSZ9Z61IZgozmUZRptLJ6tYO3qEyP3xckEcPc/0suROkogmPLh9+KXl0qQr9+HJwC7
         836VDnYsA924VF8mpti1h/+V3ylMNIpo2u3TBsyiJLtFj6zRFVCxFuN/d/5LFy0jEIh1
         lKq3BD7P3OHyv3Bh6GbAaiXsciu1eV7eY42DqI17rK+VH1YQSfFZ0Pofrq6pK5mVjavN
         dRTw==
X-Gm-Message-State: APjAAAXEVUls4GerKJOTo5dyPhV5r2lfnm9FBvMKejkaeAjHemHpqJ9B
        27/JG5uPre2FoCKucGNpTk6W/jvOBV+I4WZVp2U/cg==
X-Google-Smtp-Source: APXvYqwzYkBLQmYQURRr0+lrf6tsX3ipqoHUWJYvFyKxqyOQD2xEcjNcHr3rzEjCPa5MGQSGJPBVacMSvAPqA7OCIG4=
X-Received: by 2002:a1f:5e4f:: with SMTP id s76mr1854495vkb.4.1569404928914;
 Wed, 25 Sep 2019 02:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190923124347.30850-1-wqu@suse.com>
In-Reply-To: <20190923124347.30850-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 25 Sep 2019 10:48:38 +0100
Message-ID: <CAL3q7H6Fo+79a36Bp1kRpfyczK5diRwtgkcNLewEY1Fj=dTPiQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/011: Fill the fs to ensure we have enough
 data for dev-replace
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 6:02 PM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> When btrfs/011 is executed on a fast enough system (fully memory backed
> VM, with test device has unsafe cache mode), the test can fail like
> this:
>
>   btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /home/a=
dam/xfstests-dev/results//btrfs/011.out.bad)
>     --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>     +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-09-1=
8 14:49:28.308798022 +0800
>     @@ -1,3 +1,4 @@
>      QA output created by 011
>      *** test btrfs replace
>     -*** done
>     +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>     +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)
>     ...
>
> [CAUSE]
> Looking into the full output, it shows:
>   ...
>   Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
>
>   # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/mapper=
/test-scratch2 /mnt/scratch
>   # /usr/bin/btrfs replace cancel /mnt/scratch
>   INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>   failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>
> So this means the replace is already finished before we cancel it.
> For fast system, it's very common.
>
> [FIX]
> In fill_scratch() after all the original file creations, do a timer
> based direct IO write.
> The extra write will take 2 * $wait_time, utilizing direct IO with 64K
> block size, the write performance should be very comparable (although a
> little faster) to replace performance.
>
> So later cancel should be able to really cancel the dev-replace without
> it finished too early.
>
> Also, do extra check about the above write. If we hit ENOSPC we just
> skip the test as the system is really too fast and the fs is not large
> enough.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/011 | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)
>
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 89bb4d11..dc86539c 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -34,7 +34,7 @@ _cleanup()
>                 kill -TERM $noise_pid
>         fi
>         wait
> -       rm -f $tmp.tmp
> +       rm -f $tmp.*
>         # we need this umount and couldn't rely on _require_scratch to um=
ount
>         # it from next test, because we would replace SCRATCH_DEV, which =
is
>         # needed by _require_scratch, and make it umounted.
> @@ -54,13 +54,17 @@ _require_scratch_dev_pool_equal_size
>  _require_command "$WIPEFS_PROG" wipefs
>
>  rm -f $seqres.full
> -rm -f $tmp.tmp
> +rm -f $tmp.*
>
>  echo "*** test btrfs replace"
>
> +# In seconds
> +wait_time=3D1
> +
>  fill_scratch()
>  {
>         local fssize=3D$1
> +       local filler_pid
>
>         # Fill inline extents.
>         for i in `seq 1 500`; do
> @@ -75,6 +79,33 @@ fill_scratch()
>         for i in `seq $fssize`; do
>                 cp $SCRATCH_MNT/t0 $SCRATCH_MNT/t$i || _fail "cp failed"
>         done > /dev/null 2>> $seqres.full
> +
> +       # Ensure we have enough data so that dev-replace would take at le=
ast
> +       # 2 * $wait_time, allowing we cancel the running replace.
> +       # Some extra points:
> +       # - Use XFS_IO_PROG instead of dd
> +       #   fstests wraps dd, making it pretty hard to kill the real dd p=
id
> +       # - Use 64K block size with Direct IO
> +       #   64K is the same stripe size used in replace/scrub. Using Dire=
ct IO
> +       #   ensure the IO speed is near device limit and comparable to re=
place
> +       #   speed.
> +       $XFS_IO_PROG -f -d -c "pwrite -b 64k 0 1E" "$SCRATCH_MNT/t_filler=
" &>\
> +               $tmp.filler_result &
> +       filler_pid=3D$!
> +       sleep $((2 * $wait_time))
> +       kill -KILL $filler_pid &> /dev/null
> +       wait $filler_pid &> /dev/null
> +
> +       # If the system is too fast and the fs is too small, then skip th=
e test
> +       if grep -q "No space left" $tmp.filler_result; then
> +               ls -alh $SCRATCH_MNT >> $seqres.full
> +               cat $tmp.filler_result >> $seqres.full
> +               _notrun "system too fast and/or too small fs"

It would probably be better to require so minimal size for the
filesystem instead.

> +       fi
> +       # If killed properly, this file should be empty.

Confusing comment for me. If killed properly? How does that influence
the file being empty?
What influences the file being empty is that it's impossible (in
practice) for xfs_io to complete the write in less then 2 seconds,
assuming the fs isn't very small and it hits ENOSPC in less than 2
seconds.

I would rephrase that or remove that line.

Other than that it looks ok to me.

Thanks

> +       # If something other than ENOSPC happened, output to make sure we=
 can
> +       # detect the error
> +       cat $tmp.filler_result
>         sync; sync
>  }
>
> @@ -147,7 +178,7 @@ btrfs_replace_test()
>         if [ "${with_cancel}Q" =3D "cancelQ" ]; then
>                 # background the replace operation (no '-B' option given)
>                 _run_btrfs_util_prog replace start -f $replace_options $s=
ource_dev $target_dev $SCRATCH_MNT
> -               sleep 1
> +               sleep $wait_time
>                 _run_btrfs_util_prog replace cancel $SCRATCH_MNT
>
>                 # 'replace status' waits for the replace operation to fin=
ish
> @@ -157,10 +188,10 @@ btrfs_replace_test()
>                 grep -q canceled $tmp.tmp || _fail "btrfs replace status =
(canceled) failed"
>         else
>                 if [ "${quick}Q" =3D "thoroughQ" ]; then
> -                       # On current hardware, the thorough test runs
> -                       # more than a second. This is a chance to force
> -                       # a sync in the middle of the replace operation.
> -                       (sleep 1; sync) > /dev/null 2>&1 &
> +                       # The thorough test runs around 2 * $wait_time se=
conds.
> +                       # This is a chance to force a sync in the middle =
of the
> +                       # replace operation.
> +                       (sleep $wait_time; sync) > /dev/null 2>&1 &
>                 fi
>                 _run_btrfs_util_prog replace start -Bf $replace_options $=
source_dev $target_dev $SCRATCH_MNT
>
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
