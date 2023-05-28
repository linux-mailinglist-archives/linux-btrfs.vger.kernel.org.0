Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D8713C11
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 May 2023 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE1TBf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 May 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjE1TBd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 May 2023 15:01:33 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 May 2023 12:01:30 PDT
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0990
        for <linux-btrfs@vger.kernel.org>; Sun, 28 May 2023 12:01:30 -0700 (PDT)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 63c1dcd3;
        Sun, 28 May 2023 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=default;
         bh=Dv0EIOxCj/61kKGuli36zFhskS4=; b=ZhRcsGtqs2O/2lcFC3YiZxHIM4dz
        IijHm8P2dGcrMRhUolouO64/O2Kl3kRw1KYd13TBN45dXT9eZY9BSoxWlPA/Ceim
        pshfttvYsd1EQW3avoUPCNdBGS4bmHZjAOgIv0H4RZnuN79EKRyrJiV3GsnDSF2m
        vY+ic5xmkjf2RSY=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
        default; b=UU1YbulU8hxfvHMtCCXJcXj55OTeeaMHLUw6NH4ccHh8cHgHjEc9X
        gnI5om1wsJ+OgHm7TnL5Rpb6U635Do2AK3KTmfY0gkapMXuN9WfuPZAUkxG2snXI
        1DaHrywXH0zq1EPmqhPY7V2Npf9z7zijI9cvVrXU1WU8S05nkfZFkA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1685300087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYEIZwllYlqTFLOEWvChNWNHs2h9arIHOagb/lQIcQQ=;
        b=mcnPJkBnVmCrvLRQW3q1B1HMVzGp7jTprUWuh+CgFKB7FILCpXL60ERku3tV8UsEtN37Ze
        FS6F2INKuPmCwlxdG/ij5znpnNpgBa2jnDm8XwW8/gJZMQ0Li80kacfIvWY5zK66J3xdyb
        LemL7GCWKMw+c2KI7KVGT9ARfwZe1X4=
Received: from [192.168.0.2] (host-79-50-10-35.retail.telecomitalia.it [79.50.10.35])
        by ziongate (OpenSMTPD) with ESMTPSA id 11459e3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 28 May 2023 18:54:47 +0000 (UTC)
Message-ID: <b70ae154-c846-72ef-4d98-9a70a9dd13c2@kernel-space.org>
Date:   Sun, 28 May 2023 20:54:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 4/8] m68k: use asm-generic/unaligned.h
To:     Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
        linux-btrfs@vger.kernel.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Huan Wang <alison.wang@nxp.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Wolfgang Denk <wd@denx.de>, Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Marek Behun <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
References: <20230522122238.4191762-1-jens.wiklander@linaro.org>
 <20230522122238.4191762-5-jens.wiklander@linaro.org>
Content-Language: en-US
From:   Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20230522122238.4191762-5-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 22/05/23 2:22 PM, Jens Wiklander wrote:
> M68k essentially duplicates the content of asm-generic/unaligned.h, with
> an exception for non-Coldfire configurations. Coldfire configurations
> are apparently able to do unaligned accesses. But in an attempt to clean
> up and handle unaligned accesses in the same way we ignore that and use
> the common asm-generic/unaligned.h directly instead.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>   arch/m68k/include/asm/unaligned.h | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/unaligned.h b/arch/m68k/include/asm/unaligned.h
> index 328aa0c316c9..7fb482abc383 100644
> --- a/arch/m68k/include/asm/unaligned.h
> +++ b/arch/m68k/include/asm/unaligned.h
> @@ -1,15 +1,2 @@
> -#ifndef _ASM_M68K_UNALIGNED_H
> -#define _ASM_M68K_UNALIGNED_H
> -
> -#ifdef CONFIG_COLDFIRE
> -#include <linux/unaligned/be_byteshift.h>
> -#else
> -#include <linux/unaligned/access_ok.h>
> -#endif
> -
> -#include <linux/unaligned/generic.h>
> -
> -#define get_unaligned	__get_unaligned_be
> -#define put_unaligned	__put_unaligned_be
> -
> -#endif /* _ASM_M68K_UNALIGNED_H */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm-generic/unaligned.h>

sorry if a bit late,
i tested this on coldfire mcf54415, no issues, so ok for me.


Acked-by: Angelo Dureghello <angelo@kernel-space.org>


Regards,
angelo

