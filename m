Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2337E69F12
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 00:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfGOWkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jul 2019 18:40:55 -0400
Received: from smtp01.belwue.de ([129.143.71.86]:47908 "EHLO smtp01.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730608AbfGOWkz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jul 2019 18:40:55 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp01.belwue.de (Postfix) with SMTP id BE9F16D17
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 00:40:51 +0200 (MEST)
Date:   Tue, 16 Jul 2019 00:40:51 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: find subvolume directories
Message-ID: <20190715224051.GA30754@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20190712231705.GA16856@tik.uni-stuttgart.de>
 <75e5bd20-fafa-07fd-afd9-159e9aacb7db@gmail.com>
 <20190713082759.GB16856@tik.uni-stuttgart.de>
 <62366a29-a8ea-a889-f857-0305eba99051@gmail.com>
 <20190713112832.GA30696@tik.uni-stuttgart.de>
 <20190715132228.GF4212@pontus.sran>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715132228.GF4212@pontus.sran>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon 2019-07-15 (15:22), Piotr Szymaniak wrote:

> > I want a list of all subvolumes directories (which I can access with UNIX
> > tools like cd and ls or btrfs subvolume ...).
> 
> what about btrfs sub list [options]? (see man btrfs-subvolume)
> 
> You can make ie.:
> root@ed:~# btrfs sub list -a / | head -10
> ID 259 gen 142795 top level 5 path <FS_TREE>/@rut
> ID 267 gen 1599 top level 259 path @rut/BUP/190417-1748_Image_SYSVOL

There is no directory "<FS_TREE>/@rut" or
"@rut/BUP/190417-1748_Image_SYSVOL" which I cann access directly with
standard UNIX commands.


> But, I'm a bit like Andrei, and not sure what are you looking for. You
> already asked about "mounted" and then about "list of all subvols"...
> So you want to find mounted subvolumes or all subvolumes or all mounted
> subvolumes or ...?

I need a list of all subvolumes DIRECTORIES, to be accessible with
standard UNIX commands like cd and ls or btrfs subvolume show



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20190715132228.GF4212@pontus.sran>
