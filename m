Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660F585410
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jul 2022 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiG2RAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jul 2022 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238186AbiG2RAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jul 2022 13:00:37 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6C52447
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Jul 2022 10:00:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F82C5C016A;
        Fri, 29 Jul 2022 13:00:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 29 Jul 2022 13:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659114035; x=1659200435; bh=cxS4OLe5ZC
        RUcL08Jd+XF15fs6DJYAM4e3/VOAjAL04=; b=VWT794n9/di/phLYYuCTR2WZSQ
        U2PP+OtZXbkda5ItsgNISy1lz8qFbzr5zk/3wTm3WMXWOiiAEVKAM5GLRDMzfLkl
        4XnRBJIL13vhDuOu4fQqXaTVFz01TW77NLEWHumNRpFJlAVr2KlUcZ8xTxBlgyin
        seXPwYMWPUBtjH3vWfMA0XCOpxOlV85ecB/2UiIUyH3ODgRcICig/AWMjg06+mi/
        1hMZhdLO4YG8jiLQV17O5OSkiTjeeQlpw9sZXZUqAw3ErR4jUdev4+tywbTUfP8k
        F1ycNx2DkbMaaHLVb9kfoVKQFjzlUDy3WYcH7eFujAuIn/A0L12TzskzB4hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659114035; x=1659200435; bh=cxS4OLe5ZCRUcL08Jd+XF15fs6DJ
        YAM4e3/VOAjAL04=; b=n8ImsRMwh/FtYQur2/lEk3F+R4JolEaqs0aZ7SdcIwHz
        gGs/v/vgSFtWUPrsGXqwLn/ziAlh3Y0uOmFrzGbkMdoAcpNAff1yaT3T7Zz/Rx77
        07GXf8Ksa5CDjR/e9ALQweBwnCrfBbv7g2Uru02uCB/NN+7/RBeGpMzVvt5SPlYY
        PiZykqLCUMb/t2hHX1fW6eminWXq1PlMG9w3Mqbac3zN1Y3OeNHkQr3gIhDlQkuy
        VVwC3Ah5h7VeXz3AHjaDxkL2Tt/qYMSxqGg8Um8gU8UxKg6lYhSuN6nyF2qRfPJZ
        KDK5G4w9fyBoP4CugDkZzWh7Sjr4x5rru643yYsfmg==
X-ME-Sender: <xms:MhLkYobNGDEm-4WBMK_vWsMgLk-X8D_Qxbl8ZPWZViGDggUnHd8M2Q>
    <xme:MhLkYjYCtCOMfX5tp6bRNlpRpWgxB3HRh0KXd6x21pd51FAoBbODks60fDDo_qqGa
    81lRk183YDzwGiJs3I>
X-ME-Received: <xmr:MhLkYi_NycL1QInIJHsfIUe_wS7eOd07OEFZwXJ0AzN51pdS3sa7U0RJvKZ4e8UtAwhJJJKQfDS5DyMhKGaW9vKp4SZ2tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:MhLkYioDfGyJwr_hVsAFqrFt3Vltai_IvD3LUsM0Xem921o-mN8r1A>
    <xmx:MhLkYjrZoC7Bs84jWaWivVGPynA2g2QBU42SC1IwCgsKQDrAdAyw8w>
    <xmx:MhLkYgQ2BWwv4RYdFFHLi0nEJjDXmCx6SjLjUMd3Lfb5yDyBfGrYtQ>
    <xmx:MxLkYiTBi3PIwLF9JlYSbXgpfX1ALuEYeUTfZcd32MvMX20GArGrUw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 13:00:34 -0400 (EDT)
Date:   Fri, 29 Jul 2022 10:00:32 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] Selectable checksum implementation
Message-ID: <YuQSMGYOl8iWqbqn@zen>
References: <cover.1659106597.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659106597.git.dsterba@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 29, 2022 at 04:59:06PM +0200, David Sterba wrote:
> Add a possibility to load accelerated checksum implementation after a
> filesystem has been mounted. Detailed description in patch 3.

What branch is this based on? I am having trouble applying it to
misc-next or for-next.

> 
> David Sterba (4):
>   btrfs: prepare more slots for checksum shash
>   btrfs: assign checksum shash slots on init
>   btrfs: add checksum implementation selection after mount
>   btrfs: sysfs: print all loaded csums implementations
> 
>  fs/btrfs/check-integrity.c |   4 +-
>  fs/btrfs/compression.c     |   4 +-
>  fs/btrfs/ctree.h           |  13 ++++-
>  fs/btrfs/disk-io.c         |  30 +++++++----
>  fs/btrfs/file-item.c       |   4 +-
>  fs/btrfs/inode.c           |   4 +-
>  fs/btrfs/scrub.c           |  12 ++---
>  fs/btrfs/super.c           |   2 -
>  fs/btrfs/sysfs.c           | 101 +++++++++++++++++++++++++++++++++++--
>  9 files changed, 144 insertions(+), 30 deletions(-)
> 
> -- 
> 2.36.1
> 
