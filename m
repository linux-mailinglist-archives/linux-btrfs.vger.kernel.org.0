Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B9D535289
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 19:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbiEZRbZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 13:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEZRbX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 13:31:23 -0400
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A3227CC8
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 10:31:20 -0700 (PDT)
Received: from [104.132.1.99] (port=39850 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2 #2)
        id 1nuGc4-0007MQ-Ix by authid <merlins.org> with srv_auth_plain; Thu, 26 May 2022 10:31:19 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1nuHKR-00CfXA-Md; Thu, 26 May 2022 10:31:19 -0700
Date:   Thu, 26 May 2022 10:31:19 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent
 transid verify failed + open_ctree failed)
Message-ID: <20220526173119.GC1751747@merlins.org>
References: <CAEzrpqcX3XEQGjoJCV1wARu=Od7vAypmzO4dCFgQ+_UBBuJdMA@mail.gmail.com>
 <20220518191241.GI13006@merlins.org>
 <CAEzrpqfPEU9Vt86ykVyxwvDXrihKfGc180oT7SUcQdwtYysquw@mail.gmail.com>
 <20220519222855.GL13006@merlins.org>
 <20220524011348.GR13006@merlins.org>
 <CAEzrpqd=G50pWKYJRD57ePVpfGNPu947zJXuZFdj0tF4yGzkbQ@mail.gmail.com>
 <20220524191345.GA1751747@merlins.org>
 <CAEzrpqdTpkvguQq+MGxYBb12-RF97dgW7cccz7o2HoSkrWt8gQ@mail.gmail.com>
 <20220526171046.GB1751747@merlins.org>
 <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEzrpqd_B13rDPCZLm9h0ji8f1oS7mCw=2d1-iiW=M26FfEcCw@mail.gmail.com>
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

On Thu, May 26, 2022 at 01:12:03PM -0400, Josef Bacik wrote:
> > ./btrfs rescue chunk-recover /dev/mapper/dshelf1
> > Scanning: DONE in dev0
> > JOSEF: root 9
> > Couldn't find the last root for 8
> > We are going to rebuild the chunk tree on disk, it might destroy the old metadata on the disk, Are you sure? [y/N]:
> >
> > Do I say 'y' ?
> 
> Yup it should have found all the best chunks, lets let it do its thing.  Thanks,
 
Done.

what next?


gargamel:/var/local/src/btrfs-progs-josefbacik# fg
./btrfs rescue chunk-recover /dev/mapper/dshelf1
Scanning: DONE in dev0                          
JOSEF: root 9
Couldn't find the last root for 8
We are going to rebuild the chunk tree on disk, it might destroy the old metadata on the disk, Are you sure? [y/N]: y
Chunk tree recovered successfully
gargamel:/var/local/src/btrfs-progs-josefbacik# 

I still have this that ran almost a week:
gargamel:/var/local/src/btrfs-progs-josefbacik# jobs
[1]+  Stopped                 ./btrfs rescue init-extent-tree /dev/mapper/dshelf1 2>&1 | tee /mnt/btrfs_space/ri1

I assume it's invalidated and I should kill it?
If so, do I start the same thing again?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
