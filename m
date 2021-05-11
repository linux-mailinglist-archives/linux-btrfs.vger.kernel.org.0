Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F237ADD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 20:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhEKSJM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 14:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhEKSJM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 14:09:12 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F44C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 11:08:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id l129so19666979qke.8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 May 2021 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=vEBaMPDbeGK4OReyng8vq7HduxblR5MyAmLuOVT9xzo=;
        b=ROqP2dNKST6ZsJWYsJO4kWzEG3A8g2vLm/zcRXxzvgJD/6r6TjzJTEgt/2fIQ8v82o
         j0e9AxWt06o+hSOtygfHu10oJO8U5XvHMOK5ngIsPJSDYlI86sb63H88lOykEhFaCOra
         XWsLP9mE7hlV5kAgeZfM2gmmaONWO8sGbLspBKUEUhmKCijdSHDrAmP/KxMTtuIvsLZv
         QhmTWuVOvcKkDMMN8fI0vPXJ+Hv0dLSeuRVeSny2JBQ9tiUX8d7Pp0FbXbBRSFZqWN2f
         IN4Tv58zWXFoXh8pu5ToSW9UymBbMsXUtcP6UOjJCe3RQkCP9dy7yL/vz9+8bwXfszSd
         sTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=vEBaMPDbeGK4OReyng8vq7HduxblR5MyAmLuOVT9xzo=;
        b=SJ7fKr7dLhga61LHyMINj2PuKp1vGWo4U3BI0tiYg6xmdvU+YPDrd7lAMtnZbO7UHk
         N7u8XmvAr65Rt1FcoLX4M2THEQF4Tp9cZtAyqg6YWXq3F70k3V3SdnhfcmKq/eZ0qSaW
         UXCSJZQIYJ84QMN8PdfWZzKRm93bNSwWlhGo47dzXNx7+gqorgpYRadsH4H2slFgxJ1R
         SQfciGliwRaivhE02W35M6YbNCmdEVgm3LJoG4AyS1hrcYUVR3V5qUoFPfLWiIVmpu9d
         LqfH+vm9moFgRhMSwIhWasbPibvCIKFufm3biuIKeCgKxOAkK1j6v7wKb0S/J5qqOfaE
         Uznw==
X-Gm-Message-State: AOAM531OmUFGkks/cyn1JiBOAyMqi9+fxHjLNyQDxNP6vqq3zs0K7i5Y
        DFMhIx26lmwfmXH/JiaBO+u5Jg==
X-Google-Smtp-Source: ABdhPJw8+f+vDt3/jF1Jgp4OM91/UZy4L+G5x7Ty3j+ZNDoSlNd+FCiKApQ49TWz1AK+pyxH1XZpWA==
X-Received: by 2002:a05:620a:208a:: with SMTP id e10mr24928250qka.112.1620756483669;
        Tue, 11 May 2021 11:08:03 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 66sm14852176qkh.54.2021.05.11.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:08:03 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
Subject: next-20210511 - btrfs build failure on arm
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 11 May 2021 14:08:02 -0400
Message-ID: <564681.1620756482@turing-police>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

An arm allmodconfig build died with:

ERROR: modpost: "__aeabi_uldivmod" [fs/btrfs/btrfs.ko] undefined!

Some digging around with nm and looking at the assembler points at:

@ /usr/src/linux-next/fs/btrfs/extent_io.c:2676:        const int nr_bits = (end + 1 - start) / fs_info->sectorsize_bits;
        adds    r1, r1, #1      @, tmp552, 
        adc     r0, r0, #0      @, tmp551, 
        ldr     r3, [r5, #1576] @ tmp2, _47->sectorsize_bits
        bl      __aeabi_uldivmod                @       

Introduced by this commit:

commit 6512659d8f13015dccfb38a13c6d117d22572019
Author: Qu Wenruo <wqu@suse.com>
Date:   Mon May 3 10:08:55 2021 +0800

    btrfs: submit read time repair only for each corrupted sector

Looks like that line could use something from include/linux/math.h
