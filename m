Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBB73FF0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jun 2023 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjF0O4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jun 2023 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjF0Ozy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jun 2023 10:55:54 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3792D49
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jun 2023 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rctbiYsONwK8B4iwZuFwJBYoyHYcwkLRJvMOq4u7QSA=; b=s1ZvWDt6XLbr+ctqDAA3b+R14X
        gow+pxBl1y2K0OKTJaC1QgRkwC2AlUyCrlFSrmG8er/RSg7l3plfUsY6S+DctJmiceHXnfpXaEAJU
        C5OGOA+BPbz9Q0JsNu3rYk+94ghlX6fu16yVjPhBvKBZ5++PxEshMYrsg47Ne0DVK2/cdHNQSj6aM
        w+FPLu5AiK+aSa27NCB55amckxzgTHnrANhodplPVxyUtdFQ/zgTUFnPdF/me8C+fj5RuuncQrfA4
        Zw2qT22MRl4iDpGIdhP7yozuGbPvL+B5AAtay4LazrqgCCkFEsJW7Pi1GzITRSF8WzwjfaVdg6/q4
        dl1BbTIw==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qEA62-004bwI-F5; Tue, 27 Jun 2023 16:55:10 +0200
Message-ID: <91368428-6950-3236-6bb2-13673527aaa9@igalia.com>
Date:   Tue, 27 Jun 2023 11:55:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v2 0/9] btrfs: metadata_uuid refactors part1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Anand, thanks for the patches, nice clean-ups / improvements!

I'm working in the same-fsid mounting [0] (guess you even commented
there already) and that touches a lot the metadata_uuid/fsid related code.

So I'd like to ask if you maybe have a "part 2" ready or almost ready,
in order I can merge it and work on top of that, avoiding too much
conflicts later.

Thanks in advance!


Guilherme


[0]
https://lore.kernel.org/linux-btrfs/20230504170708.787361-1-gpiccoli@igalia.com/
