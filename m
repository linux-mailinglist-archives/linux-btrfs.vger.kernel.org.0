Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8727210E4DF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 04:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfLBDaW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Dec 2019 22:30:22 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:43590 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfLBDaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Dec 2019 22:30:21 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 796615FDAD;
        Mon,  2 Dec 2019 03:30:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id 5HsfQeMI8I0Q; Mon,  2 Dec 2019 03:30:18 +0000 (UTC)
Received: from heisenberg.scientia.net (p3E9C206A.dip0.t-ipconnect.de [62.156.32.106])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Mon,  2 Dec 2019 03:30:18 +0000 (UTC)
Message-ID: <5cea01b65a3cfe773300f69d5847cdc457ab49d1.camel@scientia.net>
Subject: Re: kernel trace, (nearly) every time on send/receive
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Anand Jain <anand.jain@oracle.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 02 Dec 2019 04:30:17 +0100
In-Reply-To: <768283ac-99c5-0fd1-2acb-e504cbb1f3fd@oracle.com>
References: <21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net>
         <768283ac-99c5-0fd1-2acb-e504cbb1f3fd@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Anand.

Thanks for looking into this.

On Mon, 2019-12-02 at 10:58 +0800, Anand Jain wrote:
> Looks like ORPHAN_CLEANUP_DONE is not set on the root.
> 
>          WARN_ON(send_root->orphan_cleanup_state !=
> ORPHAN_CLEANUP_DONE);
> 
> ORPHAN_CLEANUP_DONE is set unless it is a readonly FS, which I doubt
> is,
> (can be checked using btrfs inspect duper-super <dev>) because you
> are
> creating the snapshot for the send.

I should perhaps add, that there are two btrfs filesystems involved
here:
The first is basically the master, having several snapshots including
all + one newer which is missing from the second (which is basically a
backup of the master).

So it's about:
/master# btrfs send -p already-on-copy newer-snapshot | btrfs receive /copy/snapshots/ ; 

In fact /master is mounted ro only here, whereas /copy is of course
mounted rw.
Since nothing should be changed on /master I assumed it would be ok to
have it mounted ro.


>  btrfs check --readonly might tell
> us more about the issue.

I cannot do this right now since I'll be on some diving vacation for ~2
weeks,... but since --readonly is the standard behaviour (i.e. same
without --readonly) I'm pretty sure that a fsck (which I always do
after each snapshot to the /copy) brought now visible errors.


Does the whole thing imply any corruption to any of the two
filesystems... or is it just a "cosmetic" issue?


Cheers,
Chris

