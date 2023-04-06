Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63046DA113
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Apr 2023 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbjDFTYR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Apr 2023 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbjDFTYP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Apr 2023 15:24:15 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5FF6E94;
        Thu,  6 Apr 2023 12:24:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 988DA3417BC;
        Thu,  6 Apr 2023 19:24:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a274.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CD5C7341734;
        Thu,  6 Apr 2023 19:24:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680809052; a=rsa-sha256;
        cv=none;
        b=4bAuXMtwlyJM7rJDZxZJTpRfpPCZigeYlh0DRPb2nqdQzF+e6Fw0cIgBnLGKQBjT9/sKrR
        mhIqu9GQH9tsK542uGcg9HnJDg2QlPcJyHZ3Oy9JOCo4oXNci8zXXMrabP/N0GSp7UeRM9
        MGEBTfDc3H3ucy1Mc4RjaZ5C8oefQ8sVZlMkcVT8GuvG9qk++orOrlwUsRIMWSRRLcr1hf
        UK35H3YZIKqkEW77bDOnWWZTidtD9DsyaEq31q1T70BED9mE7uRWmMKX8I0kdTL2qfCcql
        7fX0c43+gDjn6sKdUvw4sRGE6rbRpWjV9eJwWvRUDvU/zdDrTQsmreSEITIQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680809052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=AagTPFDtfnWdwHKXEVPtAYYw7Z/AW74aMhlpOMGUgY0=;
        b=HEV8yuKKIxjLkgRDKRx4jbtyHdF7vN3Q5GQ69q/VdF2atIFMqNj7XeTuV/g5f4J4bKEb0q
        /ZZcS9LThg4D9OH1gAaX6UDnyi9yDJa/AbNxG4w65UKNdC+trBIdwwf+X5ir5wRTp59sky
        6MuZZ39Armh62EDxdy0/+yBPEP4fgfyTbS0ipV8fLhnP1mEreAQi8rXjE35vstL1vYFgwX
        laKCKS0kUtBaaxmBKDWpYxmU3MrM2+TwnuHDhTL1n1WQT6ZxZA3OskV1X1j9UZVRv/OOfz
        k85bP7wcmo/0oHmfaoNSuIb7J2hdQXRUTcLRJ1d3LvTIGE2zdlsrmJY9lfBOzA==
ARC-Authentication-Results: i=1;
        rspamd-786cb55f77-wq54t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=hussein@unixcat.org
X-Sender-Id: dreamhost|x-authsender|hussein@unixcat.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|hussein@unixcat.org
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Lettuce: 5bd3ace71e4d7d4f_1680809053169_372366452
X-MC-Loop-Signature: 1680809053169:2718878554
X-MC-Ingress-Time: 1680809053169
Received: from pdx1-sub0-mail-a274.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.101.8.119 (trex/6.7.2);
        Thu, 06 Apr 2023 19:24:13 +0000
Received: from localhost (unknown [175.144.191.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hussein@unixcat.org)
        by pdx1-sub0-mail-a274.dreamhost.com (Postfix) with ESMTPSA id 4Psrz00XvMz5F;
        Thu,  6 Apr 2023 12:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unixcat.org;
        s=dreamhost; t=1680809052;
        bh=AagTPFDtfnWdwHKXEVPtAYYw7Z/AW74aMhlpOMGUgY0=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=xxGATLlPsblhFDUZheuVRMhWcIng28Q0wPWIhmTg8QGgiSdkE7MQCrCzXvQDMV08C
         2apO/shHiPl6smPtu7aHqSjvdyujIgK5ErsGRUGvC3cQAfds5ADC1GymV6166o+Zoh
         kLgGDo3LeUjUmQ1fDTIxKXsfRt+LdvdMTla2ZRQ4=
From:   Nur Hussein <hussein@unixcat.org>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nur Hussein <hussein@unixcat.org>
Subject: [PATCH] btrfs: Avoid potential integer overflow when left-shifting 32-bit int
Date:   Fri,  7 Apr 2023 03:24:06 +0800
Message-Id: <20230406192406.2300379-1-hussein@unixcat.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In scrub_stripe(), the 32-bit signed value returned by the
nr_data_stripes(map) function call should be cast to u64
before being shifted left by BTRFS_STRIPE_LEN_SHIFT (16),
as a cautionary measure to avoid potential overflows. We
then assign it to a u64 value anyway, so a cast before a
shift seems prudent.

Signed-off-by: Nur Hussein <hussein@unixcat.org>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ccb4f58ae307..4de1665fcd52 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2187,7 +2187,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 
 	/* Initialize @offset in case we need to go to out: label */
 	get_raid56_logic_offset(physical, stripe_index, map, &offset, NULL);
-	increment = nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
+	increment = (u64)nr_data_stripes(map) << BTRFS_STRIPE_LEN_SHIFT;
 
 	/*
 	 * Due to the rotation, for RAID56 it's better to iterate each stripe
-- 
2.34.1

