Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D732572B1A2
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jun 2023 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjFKLTG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Jun 2023 07:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFKLTF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Jun 2023 07:19:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E78123;
        Sun, 11 Jun 2023 04:19:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b3b56dcf1bso6980595ad.2;
        Sun, 11 Jun 2023 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686482344; x=1689074344;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iqt3Dl9KT3PE0L7+/YPJFqJ9BXGcPkPSX2+KIrhZ5ho=;
        b=aeOrPWkncwvcKgk1wZcmhj/DEQASEFlKXvHxV/3mw0FbvM/8jisO5jt5T++B+N+LGw
         +++yORV9zSBT//C5sXr26xinPkfT0ddDcIACG/3tRnNFgyFD5dre9g8sZ3ELJLP1uMZ2
         2jhPoefzv/mRdVDeCb/Q63/PSFfxKa31TAV4MZL/LX5h7T8jnnS4filWzRQhFh5rI8Ne
         76SOW9rTlquD+Vhs3jtNPyMtvhGuQomfIqfuL03BkIWwwfI21fU7VPk6qDNVuWpr0HQV
         XRXeNEemH+hLQDaa+FayF6nrIsU2Tt4YwgDSNIzWO+mdF9s40o5bDyCByETuWAcNvEk1
         t6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686482344; x=1689074344;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqt3Dl9KT3PE0L7+/YPJFqJ9BXGcPkPSX2+KIrhZ5ho=;
        b=jHnnF1YL7XwjcBOeMKpMWvyH4PJGScScYBo6auFALNJiTUbzDrE7TirEC3+LcP2sMo
         mopKd9s3E2DI9eFcnzv15ZmMxrFpIfRT6YPiWvGNGo7bLSLZospwVw221kgh86Zyrky5
         Rgi5Ox4nRtxow10tX6MQ+KNUxQ+HDtggXfU7jK1Fl7loZinj3gTrb21p4HdE67bnuJM7
         Qyl9Grnye1WMYYuCZ8pBDmDUhopv2yr/xA/UguAon4B5U185TOI3E/AGHhY62xEV3znB
         I8bLIhUEIsBH8DxU4tyuM+sGeuM5bd+j98rAXh5SgeMiWTc4LsumBqk/oAz59w0FQVsH
         Y0iQ==
X-Gm-Message-State: AC+VfDzqunMOa2955bz3uCcJlVbqSAGhUiYuRqDqC2EQEdmw5BGycfqq
        uyIWFpnVlcu23OV7ZfP+XcX9LMPeNwU=
X-Google-Smtp-Source: ACHHUZ734Sx1racFAcTtjoaAVM7PKvfcAE2PDSUEWwlBtTUhRS6XXwLabKQZmTdYBL6o3GygxQ0K8Q==
X-Received: by 2002:a17:902:7583:b0:1b3:b84b:9006 with SMTP id j3-20020a170902758300b001b3b84b9006mr2104256pll.7.1686482343639;
        Sun, 11 Jun 2023 04:19:03 -0700 (PDT)
Received: from dw-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001b00fd3cf5bsm6167573pls.297.2023.06.11.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 04:19:03 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:48:56 +0530
Message-Id: <87cz22i6vz.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/122: fix nodesize option in mfks.btrfs
In-Reply-To: <a45349aa46e0b185acf59f3914e78dce245bb696.1685705269.git.anand.jain@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Anand Jain <anand.jain@oracle.com> writes:

> btrf/122 is failing on a system with 64k page size:
>
>      QA output created by 122
>     +ERROR: illegal nodesize 16384 (smaller than 65536)
>     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/vdb2, missing codepage or helper program, or other error.
>     +mount /dev/vdb2 /mnt/scratch failed
>     +(see /xfstests-dev/results//btrfs/122.full for details)
>
> Mkfs.btrfs sets the default node size to 16K when the sector size is less
> than 16K, and it matches the sector size when it's greater than 16K.
> So, there's no need to explicitly set it.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Remove the redundant explicit nodesize option from mkfs.btrfs.
>     Changed: Title from "btrfs/122: adjust nodesize to match pagesize"
>
>
>  tests/btrfs/122 | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Thanks for fixing this. I have tested this on Power with 64k pagesize and x86
with 4k pagesize.

Please feel free to add -
Tested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh
