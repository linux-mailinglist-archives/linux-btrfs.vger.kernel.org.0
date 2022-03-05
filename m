Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D763E4CE68E
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiCETW2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 5 Mar 2022 14:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiCETW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 14:22:27 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94937BC8
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 11:21:36 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1162F861667
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 19:21:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4CF64861595
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 19:21:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1646508095; a=rsa-sha256;
        cv=none;
        b=pETiXAzkC7LHbCC0AnIuLPTn8HZmELRP+yN/7GqF9TwNJIao6MIs+643tlt2K7fkGqaNOM
        4qzmvqMljfE9NpoFk+zluV0hWc98Pdt8E3el2mqo55Jwf/WBA2NSt/A11glFFmMfYuDf2w
        W7epk5mhTvY8q3/EvajgU0jrKBtC9WeqUWl4QMHoVpUDZRHEOd60UIfm/qADxhqVg3/3gO
        cm3lSSjqaGZr7UBRayLXthIoeYgaW75a9QVqDbZSZVOoiK7rGXzQwotdlzvy9Vmd6vZTx+
        g9aXqmvGER/o3yv9QoND6ofWb0KtbG3kEcjf8+6h+kTdc/1sRw1tatYzd7LhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1646508095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5DrFZXQYtBLDEH2h5LD/pOJPbj9aGBnbqoiFM3PU4RQ=;
        b=xNWn8IjhgK7Jy+7yTNxSx+9bhnQKM4/mHY2+M1aMtsscg5cwrX4bVptU2V05PSSXEkn3VS
        puU3EHCOgfFcSGQBY3YF+iASts2aRk2dIOcroNODw1qi6dXnEFmBMc87eUaXajJxtm8i03
        TvSf7T9lxbr7KtEHsYFpQ3CiJTnO7wISFj/S+7ttW9mEI9eMs/dhd+Yzh58ZCy6ntbkLnn
        uqE3HUuckAGIsp94UrqGKrP2Deov/Xw1pgqdv7NYEK7vhDnTarIqweYew80n0lDGK6p/ar
        /52Vvk7PlEhWQil5OqMKUkS80153FrV/qf1bEaL58L7fsvMQPtQg0ak/CJ7seA==
ARC-Authentication-Results: i=1;
        rspamd-c9cb649d9-4q8r9;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.31.123 (trex/6.5.3);
        Sat, 05 Mar 2022 19:21:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abaft-Eyes: 253be74d63011229_1646508095796_2543740886
X-MC-Loop-Signature: 1646508095796:3272448369
X-MC-Ingress-Time: 1646508095795
Received: from p57b04fe1.dip0.t-ipconnect.de ([87.176.79.225]:59386 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1nQZy6-0006az-Vv
        for linux-btrfs@vger.kernel.org; Sat, 05 Mar 2022 19:21:33 +0000
Message-ID: <c16169c5b971fe5dee1e50e07e2c7bb8d2bface4.camel@scientia.org>
Subject: status page status - dedupe
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     linux-btrfs@vger.kernel.org
Date:   Sat, 05 Mar 2022 20:21:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        HAS_X_OUTGOING_SPAM_STAT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

I just wondered about the status of the wiki status page?! ;-)

E.g. it says seeding would be stable, while right now there's an
ongoing thread on this list about it being broken again.


In especially, what's the status of out-of-band deduplication (i.e. run
manually by some program like duperemove or jdupes)?
Is it safe to be used?


My understanding was, that for out-of-band dedupe, the kernel performs
a full byte-by-byte comparison before actually deduplicating, right?

So it shouldn't matter so much which tool is used in the end and
whether that's stable or not?


Thanks,
Chris.
