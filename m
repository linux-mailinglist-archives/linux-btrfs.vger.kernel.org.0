Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E724EC611
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbiC3OAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245501AbiC3OAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:00:08 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6288BF72
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 06:58:21 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 6EDA880903;
        Wed, 30 Mar 2022 09:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1648648700; bh=4m9a37aDCe9Y7S3EVDriTwvt0ImeV5dVGMbVS3zqKDA=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ehADTtaShiCe0ufUdUhFIQwLWyYWcnAAW+MLGiDcbyQPuH5G4OHBaPAf9lgm4bXSv
         XyFoxc6nlKXgY80R8zpFrTONu3OT/sW9FCVRRivxAi+h/9SptEVpnHWUlDALKbrJx1
         rgsCCS+dSZVQIGEyJnnsyAVhcCJJ7PtqTPeRB8jQf1mKMHxIJA9EEqYRTwcfa0fDDS
         rRcJpVHDUw6zpd6BTWYBPqyxn+m1c25q7uzCxYfTdrldL7b6dGBVpkc8LgkdQddj7Z
         8IabZrdl0rKeJfGkdB09j1vJPZ/L71GY3mUdauaSUOSbS+r3jK7jTORgIRc6qOOMsU
         IVIdIduG/3hYw==
Message-ID: <0012253a-6fad-5196-c1b6-8bd07f417a89@dorminy.me>
Date:   Wed, 30 Mar 2022 09:58:19 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Remove balance v1 ioctl
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220330091407.1319454-1-nborisov@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220330091407.1319454-1-nborisov@suse.com>
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


On 3/30/22 05:14, Nikolay Borisov wrote:
> It was slated for removal in 5.18. So here are the patches which remove the
> relevant bits (patch 1 and 2). As a result of this simplification code can be
> juggled around a bit so further simplify btrfs_ioctl_balance(patch 3).
> 
> 
> 
> Nikolay Borisov (3):
>    btrfs: remove balance v1 ioctl
>    btrfs: remove checks for arg argument in btrfs_ioctl_balance
>    btrfs: simplify codeflow in btrfs_ioctl_balance
> 
>   fs/btrfs/ioctl.c | 69 ++++++++++++++++++------------------------------
>   1 file changed, 25 insertions(+), 44 deletions(-)
> 
> --
> 2.25.1

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
