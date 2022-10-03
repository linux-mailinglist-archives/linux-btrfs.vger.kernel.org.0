Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224A95F2F42
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Oct 2022 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJCLEC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 07:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCLEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 07:04:00 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5E578B5
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 04:03:59 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w13so10957611oiw.8
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Oct 2022 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date;
        bh=L2h9sZGHWA4G7GGNDqixkW+X2w2s92U7A4uDnemJbfI=;
        b=nTEYJ5UEhe7tIVg6CnHOJ2yFxVWfIS3Pg1DxFkka0qNVKSN/2T8E/uuBDnWuEUhxEk
         fPARW9BwPBp/fx2pnSMPXgbSaSKPIRbhqkK7WxrExMUCBsz9JRox3Yrg5lxcf2G9GAPC
         9V6bH1lY+zJFeVFisvu8o0l/PHutghKuchy4nGZ4IKA47x47KdlcFjSXc4x28AZjmQrQ
         SUTbOWPZHJRE3gChg/0Wdk08kg7muSpWaRg/L7sVeMPi/4N/PadtOAzUoG8fGRQ/HaDx
         1YjC74Z5ZYtLYm/ygJm+Xk8winsFPujUmLQebpxj9HSUMWdS3kSu+yDO00lfwMGNmzKK
         aFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=L2h9sZGHWA4G7GGNDqixkW+X2w2s92U7A4uDnemJbfI=;
        b=H7XRwU5WxOvUq/KtRs1+yZw2obgdRHEsnytUUui5a/r0aJiTBvFBksQOgTQ6WaQ9uD
         tWoevIJJnYn0MQgxT1lSJ28Ny44vjwyGSiSynbcro6uMmZQ2NcM91HURIzUAFIqov9J/
         NVZ1BdH3tMqAZx8iCHWwcO19hi5ikHU3M3FPt1VzH/6vVH3nxzvcKhxQkUDSxTZUEFaw
         gD1sm23KGcZxaqlCRvhLwx2q9ZpxES4Gh1qd4xugSqdd7B4IaA4x8nO1o/uvZF+S1NOl
         JvYPYqTIK9I5r9aCWA6mz4jGgQmg9lt8dF5Yi88qQtIstqIHIQ1T/4D51WqYwy4SRxyX
         ykqQ==
X-Gm-Message-State: ACrzQf13Dgkrw01jhG78heLsZZWijROWOSaBZrM8eZY16mmls/V5EtJG
        V3Jy7yKVTgsUbFPIviQt1ZpoRFms4SIV4lBwMvA=
X-Google-Smtp-Source: AMsMyM7z3JIcCvHTicDqpAiCQjXqr/xpq4eTAAcWJfBRNpikf/2P7f+V2lAVAMJb4ddQBtgFvtYWGfdnQj0lb+zcXvg=
X-Received: by 2002:a05:6808:1a09:b0:350:1e6a:e469 with SMTP id
 bk9-20020a0568081a0900b003501e6ae469mr3644128oib.92.1664795039280; Mon, 03
 Oct 2022 04:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1664570261.git.josef@toxicpanda.com>
In-Reply-To: <cover.1664570261.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 3 Oct 2022 12:03:23 +0100
Message-ID: <CAL3q7H4uDS9kVad9USMN-D-qryy+RksPyX79LMKDW7fT1WWMJg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Deadlock fix and cleanups
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 30, 2022 at 10:08 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Hello,
>
> There's a problem with how we do our extent locking, namely that if we en=
counter
> any contention in the range we're trying to lock we'll leave any area we =
were
> able to lock locked.  This creates dependency issues when the contended a=
rea is
> blocked on some other thing that depends on an operation that would need =
the
> range lock for the area that was successfully locked.  The exact scenario=
 we
> encountered is described in patch 1.  We need to change this behavior to =
simply
> wait on the contended area and then attempt to re-lock our entire range,
> clearing anything that was locked before we encountered contention.
>
> The followup patches are optimizations and cleanups around caching the ex=
tent
> state in more places.  Additionally I've added caching of the extent stat=
e of
> the contended area to hopefully reduce the pain of needing to unlock and =
then
> wait on the contended area.
>
> The first patch needs to be backported to stable because of the extent-io=
-tree.c
> move.  Once it lands in Linus I'll manually backport the patch and send i=
t back
> to the stable branches.
>
> I've run this through a sanity test on xfstests, and I ran it through 2 t=
ests on
> fsperf that I felt would hammer on the extent locking code the most and b=
e most
> likely to run into lock contention.  I used the new function profiling st=
uff to
> grab latency numbers for lock_extent(), but of course there's a lot of va=
riance
> here.  The only thing that fell outside of the standard deviation were so=
me of
> the maximum latency numbers, but generally everything was within the stan=
dard
> deviation.  Again these are mostly just for information, deadlock fixing =
comes
> before performance.  Thanks,
>
> Josef
>
> bufferedrandwrite16g results
>       metric           baseline       current        stdev            dif=
f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> avg_commit_ms            10090.03       8453.23       3505.07   -16.22%
> bg_count                    20.80         20.80          0.45     0.00%
> commits                      6.20             6          1.10    -3.23%
> elapsed                    140.60        139.60         18.06    -0.71%
> end_state_mount_ns    42066858.80   45104291.80    6317588.83     7.22%
> end_state_umount_ns      6.26e+09      6.23e+09      1.76e+08    -0.39%
> lock_extent_calls     10795318.60   10713477.60     233933.51    -0.76%
> lock_extent_ns_max     3945976.80       7027641    1676910.27    78.10%
> lock_extent_ns_mean       2258.36       2187.89        212.76    -3.12%
> lock_extent_ns_min         503.60        500.80          7.44    -0.56%
> lock_extent_ns_p50        1964.80       1953.60        190.31    -0.57%
> lock_extent_ns_p95        4257.40       4153.20        409.06    -2.45%
> lock_extent_ns_p99        6967.20       6429.20       1166.93    -7.72%
> max_commit_ms            24686.20         25927       5930.26     5.03%
> sys_cpu                     46.68         45.52          6.83    -2.48%
> write_bw_bytes           1.25e+08      1.24e+08   15352552.51    -0.61%
> write_clat_ns_mean       23568.91      21840.81       4061.83    -7.33%
> write_clat_ns_p50        13734.40      13683.20       1268.43    -0.37%
> write_clat_ns_p99           33152      30873.60       4236.59    -6.87%
> write_io_kbytes          16777216      16777216             0     0.00%
> write_iops               30413.83      30228.55       3748.18    -0.61%
> write_lat_ns_max         1.72e+10      1.77e+10      9.25e+09     2.64%
> write_lat_ns_mean        23645.69      21934.65       4057.93    -7.24%
> write_lat_ns_min          6049.40       5877.60         80.29    -2.84%
>
> randwrite2xram results
>       metric           baseline       current        stdev            dif=
f
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> avg_commit_ms            21196.15      32607.37       2286.20    53.84%
> bg_count                    43.80         39.80          6.46    -9.13%
> commits                     11.20          9.80          1.10   -12.50%
> elapsed                    329.20           350          4.97     6.32%
> end_state_mount_ns    61846504.40   57392390.60    7914609.45    -7.20%
> end_state_umount_ns      1.74e+10      1.80e+10      2.35e+09     3.44%
> lock_extent_calls     26193512.60      24046630    4169768.34    -8.20%
> lock_extent_ns_max    23699711.60   17524496.80   13253697.58   -26.06%
> lock_extent_ns_mean       1871.04       1866.95         26.60    -0.22%
> lock_extent_ns_min         495.60           501          5.41     1.09%
> lock_extent_ns_p50        1681.80       1675.40         22.13    -0.38%
> lock_extent_ns_p95        3487.60          3492         45.35     0.13%
> lock_extent_ns_p99        4416.60       4431.80         44.77     0.34%
> max_commit_ms               53482     116910.40       8707.34   118.60%
> sys_cpu                      9.88          8.32          1.75   -15.85%
> write_bw_bytes           1.05e+08   89841897.40   20713472.34   -14.84%
> write_clat_ns_mean      158731.16     234418.93      30030.49    47.68%
> write_clat_ns_p50        14732.80      14873.60        448.91     0.96%
> write_clat_ns_p99        75622.40      82892.80      12865.88     9.61%
> write_io_kbytes       31930975.20   28774377.60    5985362.29    -9.89%
> write_iops               25756.55      21934.06       5057.00   -14.84%
> write_lat_ns_max         3.49e+10      5.87e+10      6.68e+09    68.41%
> write_lat_ns_mean       158828.62     234533.46      30028.84    47.66%
> write_lat_ns_min             7809       7923.40        371.87     1.46%
>
> Josef Bacik (6):
>   btrfs: unlock locked extent area if we have contention
>   btrfs: add a cached_state to try_lock_extent
>   btrfs: use cached_state for btrfs_check_nocow_lock
>   btrfs: use a cached_state everywhere in relocation
>   btrfs: cache the failed state when locking extents
>   btrfs: add cached_state to read_extent_buffer_subpage

The whole patchset looks good to me, so

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>  fs/btrfs/extent-io-tree.c | 68 +++++++++++++++++++++++++++------------
>  fs/btrfs/extent-io-tree.h |  6 ++--
>  fs/btrfs/extent_io.c      | 17 +++++++---
>  fs/btrfs/file.c           | 12 ++++---
>  fs/btrfs/inode.c          |  3 +-
>  fs/btrfs/ordered-data.c   |  7 ++--
>  fs/btrfs/ordered-data.h   |  3 +-
>  fs/btrfs/relocation.c     | 40 +++++++++++++++--------
>  8 files changed, 106 insertions(+), 50 deletions(-)
>
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
