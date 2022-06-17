Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE754EE65
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 02:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiFQAV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 20:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379457AbiFQAVR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 20:21:17 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE5F63BD6
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 17:21:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q1-20020a056830018100b0060c2bfb668eso2102728ota.8
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 17:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=iKSZB+z5a5vfPav0XS+3MpGE1/C2EVyTEygLy0XRThU=;
        b=nhJEaV2snLFscmpURHmhFCLeq7HA1xaA1RMllYIBj3+ir/vEV5+U80ExxdGIP1dzf/
         +thMOI5+apbZncxlQeKVNaVQyOqj2G0Q89nO3cd3LnyVjoe8hPUMoB8P6SlJu8sKhkgT
         bFDTtBw8FlXEiMBNQuf4/KcUM6vMuk+z0pgpRrQT/77dZzyV7bkqDlly7Ho/ZmDW1vOe
         nmxOXe1Xr94SM9Q0O0wEsyYtKfQDtzCgAhP9k2XZ99wixzsW0YZZqp8rah6f8lpDgxg7
         G46k0PGxnaTC13ItoeCnGIZVFKPwcfWKdAhjlk7EP4Yv7deR/WTXU7muPF+kAll0KF7i
         39Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iKSZB+z5a5vfPav0XS+3MpGE1/C2EVyTEygLy0XRThU=;
        b=ajRnAfykonUo+f98RzlmnuLcPoc0YqLa/kvc2pWFiHMRz7iT6hPVzDvFTkAno+UFDf
         grrK5x2NVsxOYXkqUH5mVpHhI+URGnH/Oy1W9XPZBcXKoX7lCRYUZfXtUXLZLRp3M/In
         IvirIbYHN7DhPJ/bSo3pNxZk7YuE+VGDg7ShSiJZZ3dHAwpQ8cDbsxW+d1K2IkELzMOo
         cNhn0HVirPCBmJd+3je92UhLQ33hMHVmvegjYro2kyh30d2Q+W2PAbkWDSjWSNmhQUVm
         st5kYI+t5fBT2rbswV4rhsXjzGfNk92HMiSnMP49wGPudXIlwhM39uFc7MsgpiCJBxKg
         I3YQ==
X-Gm-Message-State: AJIora+HW0IyCoN6WbGhfVCIlOVVf6IOD3j4DKGMKdhTgb/rnplR9ZCb
        N3i9SVoN6McLaJfN/1tj99Qkzl79HMz0yG70+UBywt+Ahrw=
X-Google-Smtp-Source: AGRyM1vINELKCQKsuHHdGIpMetngrEVFVCqmEXEBktrlF5dFMKG7uDAA9uCMuNC5D6Ank8ssx1I85WXSXsuXerk/sqk=
X-Received: by 2002:a9d:684d:0:b0:60e:25e0:6fab with SMTP id
 c13-20020a9d684d000000b0060e25e06fabmr3028061oto.381.1655425269588; Thu, 16
 Jun 2022 17:21:09 -0700 (PDT)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Fri, 17 Jun 2022 02:20:33 +0200
Message-ID: <CAODFU0pspd_405HAxO+2MGneU8dbSVB9ZJFhqu9w2i86PczLYA@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a random update to previously reported btrfs fragmentation issues.

Defragmenting a 79 GiB file increased the number of bytes allocated to
the file in a btrfs filesystem from 118 GIB to 161 GiB:

linux 5.17.5
btrfs-progs 5.18.1

$ compsize file.sqlite
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       99%      117G         118G          78G
none       100%      116G         116G          77G
zstd        30%      471M         1.5G         1.2G

$ btrfs filesystem defragment -t 256K file.sqlite

$ compsize file.sqlite
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       99%      160G         161G          78G
none       100%      159G         159G          77G
zstd        28%      405M         1.3G         1.3G

$ dd if=file.sqlite of=file-1.sqlite bs=1M status=progress
84659167232 bytes (85 GB, 79 GiB) copied, 122.376 s, 692 MB/s

$ compsize file-1.sqlite
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       98%       77G          78G          78G
none       100%       77G          77G          77G
zstd        28%      361M         1.2G         1.2G
