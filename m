Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00010EA77
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 14:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLBNEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 08:04:45 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:43660 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfLBNEp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 08:04:45 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id E76A45FE34;
        Mon,  2 Dec 2019 13:04:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id wbemJyyGXqBq; Mon,  2 Dec 2019 13:04:41 +0000 (UTC)
Received: from heisenberg.scientia.net (p3E9C206A.dip0.t-ipconnect.de [62.156.32.106])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Mon,  2 Dec 2019 13:04:41 +0000 (UTC)
Message-ID: <8105bdea348b85cdd1441712b1911e193b8e9fb2.camel@scientia.net>
Subject: Re: kernel trace, (nearly) every time on send/receive
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Anand Jain <anand.jain@oracle.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 02 Dec 2019 14:04:41 +0100
In-Reply-To: <46777ed1-acb5-4f5e-e981-17d1f71fe815@oracle.com>
References: <21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net>
         <768283ac-99c5-0fd1-2acb-e504cbb1f3fd@oracle.com>
         <5cea01b65a3cfe773300f69d5847cdc457ab49d1.camel@scientia.net>
         <46777ed1-acb5-4f5e-e981-17d1f71fe815@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.


On Mon, 2019-12-02 at 12:37 +0800, Anand Jain wrote:
>   I am able to reproduce. Create send from the readonly mounted FS
>   and we log the warning as we couldn't clean the orphan flag. It's
>   false positive log. Will fix.

Great, thanks! :-)


>   One question though - why the FS is readonly mounted? Its ok if
> that's
>   part of your operations.

It's effectively just part of my opterations. The HDD is an mostly an
archival storage where I put photos/etc. on.
fstab entries are, that it's mounted per default ro (so I cannot
accidentally delete something or so), and this is why I do the
send/receive from an ro-mounted fs.

Cheers,
Chris.

