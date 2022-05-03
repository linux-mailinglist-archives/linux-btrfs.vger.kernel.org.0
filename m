Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F14517FCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbiECIjC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 04:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiECIik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 04:38:40 -0400
Received: from ssl1.xaq.nl (ssl1.xaq.nl [45.83.234.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0E53334C
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 01:35:09 -0700 (PDT)
Received: from kakofonix.xaq.nl (kakofonix.utr.xaq.nl [192.168.64.105])
        by ssl1.xaq.nl (Postfix) with ESMTPSA id 4E24482F50
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 10:35:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucassen.org;
        s=202104; t=1651566907;
        bh=ljgDFb6vWZNsvKsxtH63WrY0A7ueypzGCj0Vk3xUQfM=;
        h=Date:From:To:Subject:In-Reply-To:References:Reply-To;
        b=Bk6S0I+B3NIO0v2oaejrzSWpzQgFwy6Y0xoR5WnEH9GnCtIvnfLagpY4mTTBlud87
         3hqeyxR3CSqWmJWprC5hGLr5E0+kjSkTN07LV5kdAOaShfwJvrENTXRMHCC6aVdTGp
         fub7K0oZMKDER5h4FpYsYyzijLkdhv3GFc3w3HrcduZ54YOcA5eAmuSh/bBN81fFyD
         u/gu0HkNCm3QiNEEpOKH17P2V4RFfM8aF8pFfFEI8vnPTTYQcU66b2KuGwHvvgbKIa
         TVSWkZ3Dzv/n5mmYc6d9xfm5Gix4g91EuCJBGoQEwfULCQ/BLL8nb7jc3zpoZx9Dvf
         0D2KUOwicLtBg==
Date:   Tue, 3 May 2022 10:35:06 +0200
From:   richard lucassen <mailinglists@lucassen.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot mount btrfs root partition
Message-Id: <20220503103506.fbf5ae803d00eaa0aa7025f2@lucassen.org>
In-Reply-To: <20220503102001.271842da4933a043ba106d92@lucassen.org>
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
Reply-To: linux-btrfs@vger.kernel.org
Organization: XAQ Systems
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 3 May 2022 10:20:01 +0200
richard lucassen <mailinglists@lucassen.org> wrote:

> lilo stanza:
> image=/boot/vmlinuz-5.10.113-apu1
>         label=btrfs
>         read-only
>         root=/dev/sdb6
>         append="console=ttyS0,115200n8"
> 
> BTRFS: device label data devid 1 transid 19 /dev/root scanned \
>   by swapper/0 (1)
> BTRFS info (device sda6): flagging fs with big metadata feature
> BTRFS info (device sda6): disk space caching is enabled
> BTRFS info (device sda6): has skinny extents
> BTRFS error (device sdb6): devid 1 uuid \
>  d201a08f-84ab-42e1-a411-83caadd1df2d is missing
> BTRFS error (device sdb6): failed to read the system array: -2 
> BTRFS error (device sdb6): open_ctree failed

[addendum]

I also have a /dev/sda6 lilo stanza, it is possible that the logs shown
come from using root=/dev/sda6

-- 
richard lucassen
https://contact.xaq.nl/
