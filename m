Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA615F76F
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 21:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgBNUHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 15:07:02 -0500
Received: from mail.nethype.de ([5.9.56.24]:47641 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388678AbgBNUHB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 15:07:01 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2hEq-002DBL-6l; Fri, 14 Feb 2020 20:07:00 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1j2hEq-0001O1-10; Fri, 14 Feb 2020 20:07:00 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1j2hEq-00020a-0c; Fri, 14 Feb 2020 21:07:00 +0100
Date:   Fri, 14 Feb 2020 21:07:00 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: cpu bound I/O behaviour in linux 5.4 (possibly others)
Message-ID: <20200214200659.GA7612@schmorp.de>
References: <20200214113027.GA6855@schmorp.de>
 <7a472107-ab87-d787-9f4f-d0d0e148061a@suse.com>
 <CAL3q7H7SPyXB+5G6+XtgfviJdBQQSYD1YyJZPX6rbWxhes-+qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7SPyXB+5G6+XtgfviJdBQQSYD1YyJZPX6rbWxhes-+qw@mail.gmail.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 12:20:46PM +0000, Filipe Manana <fdmanana@gmail.com> wrote:
> So you can't deduce that the free space cache is being used, and
> despite being the default, it was not mentioned by Marc if he's not
> using already the free space tree (-o space_cache=v2).

Today, during an idle period, I stopped the news process, waited 15
minutes for I/O tand CPU to become mostly idle, and did this:

   # mount -noremount,clear_cache,space_cache=v1 /localvol5
   # mount -noremount,clear_cache,space_cache=v2 /localvol5

Which, to my surprise, didn't make btrfs complain too much:

   [1378546.558533] BTRFS info (device dm-17): force clearing of disk cache
   [1378546.558536] BTRFS info (device dm-17): enabling disk space caching
   [1378546.558537] BTRFS info (device dm-17): disk space caching is enabled

   [1378553.868438] BTRFS info (device dm-17): enabling free space tree
   [1378553.868440] BTRFS info (device dm-17): using free space tree

I don't know if this was effective in clearing the cache, but it didn't
change the behaviour - as soon as the new process started writing files
again, it was at 100% cpu.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
