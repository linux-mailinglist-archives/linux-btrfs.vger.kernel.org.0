Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4867C15D7F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 14:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgBNNIa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 08:08:30 -0500
Received: from mail.nethype.de ([5.9.56.24]:40879 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgBNNIa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 08:08:30 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2aho-001scE-Jg; Fri, 14 Feb 2020 13:08:28 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2aM3-00007B-GU; Fri, 14 Feb 2020 12:45:59 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1j2aM3-0002Mk-CK; Fri, 14 Feb 2020 13:45:59 +0100
Date:   Fri, 14 Feb 2020 13:45:59 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: cpu bound I/O behaviour in linux 5.4 (possibly others)
Message-ID: <20200214124554.GB7686@schmorp.de>
References: <20200214113027.GA6855@schmorp.de>
 <20200214173654.394c1c7d@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214173654.394c1c7d@natsu>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 05:36:54PM +0500, Roman Mamedov <rm@romanrm.net> wrote:
> 
> You don't seem to mention which version you upgraded from. If a full bisect is
> impractical, this is the (very distant) next best thing you can do. Was it from
> 5.14.14, or from 3.4? :)

It was 5.2.21, and before that, 4.19. I might be able to do this, but it's
not something that I can quickly do to test this out.

> Also would be nice if you can double-check that returning to that previous
> version right now makes the issue go away, and it's not a coincidence of
> something else changed on the FS or OS (such as other package upgrades beside
> the kernel).

Would have done so, if I could easily do that. In the meantime, it's a
definite possibility that this is not actually something new, but only
something that recently manifested due to different I/O patterns.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
