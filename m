Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BFD742E6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jun 2023 22:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjF2Uc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jun 2023 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjF2Ucx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jun 2023 16:32:53 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A05E30F7
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jun 2023 13:32:52 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id C233583418;
        Thu, 29 Jun 2023 16:32:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1688070772; bh=ykDT7RTbLJwX1bq1GzyQydKOwWs1CjjZON0D439+DxM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=dFq5EjB/UtLM/V1JvOnk6JRHQXJWoGB7nu6qmBucqzQnYb1xZhUb8zUUi4POHDyGR
         IN43imhrOh05DMWMC5jgIqcJwmi+dk9AvOFFuLviYISXGKotS4nrpaEk0OSIJy96iK
         DS4k9hscGXv2R0yLMvSg43cl/cVJ/Dka7NIMMQjgW2JIsDS/Af6AioDmzcA1mdWAx2
         ioItT51ZrwzDX3C8HY57jUmA+AP2qsCgS1Vm0KvR787w1Nm1IUN3ZSgsCzd2zeJmHD
         NRlnfLoLkBpQ13qYrpy5R4keSjD/Z7Qbffg/Je291aXO6aYxnRzeqZA0LGu7GfTlXQ
         id+YVSv8J6XwQ==
Message-ID: <a0b87199-1289-90b5-33db-1d99b5e40f06@dorminy.me>
Date:   Thu, 29 Jun 2023 16:32:50 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 1/8] progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org, kernel-team@meta.com
References: <cover.1688068150.git.sweettea-kernel@dorminy.me>
 <5fbf8d6827c91bae6a31f03c1f017eada9226c90.1688068150.git.sweettea-kernel@dorminy.me>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <5fbf8d6827c91bae6a31f03c1f017eada9226c90.1688068150.git.sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Apparently I sent half the change twice under slightly different titles; 
the ones that start with 'progs' aren't supposed to exist, sorry about 
that :/
