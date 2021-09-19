Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47821410B93
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Sep 2021 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhISMdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Sep 2021 08:33:05 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:43704 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhISMdE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Sep 2021 08:33:04 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 906491E00485;
        Sun, 19 Sep 2021 15:31:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1632054698; bh=iF6Svq1BbarJs0op9PbQNv41Guu3rQRpvnC9LwbSsOc=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=A28vdvChzRcyuiEju7Ttfj1998XCPi13bQlybPr8SzwFeHbvT54ERZ72Bqxxvs9RW
         KjJYMWN5b/V4SN8wex1eLKSvmDvjr62Q9uv5XvkOfUCurl0NeQvLYqQ8zEuq5o3juG
         YwpxulmRWM8VNyZV72hnJj+8oQ9UXtXy//iVBjMk=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 8749B1E00482;
        Sun, 19 Sep 2021 15:31:38 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id yOikGp_f59MJ; Sun, 19 Sep 2021 15:31:38 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 42DC41E00452;
        Sun, 19 Sep 2021 15:31:38 +0300 (EEST)
Received: from nas (unknown [117.89.173.253])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 2383A1BE012E;
        Sun, 19 Sep 2021 15:31:36 +0300 (EEST)
References: <9809e10.87861547.17bfad90f99@tnonline.net>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Forza <forza@tnonline.net>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
Date:   Sun, 19 Sep 2021 20:19:55 +0800
In-reply-to: <9809e10.87861547.17bfad90f99@tnonline.net>
Message-ID: <v92wzqzf.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +dBm1NUOBkfEh1+gRGXWDBg2qClXXujm55TJ3W4ngBmOPC+CfkkPWBO2mWpqLw+1vCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 18 Sep 2021 at 23:38, Forza <forza@tnonline.net> wrote:

> Hello everyone,
>
> I'd like to revisit the topic I opened on Github(*) a year ago, 
> where I
> suggested that DUP metadata profile ought to be the default 
> choice when doing
> mkfs.btrfs on single devices.
>
> Today we have much better write endurance on flash based media 
> so the added
> writes should not matter in the grand scheme of things. Another 
> factor is disk
> encryption where mkfs.btrfs cannot differentiate a plain SSD 
> from a
> luks/dm-crypt device. Encryption effectively removes the 
> possibility for the SSD
> to dedupe the metadata blocks.
>
> Ultimately, I think it is better to favour defaults that gives 
> most users better
> fault tolerance, rather than using SINGLE mode for everyone 
> because of the
> chance that some have deduplicating hardware (which would 
> potentially negate the
> benefit of DUP metadata).
>
> One remark against DUP has been that both metadata copies would 
> end up in the
> same erase block. However, I think that full erase block 
> failures are in
> minority of the possible failure modes, at least from what I've 
> seen on the
> mailing list and at #btrfs. It is more common to have single 
> block errors, and
> for those we are protected with DUP metadata.
>
> Zygo made a very good in-depth explanation about several 
> different failure modes in the Github issue.
>
> I would like voice my wish to change the defaults to DUP 
> metadata on all single devices and I hope that the developers 
> now can find consensus to make this change.
>

I'd vote for the idea. It may change some users' scripts doing
mkfs.btrfs but may save others' critical data.

And hope guys running filesystem benchmarks regularly notice the 
change
rather than saying 'Btrfs became slower' :)

--
Su
> * https://github.com/kdave/btrfs-progs/issues/319
>
> Thanks.
>
> ~ Forza
