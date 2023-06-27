Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574574017B
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjF0Qk1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjF0Qk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 12:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DDEF4;
        Tue, 27 Jun 2023 09:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59458611EB;
        Tue, 27 Jun 2023 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D8F0C433C9;
        Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687884023;
        bh=Mddr9IEnVSSEtvey/EPFRhLi4YnxlTkalZzmHZ6bmJ8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XGRGiORnH0FmaQ+kclMjYIsE8aiZt7Gs4g5WBNw+zT0ASSus8daZkKZirfbcgaoBv
         HsuO0nskJhLaiZxylU7zlINMijGNLl9q7WEg/ms3Lh/IrCmjj2LVp6pXCXh1uqP4W3
         kOcx2VCa4pIOSzcMTF35giAc72J/A42BnFN7K4h/MvLUE7JXaOanngW1cFFib+5J4v
         8N2ABirViOcrN32FYcrvP15sAv/TezaSVGJHU9rgp1d1sCUFbyUbMRRUsWjqDMoEYN
         HlJlhL0V9YgQDqvmqEWLdtvBli6Q5b70JaJ8QNh8cP8DiB/xBCXlUB+GXHpoI+1ee3
         oj4CRUwtvenNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B046C64458;
        Tue, 27 Jun 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/24] use vmalloc_array and vcalloc
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168788402349.21860.17350888958370358926.git-patchwork-notify@kernel.org>
Date:   Tue, 27 Jun 2023 16:40:23 +0000
References: <20230627144339.144478-1-Julia.Lawall@inria.fr>
In-Reply-To: <20230627144339.144478-1-Julia.Lawall@inria.fr>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-hyperv@vger.kernel.org, kernel-janitors@vger.kernel.org,
        keescook@chromium.org, christophe.jaillet@wanadoo.fr,
        kuba@kernel.org, kasan-dev@googlegroups.com, andreyknvl@gmail.com,
        dvyukov@google.com, iommu@lists.linux.dev,
        linux-tegra@vger.kernel.org, robin.murphy@arm.com,
        vdumpa@nvidia.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com, linux-scsi@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        jstultz@google.com, Brian.Starkey@arm.com, labbott@redhat.com,
        lmark@codeaurora.org, benjamin.gaignard@collabora.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, shailend@google.com,
        linux-rdma@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-btrfs@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, linux-sgx@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 16:43:15 +0200 you wrote:
> The functions vmalloc_array and vcalloc were introduced in
> 
> commit a8749a35c399 ("mm: vmalloc: introduce array allocation functions")
> 
> but are not used much yet.  This series introduces uses of
> these functions, to protect against multiplication overflows.
> 
> [...]

Here is the summary with links:
  - [v2,02/24] octeon_ep: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/32d462a5c3e5
  - [v2,04/24] gve: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/a13de901e8d5
  - [v2,09/24] pds_core: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/906a76cc7645
  - [v2,11/24] ionic: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/f712c8297e0a
  - [v2,18/24] net: enetc: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/fa87c54693ae
  - [v2,22/24] net: mana: use vmalloc_array and vcalloc
    https://git.kernel.org/netdev/net-next/c/e9c74f8b8a31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


