Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5481957EC54
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jul 2022 08:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiGWGb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jul 2022 02:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiGWGb2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jul 2022 02:31:28 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 23:31:26 PDT
Received: from mail.tol.fr (mail.tol.fr [82.66.50.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EBF422F0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Jul 2022 23:31:26 -0700 (PDT)
Message-ID: <4ade214c-db16-dd74-7118-8d0fa128ea52@couderc.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1658557368; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=pXf36MDiHfUHI3sYeVpK6hmUK4clJxfDqf6Aqmh9StE=;
        b=Sw2qAJME0C5dereo7g+iiY5t/u2os8idIoIl3LEES+Ttbz+TdL/2+8s9CStSCJk2hl4D8q
        jQaTK3jcfhjyQsNltVUHk3nEEqb6z63SfOlh19Ez46huCaJMOxW7Xzq32pq+KHw0y3z1x3
        WvnspZ9NJQ1LvHyfMh4RlErKM9EvGtUylX94qnumnL4dcju3xkHRBM5OC7zFyaseX1VvrY
        HVQ81GZQ7x5gwEcQX4r6DP35xPtlvCCLg3aIOtr/ASPQSK0e8bDgqalgLHfkCmIvrUZ00h
        XLfxs16IUn0q6Jm2dFNmY+g+0HQIYwJ1d4wz5ry9ppoGDznadqLHX/6t6RQozA==
Date:   Sat, 23 Jul 2022 08:22:48 +0200
MIME-Version: 1.0
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   Pierre Couderc <pierre@couderc.eu>
Subject: Best way to programmatically send/receive ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1658557368; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=pXf36MDiHfUHI3sYeVpK6hmUK4clJxfDqf6Aqmh9StE=;
        b=NYi7mPo7jlNHNFQjE3mzlPpMbhxWOFZa/2lEO95zcx7YwS6K0oj94cx7RoWCTwTmKJENPE
        OJUB8uDe4/IGJlqtsPy2kcNWBS+hy9xGn6GEOtnI0G4jT+DOlO+jJdGWdPPSORj+PM3KBW
        CexJj/mzCe8E/XfJo0N0fDhM/mK2nF6REUhh+GNmA1M3nUHkqFZw4s6v/fEk+Fh7cYm8ta
        zRioYYjIhRpwgURleTT1HqYxzQJO/2RkcV+fsFxooKusWIzyMcDL46nZ4rxWeSNIhTGxxM
        0bRtzwZw/T99nLsKaMTw5QiXP38tJFIuvv+9uBA8PJj5KKHT+7p7blgdThYVSA==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1658557368; a=rsa-sha256; cv=none;
        b=Boi4AcWbzd3oSsu58ffh0dZ+CQIuY49/Y8cibSk99EQPaIzkwSCXa7HueCsYqXSeWFFeWptX6mpOpxCmZbEJParx9XAaIzgEILw45sWBELRlGejnTRGvp6Dsd5NvK/p2peMLjapJUxRok4f0XNnGxeSt5DB4ZDlkqOCGOaCxgivV5kdPwmEFz09ovzx2niJtF3H+PdYNxK9KzE5jRIadZ0lEHdX+N2PYekxgvYO7+fqxTsKtNhFhdE/QZX5m8zOgqFfJ9hC5LoKL6C/pM8yE+28PUFqr2S9OZOOrPO6FLTxNf7/qrGGnIWVrlbdAvZsUoOenh2vj+8D/RYyLQAAFrw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am doing a utility to manage backup of btrfs subvolumes.

I need to save a subvolume using btrfs send/receive


I use libbtrfsutils, which is very fine, but I have found no entry about 
send/receive in it.

What is the best  way to do that in C/C++...?

Thanks

PC

