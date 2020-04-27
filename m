Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B226F1BA246
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 13:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0L3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 07:29:49 -0400
Received: from mail.nethype.de ([5.9.56.24]:46733 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgD0L3t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 07:29:49 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jT1xL-001J4k-Ab; Mon, 27 Apr 2020 11:29:47 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jT1xL-00060v-66; Mon, 27 Apr 2020 11:29:47 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jT1xL-0001fh-5Z; Mon, 27 Apr 2020 13:29:47 +0200
Date:   Mon, 27 Apr 2020 13:29:47 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
Subject: Re: questoin about Data=single on multi-device fs
Message-ID: <20200427112946.GA3648@schmorp.de>
References: <20200426100405.GA5270@schmorp.de>
 <20200426102547.GM32577@savella.carfax.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426102547.GM32577@savella.carfax.org.uk>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 26, 2020 at 11:25:47AM +0100, Hugo Mills <hugo@carfax.org.uk> wrote:
> > The reason I chose data=single was specifically to help in case of device
> > loss at the cost of performance.
> 
>    Make backups. That's the only way to be sure about this sort of thing.

I think you are unthinkingly repeating a wrong (and slightly dangerous)
claim - backups cannot actually do that sort of thing: a raid will protect
against (some amount of) disk failures with no data loss, but backups
cannot: Backups can protect against complete data loss, but cannot
completely protect against data loss.

>    With single data, *chunk allocation* will go to the device with the
> largest amount of unallocated space. If your data is WORM

That is definitely not the case with 5.4 - I added two disks to an
existing filesystem and copied 8TB onto it with btrfs receive, resulting
in about 3800G used on both new disks, with Data=single. I repeated it by
creating a 5 disk-fs and 1TB of data and got prettyx even distribution.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
