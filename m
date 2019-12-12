Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B854E11D072
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 16:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfLLPEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 10:04:25 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46823 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfLLPEZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 10:04:25 -0500
Received: by mail-vs1-f68.google.com with SMTP id t12so1739986vso.13;
        Thu, 12 Dec 2019 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iJxOs+GYRqOPgEdebpFZWCohyjdtB7XwJCeqoNGvKVQ=;
        b=LqMSnbjrj5G76MDG14n2h+uY8RoLCZC3LuTQKgt4a4I3AYAh0D0KaAl3X0S0fu6c4Q
         hk6kSK3OWWiNa3tI/zuRYgLbCiCmGMpUFkB7hUFCIW0iF3y824fhP5keXEl2ru7hfPeB
         owQ0EZtG08S07ugWGNto1zbe1V0heTNhz47qNFzpSyJYVHBDlZ35KGzTNdGG4MJCr3pC
         pR8CvFEtcS8QDcPEvkki60l22icyJdld9dp+O0ZCTRplti6omaFK+EwTG5pZ608zbkoq
         kKzuDtx7gY94YBwY99szvoRoAWB39/+13fajH6IXU8+OcMbOd+TO+Qlnr/5pRrPa62ek
         GPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iJxOs+GYRqOPgEdebpFZWCohyjdtB7XwJCeqoNGvKVQ=;
        b=HjFenVNzLJp2coPwpseFboCCDWsb1gE782wGPdPmNpGLnENRytSMjrw1aBf4TNUWpT
         rtzhY69qmZQ7G/qtItaJl4wsEWygJRSLnxaUhQYMPr7LAU4CdRpsruFdnN8NgWiEN//E
         aujRLZu1p1Jgmc7xUHPr5dhpSay6SemLDdP9f2yXtmbNmK4Fea5McfyhMdog4O/9o2Pe
         Z+tkkcAIr7RA/AWb8kF54gmeNnLsOn22LyBWeJEHpTpBxc557bnbMocPJP9kSE4fb/Hd
         AfUSly95MK3JZOFOnmZj1m5tlQyQpLuQwB9tO4c1nshFt8yNJgc1/lVlzhXRiO36HAVe
         M0mw==
X-Gm-Message-State: APjAAAXh0ySCH1iwnrlwGz3bk/rM8ImvtPGcEqSmiX46SrehccA6rZBc
        yiThk+H8NCNUZ6DaTurM9in5wSoM2dzlT712hYewJ3GR
X-Google-Smtp-Source: APXvYqwjjaoRFauUa0LYE8WNtMzveLybTffZ30s48QS49eg7sYOG9UdQ5tllm7rM3rF6a4dWZ3TwKLfPFV7zO5JAii0=
X-Received: by 2002:a67:8010:: with SMTP id b16mr7435445vsd.90.1576163063777;
 Thu, 12 Dec 2019 07:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20191212053034.21995-1-wqu@suse.com>
In-Reply-To: <20191212053034.21995-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 12 Dec 2019 15:04:12 +0000
Message-ID: <CAL3q7H7X5JfnjRra2ivGFauizxeSjXS1bazjcWrhuBM3sD4H0g@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/09[58]: Use hash to replace unreliable od output
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 5:30 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> With latest master, btrfs/09[58] fails like:
>
>   btrfs/095 2s ... - output mismatch (see xfstests-dev/results//btrfs/095=
.out.bad)
>       --- tests/btrfs/095.out     2019-12-12 13:23:24.266697540 +0800
>       +++ xfstests-dev/results//btrfs/095.out.bad      2019-12-12 13:23:2=
9.340030879 +0800
>       @@ -4,32 +4,32 @@
>        File contents before power failure:
>        0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>        *
>       -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>       +771 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>        *
>       -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>       ...
>       (Run 'diff -u xfstests-dev/tests/btrfs/095.out xfstests-dev/results=
//btrfs/095.out.bad'  to see the entire diff)
>   btrfs/098 2s ... - output mismatch (see xfstests-dev/results//btrfs/098=
.out.bad)
>       --- tests/btrfs/098.out     2019-12-12 13:23:24.266697540 +0800
>       +++ xfstests-dev/results//btrfs/098.out.bad      2019-12-12 13:23:3=
1.306697545 +0800
>       @@ -3,20 +3,20 @@
>        File contents before power failure:
>        0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>        *
>       -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>       +537 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>        *
>       -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>       ...
>       (Run 'diff -u xfstests-dev/tests/btrfs/098.out xfstests-dev/results=
//btrfs/098.out.bad'  to see the entire diff)
>   Ran: btrfs/095 btrfs/098
>   Failures: btrfs/095 btrfs/098
>   Failed 2 of 2 tests
>
> [CAUSE]
> It looks like commit 37520a314bd4 ("fstests: Don't use gawk's strtonum")
> is making _filter_od doing stupid filtering.
>
> [FIX]
> Personally speaking, I don't really care about whatever _filter_od is
> doing at all.
> And since these two test cases only care about the content, let's use
> hash to replace unreliable _filter_od output.

Nop, this won't work.
Have you read carefully the tests and the changelogs?

The file contents are different depending on the page size of the
system where it runs. If you look at the tests, they do things like:

$CLONER_PROG -s $(((200 * $BLOCK_SIZE) + (5 * $BLOCK_SIZE))) ....

So hardcoding a checksum in the golden output is not an option, it
won't be the same on x86 as on powerpc (with a page size of 64Kb).

> While move the filtered (and meaningless) od output to $seqres.full.

Well, it does't make sense to use the filter for the output to $seqres.full=
.

Given that the author of the commit that introduced the regression is
asking Eryu to revert it, as it's causing problems on xfs tests as
well, this won't be necessary.

Thanks.

>
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/095     | 13 +++++++++----
>  tests/btrfs/095.out | 36 ++++--------------------------------
>  tests/btrfs/098     | 14 ++++++++++----
>  tests/btrfs/098.out | 24 ++++--------------------
>  4 files changed, 27 insertions(+), 60 deletions(-)
>
> diff --git a/tests/btrfs/095 b/tests/btrfs/095
> index 4c810a5d..4b381a9e 100755
> --- a/tests/btrfs/095
> +++ b/tests/btrfs/095
> @@ -122,8 +122,10 @@ $CLONER_PROG -s $((768 * $BLOCK_SIZE)) -d $((150 * $=
BLOCK_SIZE)) -l $((25 * $BLO
>  # fsync and before the next transaction commit.
>  $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>
> -echo "File contents before power failure:"
> -od -t x1 $SCRATCH_MNT/foo | _filter_od
> +echo "File hash before power failure:"
> +_md5_checksum $SCRATCH_MNT/foo
> +echo "File contens before power failure:" >> $seqres.full
> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
>  # During log replay, the btrfs delayed references implementation used to=
 run the
>  # deletion of back references before the addition of new back references=
, which
> @@ -135,8 +137,11 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
>  # failure of the insertion that ended up turning the fs into read-only m=
ode.
>  _flakey_drop_and_remount
>
> -echo "File contents after log replay:"
> -od -t x1 $SCRATCH_MNT/foo | _filter_od
> +echo "File hash after log replay:"
> +_md5_checksum $SCRATCH_MNT/foo
> +
> +echo "File contents after log replay:" >> $seqres.full
> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
>  _unmount_flakey
>
> diff --git a/tests/btrfs/095.out b/tests/btrfs/095.out
> index e73b24d5..5c3ec951 100644
> --- a/tests/btrfs/095.out
> +++ b/tests/btrfs/095.out
> @@ -1,35 +1,7 @@
>  QA output created by 095
>  Blocks modified: [135 - 164]
>  Blocks modified: [768 - 792]
> -File contents before power failure:
> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> -*
> -257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> -*
> -1431
> -File contents after log replay:
> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -207 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -226 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> -*
> -257 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -1137 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -1175 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -1400 bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
> -*
> -1431
> +File hash before power failure:
> +beaf47c36659ac29bb9363fb8ffa10a1
> +File hash after log replay:
> +beaf47c36659ac29bb9363fb8ffa10a1
> diff --git a/tests/btrfs/098 b/tests/btrfs/098
> index 0e0b5123..e42e3146 100755
> --- a/tests/btrfs/098
> +++ b/tests/btrfs/098
> @@ -69,8 +69,11 @@ $CLONER_PROG -s $(((200 * $BLOCK_SIZE) + (5 * $BLOCK_S=
IZE))) \
>  # first fsync we did before.
>  $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>
> -echo "File contents before power failure:"
> -od -t x1 $SCRATCH_MNT/foo | _filter_od
> +
> +echo "File hash before power failure:"
> +_md5_checksum $SCRATCH_MNT/foo
> +echo "File contents before power failure:" >> $seqres.full
> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
>  # The fsync log replay first processes the file extent item correspondin=
g to the
>  # file offset mapped by 100th block (the one which refers to the [5, 10[=
 block
> @@ -95,10 +98,13 @@ od -t x1 $SCRATCH_MNT/foo | _filter_od
>  #
>  _flakey_drop_and_remount
>
> -echo "File contents after log replay:"
>  # Must match the file contents we had after cloning the extent and befor=
e
>  # the power failure happened.
> -od -t x1 $SCRATCH_MNT/foo | _filter_od
> +echo "File hash after log replay:"
> +_md5_checksum $SCRATCH_MNT/foo
> +
> +echo "File contents after log replay:" >> $seqres.full
> +od -t x1 $SCRATCH_MNT/foo | _filter_od >> $seqres.full
>
>  _unmount_flakey
>
> diff --git a/tests/btrfs/098.out b/tests/btrfs/098.out
> index 98a96dec..e3db64a0 100644
> --- a/tests/btrfs/098.out
> +++ b/tests/btrfs/098.out
> @@ -1,22 +1,6 @@
>  QA output created by 098
>  Blocks modified: [200 - 224]
> -File contents before power failure:
> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -341
> -File contents after log replay:
> -0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -144 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -151 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> -*
> -310 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> -*
> -341
> +File hash before power failure:
> +39b386375971248740ed8651d5a2ed9f
> +File hash after log replay:
> +39b386375971248740ed8651d5a2ed9f
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
