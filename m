Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AEC02EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfI0KFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 06:05:10 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38150 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0KFK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 06:05:10 -0400
Received: by mail-vk1-f194.google.com with SMTP id s72so1091931vkh.5;
        Fri, 27 Sep 2019 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=B5yrRDxVoE1DO+l4BPL0wclfQGPJopJ0dzIMG8YiqKE=;
        b=rL+xtXm08w0OPPpH3DEBqrOcdaHG4N+HmzvIPb5dJeqZAaK+4R2ZNax7U7T2VoSGpB
         yGLQXKoJaC6qpergvv0cukctPTrBmUjT+iwcPUVKOF12RE217VC0iF7Eijx2wqqAL6r2
         UqqrvQknQdKo6DIYxKjMxvf7M05sr3XTd9hLhnYx627xhO9fOAiFgNvtG5DoGqbbw8yV
         6iTzb15nj5Wrh1FFoGctEKCwJH6/fr+HDr9SgYP7g/1/rctSgBYNMYJ6l/FZPJykfYrv
         WjFARiRIm8PQopOGrgdg3sWhO9rcOqzdSOibssTHX9S9rRN/7fzKk6CoWSEyYYlbb+PQ
         2LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=B5yrRDxVoE1DO+l4BPL0wclfQGPJopJ0dzIMG8YiqKE=;
        b=NyHx1qXNZiJB98jwqsiwBRXxtNNSJFlHXvsn3xK2Sso5sc1D0JyenJ7P9DElXyxuy1
         WCSErpSi8y5bVEexUN3CL7uBhH6V7tAVXEBbPJjiZY/TC/MUkjT6jYgwMWps51Lb/j0T
         Q2jlL+bIH96AIIJqxM3bUySK5+SDMOcV8Wr6FNyzLRBR3GpIMm2DZCbVIPWjNmzBu3JO
         vIzB61VuIWON5tvh1WmtCf/MCeCmMs3WCoECs5boiHMbu30ax2YzcAVnc68ny9AO26fZ
         pTI9jcYbXZlFgTbgu7GN3tup61VJNTiaOEfu9zMZryCUlq9MfwkOUMJ5KNpnHihVB12l
         zdFA==
X-Gm-Message-State: APjAAAX+feFYjHbQ/Dgj2UTf7utWe/2aEA/nwi4YVU2skU+7TGKda3q9
        Ya/rIjvaEMVyqfi+2GRry1UW8cSBd7pfEGiJtuOUYg==
X-Google-Smtp-Source: APXvYqydgeRvmxG5iy5IPEZHEYKG5JZHUqhi1hweenwyg3k1H2QpC7n2iyz8SKPtEhozp/5k83oReWdPhsTytHyWWfs=
X-Received: by 2002:a1f:c2c3:: with SMTP id s186mr4019998vkf.88.1569578708704;
 Fri, 27 Sep 2019 03:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190927095843.20595-1-wqu@suse.com>
In-Reply-To: <20190927095843.20595-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 27 Sep 2019 11:04:57 +0100
Message-ID: <CAL3q7H531Hmv+wOSzq6gxrQGZ7Pf3y7ZjxEHoxrON9iNDY8VRA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/011: Fill the fs to ensure we have
 enough data for dev-replace
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 10:59 AM Qu Wenruo <wqu@suse.com> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> changelog
> v2:
> - Remove one confusing comment
> - Change the _notrun message to focus on too small fs
> ---
>  tests/btrfs/011 | 42 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 89bb4d11..de424f87 100755
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
> @@ -75,6 +79,30 @@ fill_scratch()
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
> +               _notrun "fs too small for this test"
> +       fi
> +       cat $tmp.filler_result
>         sync; sync
>  }
>
> @@ -147,7 +175,7 @@ btrfs_replace_test()
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
> @@ -157,10 +185,10 @@ btrfs_replace_test()
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
