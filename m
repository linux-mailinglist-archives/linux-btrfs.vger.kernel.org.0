Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3323653526E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244863AbiEZRKv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEZRKu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 13:10:50 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB04F9F4
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 10:10:48 -0700 (PDT)
Received: from [104.132.1.99] (port=48245 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nuGIB-0005dW-Bh by authid <merlins.org> with srv_auth_plain; Thu, 26 May 2022 10:10:46 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nuH0Y-00CbSl-7n; Thu, 26 May 2022 10:10:46 -0700
Date:   Thu, 26 May 2022 10:10:46 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220526171046.GB1751747@merlins.org>
References: <CAEzrpqdgKtSDJj2QekYuS+M77wYrp6bvXv2Ue3xQ8Vm2bGGYAg@mail.gmail.com>
 <20220517212223.GL8056@merlins.org>
 <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org>
 <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org>
 <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org>
 <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-Broken-Reverse-DNS: no host name for IP address 104.132.1.99
X-SA-Exim-Connect-IP: 104.132.1.99
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 25, 2022 at 10:35:22AM -0400, Josef Bacik wrote:
> At this point let's stop it and try and get the missing chunks back.
> Looking at the chunk rescue code it looks like it should do the
> correct thing, can you do

I stopped it here, can't tell how far it was after almost a week of running:
 
searching 163316 for bad extents
processed 74514432 of 108576768 possible bytes, 68%
Found an extent we don't have a block group for in the file
History/JeanMerlin_Picts/VACANCES/0320-052633.jpg
Deleting [58726, 108, 0] root 6781246275584 path top 6781246275584 top slot 18 leaf 11160503386112 slot 80

searching 163316 for bad extents
processed 74514432 of 108576768 possible bytes, 68%
Found an extent we don't have a block group for in the file
History/JeanMerlin_Picts/VACANCES/0320-052720.jpg
Deleting [58727, 108, 0] root 6781246226432 path top 6781246226432 top slot 18 leaf 11160503353344 slot 82

searching 163316 for bad extents
processed 74514432 of 108576768 possible bytes, 68%
Found an extent we don't have a block group for in the file
History/JeanMerlin_Picts/VACANCES/0320-053405.jpg
Deleting [58728, 108, 0] root 6781246275584 path top 6781246275584 top slot 18 leaf 11160503386112 slot 84

searching 163316 for bad extents
processed ^Z515008 of 108576768 possible bytes, 67%

> btrfs rescue chunk-recover <device>

Took close to a day to run, and now I have this:

./btrfs rescue chunk-recover /dev/mapper/dshelf1
Scanning: DONE in dev0                          
JOSEF: root 9
Couldn't find the last root for 8
We are going to rebuild the chunk tree on disk, it might destroy the old metadata on the disk, Are you sure? [y/N]: 

Do I say 'y' ?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
