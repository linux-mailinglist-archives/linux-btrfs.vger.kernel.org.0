Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B6A65764C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Dec 2022 13:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiL1MGP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 28 Dec 2022 07:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1MGO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 07:06:14 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC15C3A
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 04:06:12 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id 17so15935312pll.0
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 04:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VbLV1/4fIGgZNtOEh+DCWdRsqvSZLOe7d5SqIjCMpQ=;
        b=X0vRMLmk3UEl1gzn+sVfQYkMTsyBR5fo/finYSU3enftQuErM3I2VxhX2VoQAYXyef
         PoW/wcMegJ1eMayIbKJuBrdJHrNbPHN42aDyzex5/ZaZnSNiA2bUQpLrKvFmX0vNhN0E
         X/RIpcCYDN81OiuOojzR3RT2mRukXkVXb69Bn6baqRDK+GusGfKTk5h32E+ofURezZWz
         oaONrorBrD/RM33ASj8a/ZWbNnIHcCvWBAbpRD9xKuDngHUfz+D8cG5zz0Em9tOzSoS4
         Bz9XfSalpFNpoAc/0F56lyOSulOGqwLtelQIo+RDsUGMNmdkPfl1deXK3EdXxy6Dswk2
         gwFg==
X-Gm-Message-State: AFqh2kptxENLEwG08m48cDAfPCc0cKzvxZxfTc3kQSc74u2cVBeuJxaR
        fMmYNvxDEO/1Cv4jDVyka0Tzum+zzRI=
X-Google-Smtp-Source: AMrXdXtJrfNyG165T1ez7kCnGHk8MxjFfQof3HgGlTRGxIdTZR3fJn/LlPUs5zWFBmHhR0FwJa/E9w==
X-Received: by 2002:a17:903:114:b0:192:9ab2:fd1d with SMTP id y20-20020a170903011400b001929ab2fd1dmr43936plc.3.1672229171881;
        Wed, 28 Dec 2022 04:06:11 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id ij7-20020a170902ab4700b00189743ed3b6sm10987658plb.64.2022.12.28.04.06.11
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:06:11 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id k19so2892877pfg.11
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Dec 2022 04:06:11 -0800 (PST)
X-Received: by 2002:a63:1164:0:b0:480:ae27:c7ae with SMTP id
 36-20020a631164000000b00480ae27c7aemr1293919pgr.24.1672229170763; Wed, 28 Dec
 2022 04:06:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672120480.git.wqu@suse.com> <6b439939b69d08debf357e7b9d7a5b3ef8ae6b4b.1672120480.git.wqu@suse.com>
In-Reply-To: <6b439939b69d08debf357e7b9d7a5b3ef8ae6b4b.1672120480.git.wqu@suse.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Wed, 28 Dec 2022 07:05:34 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-V88GQRkgZDMJL6xbmfrWgYk14N9yMhERdf6iFLoAZUg@mail.gmail.com>
Message-ID: <CAEg-Je-V88GQRkgZDMJL6xbmfrWgYk14N9yMhERdf6iFLoAZUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs-progs: misc-tests: add a test case to make sure
 uuid is correctly reported
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 27, 2022 at 1:10 AM Qu Wenruo <wqu@suse.com> wrote:
>
> The new test case will execute "btrfs subvolume list -u" on the newly
> create btrfs.
>
> Since the v0 root item is already deprecated for a long time, newly
> created btrfs should be already using the new root item, thus "btrfs
> subvolume list -u" should always report the correct uuid.
>
> The test case relies on external program "uuidparse" which should be
> provided by util-linux.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  .../056-subvolume-list-uuid/test.sh           | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100755 tests/misc-tests/056-subvolume-list-uuid/test.sh
>
> diff --git a/tests/misc-tests/056-subvolume-list-uuid/test.sh b/tests/misc-tests/056-subvolume-list-uuid/test.sh
> new file mode 100755
> index 000000000000..45f4f956c25f
> --- /dev/null
> +++ b/tests/misc-tests/056-subvolume-list-uuid/test.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +#
> +# Make sure "btrfs subvolume list -u" shows uuid correctly
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +check_global_prereq uuidparse
> +
> +setup_root_helper
> +prepare_test_dev
> +
> +tmp=$(_mktemp_dir list_uuid)
> +
> +run_check_mkfs_test_dev
> +run_check_mount_test_dev
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
> +run_check_stdout $SUDO_HELPER "$TOP/btrfs" subvolume list -u "$TEST_MNT" |\
> +       cut -d\  -f9 > "$tmp/output"
> +
> +result=$(cat "$tmp/output" | uuidparse -o TYPE -n)
> +rm -rf -- "$tmp"
> +
> +if [ "$result" == "invalid" ]; then
> +       _fail "subvolume list failed to report uuid"
> +fi
> +run_check_umount_test_dev
> --
> 2.39.0
>

Reviewed-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
