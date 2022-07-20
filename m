Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F957B8BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jul 2022 16:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbiGTOrP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jul 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiGTOrO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jul 2022 10:47:14 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C984C61F
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jul 2022 07:47:12 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 770E4808ED;
        Wed, 20 Jul 2022 10:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658328432; bh=zIQpPZLqi0uOvk1bBdmIDFoiG7UTrKkASh6d5p3LjZo=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=A9kyOOMqNiKVmuv73b3w5Fv2tIC7X1qWE6YV1cOkm8H3FwVUbMWPzCVf583fLc/Jd
         pcg7TWk5wE1f6kBACfZ2mspUUO0UkvbVXTv+7e805lIViwZr3ORW55Mb8uCc64EjJB
         2huXCq7g67SvvBvXOuj86kfOZnqkuTK8VgKm9VKzRMAP2K/KJ0JLCme/wy+oAuKV4T
         EsWfYH/1Io/JgysM3sib/9B9e8C8wcG0qfUK/Ioocy9GxzqqgAqbrPiXTAKm0j+86k
         nRQ161CKay6sPQzuF4cd6cgSRTD/jxxULRyAVOfy2aP3T6CCCQJmeYWXYldCyYRmIL
         kgg51AhA85kwg==
Message-ID: <90d978b2-1053-f0ee-aa56-453568f88391@dorminy.me>
Date:   Wed, 20 Jul 2022 10:47:10 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] btrfs: Annotate wait events with lockdep
Content-Language: en-US
To:     Ioannis Angelakopoulos <iangelak@fb.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20220719040954.3964407-1-iangelak@fb.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <20220719040954.3964407-1-iangelak@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/19/22 00:09, Ioannis Angelakopoulos wrote:
> Hello,
> 
> With this patch series we annotate wait events in btrfs with lockdep to
> catch deadlocks involving these wait events.
> 
> Recently the btrfs developers fixed a non trivial deadlock involving
> wait events
> https://lore.kernel.org/linux-btrfs/20220614131413.GJ20633@twin.jikos.cz/
> 
> Currently lockdep is unable to catch these deadlocks since it does not
> support wait events by default.
> 
> With our lockdep annotations we train lockdep to track these wait events
> and catch more potential deadlocks.
> 
> Specifically, we annotate the below wait events in fs/btrfs/transaction.c
> and in fs/btrfs/ordered-data.c:
> 
>    1) The num_writers wait event
>    2) The num_extwriters wait event
>    3) The transaction states wait events
>    4) The pending_ordered wait event
>    5) The ordered extents wait event
> 
> Changes from v1:
>    1) Added 2 labels in the cleanup code of btrfs_commit_transaction() in
>    fs/btrfs/transaction.c so that btrfs_lockdep_release() is not called
>    multiple times during the error paths.
>    2) Added lockdep annotations for the btrfs transaction states wait
>    events.
>    3) Added a lockdep annotation for the pending_ordered wait event.
>    4) Added a lockdep annotation for the ordered extents wait event.
> 
Overall this seems really nice and I learned a bit about lockdep 
reviewing it; thank you! I have only organization and change description 
comments, I think.

I don't know much about lockdep and may be systematically confused here, 
but here's a change organization suggestion, and I have a few 
change-specific comments too in re specific changes.

I think it would be a little more elegant to have as change 1 the 
introduction of the various btrfs_lockdep_* macros and a detailed 
explanation of how the notional locks work. (I really like the word 
notional.) All the boilerplate currently in each change description 
could come into this one change description, maybe something like this:

"We use a read/write lockdep map to annotate 'lock'-type counters or 
events in the code. A common pattern among all the notional locks is 
that threads start or join a planned action, representing getting a 
non-exclusive lock on that action. Later, threads move on, relying on 
other threads to perform the planned action, until only one thread 
remains which then performs the action; notionally this is equivalent to 
releasing the lock and then attempting to get an exclusive lock. These 
lock actions are represented in code by the new btrfs_lockdep_*() 
functions [etc etc etc]" (I may be basing this too heavily on the first 
one...)

Then each subsequent change could be described as e.g. "Annotate the 
notional transaction writers lock, representing the threads involved in 
a particular transaction."

I personally don't know the code well enough to really grasp what each 
annotation represents from the current individual change description... 
is it possible to flesh out the changes with a little bit more about 
what each one is?
