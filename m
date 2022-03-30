Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968734ECE65
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 23:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiC3VGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiC3VGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 17:06:32 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12567662
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 14:04:46 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 46C2280B18;
        Wed, 30 Mar 2022 17:04:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648674286; bh=DP2cTNUilYYTaCALmf7YWxOfGCPttZPaCqm7BsJ9SIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=u0N68HrXykVY8JXAq9BYZnRnh9GO6UZO975iPWW58oS8TMB+Z0upBOc5TeDOaMG/C
         zIncylJoS5sCWhRoAVUKEpJyZlKj83D/0z3AuVKRYQiWzfIabU1k0DAjmUefx3+q6g
         qNKzIpQffcGxRivEWyk2t+jGFb1VAZyrUcYdEgXKC/x5om2dYa8eTJEIbDOxSRgtID
         ply8v7UGQVUQYiqJr2dBXqf4cu461nrwWr8Q4XxRwa3MY0w4GN3cz2fm1ohjr6NiGG
         5OXOT4Dcdx5dW8ZYXAB1sXeBXy03Jqj8EV9OSISJiHnC+3arPntPqUAhO67SQmJfKc
         CdKP/WH4rzJgQ==
Message-ID: <f156cd23-cea5-1805-6425-4efc380d3515@dorminy.me>
Date:   Wed, 30 Mar 2022 17:04:45 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v14 5/7] btrfs: send: allocate send buffer with
 alloc_page() and vmap() for v2
Content-Language: en-US
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1647537027.git.osandov@fb.com>
 <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
 <fb73fe9a-21a4-0744-2a61-bfd3602a0f20@dorminy.me>
 <YkR/QuBrKPYTwIFt@relinquished.localdomain>
 <598151ee-7a14-0c54-34d6-4591bc19fb73@dorminy.me>
 <YkSPsV0l0JV1Lx1f@relinquished.localdomain>
 <9b168d90-e0e7-459b-36e1-ea5cbe23c8ea@dorminy.me>
 <YkTAn44i6Se++wOT@relinquished.localdomain>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <YkTAn44i6Se++wOT@relinquished.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,DOS_RCVD_IP_TWICE_B,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Yeah, vmalloc()+vmalloc_to_page() is going to be more or less equivalent
> to the vmap thing I'm doing here, but a lot cleaner. Replacing this
> patch with the below patch seems to work:
Looks great to me - thanks!
