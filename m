Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ADB6A41B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 13:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjB0Mbv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 07:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0Mbu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 07:31:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F01DB94
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 04:31:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso6579977wmi.4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUHVmupV0YisyTUQXBXyeawpVOfUiitHxEHFYrVSaTQ=;
        b=RxUXFnstsu+0C3Z9EmGxJQ2TUrQ9cfHmFm7+7mfMvA9W1P1rqLL4VKRvqGXP9cl5OX
         Kd0iIrXm4UWB7AtOoOvMRXQeJvG1lhTGdaozDo576qaR4Dcz9rl6it6Nbf7FdSX+tC1x
         efIOXFb1Rb8UXFjC9M9TBbv9sFwizdUu5CVxmIS5kOfQnbScM9GExKN5GpRFXrSzNYA0
         3SmZR6VPqjfkn/FdqjPVqjixGOIFqiCDdYNdpKeDkalfNecH2VVVcYGKC8aTkpOGe27j
         Hr/VCNoAYMFDPh8QpEeJ3RgW99H+DxVoQuHCbzRlGBeteltHVMT86gwFyuezRE73LAo8
         OcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUHVmupV0YisyTUQXBXyeawpVOfUiitHxEHFYrVSaTQ=;
        b=z01xNaLbS2zrgbYy9sZ8p4o+59Wwho5Xyf9zBZNd+y11aAFecefXMz5YEgAxrEOo0U
         iM1ZPKmD/wGye2yMy5GRBbmkUGmU8+Y3Yoh6s2nRkGvEfFX1Qmk2QoAcWtuR5/KifWCM
         o7vxUosof6Xd+TehBoruA7eAlKf7XN2ZPyug+sDaP4CFBIms5oYIlLwO2hWgHZ/N/oQs
         MiKHunp3PbobUOg56LTgpIGxSodUfnQo+IuTS+cycnioltUDThk2oRX2c9ayk0kuawX1
         MDqAZj+OaskI5n3p90uXD6eckoR41Xp9T6NDX8eiu/PkM4MhjyCGLvcnKSzuZimQv+hV
         +trw==
X-Gm-Message-State: AO0yUKU6rdPikz0fXEgcccKzqcLbThmZ6iW1o0CRMlFitDpwgKJYIDFJ
        1E0GINOOn9lHj13CK4eQpcRYDKxW5erj5w==
X-Google-Smtp-Source: AK7set+1pVAMJhd+ljUYonXrk8UI362s7NXlDNToIoU0bswa7M0yrk39rSv0p/QBPj5hNDEbJcC0jg==
X-Received: by 2002:a05:600c:807:b0:3eb:399d:ab1d with SMTP id k7-20020a05600c080700b003eb399dab1dmr4132808wmp.16.1677501107913;
        Mon, 27 Feb 2023 04:31:47 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b003eb2e685c7dsm10307600wmq.9.2023.02.27.04.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:31:47 -0800 (PST)
Date:   Mon, 27 Feb 2023 15:31:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     fdmanana@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [bug report] btrfs: drop extent map range more efficiently
Message-ID: <Y/yipSVozUDEZKow@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Filipe Manana,

The patch db21370bffbc: "btrfs: drop extent map range more
efficiently" from Sep 19, 2022, leads to the following Smatch static
checker warning:

	fs/btrfs/extent_map.c:767 btrfs_drop_extent_map_range()
	passing uninitialized variable 'flags'

fs/btrfs/extent_map.c
    740         while (em) {
    741                 /* extent_map_end() returns exclusive value (last byte + 1). */
    742                 const u64 em_end = extent_map_end(em);
    743                 struct extent_map *next_em = NULL;
    744                 u64 gen;
    745                 unsigned long flags;
                        ^^^^^^^^^^^^^^^^^^^

    746                 bool modified;
    747                 bool compressed;
    748 
    749                 if (em_end < end) {
    750                         next_em = next_extent_map(em);
    751                         if (next_em) {
    752                                 if (next_em->start < end)
    753                                         refcount_inc(&next_em->refs);
    754                                 else
    755                                         next_em = NULL;
    756                         }
    757                 }
    758 
    759                 if (skip_pinned && test_bit(EXTENT_FLAG_PINNED, &em->flags)) {
    760                         start = em_end;
    761                         if (end != (u64)-1)
    762                                 len = start + len - em_end;
    763                         goto next;
    764                 }
    765 
    766                 clear_bit(EXTENT_FLAG_PINNED, &em->flags);
--> 767                 clear_bit(EXTENT_FLAG_LOGGING, &flags);
                                                       ^^^^^^
flags is uninitialized at this point.  This clear_bit() is a no-op.

    768                 modified = !list_empty(&em->list);
    769 
    770                 /*
    771                  * The extent map does not cross our target range, so no need to
    772                  * split it, we can remove it directly.
    773                  */
    774                 if (em->start >= start && em_end <= end)
    775                         goto remove_em;
    776 
    777                 flags = em->flags;
    778                 gen = em->generation;
    779                 compressed = test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);

regards,
dan carpenter
