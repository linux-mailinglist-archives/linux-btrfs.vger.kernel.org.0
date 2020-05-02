Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8381C2790
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEBS1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 14:27:38 -0400
Received: from mail.nethype.de ([5.9.56.24]:46739 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgEBS1i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 14:27:38 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jUwrQ-002Wtm-Jh; Sat, 02 May 2020 18:27:36 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jUwrQ-0005EL-EU; Sat, 02 May 2020 18:27:36 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jUwrQ-0001VC-DT; Sat, 02 May 2020 20:27:36 +0200
Date:   Sat, 2 May 2020 20:27:36 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: experiment: suboptimal behaviour with write errors and
 multi-device filesystems
Message-ID: <20200502182736.GE1069@schmorp.de>
References: <20200426124613.GA5331@schmorp.de>
 <20200428061959.GB10769@hungrycats.org>
 <20200428181436.GA5402@schmorp.de>
 <20200428213551.GC10796@hungrycats.org>
 <20200501015520.GA8491@schmorp.de>
 <20200501033720.GF10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501033720.GF10769@hungrycats.org>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 30, 2020 at 11:37:20PM -0400, Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> > My concern is merely that btrfs stubbornly insists a completely missing
> > disk is totally fine to write to, essentially forever :)
> 
> That's an administrator decision, but btrfs does currently lack the tool
> to implement the "remove the failing device" decision.  A workaround is
> 'echo 1 > /sys/block/sdX/dev/delete'.

Ah, I forgot to mention, the kernel did this automatically in my
experiment (as I described - the device node was gone).

The problem is the upper layers (lvm/dm and btrfs) didn't react to this
- dm becaus eit leaves error handling to the fs, and btrfs, because it
didn't have error handling other than "ignore an continue".

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
