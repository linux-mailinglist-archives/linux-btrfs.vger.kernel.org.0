Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC433702B31
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 13:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjEOLOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjEOLOH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 07:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E59172B
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 04:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B131261E4C
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 11:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F74C433A0
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149245;
        bh=zNdkTUZ+kuUxeHz0Jq4U2DJqxokT3IfiMdz4GCtqNiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bypUEPhMZa+QHaAo1MLjJgFV/xSj0LR23jDNBB1Pf1LgtjeoV1yD4fZ84RcRAEjw4
         LFk5qNnIiDIAODGL4+iGqsHqHQ5cpUhh9+qhEiZzr4N9/22ts1ad+i+KKDsOhhI5H6
         D2lrTiuHC4P0UXUI1mmj2j+nzI9qQofIGK6F5SANEvogLTw1bzuidsbbmftp3kTc+6
         nOMg51iFE5os/Bfddl06oRTnWShzUZK3JUI5Aavm4Voy0YvwWh1lLZ05murz4fD24a
         ZJ3TU5V8J1X3kJJxeGKgQvlSCfZ2eCocrtXQYmuGw7n6NBuD1oSOro+dUos+Cn0jpS
         1xJ2lgrJv8e5w==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1928253dd95so5409859fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 04:14:05 -0700 (PDT)
X-Gm-Message-State: AC+VfDyPLluaIyJR4QtOYt0TXyQ1bfbNtxTZ8OqMDOhhbeERRTYwbPzh
        HsmHI8BPDPFm9nL9dy56KmVyqWEofqIeL/3Bl3Q=
X-Google-Smtp-Source: ACHHUZ5I4rV1BE71yFvHt0OEIMEPosbg7bHc8sbO8898v03H2p1+AHkOB4lwS9SgQ8A7Ubb01XPW4tpCrXFHVLL5+JA=
X-Received: by 2002:a05:6870:76a5:b0:17e:9798:6e34 with SMTP id
 dx37-20020a05687076a500b0017e97986e34mr16043085oab.32.1684149244170; Mon, 15
 May 2023 04:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <202305151446.364f9707-oliver.sang@intel.com>
In-Reply-To: <202305151446.364f9707-oliver.sang@intel.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 15 May 2023 12:13:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H53mD=ZrxSK7M6RMcJFE88md9Rd9cHq0c8VXAC6CA3aog@mail.gmail.com>
Message-ID: <CAL3q7H53mD=ZrxSK7M6RMcJFE88md9Rd9cHq0c8VXAC6CA3aog@mail.gmail.com>
Subject: Re: [kdave-btrfs-devel:misc-next] [btrfs] 99635ae5e8: xfstests.btrfs.228.fail
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 15, 2023 at 7:26=E2=80=AFAM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "xfstests.btrfs.228.fail" on:
>
> commit: 99635ae5e80e4696458d671bdff286346b02b1be ("btrfs: don't commit tr=
ansaction for every subvol create")
> https://github.com/kdave/btrfs-devel.git misc-next
>
> [test failed on linux-next/master e922ba281a8d84f640d8c8e18a385d032c19e18=
5]
>
> in testcase: xfstests
> version: xfstests-x86_64-06c027a-1_20230501
> with following parameters:
>
>         disk: 6HDD
>         fs: btrfs
>         test: btrfs-group-22
>
>
>
> compiler: gcc-11
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz=
 (Haswell) with 8G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Link: https://lore.kernel.org/oe-lkp/202305151446.364f9707-oliver.sang@=
intel.com
>
> 2023-05-14 22:04:42 export TEST_DIR=3D/fs/sdb1
> 2023-05-14 22:04:42 export TEST_DEV=3D/dev/sdb1
> 2023-05-14 22:04:42 export FSTYP=3Dbtrfs
> 2023-05-14 22:04:42 export SCRATCH_MNT=3D/fs/scratch
> 2023-05-14 22:04:42 mkdir /fs/scratch -p
> 2023-05-14 22:04:42 export SCRATCH_DEV_POOL=3D"/dev/sdb2 /dev/sdb3 /dev/s=
db4 /dev/sdb5 /dev/sdb6"
> 2023-05-14 22:04:42 sed "s:^:btrfs/:" //lkp/benchmarks/xfstests/tests/btr=
fs-group-22
> 2023-05-14 22:04:42 ./check btrfs/220 btrfs/221 btrfs/222 btrfs/223 btrfs=
/224 btrfs/225 btrfs/226 btrfs/227 btrfs/228 btrfs/229
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 lkp-hsw-d01 6.4.0-rc1-00014-g99635ae5e80e #=
1 SMP Mon May 15 05:41:11 CST 2023
> MKFS_OPTIONS  -- /dev/sdb2
> MOUNT_OPTIONS -- /dev/sdb2 /fs/scratch
>
> btrfs/220        15s
> btrfs/221        3s
> btrfs/222        2s
> btrfs/223       [not run] FITRIM not supported on /fs/scratch
> btrfs/224        2s
> btrfs/225        4s
> btrfs/226        5s
> btrfs/227        2s
> btrfs/228       [failed, exit status 1]- output mismatch (see /lkp/benchm=
arks/xfstests/results//btrfs/228.out.bad)
>     --- tests/btrfs/228.out     2023-05-01 18:50:21.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//btrfs/228.out.bad     2023-05-1=
4 22:05:18.648983306 +0000
>     @@ -1,2 +1,3 @@
>      QA output created by 228
>     -Silence is golden
>     +First subvol with id 256 doesn't exist
>     +(see /lkp/benchmarks/xfstests/results//btrfs/228.full for details)

Know problem and it was very recently fixed in fstests' for-next branch:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor-next=
&id=3De35817daa103d6c8dd670fc0acef7f2247e10a9f


>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/btrfs/228.out /lkp/bench=
marks/xfstests/results//btrfs/228.out.bad'  to see the entire diff)
> btrfs/229        3s
> Ran: btrfs/220 btrfs/221 btrfs/222 btrfs/223 btrfs/224 btrfs/225 btrfs/22=
6 btrfs/227 btrfs/228 btrfs/229
> Not run: btrfs/223
> Failures: btrfs/228
> Failed 1 of 10 tests
>
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
>
>
