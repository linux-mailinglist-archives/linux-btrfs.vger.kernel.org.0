Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECD5E6803
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiIVQD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiIVQDk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 12:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C02FE074
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663862618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FEe+cYZ7lwyjZZ1U9Axmi+jUZoknJtCV8UJ7X0Ts+rU=;
        b=E71i/Cyny647aXMYRM667lokni1rogsXmxntZ4Cb9Xe0lEkDPJ4FG4j7VtDVUNO0gKTe76
        YGUjScng36xNc8vp9t4qMlv/0NKok/o0BOwYq9m/+X2qf5GLHG8AOsxk+jKEpzNxWCM4Ou
        Rc64x8jDli4p4DSM6mZ3SIh2RjijkDY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-aT91vUGfOYWV7kmTSl4ihw-1; Thu, 22 Sep 2022 12:03:37 -0400
X-MC-Unique: aT91vUGfOYWV7kmTSl4ihw-1
Received: by mail-qk1-f200.google.com with SMTP id bp17-20020a05620a459100b006ce7f4bb0b7so6917216qkb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 09:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FEe+cYZ7lwyjZZ1U9Axmi+jUZoknJtCV8UJ7X0Ts+rU=;
        b=s1zEhRgRjEGWMGn3FozPlbyDJsK4/JW1eDShn5XiGQRqvOM01UzLmb7WpjRCC0q0J7
         bKUX74/SW33iTXJ8VuDTEcyI1Mpkt7O4Q9LJIlOnI1N7//1GXq0P5qebkFXlrUgcBGqU
         jDZx30knkH+bEKAvkDiMliDQFcyuXtfVCdQq2Lrq9TM/qAaF6s867zzgKiKxrUwwniru
         P6ZnamVaxGNdnwgaE0vXq35S13YLlOydOI0WzWF0QiqUXjo0YT0q9KzMpFBp9v5Jd6Im
         ox4F09PBXlcgmB6XAfeCgsDaPjLrwYQqHHtsy74QhR0AU7nluZdYL9diTqfHTaBoKyO5
         e3NQ==
X-Gm-Message-State: ACrzQf1qc/FLMzzCjARQ/nnGCvvvGLM0LE49OF/t93kjn0ehFPh5otA6
        9vl2ig8BtW/hK4U12pWeBch0mc4HHNkw402HdaIRJjVS+ev3mn+FXysRfHc0SMa3n12Gsx7jJlJ
        CbrYi2SmodgeIkm2jdVCaD+0=
X-Received: by 2002:a05:620a:998:b0:6ce:6069:c713 with SMTP id x24-20020a05620a099800b006ce6069c713mr2657645qkx.181.1663862616769;
        Thu, 22 Sep 2022 09:03:36 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JkDjLCgg9mex4cT8zQVQrDLWyXFrsj3zdGpFpst7y92/Z1N6/wKXLsceRjpSufxOomq97uA==
X-Received: by 2002:a05:620a:998:b0:6ce:6069:c713 with SMTP id x24-20020a05620a099800b006ce6069c713mr2657607qkx.181.1663862616429;
        Thu, 22 Sep 2022 09:03:36 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g3-20020ac81243000000b00342f8984348sm3630098qtj.87.2022.09.22.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 09:03:35 -0700 (PDT)
Date:   Fri, 23 Sep 2022 00:03:31 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: test active zone tracking
Message-ID: <20220922160331.mzddtycyewfev7jo@zlang-mailbox>
References: <cover.1663825728.git.naohiro.aota@wdc.com>
 <7e30a693ce98783d68bc70d07c185bffc693a4d1.1663825728.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e30a693ce98783d68bc70d07c185bffc693a4d1.1663825728.git.naohiro.aota@wdc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 22, 2022 at 02:54:59PM +0900, Naohiro Aota wrote:
> A ZNS device limits the number of active zones, which is the number of
> zones can be written at the same time. To deal with the limit, btrfs's
> zoned mode tracks which zone (corresponds to a block group on the SINGLE
> profile) is active, and finish a zone if necessary.
> 
> This test checks if the active zone tracking and the finishing of zones
> works properly. First, it fills <number of max active zones> zones
> mostly. And, run some data/metadata stress workload to force btrfs to use a
> new zone.
> 
> This test fails on an older kernel (e.g, 5.18.2) like below.
> 
> btrfs/292
> [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
>     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
>     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
>     @@ -1,2 +1,5 @@
>      QA output created by 292
>     -Silence is golden
>     +stress_data_bgs failed
>     +stress_data_bgs_2 failed
>     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/snap825'
>     +(see /host/btrfs/292.full for details)
>     ...
>     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292.out.bad'  to see the entire diff)
> 
> The failure is fixed with a series "btrfs: zoned: fix active zone tracking
> issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_segments()
> helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
> allocation didn't progress")).
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1657321126.git.naohiro.aota@wdc.com/
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  common/zbd          |  12 ++++
>  tests/btrfs/292     | 137 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/292.out |   2 +
>  3 files changed, 151 insertions(+)
>  create mode 100755 tests/btrfs/292
>  create mode 100644 tests/btrfs/292.out
> 
> diff --git a/common/zbd b/common/zbd
> index 329bb7be6b7b..19a59fd27e69 100644
> --- a/common/zbd
> +++ b/common/zbd
> @@ -2,8 +2,20 @@
>  # Common zoned block device specific functions
>  #
>  
> +. common/rc

Did hit anything wrong if you don't import this file here? I think generally
we don't need to import common/rc in other common files (except common/preamble)
, due to it's always be imported at the beginning of each test cases.

>  . common/filter

As I said in patch 1/2, if you'd like to create this separated common file
about zone device, are you willing to move those extant zone related helpers
into this file, and change related cases to turn to import this file? I don't
have objection if you'd like to organize that.

Thanks,
Zorro

>  
> +_require_limited_active_zones() {
> +    local dev=$1
> +    local sysfs=$(_sysfs_dev ${dev})
> +    local attr="${sysfs}/queue/max_active_zones"
> +
> +    [ -e "${attr}" ] || _notrun "cannot find queue/max_active_zones. Maybe non-zoned device?"
> +    if [ $(cat "${attr}") == 0 ]; then
> +	_notrun "this test requires limited active zones"
> +    fi
> +}
> +
>  _zone_capacity() {
>      local phy=$1
>      local dev=$2
> diff --git a/tests/btrfs/292 b/tests/btrfs/292
> new file mode 100755
> index 000000000000..30c027c4ba5f
> --- /dev/null
> +++ b/tests/btrfs/292
> @@ -0,0 +1,137 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 292
> +#
> +# Test that an active zone is properly reclaimed to allow the further
> +# allocations, even if the active zones are mostly filled.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot zone
> +
> +# Import common functions.
> +. ./common/btrfs
> +. ./common/zbd
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_zoned_device "$SCRATCH_DEV"
> +_require_limited_active_zones "$SCRATCH_DEV"
> +
> +_require_command "$BLKZONE_PROG" blkzone
> +_require_fio
> +_require_btrfs_command inspect-internal dump-tree
> +
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_no_compress
> +
> +max_active=$(cat $(_sysfs_dev ${SCRATCH_DEV})/queue/max_active_zones)
> +
> +# Fill the zones leaving the last 1MB
> +fill_active_zones() {
> +    # Asuumes we have the same capacity between zones.
> +    local capacity=$(_zone_capacity 0)
> +    local fill_size=$((capacity - 1024 * 1024))
> +
> +    for x in $(seq ${max_active}); do
> +	dd if=/dev/zero of=${SCRATCH_MNT}/fill$(printf "%02d" $x) bs=${fill_size} \
> +	   count=1 oflag=direct 2>/dev/null
> +	$BTRFS_UTIL_PROG filesystem sync ${SCRATCH_MNT}
> +
> +	local nactive=$($BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | wc -l)
> +	if [[ ${nactive} == ${max_active} ]]; then
> +	    break
> +	fi
> +    done
> +
> +    echo "max active zones: ${max_active}" >> $seqres.full
> +    $BLKZONE_PROG report ${SCRATCH_DEV} | grep oi | cat -n >> $seqres.full
> +}
> +
> +workout() {
> +    local func="$1"
> +
> +    _scratch_mkfs >/dev/null 2>&1
> +    _scratch_mount
> +
> +    fill_active_zones
> +    eval "$func"
> +    local ret=$?
> +
> +    _scratch_unmount
> +    _check_btrfs_filesystem ${SCRATCH_DEV}
> +
> +    return $ret
> +}
> +
> +stress_data_bgs() {
> +    # This dd fails with ENOSPC, which should not :(
> +    dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=1 oflag=sync \
> +       >>$seqres.full 2>&1
> +}
> +
> +stress_data_bgs_2() {
> +    # This dd fails with ENOSPC, which should not :(
> +    dd if=/dev/zero of=${SCRATCH_MNT}/large bs=64M count=10 conv=fsync \
> +       >>$seqres.full 2>&1 &
> +    local pid1=$!
> +
> +    dd if=/dev/zero of=${SCRATCH_MNT}/large2 bs=64M count=10 conv=fsync \
> +       >>$seqres.full 2>&1 &
> +    local pid2=$!
> +
> +    wait $pid1; local ret1=$?
> +    wait $pid2; local ret2=$?
> +
> +    if [ $ret1 -ne 0 -o $ret2 -ne 0 ]; then
> +	return 1
> +    fi
> +    return 0
> +}
> +
> +get_meta_bgs() {
> +    $BTRFS_UTIL_PROG inspect-internal dump-tree -t EXTENT ${SCRATCH_DEV} |
> +        grep BLOCK_GROUP -A 1 |grep -B1 'METADATA|' |
> +        grep -oP '\(\d+ BLOCK_GROUP_ITEM \d+\)'
> +}
> +
> +# This test case does not return the result because
> +# _run_btrfs_util_prog will call _fail() in the error case anyway.
> +stress_metadata_bgs() {
> +    local metabgs=$(get_meta_bgs)
> +    local count=0
> +
> +    while : ; do
> +        _run_btrfs_util_prog subvolume snapshot ${SCRATCH_MNT} ${SCRATCH_MNT}/snap$i
> +        _run_btrfs_util_prog filesystem sync ${SCRATCH_MNT}
> +        cur_metabgs=$(get_meta_bgs)
> +        if [[ "${cur_metabgs}" != "${metabgs}" ]]; then
> +            break
> +        fi
> +        i=$((i + 1))
> +    done
> +}
> +
> +WORKS=(
> +    stress_data_bgs
> +    stress_data_bgs_2
> +    stress_metadata_bgs
> +)
> +
> +status=0
> +for work in "${WORKS[@]}"; do
> +    if ! workout "${work}"; then
> +	echo "${work} failed"
> +	status=1
> +    fi
> +done
> +
> +# success, all done
> +if [ $status -eq 0 ]; then
> +    echo "Silence is golden"
> +fi
> +exit
> diff --git a/tests/btrfs/292.out b/tests/btrfs/292.out
> new file mode 100644
> index 000000000000..627309d3fbd2
> --- /dev/null
> +++ b/tests/btrfs/292.out
> @@ -0,0 +1,2 @@
> +QA output created by 292
> +Silence is golden
> -- 
> 2.37.3
> 

