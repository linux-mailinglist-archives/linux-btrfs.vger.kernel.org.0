Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1646F57DF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 14:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjECM2S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 08:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjECM2R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 08:28:17 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C710E5
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 05:28:15 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-55a829411b5so26467397b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 05:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683116894; x=1685708894;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEo7H6HLiPtPvqUewwHdgki89ISIKZ6nE1BOPM4Zg40=;
        b=QKc3qERm3kjzVu7ZJ3Hb0R58aNQK8nVk6ZolsKhsDdAgkxUnTPHv2QL4bl9rzipiAe
         /wVPBgi4d3YFxWPIhU8dirL475GE+Orgq/BdCNEXOPsws8+hjX0vxCbgDs5s2rmzHZqV
         fU/NIDcQj2rlKT0xkL605EFdqgXkq0d/Rw7hV9aSlNdRthZorkSlT6tgXX1RiSkqu1cV
         EjZDzrxS4KJHFULPm/GY1zYcQe9U+lmo0xUbcnSdEg1yVrACLEqJjsdOY6Yd6IL0+LZJ
         VA42xVySHXmaOajjhxFNrZIUaPsvo3lfL+eS6OYRrzI8Wid+DeeBG26o9eWJAVd8oAqS
         Fflg==
X-Gm-Message-State: AC+VfDy5+T4dEDmaFRlzQWV+47uzNfWQvIe2GwOYXfGtcRKU04eIsn6i
        x4WLQ/kgTSwZ1IAsdK+R1ZXgpcqlT1uMGw==
X-Google-Smtp-Source: ACHHUZ7fP1VjP8Gqxtv+3mzzM7B1BnntBigDGaU6u5+zYUZOoEcxPq7hgGjQkUMBOUBf5uqi2H4tWA==
X-Received: by 2002:a0d:f486:0:b0:541:7e07:ed65 with SMTP id d128-20020a0df486000000b005417e07ed65mr18397941ywf.5.1683116893627;
        Wed, 03 May 2023 05:28:13 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id y185-20020a0defc2000000b00555ca01b115sm8545711ywe.104.2023.05.03.05.28.13
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 05:28:13 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso4181237276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 05:28:13 -0700 (PDT)
X-Received: by 2002:a25:db4d:0:b0:b9e:8868:5cb2 with SMTP id
 g74-20020a25db4d000000b00b9e88685cb2mr4745036ybf.37.1683116892785; Wed, 03
 May 2023 05:28:12 -0700 (PDT)
MIME-Version: 1.0
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Wed, 3 May 2023 12:27:56 +0000
X-Gmail-Original-Message-ID: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
Message-ID: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
Subject: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Commit 6ce6ba534418132f4c727d5707fe2794c797299c appears to have broken
the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag to
BTRFS_IOC_LOGICAL_INO_V2. The ioctl now always seems to return zero
inodes with the flag, if the same happened without the flag, thus
making it not very useful.

Context: I maintain btdu, a disk usage profiler for btrfs. It uses
BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET to help users estimate the amount
of space wasted by bookend extents, and identify files / applications
/ IO patterns which create excessive amounts of them.

Thanks!
