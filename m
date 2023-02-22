Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261869ED2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 04:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjBVDAS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 22:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjBVDAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 22:00:17 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A7834C0D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 18:59:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id b12so93472ils.8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 18:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkYG3QAnKY+faHbh5WQzftnwSBZ78LTfwY1d8pAEoT0=;
        b=dbbod69ldMvRqSCQ9gqV/oCvUTjQGwgVfO1nYqUCMys6Q3IE6eUcgWszDQInesGoX6
         n3Z+RC/48P3xFjX+A0RdDYXasiPA0Qi6Pw8rlEgFfF3X4ti7fZfC3Rz3pfyzr1krlCEC
         gcG61ftnxs1SQjQC7Cx8BlYnfMwcD3RqGcQY3yP/cULkJs9wI9yp+gzVeGK8tAZQ0cf9
         mXZ5IwR/K5kE3VokL1ToCsaqpSnZBrsPVy4o77+ScTjUJrpY8t9LzizaJ/C2jNcKp/Uf
         /V8WHW6JOL6uUvAIdz3QWmIHj6MJMro6dbnlih3gh+Yf0XanWbny+Ahi2HvFJOUFaCMY
         JBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkYG3QAnKY+faHbh5WQzftnwSBZ78LTfwY1d8pAEoT0=;
        b=AbCYpycbtgB4IJ3/+V9IdubddmhfsHZbmlxUIYKWnrZBrZ3X+GGclgzGa9Yn3OFNDF
         iW6rdaCn70PmuXKGkz2oy52Z7k83sjeBOImOJZoumyIDxs/qMYslGKgYqYnrNoLUzPCE
         VTGYI/qSAMct/uFwZGfYwVrLybgzxZ4Gxmi3vgLvCs++iH9H5sBaxnudL9i81DMqClcZ
         Sn8j52Yqp8jp+a8KpOF5KoZoP/OxWLZnrr0bnVnv1CgG0SKr7WYgRziQZYos488XeJYI
         fT2Yl+2nIiXj5XJdisJgTMAY2zv8BUVHiCPl8NOS1QNmwt9LHQ2GRZyo04txaP7BVR5F
         scgA==
X-Gm-Message-State: AO0yUKXc4Bi9vrXQEZWLVrpRHMgwAJ5ddoUWfJAEr2zMJeOTgzpJ3yDZ
        fUKQNR58sBk7YNOCA+Qj4a8=
X-Google-Smtp-Source: AK7set9Lz+LZqfziNmYb3FKDBmgWgOQNJ0FqLBTv0OgTebRYEkxQFnU0kmyzqkj2EcOFh9cnVImjhQ==
X-Received: by 2002:a05:6e02:1d99:b0:310:e816:8c8c with SMTP id h25-20020a056e021d9900b00310e8168c8cmr5845540ila.3.1677034761166;
        Tue, 21 Feb 2023 18:59:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15-20020a029f0f000000b003a958f51423sm580872jal.167.2023.02.21.18.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 18:59:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Feb 2023 18:59:18 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Message-ID: <20230222025918.GA1651385@roeck-us.net>
References: <cover.1671221596.git.josef@toxicpanda.com>
 <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 03:15:58PM -0500, Josef Bacik wrote:
> We had a recent bug that would have been caught by a newer compiler with
> -Wmaybe-uninitialized and would have saved us a month of failing tests
> that I didn't have time to investigate.
> 

Thanks to this patch, sparc64:allmodconfig and parisc:allmodconfig now
fail to commpile with the following error when trying to build images
with gcc 11.3.

Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
fs/btrfs/inode.c: In function 'btrfs_lookup_dentry':
fs/btrfs/inode.c:5730:21: error: 'location.type' may be used uninitialized [-Werror=maybe-uninitialized]
 5730 |         if (location.type == BTRFS_INODE_ITEM_KEY) {
      |             ~~~~~~~~^~~~~
fs/btrfs/inode.c:5719:26: note: 'location' declared here
 5719 |         struct btrfs_key location;

Bisect log attached.

Guenter

---
# bad: [8bf1a529cd664c8e5268381f1e24fe67aa611dd3] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
# good: [c9c3395d5e3dcc6daee66c6908354d47bf98cb0c] Linux 6.2
git bisect start 'HEAD' 'v6.2'
# good: [e43efb6d713bca3855909a2f9caec280a2b0a503] dt-bindings: riscv: correct starfive visionfive 2 compatibles
git bisect good e43efb6d713bca3855909a2f9caec280a2b0a503
# bad: [1f2d9ffc7a5f916935749ffc6e93fb33bfe94d2f] Merge tag 'sched-core-2023-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 1f2d9ffc7a5f916935749ffc6e93fb33bfe94d2f
# bad: [553637f73c314c742243b8dc5ef072e9dadbe581] Merge tag 'for-6.3/dio-2023-02-16' of git://git.kernel.dk/linux
git bisect bad 553637f73c314c742243b8dc5ef072e9dadbe581
# good: [274978f173276c5720a3cd8d0b6047d2c0d3a684] Merge tag 'fixes_for_v6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect good 274978f173276c5720a3cd8d0b6047d2c0d3a684
# bad: [801fcfc5d790f4a9be2897713bd6dd08bed253f1] btrfs: raid56: add a bio_list_put helper
git bisect bad 801fcfc5d790f4a9be2897713bd6dd08bed253f1
# bad: [e2fd83064a9bae368ce1c88a0cb9aee64ad4e124] btrfs: skip backref walking during fiemap if we know the leaf is shared
git bisect bad e2fd83064a9bae368ce1c88a0cb9aee64ad4e124
# bad: [cb0922f264643f03b04352f7a04abb913c609369] btrfs: don't use size classes for zoned file systems
git bisect bad cb0922f264643f03b04352f7a04abb913c609369
# good: [cd30d3bc78d9acbd505d0d6a4cff3b87e40a8187] btrfs: zoned: fix uninitialized variable warning in btrfs_get_dev_zones
git bisect good cd30d3bc78d9acbd505d0d6a4cff3b87e40a8187
# bad: [235e1c7b872f9cf16e8a3e6050a05774b8763c58] btrfs: use a single variable to track return value for log_dir_items()
git bisect bad 235e1c7b872f9cf16e8a3e6050a05774b8763c58
# bad: [d31de3785047a24959eda835b0bafb1f8629f8a9] btrfs: go to matching label when cleaning em in btrfs_submit_direct
git bisect bad d31de3785047a24959eda835b0bafb1f8629f8a9
# bad: [1ec49744ba83f0429c5c706708610f7821a7b6f4] btrfs: turn on -Wmaybe-uninitialized
git bisect bad 1ec49744ba83f0429c5c706708610f7821a7b6f4
# good: [a6ca692ec22bdac5ae700e82ff575a1b5141fa40] btrfs: fix uninitialized variable warning in run_one_async_start
git bisect good a6ca692ec22bdac5ae700e82ff575a1b5141fa40
# first bad commit: [1ec49744ba83f0429c5c706708610f7821a7b6f4] btrfs: turn on -Wmaybe-uninitialized
