Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953655AE6CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 13:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiIFLoy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 6 Sep 2022 07:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiIFLow (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 07:44:52 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B421571A
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 04:44:49 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 044C68C0F6D;
        Tue,  6 Sep 2022 11:25:24 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id F13B58C0C8C;
        Tue,  6 Sep 2022 11:25:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1662463523; a=rsa-sha256;
        cv=none;
        b=XZGpK58k99dtbQE/8/M1HuiYad5hUKgHhuktN5BD7S2Bgq0Lv1VvHmF2Maphv3fgVVA+PE
        Il74v6uF0rjnyb8bQOv6W5NQoQPfR2PIbge5KzPpbs9tf7TDiZkDDnc9UgwhJP7NKPB4l7
        p1x1jE+Lmb5Pev3Al3wyR5jMrVDzyjElxeJpCH5/PHmQcRMcpLVBpiterCo1AzAKr+PISM
        lXnmOFWCdupjNMCVvaBYb8+O/ErVsaasM0lPo4wLY8/fdpF8XNj24eplaAue6J0jYOzgOc
        f+mHBRO528aWZrcj5AQgHuJjUfacf10t7XeFBfd3MYX7+fis7FdXHGz163P9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1662463523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mvhfwl4OIF7pP+25q9VsPO8xmtVUOMNj37jHZ6975lY=;
        b=kHk1z7qLQychPxzBjhyYKROBiCjCYJlr0hg3bURJdMVeJxz/S/+Fs84uYpTLUPxVDFJhkX
        jzGyfuD3xzgvn3JmaLl5LOe6nh7NL7V4LYUmJSggoyHQwyGTYbwD0WuHaaAfPa9UAtIZCX
        Aat1d3J0JSbCIb+fggYj5XJCspEGn8aTW2Jg4M8gaIgC4gD7Yc5GxAsCMTKjH7w93xlSTn
        d0iUwm4CuWa3Drm04yP+6Ak1dSZN7GZQefFC4HMEtw1rxEDkqf3q8U+F+pDvkLlxy2DQJY
        hSItLEuRStF7w3u0mJfMSXC5cmo/pybAYC4+aFjGgIfvDqXDdCyZifOQfWf2Iw==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-v6xcr;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Zesty-Bitter: 05b5494a3b5a1155_1662463523604_3013101212
X-MC-Loop-Signature: 1662463523604:517458807
X-MC-Ingress-Time: 1662463523604
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.147.32 (trex/6.7.1);
        Tue, 06 Sep 2022 11:25:23 +0000
Received: from p3e9c2169.dip0.t-ipconnect.de ([62.156.33.105]:56346 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oVWhg-0000Hr-Nm;
        Tue, 06 Sep 2022 11:25:21 +0000
Message-ID: <2f18f498ab2abeceeec08a4168ee87f85794bfbc.camel@scientia.org>
Subject: Re: [PATCH] btrfs: check for overlapping extent items in tree
 checker
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 06 Sep 2022 13:25:15 +0200
In-Reply-To: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
References: <0a9f7ca2717c0378acf77d71a0d1b680d4d5d6b9.1659551313.git.josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.45.3-2 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

On Wed, 2022-08-03 at 14:28 -0400, Josef Bacik wrote:
> We're seeing a weird problem in production where we have overlapping
> extent items in the extent tree.  It's unclear where these are coming
> from, and in debugging we realized there's no check in the tree
> checker
> for this sort of problem.  Add a check to the tree-checker to make
> sure
> that the extents do not overlap each other.

Is there a way to check whether one was affected by this? I mean pro-
actively on already existing data? scrubbing once one has a kernel with
a patch?


And I assume this could cause data corruption?


Cheers,
Chris.
