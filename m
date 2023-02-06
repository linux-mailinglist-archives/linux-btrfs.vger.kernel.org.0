Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90C268B452
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 04:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBFDIE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 5 Feb 2023 22:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFDID (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 22:08:03 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA31B113E1
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 19:08:00 -0800 (PST)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F32191007FC;
        Mon,  6 Feb 2023 03:07:59 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id F40CC100A08;
        Mon,  6 Feb 2023 03:07:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1675652879; a=rsa-sha256;
        cv=none;
        b=97SAhh/SpcI3Bnb3xVOi5EpUj7eCJj3heDugtyWaLmyEwVyHz33Sg7tVcDMSExr6ePGvGv
        wzIK2MDrTamQilWk5JgCps5eMQfNqX4OKUwZ5v7IHIeMkUZu4QCogtI0DTiOg4ja/Ay/7+
        PGE4yvfABwAG9dIqT/QqXL+DtV9K1VANEsQaiOzQ6gMrZY4brLBekmUq3oNlC7UjRjK48M
        WAesM+OY0+/KrQmj3EY1dBbCP8DtatzjwXZi88qwBokLXHuYN+V+P8gHtuz10EsfKZSIdU
        FYZzw+DN5RzUgLZdobJOK8T4cm6qWDU1tK+zyGCS5PbvGV5voBxyHkHB12OSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1675652879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFgK0zFjZc4k3AcUc0zTR0hrOialKepEfpkMTel8dLQ=;
        b=sikwUN1pndr2TYzsOZrRkvkOHX/+u5znUOq5mprN3Dq98GcU2sP9m/tYAf71JZfezDe1iP
        rrriYc9TuM9OAos3oW5QW04EUOfHMQnppplqFrL6Vb8SA/3G+iH0siEdCJ6IOw2ewwaFQJ
        foXd3Zd43rSY2DlFE331+X7PVGWHvr1N/QA9BFV7wqPQQB7Kh95tjg3UarhzD1Z34B3Uv7
        Z5rQ5kWwhwawOQOB7B7dPRjQ+5aKOFKYfgXSSXhmYWfX59us5zXhSBvo9QUFOA2R4T+8zF
        jLbUJeajlq/uMQoAa4IaH80U1l56Epq4Mf23hhRE3hLbje6GuqB26OCb04BSqw==
ARC-Authentication-Results: i=1;
        rspamd-544f66f495-hbcgk;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Stretch-Cooing: 407d23561782dd28_1675652879623_3340428626
X-MC-Loop-Signature: 1675652879623:837335533
X-MC-Ingress-Time: 1675652879623
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.103.24.110 (trex/6.7.1);
        Mon, 06 Feb 2023 03:07:59 +0000
Received: from p54b6d414.dip0.t-ipconnect.de ([84.182.212.20]:41274 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1pOrrG-0004yx-7H;
        Mon, 06 Feb 2023 03:07:57 +0000
Message-ID: <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
Subject: Re: back&forth send/receiving?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Andrei Borzenkov <arvidjaar@gmail.com>, linux-btrfs@vger.kernel.org
Date:   Mon, 06 Feb 2023 04:07:52 +0100
In-Reply-To: <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
         <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3-1 
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

On Sat, 2023-02-04 at 09:10 +0300, Andrei Borzenkov wrote:
> > So one might have a setup, where a master is send/received to
> > multiple
> > copies of that like in:
> > 
> > master-+-> copy1
> >         |-> copy2
> >         \-> copy3
> > 
> > with those all being different storage mediums.
> > 
> 
> Then you do not have incremental replication and your question is
> moot. 
> Incremental btrfs send/recieve is possible only between the same pair
> of 
> filesystems.

I don't quite get why this shouldn't be incremental backups.

Whenever the files on master have changed and a new snapshot is created
on it, and the copies shall be synced with the current state of master,
the new snapshot from that is send|receive(d) to the copies, using
previous snapshots on them as -p parent.



> You seem to misunderstand how btrfs send/receive works. There is no 
> inherent relationship between copy1, copy2 etc nor between master and
> copy1, copy2, ... As mentioned as each copy1, copy2, ... is on
> separate 
> medium, each one is the complete copy of master and you can make new 
> complete copies as you need.

I rather believe that there was a misunderstanding of my setup
respectively what I do :-)


Cheers,
Chris.
