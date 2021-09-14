Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0F140B061
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhINOS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 10:18:58 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:59892 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhINOS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 10:18:57 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 5D58E1E006C0;
        Tue, 14 Sep 2021 17:17:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1631629059; bh=WEA0nHxHshSqxxdH3J7JdsAVovukVXzHVUvLba9UfRQ=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=cZ3TStfd0u+PUJZIdSv2/DtB57F5UjLySOc/dxAIOBcEZUCp2tHkM8wd8SAkSD6Ce
         lSYlZcGRkA7+r5P1DQ5JcX0Rq3FoOm/RrKl8FP+7LX8iXd2hEaj7w0xRw9yQcTZzwF
         cUEZcYrHS3cQ0t6YLYtOrXKBhDFsNXwLWBpshRq4=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 566B41E006B5;
        Tue, 14 Sep 2021 17:17:39 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id qeZaCkUmhLcA; Tue, 14 Sep 2021 17:17:39 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 1D4391E006BB;
        Tue, 14 Sep 2021 17:17:39 +0300 (EEST)
Received: from nas (unknown [117.89.173.253])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 7E6431BE00A6;
        Tue, 14 Sep 2021 17:17:36 +0300 (EEST)
References: <20210914105335.28760-1-l@damenly.su>
 <20210914131253.GA9286@twin.jikos.cz>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_node_key static inline
Date:   Tue, 14 Sep 2021 22:08:36 +0800
In-reply-to: <20210914131253.GA9286@twin.jikos.cz>
Message-ID: <mtof1bt2.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWe8dgs1s1k3Ua26u/vDsBBYnXzkOSeaf08OThKynnAFPnHLwCM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 14 Sep 2021 at 15:12, David Sterba <dsterba@suse.cz> wrote:

> On Tue, Sep 14, 2021 at 06:53:35PM +0800, Su Yue wrote:
>> It looks strange that btrfs_node_key is in struct-funcs.c.
>> So move it to ctree.h and make it static inline.
>
> "looks strange" is not a sufficient reason. Inlining a function 
> means
> that the body will be expanded at each call site, bloating the 
> binary
> code. Have you measured the impact of that?
>
Fair enough.

Before:
   text    data     bss     dec     hex filename
1202418  123105   19384 1344907  14858b fs/btrfs/btrfs.ko
After:
   text    data     bss     dec     hex filename
1202620  123105   19384 1345109  148655 fs/btrfs/btrfs.ko

+202

> There's some performance cost of an non-inline function due to 
> the call
> overhead but it does not make sense to inline a function that's 
> called
> rarely and not in a tight loop. If you grep for the function 
> you'd see
> that it's called eg. once per function or in a loop that's not
> performance critical on first sight (eg. in reada_for_search).

Right, the patch won't impact performance obviously at the cost of
+202 binary size. So I'd drop the patch.

Sorry for the noise.

--
Su
