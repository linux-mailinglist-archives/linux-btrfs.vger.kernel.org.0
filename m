Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3592E67BB3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jan 2023 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjAYTxe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Jan 2023 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbjAYTxU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Jan 2023 14:53:20 -0500
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1775D11B
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Jan 2023 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=ZfCcAxrf+FbiaEFSsTojjEonfI1kLo6gQ8wkIwiC/bE=; b=j1RTdQ1o8yoBhdLsK27iZUwah
        HLKKDSLEsdQ0tpF81rhiFhXRT6iHtKwAo1epPNbUIHuQwn5RAb9BF2jTxDNGbxObA4wcVaecaqJtv
        aE20LCynzXdHDnJAqTzFC2TcpikhmA5UitD63+M0DJig9RXH2JyvJEf+M/fL4fHBLlbcyHHEtOLEm
        YYz5xVQ7fNzzBoGTWJ6aqylWehvrEmzkF5VL4Go4RXalkYVkxNulrsKobJru+aVMLfnl64A3uCJL8
        G6dKDNPxqeZo+pHI8zGWfBcWt2Rq/gZoL08igEfJgS39JCvwqXMWwX/NCiUElqkTA+8NwwNebW2Ts
        yUHAvwKhA==;
References: <87a6271kbg.fsf@fsf.org>
 <CAA7pwKOXSNpS0o9DhFCgPH1JV-wiLptZ77MiS1Wqam5O3-yfFg@mail.gmail.com>
User-agent: mu4e 1.9.0; emacs 29.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Patrik Lundquist <patrik.lundquist@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: balance stuck in loop on linux 6.1.7
Date:   Wed, 25 Jan 2023 14:48:13 -0500
In-reply-to: <CAA7pwKOXSNpS0o9DhFCgPH1JV-wiLptZ77MiS1Wqam5O3-yfFg@mail.gmail.com>
Message-ID: <87k01afl4o.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Patrik Lundquist <patrik.lundquist@gmail.com> writes:

> On Wed, 25 Jan 2023 at 02:48, Ian Kelling <iank@fsf.org> wrote:
>>
>> If I restart the balance, it will take about 2.8 days to get back to the
>> stuck 11% point. The balance is still running, but I'm going to cancel
>> it morning unless I hear from the list that there is some use to letting
>> it run since it is wearing out the mechanical drives.
>
> You can pause it instead of cancelling it.

I ran btrfs balance pause but the command is taking a very long time. My
ssh session died about half an hour after the command started for
unrelated reasons, but I see the command still running 5 hours after it
started. Is that normal?

Balance status says:

Balance on '/mnt/i' is running, pause requested
