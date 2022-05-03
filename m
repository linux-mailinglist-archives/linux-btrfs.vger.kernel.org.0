Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3105180A9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 11:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiECJMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 05:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiECJMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 05:12:15 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D7C34643
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 02:08:43 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1nloWQ-0006zD-Dr
        for linux-btrfs@vger.kernel.org; Tue, 03 May 2022 10:08:42 +0100
Date:   Tue, 3 May 2022 10:08:42 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: cannot mount btrfs root partition
Message-ID: <20220503090842.GJ15632@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs@vger.kernel.org
References: <20220503102001.271842da4933a043ba106d92@lucassen.org>
 <20220503083206.GI15632@savella.carfax.org.uk>
 <20220503104550.16d2465877beb89f713485c2@lucassen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503104550.16d2465877beb89f713485c2@lucassen.org>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 03, 2022 at 10:45:50AM +0200, richard lucassen wrote:
> On Tue, 3 May 2022 09:32:06 +0100
> Hugo Mills <hugo@carfax.org.uk> wrote:
> 
> > > New to btrfs, I try to load a btrfs / filesystem WITHOUT initrd but
> > > it ends up in a kernel panic. I run lilo, boot from /dev/md0.
> > > md1: swap,
> > > md2: / filesystem
> > > sda6/sdb6: btrfs raid1
> > 
> >    Generally speaking, if you have a multi-device FS as your /, you
> > *really* should have an initramfs. In order to mount the FS, the
> > kernel needs to know which devices contain which parts of which
> > filesystem. The tool for doing this, "btrfs dev scan", runs in
> > userspace, so you have to have a userspace available before you can
> > mount /. This is what an initramfs is.
> > 
> >    In theory, it's possible to use a mount option to specify the
> > devices explicitly, but in practice, that's heavily dependent on the
> > device enumeration order, and can change at any time (between one
> > kernel version and another; or even simply between one boot and
> > another). I would strongly recommend against using it, for that
> > reason.
> 
> Ok, but I see the same problem using a single /dev/sdc1 (non-raid1)
> btrfs system. AFAIUI, that should work, correct?
> 
> I know devices can be renamed, but also tried to append
> 
> rootflags=device=/dev/sda6,device=/dev/sdb6
> 
> as written on this page:
> 
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices
> 
> I have no idea if that is the right syntax, but that did not work
> either.
> 
> And I know: it is also there: I should use an initrd, but just eager to
> why it is not working anyway...

   For the single-drive case, I don't know why that's not working. Is
the error message the same with that as for the multi-device FS?

   Hugo.

-- 
Hugo Mills             | Great films about cricket: The Third Man
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
