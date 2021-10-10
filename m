Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56042841E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhJJWx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Oct 2021 18:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJJWx4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 18:53:56 -0400
Received: from mail.fsf.org (mail.fsf.org [IPv6:2001:470:142::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EBAC061570
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Oct 2021 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fsf.org;
        s=mail-fsf-org; h=MIME-Version:In-reply-to:Date:Subject:To:From:References;
         bh=tPNXNiz1QikXyxtS2txfWsBeH4NiXZjr15oeyhJeaNY=; b=wlG6KWLgNVfwOikawcYpLIWfd
        6W+XQhifLsCjUaVmfI8yi8PgXtJuPJQ9shQSRzwieh1fBQbmYTH/3YD0z0PyRGGlN4ae1l3+pWzs0
        MNrSCkOcOF4ejopcbYV4pe6NOTlQE0Wg7j1hJjWVC19TcZ37EwihURisK0vr0B3XxHGTUk1fvh5/0
        pZWV8stsdQzFzYDYoCoI9peaiyuT0zcAwfwvw/ymtxWbd151ZOjaHTt1pPEQK98w++DXf7fqcTCCI
        +eAMX4jslOPlpu1pxUhm+RF08H/YcwUvjqX/Dycio2GWtTjvaGKwdtAV0UozktbUKQ8Tq30tUWVMH
        m7GKjxgSg==;
Received: from jumpgate.fsf.org ([74.94.156.211]:37210 helo=mail.iankelling.org)
        by mail.fsf.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <iank@fsf.org>)
        id 1mZhfd-0003o2-GP; Sun, 10 Oct 2021 18:51:53 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.93)
        (envelope-from <iank@fsf.org>)
        id 1mZhfc-00Gz0m-R5; Sun, 10 Oct 2021 18:51:52 -0400
References: <87ily8y9c8.fsf@fsf.org> <20211010180055.GR29026@hungrycats.org>
User-agent: mu4e 1.7.0; emacs 28.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: I got a write time tree block corruption detected
Date:   Sun, 10 Oct 2021 16:52:12 -0400
In-reply-to: <20211010180055.GR29026@hungrycats.org>
Message-ID: <87o87w8pdj.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Zygo Blaxell <ce3g8jdj@umail.furryterror.org> writes:

> This is a failure in log tree replay.  'btrfs rescue zero-log' should
> resolve it, though it will wipe out the last few seconds of writes to
> the filesystem.

That worked. The filesystem is mounted and working fine.

>
> I'd upgrade to at least a current LTS kernel (5.10).  5.8 is a year old
> and no longer maintained.  The bug you have found may be fixed already.

 Ok. Fyi, I upgraded to a 5.11 kernel & 5.14 btrfs-progs.

Thanks for the help and keep up the good work on btrfs!

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
