Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85126128119
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Dec 2019 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLTRHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Dec 2019 12:07:12 -0500
Received: from mail.nethype.de ([5.9.56.24]:47613 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLTRHM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Dec 2019 12:07:12 -0500
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiLk3-003dNe-J0; Fri, 20 Dec 2019 17:07:07 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1iiLk3-0002qK-DQ; Fri, 20 Dec 2019 17:07:07 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1iiLk3-0001VM-D8; Fri, 20 Dec 2019 18:07:07 +0100
Date:   Fri, 20 Dec 2019 18:07:07 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs dev del not transaction protected?
Message-ID: <20191220170707.GA5577@schmorp.de>
References: <20191220040536.GA1682@schmorp.de>
 <b9e7f094-0080-ef08-68df-61ffbeaa9d19@gmx.com>
 <20191220063702.GE5861@schmorp.de>
 <1912b2a1-2aa9-bf4c-198f-c5e1565dd11f@gmx.com>
 <20191220132703.GA3435@schmorp.de>
 <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204287e5-8aca-3a51-9bc9-be577299bfd6@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Just while I was writing this mail, on 5.4.5, the _newly created_ btrfs
> filesystem I restored to went into readonly mode with ENOSPC. Another
> hardware problem?

btrfs check gave me a possible hint:

   Checking filesystem on /dev/mapper/xmnt-cold15
   UUID: 6e035cfe-5b47-406a-998f-b8ee6567abbc
   [1/7] checking root items
   [2/7] checking extents
   [3/7] checking free space tree
   cache and super generation don't match, space cache will be invalidated
   [4/7] checking fs roots
   [no other errors]

But mounting with clear_cache,space_cache=v2 didn't help, df still shows 0
bytes free, "btrfs f us" still shows 3tb unallocated. I'll play around with
it more...

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
