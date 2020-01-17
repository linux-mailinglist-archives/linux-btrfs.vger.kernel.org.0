Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FA51411EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 20:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgAQTjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 14:39:09 -0500
Received: from zaphod.cobb.me.uk ([213.138.97.131]:42278 "EHLO
        zaphod.cobb.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQTjJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 14:39:09 -0500
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 0D09E9C3E7; Fri, 17 Jan 2020 19:39:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579289948;
        bh=suZ16vlGbGobLGMV4qlDQJ+Ewa62mhWcRucZUuRWz4s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=vZ0GMCSMhd6Jk7+lqDJBHj88qm5IWbQgEUEonoM+o245F8S2LQyvvv4SIDLyE0yXb
         a3JqNFouKbG89ZQ2CeyS4DJXlhFenIOff8jPVTUJY0lQ7C75jwVEI6G/PPEUF2Apzk
         hl3uunn4rVM1nWyq275O7XihFj8ch82OL5NqvYEbpX29iiLtQ464TeCo/TSrAnIvN+
         mhfNKNQy2zHQdlOBxTTfQTOvMbEqjf9goldtup/S7oZZMU58y4Mpl1UYpwONSrOA5h
         Ngax8cDRTSAWrwUAxXipqlHolmyrf0yDfw14AsAT/di4bRp/mtO946Dq8TN9k804VO
         Auuo9k6PdRRIA==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-0.8 required=12.0 tests=ALL_TRUSTED,DKIM_INVALID,
        DKIM_SIGNED,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 3D9E89B967;
        Fri, 17 Jan 2020 19:39:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1579289943;
        bh=suZ16vlGbGobLGMV4qlDQJ+Ewa62mhWcRucZUuRWz4s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=AF7U7z8g+fgYNGtF5OVl9kY5ePpz2xfcIl/QrmeVIRrN14KuRBel+EUXOYDbTnBSb
         gBkksLf4WYjKtY9RoxMLgOesK5VYxN/RKZJUs4aJ5rydmpJ0OomXq9V4rvRnHDJ5NI
         zfgfjAzH/R45XoTmE6+wo/qXNsvNVvAtftGteNHl9Y48TkSakDqR2OAg2FJi4G4ap8
         U58yeyg9aLRaRju5PE2vSU/zQ5bAL/pUJhAMU+ZbEaKxdoYTQ4CoQYKuK1ScEhiRHb
         OoEhaw/EEllgdpdj0BAvIBQkwghlCeJMAS24200MrxvRzBDw4FNdnhQp9cFbZqc+yH
         2I8ZzjODseNCA==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 0305DADA70;
        Fri, 17 Jan 2020 19:39:02 +0000 (GMT)
Subject: Re: Scrub resume regression
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <d0a97688-78be-08de-ca7d-bcb4c7fb397e@cobb.uk.net>
 <20200115125134.GN3929@twin.jikos.cz>
 <5aa23833-d1e2-fe6f-7c6e-f366d3eccbe3@applied-asynchrony.com>
 <20200116140227.GV3929@twin.jikos.cz> <20200117155948.GM13306@hungrycats.org>
 <CAJCQCtTZMSzNosnognWCyBU+iJ4La=0EG0xBKHEPSDdaAAqt4A@mail.gmail.com>
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <5a0ee78c-31a1-d12f-5816-9155adf19ebe@cobb.uk.net>
Date:   Fri, 17 Jan 2020 19:39:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTZMSzNosnognWCyBU+iJ4La=0EG0xBKHEPSDdaAAqt4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/01/2020 18:39, Chris Murphy wrote:
> It's no one's fault, it's just confusing. :P
> 
> Cancel word origin means more than stop, implies resetting state, to
> obliterate or invalidate.
> 
> Pause and stop word origin suggests they're interchangeable, but in
> practice with digital audio and video consumer gear, stop has come to
> mean a kind of cancel. (I'm gonna ignore tape.) Where a start from a
> stop will start at the very beginning. Whereas pause saves state and
> unpause means resume.
> 
> Lightweight change, add new command stop, which saves state, and
> cancel is an alias for backward compatibility. No other change.

That seems fairly pointless.

> Moderate change:
> start = alias resume

start and resume do different things today. The distinction is important
as the "saved state" after a cancel stays around until the next scrub
starts (it could be months old).

> stop = alias cancel
> i.e. a stop then start does the same thing as a cancel then resume,
> unless new command 'reset' is used
> reset = stops, and resets state to the beginning

That really isn't useful. It is much more useful to be able to decide
whether to use the saved state at start time than it is to decide
whether to save state at stop time. To build on Zygo's example, I might
have a script which pauses the scrub when the system load goes up and
then decides whether to resume it or restart from scratch depending on
how long it has been paused for. Also, the saved state can be inspected
while the scrub is paused to allow the operator to estimate how long it
might take to complete.

> Heavier change that's linguistically sane, but breaks expectations of
> today's cancel:
> pause and unpause (alias resume), and start and stop (alias cancel).
> The former is stateful, and the latter is stateless.

Changing the meaning of the current start, resume, or cancel commands
isn't an option - these are built into user scripts.

