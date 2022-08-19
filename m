Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDA25991A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 02:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbiHSAQj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 18 Aug 2022 20:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHSAQi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 20:16:38 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE9BBA65
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 17:16:36 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 2DA9B1226A8;
        Fri, 19 Aug 2022 00:16:36 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1240A122698;
        Fri, 19 Aug 2022 00:16:34 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660868195; a=rsa-sha256;
        cv=none;
        b=F/tgCTZphvxTHxCbVQlVitf1Ny26P7ainj0+3Q+UTwdmAERa2JHCj85JgFaOzlPV1EXWB9
        29VNw+qTjHVcugZP14V8qCGXItLm2FnHpfZ4g/+JrhHjA9pOU12wZPMEOAaZgwOCVK7AHV
        hoeLVGzjlCp8ifZFLMLiQcvByWTeXu5W0B29CzAT3JYdpUTt8uef71vAuKv7W5oI9A0T5+
        Qx8VwLw+UBIWfFenFRCl6WS2t7CcZg0b5/SQElR5oTjzLwFFPTBs3RjTLK2Y43eo9iNv7T
        6AXkGRaeoGtD4+d0UdN/o8jZ57tN6sXDbYwgXLAnsBfjjZsp9d/+U6Ma64l9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660868195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aL9zmd8VC5S5PZh3OhJ3ojjHbm6UUrSmrPNMA5txEz8=;
        b=pi1uE7NsBoE8dJo9CiIVq0Hq5lQZ6oUlMczlGTS6gRfq6MeciA0Uqbw03tUQl6quPz/NbU
        LLNaU+eyPYjFWbbUZuD8uoR6ZsG4CDViajdk1lXZF7R9LiSxLV8BWHs/1AWLUFTMJLrNEN
        C6sKYHQWvCFkkIC5y9DyJ41oXBf9hMp8GxGgHVvCw916fT0DkaSAhz3In9X5MeRUfFtC1W
        j8LxZ97Hc79+yT054jhBHxb0ddlMuafhzh3dpqo8GmsmjvuqimlVZrH+OXZVFWWUvcyYy8
        n2kUVr3AaLGq6fQw7FUoIXEH6euk6kPzfESIMYKLgNvioqRaa49szCyASiFRvA==
ARC-Authentication-Results: i=1;
        rspamd-79945fd77c-qf2m6;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Lyrical-Eight: 6c4a5c483b678cb4_1660868195897_4065343456
X-MC-Loop-Signature: 1660868195897:1752898746
X-MC-Ingress-Time: 1660868195897
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.124.238.95 (trex/6.7.1);
        Fri, 19 Aug 2022 00:16:35 +0000
Received: from p54b6dab3.dip0.t-ipconnect.de ([84.182.218.179]:37330 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <calestyo@scientia.org>)
        id 1oOpgd-00067d-Hp;
        Fri, 19 Aug 2022 00:16:33 +0000
Message-ID: <467e49af8348d085e21079e8969bedbe379b3145.camel@scientia.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linux BTRFS <linux-btrfs@vger.kernel.org>
Date:   Fri, 19 Aug 2022 02:16:28 +0200
In-Reply-To: <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
         <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
         <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
         <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
         <Yv2A+Du6J7BWWWih@relinquished.localdomain>
         <b5d37d4d059e220313341d2804cbf1daf2956563.camel@scientia.org>
         <Yv2IIwNQBb3ivK7D@relinquished.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Omar.


I'd have some more questions, which I hope help others and myself to
better asses the impact of this issue:


On Wed, 2022-08-17 at 17:30 -0700, Omar Sandoval wrote:
> > 
> but metadata deletions also count, so basically any modification
> results in a deletion. We haven't seen this in practice, but I
> couldn't
> find anything that would make it impossible.
> 
> In place modifications of files also result in COW and deletion of
> the
> old data, so that also technically counts.


1) I thought the issue happens primarily with space-cache-v2, and there
only when extents are deleted, which is when e.g. deleting (or because
of CoW: modifying) regular files.

I assume also when doing balance or scrub (when the scrub causes a
repair)?


But now you wrote "metadata deletions also count"? Wouldn't that mean
that any other tree (csum, etc.) of the fs could be affected?

So can corruptions happen when moving/renaming files, writing any
metadata (either btrfs internal trees or also things like file
permissions bits, XATTRs, etc.) or creating snapshots or subvolumes (or
moving files therein)?


I may also happen with v1 (or no-space-cache), but only when that needs
to be regenerated (i.e. when one sees that cheksum error messages on
the v1 space cache), but less likely (because it already requires the
v1 cache to get corrupted somehow?




2) The silent data corruption itself happens by some range being sill
used by some extent... AND also added back to the free space cache.
So next time that range from the free space cache is assigned and
written to the precious data would be lost.

Or are there other ways that issue could strike?

Or is it just a corruption of the free space cache, and the actual data
in the extents is fine?




3) In your commit, you described a number of symptoms that were seen
when the issue occurred.
AFAIU, some of the cases were silent (data corruption), right?

Is the whole issue super rare (like back the corruption with
compression and holes only happened under some very awkward and rare
situations) for v2?

I just wonder a bit,... cause if you say it was introduced with 5.12,
and since 5.15 (IIRC) v2 is the default for btrfs-progs... why haven't
more people seen any corruptions?

Or is the silent corruption much less likely than the one giving EEXIST
- or vice versa?




4) The tool you're going to write - what will it be able to do?
[I guess it will do something check whether any extent ranges are
 allocated AND also in the free space cache (v1 or v2)?]

Will it just be able to tell whether one's current free space cache is
corrupted.
Or will it also be able to tell previously any actual data corruption
already happened (i.e. still used extents got reallocated and
overwritten)?




5) Are there ways for people to *definitely* rule out whether their
data OR any other part of the fs was corrupted?

Like I personally have SHA512 hashsums attached as XATTRS on all files
of some filesystems with just data.
So I can easily go over those and verify.

Would a scrub (csum verification) also tell any data corruption?
But I guess that would only tell it for extents... not if any other
metadata in btrfs could be affected, too?




6) What should people do to get back to a safe and sound state?
I mean if I'd now verify my hashsum XATTRS, even if they'd all be
valid, my kernel would be still unpatched.


But once the kernel is patched:

Will it not be necessary to somehow check the free space cache then?
Cause otherwise I could do my verification (and get an: all ok) but the
free space tree is still bogus and some time later my data gets
corrupted again - despite the fixed kernel.

Wouldn't it be better to simply re-create the cache then (that is:
after the kernel is patched BUT before doing the verification of data
with e.g. hash sums or scrub), using:
btrfs check --clear-space-cache v1|v2
?


When any other metadata could in principle have been affected by this
issue,... wouldn't it - for 100%-safety - be recommended to start with
creating a new filesystem (after having the fixed kernel) and recover
from backups?

(Right now this might be just quite some work... in 5 years or so
people might simply no longer have their old backups. So I better re-
create the fs now, than being sorry later.)




7) What are people advised to do until they receive a fixed kernel?

You said with nodiscard the race window is smaller. So HDDs should
already have this, but SSDs not (and people may want to set it).
What about btrfs e.g. on top of dm-crypt, which per default blocks
discard, would that count (even if not specifically set for btrfs)?

Should one switch from v2 to v1?




Thanks,
Chris.
