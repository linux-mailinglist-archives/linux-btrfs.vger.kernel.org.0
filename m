Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4230B905
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 08:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBBH5H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 02:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBBH5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 02:57:05 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35185C061573
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Feb 2021 23:56:25 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l6qVD-0002sP-2J; Tue, 02 Feb 2021 07:53:35 +0000
Date:   Tue, 2 Feb 2021 07:53:34 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: is back and forth incremental send/receive supported/stable?
Message-ID: <20210202075334.GP4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <157ed91bb66820d1fef89eb05d00e65c25607938.camel@scientia.net>
 <20210129192058.GN4090@savella.carfax.org.uk>
 <956e08b1aed7805f7ee387cc4994702c02b61560.camel@scientia.net>
 <20210201104609.GO4090@savella.carfax.org.uk>
 <d73ee44738fc69df8aa3f9a5d3c04c5a88e2731a.camel@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d73ee44738fc69df8aa3f9a5d3c04c5a88e2731a.camel@scientia.net>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 01, 2021 at 11:51:06PM +0100, Christoph Anton Mitterer wrote:
> On Mon, 2021-02-01 at 10:46 +0000, Hugo Mills wrote:
> >    It'll fail *obviously*. I'm not sure how graceful it is. :)
> 
> Okay that doesn't sound like it was very trustworthy... :-/
> 
> Especially this from the manpage:
>        You must not specify clone sources unless you guarantee that these
>        snapshots are exactly in the same state on both sides—both for the
>        sender and the receiver.
> 
> I mean what should the user ever be able to guarantee... respectively
> what's meant with above?
> 
> If the tools or any option combination thereof would allow one to
> create corrupted send/received shapthots, then there's not much a user
> can do.
> If this sentence just means that the user mustn't have manually hacked
> some UUIDs or so... well then I guess that's anyway clear and the
> sentence is just confusing.

   It means that (a) the snapshots should exist, and (b) you shouldn't
use the tools to make any of them read-write, make modifications, and
make them read-only again. (and (c), as you say, don't modify the
UUIDs).

   Hugo.

> > but I guess it's not a priority for the devs
> 
> Since it seems to be a valuable feature with probably little chances to
> get it working in the foreseeable future, I've added it as a feature
> request to the long term records ;-)
> https://bugzilla.kernel.org/show_bug.cgi?id=211521
> 
> 
> 
> Cheers,
> Chris.
> 

-- 
Hugo Mills             |
hugo@... carfax.org.uk | __(_'>
http://carfax.org.uk/  | Squeak!
PGP: E2AB1DE4          |
