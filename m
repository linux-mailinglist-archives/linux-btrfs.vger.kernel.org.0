Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABC7C19BA09
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 03:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgDBB4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 21:56:37 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:37040 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgDBB4h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 21:56:37 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id B0BDF6008B;
        Thu,  2 Apr 2020 01:56:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id I7N86pac2E0p; Thu,  2 Apr 2020 01:56:33 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Thu,  2 Apr 2020 01:56:33 +0000 (UTC)
Message-ID: <360ca434f26ced5eca6821294719c463a2dcd910.camel@scientia.net>
Subject: Re: Btrfs transid corruption
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Date:   Thu, 02 Apr 2020 03:56:32 +0200
In-Reply-To: <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net>
         <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
         <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net>
         <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Josef, et al.


First, many thanks for the quick help before. :-)


On Wed, 2020-04-01 at 16:40 -0400, Josef Bacik wrote:
> btrfs rescue zero-log /dev/whatever

This worked nicely and at the very first glance (though I haven't
diffed any of the data with backups nor did I run scrub, yet) it seems
to be mostly all there.


I have a number of questions though...


1) Could this be a bug?
Yes I know I had a freeze but, here's what happened.
- few days ago I've upgraded from 5.2 respectively 5.4 to 5.5.13
  the system ran already for one day without issues, "before" it
  suddenly froze, Magic-SysRq wasn't working and I had to power-off
- I then booted from a rescue USB stick with some kernel 5.4 and btrfs
  tools 5.4.1

- did a --mode=normal fsck of the fs, no errors !!

- then I did a --clear-space-cache v1
  Every now and then I see some free space warnings in the kernel log,
  and so I do clear the cache from time to time when I have the
  filesystem offline

- I didn't to another fsck directly afterwards unfortunately...
  if I had done (and saw errors already by then, we'd now know for sure
  there must be some bug)

- then I rebooted in the the normal system and there it failed to mount
  (i.e. the root fs)


So I mean I could understand that something would have gotten damaged
right after the freeze, but the fsck there seemed fine,...
Any ideas?




2) What's the tree log doing? Is it like kind of a journal? And
basically everything that was in it and not yet fully commited to the
fs is now lost?


3) Based on the generation (I assume 1453260 and 1452480 are generation
numbers?), can one tell how much data is lost, like in the sense of the
time span?
parent transid verify failed on 425230336 wanted 1453260 found 1452480

And can one tell what is pointed to by 425230336?


4) The open_ctree failed error one saw on the screenshot... was this
then just a follow up error from the failure of replaying the log?


5) Was some backup superblock used now and thus some further
data/metadata-lost?


And most importantly:


6) Can one expect now, that everything which is now there/seen is still
valid? Or could there be any file internal corruptions (respectively is
this likely or not)?

I mean this is what I'd more or less expect from a CoW fs... if it
crashes some data might be gone, but what's still there is 100% valid?


7) Am I advised to re-create the filesystem? Like could there be still
any hidden errors that fsck doesn't see and that sooner or later build
up and make it explode again?
Or is the whole thing just a minor issue and a well known/understood
clean up procedure from a previous freeze?

Setting it up again (with the recovery) would be just work (not that I
can access the data again)... so if it's advisable I'd rather go for
that.


8) Any other checks I could/should make, like scrub?



Thanks a lot,
Chris.

