Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D98609677
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJWVTf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 23 Oct 2022 17:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJWVTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 17:19:33 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F682196
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 14:19:27 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1CA408C0BDC;
        Sun, 23 Oct 2022 21:19:27 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 389578C1AF5;
        Sun, 23 Oct 2022 21:19:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1666559966; a=rsa-sha256;
        cv=none;
        b=HMSM1mNuP7GnmjPLXrMAN+78rgNPRL/nQO/HAtElJMJQP8GcYPZ10PZBcAL6casuEo+MfG
        9IRHD95JeOmjJpPeQZd+bnW8VFYgS4gXCEkXzB3j43oW9eC7fkTE7L62GRW8fd8cKtFrXP
        9g8LLwnaIVIsDnnSESNmWskX+lhQN1rJN+t4dZ/9v3hXYmvmI7NRiyIXC7hig8TRMdH4kg
        m65Wp8hTwY3ieq1Z46G4kDugJWAt0iuXl/P7RoRpUdLZg3h7sLrwXaFw3jVba0Yms5JhTX
        l/bjBqGXe9tV0vYuvTI1XaoFjmfI7XxoB60LIcbg4GLH5Lh8QTPpdqFrbgn4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1666559966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aN9YdQKH4H+DPn8RJwEvFlWeZ963b9gPkXah2/1yc/M=;
        b=tFQlHQD0cNu8tXk7zYg17Upj3HWMhtX01bQA9Dz9YmcG1QynaxqwJNzkA39h6ZyArxsJ1G
        dGPmtHNg2PPlEYa45S0UeiV4JCf/r/SwQhVRs9vPzmWJe0zPr1yN5AmT7S+ZBNBnnfEPuE
        csZRSiLSARP6vXL8T1Shy6lFElA703AIKytycc6Or3F7LjcVO/YqUliQoMzql3oXTHJwmB
        yHxUphT98pmg+A7oxnXq4OYAhdyu99rgae67+28rMENDzy1UKmKeXRIWa0ZnJyxbntHU1X
        gsChJv1CMPKlSMNMBqyC87yQ1WVoPCup/6nI8hQnVoCFPxyRxTMme5c4mOoYiw==
ARC-Authentication-Results: i=1;
        rspamd-6955c7cd5b-8s48h;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stupid-Robust: 78f911e925a9d398_1666559966849_2514320503
X-MC-Loop-Signature: 1666559966849:677789934
X-MC-Ingress-Time: 1666559966849
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.120.183.105 (trex/6.7.1);
        Sun, 23 Oct 2022 21:19:26 +0000
Received: from ppp-88-217-43-50.dynamic.mnet-online.de ([88.217.43.50]:34988 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1omiNM-0001Ot-51;
        Sun, 23 Oct 2022 21:19:24 +0000
Message-ID: <fed9bf82ebef6fcf9c40c2803c9c1503fe505e99.camel@scientia.org>
Subject: Re: btrfs and hibernation to swap file on it?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Sun, 23 Oct 2022 23:19:18 +0200
In-Reply-To: <ed497bfa-1f82-6761-788e-a20ef3b91cab@gmail.com>
References: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
         <ed497bfa-1f82-6761-788e-a20ef3b91cab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Andrei.

Thanks for your replies and sorry for my late answer but first I had
been on some diving trip and then had a cold until few days ago.


On Wed, 2022-09-28 at 22:12 +0300, Andrei Borzenkov wrote:
> There are quite some restrictions for using swapfile on btrfs, in
> particular, it must be preallocated and btrfs will refuse relocation
> of
> extents in this file.

I assume it only does so (refuse relocation) while it's actually an
active swap area (how would it know otherwise that the file is a swap
file)?


> kernel supports swapfile with multiple extents.

Ah, I see.


So, with the btrfsprogs, is there a way to get the offset?

The whole interface with specifying an offset seems to be quite unhandy
anyway (would be better for users IMO, if one could specify a pathname
and the kernel would find out the offset by itself)... but having to
download/compile a "3rd party" tool makes it even more cumbersome.


Cheers,
Chris.
