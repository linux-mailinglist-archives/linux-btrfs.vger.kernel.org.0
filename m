Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40760C1A0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJYCWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Oct 2022 22:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJYCWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Oct 2022 22:22:47 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54FABA905
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Oct 2022 19:22:45 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4MxG1Z2qjMz9sT6
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Oct 2022 04:22:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1666664562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kSRN5W7JUIh/LpbzWYHIjam8JLoVJQQAiMqvEAFLHUY=;
        b=hpwoTFbQLN4b+XEhH1upMoqJgwGfVLgSvmTrELh6gyhI3G99bwX81F8hJJXjEXc2zOkQCw
        fSd1T6XNnMxLH+6PezuggZ2xEHL9ZqJnDL3xfil9elaGlY38+6+Ok4nT8/K2VZwAf/N+sz
        Oz1GkVm41d1jMLNxZcSHnpUxrUxZdu1gRSW9lJhKZS9/hZkDRytYTQPc23IUQFuJhLF54d
        /0xfM6kMspAW8C6edCE0c3hrXH6fmyAFD0mw/rfyEwZYCKhovHKTfw4JpernNLON5JcTgE
        UXdzI0ruhRzyNwdA1pQGFZYVv5lU+pfSJcPlRFaBgBC661zsN5BGOxhwciqfXg==
Message-ID: <20cbb83b-5fa0-d092-cd0c-fa38890ac09f@mailbox.org>
Date:   Tue, 25 Oct 2022 06:22:35 +0400
MIME-Version: 1.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
From:   Cabia Rangris <cab404@mailbox.org>
Subject: [ADVICE] dd if=ubuntu.iso of=/dev/btrfs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ada4fa96304609bb946
X-MBO-RS-META: 8wxsx6cgd3npxpbn4y9d717mt8tm4ter
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Good time of day!

I have  a problem recovering from writing a full ubuntu iso onto by 
backup btrfs disk (3.4 gigs or so).

`btrfs recover` cannot recover from this, as the root tree is completely 
overwritten.

I’ve patched progs to show detected nodes, however I am far from being 
an expert in btrfs repo or making my clangd start actually working — so 
I didn't even get to see any filenames, but I've managed to print 
detected nodes.

I can recover what's left via photorec, and already have done so, 
however a lot of data is unrecoverable without it's folder structure.

That's why I ended up here :)

- Is there any way recover some parts of the tree metadata from this 
sort of accident?
- Is there a person who's ready to answer some dumb questions (for 
money?) of a non-system programmer so I can write a parser?
- Is there maybe an unfinished Kaitai struct format for btrfs lying 
around where I couldn't find it?

-- <3; cab
