Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8CF601B49
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJQVav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJQVat (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 17:30:49 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBD37C31C
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 14:30:48 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1370acb6588so14755988fac.9
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VdRc97JpBohoqF6/o/tl+OhgR/OgymDvdNyqLFO538k=;
        b=RFhgON0DbmQz76y+3UpSYw8O6qTRaT1vOdEiw4TSAzDgqWmyDWLtaCLwwQim4+RxX0
         NTkgce1empp6vhMV4BG1Hdx1IalwBgWqqJ7zw2Ja5vwXT1yRh3jJTPvdWnupZRc3tvVl
         3djdlFWhe2pVEpWkV4s8nvHDou3t1AcnlpuzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdRc97JpBohoqF6/o/tl+OhgR/OgymDvdNyqLFO538k=;
        b=nged60K0YynzkUbGd60qkvGrC7Z3wBW+B3O7oz+AOBF94q4AXwZrzp4hqnDbwvi+Xh
         fsXjU4YcpPHnx0gc6SAPjw/m78HVs+oMm7zrehCpyR710f6+6HOSJTxo/P3Gs2KjOTKt
         jBVhmyCtQVUvr01hpcivWlQcustM/JxS6xuAgq+5aO2PLFv6QtB6Mxun4Cz0jQp3Du1C
         6oB++11ntTGvlcPFHdcLaaopY7BTDu7Ym/JyJxyGegVyHEztkf7HdXu/aFhL53RVBVvq
         F2G5ekpFKYYeXUtoIyDQWx3dNZtUzdngyWQt96S/SNW5rI5yZhJoWhOUlVeuwwuoU89m
         Hqkw==
X-Gm-Message-State: ACrzQf3qtOClCZS/IravOqyDkv53JaAzcXQBANuCsd3ttHfbDjozlgT1
        5v+q+mKEAGg+UR8kX7BOkmVZlZFL04q65bH+i4MX/g==
X-Google-Smtp-Source: AMsMyM5Rx7CPp1xUKFsnViNQyXO5p9JfPXNoFeIlFy8L99TZi6fHTCqPIjyQ0/ZY8jO9CmAYf7M2+jmKw0/TAAZ4Pb4=
X-Received: by 2002:a05:6870:4250:b0:132:b47f:c92c with SMTP id
 v16-20020a056870425000b00132b47fc92cmr7030414oac.64.1666042247887; Mon, 17
 Oct 2022 14:30:47 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Oct 2022 14:30:16 -0700
MIME-Version: 1.0
Sender: Simon Glass <sjg@chromium.org>
From:   Simon Glass <sjg@chromium.org>
In-Reply-To: <20221011154720.550320-6-sjg@chromium.org>
References: <20221011154720.550320-6-sjg@chromium.org> <20221011154720.550320-1-sjg@chromium.org>
Date:   Mon, 17 Oct 2022 14:30:16 -0700
X-Google-Sender-Auth: YDmZ0DYlnH3phHPTUNfx_h2Vvxo
Message-ID: <CAPnjgZ2MV72B6LFgij8KrEtg_Fs4jQG0r+KY7EPyd9w61A4GGw@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] fs: Quieten down the filesystems more
To:     Simon Glass <sjg@chromium.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Philippe Reynes <philippe.reynes@softathome.com>,
        Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>,
        linux-btrfs@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When looking for a filesystem on a partition we should do so quietly. At
present if the filesystem is very small (e.g. 512 bytes) we get a host of
messages.

Update these to only show when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part_efi.c       | 15 +++++++--------
 fs/btrfs/disk-io.c    |  7 ++++---
 fs/ext4/ext4_common.c |  2 +-
 fs/fs_internal.c      |  3 +--
 4 files changed, 13 insertions(+), 14 deletions(-)

Applied to u-boot-dm, thanks!
