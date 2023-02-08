Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23AE68F221
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 16:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBHPi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 10:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjBHPiZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 10:38:25 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9748A37
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 07:38:24 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1pPmVX-0006di-0A; Wed, 08 Feb 2023 15:37:15 +0000
Date:   Wed, 8 Feb 2023 15:37:14 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Patrik Lundquist <patrik.lundquist@gmail.com>
Cc:     Paul Boughner <paulboughner@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: Leap Guest OS in Vbox =?utf-8?Q?parent?=
 =?utf-8?Q?_transid_verify_failed=E2=80=A6=2E613771?= wanted 613774
Message-ID: <20230208153714.GE31918@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Patrik Lundquist <patrik.lundquist@gmail.com>,
        Paul Boughner <paulboughner@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAKH6Scdg_BXDo9MR9O-RosM-VbR2Uz7Or=d_5-x3FSMSu75ziw@mail.gmail.com>
 <CAA7pwKPtkGH3HbJBWj7KA==Vwm+k8V4Q8j-Askxn9C7ZkSWbwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA7pwKPtkGH3HbJBWj7KA==Vwm+k8V4Q8j-Askxn9C7ZkSWbwQ@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 04:23:02PM +0100, Patrik Lundquist wrote:
> On Wed, 8 Feb 2023 at 16:03, Paul Boughner <paulboughner@gmail.com> wrote:
> >
> > This is in a VM so I am not sure how to get the log out and everything
> > is in images.
> >
> >  I did a dumb thing and hibernated my Win10 host with the Leap guest
> > still running then woke it up, then hibernated again, repeatedly 3x.

   This in itself shouldn't cause FS corruption, unless you were using
the FS from a different OS during the hibernation (in which case, it's
a miracle it lasted for 3 goes before breaking).

> Loopback mount the disk image and run btrfs check?
> 
> https://superuser.com/questions/158908/how-to-mount-a-virtualbox-vdi-disk-on-linux

   btrfs check isn't likely to help here, but the loopback is useful
if you can't boot the original VM into a recovery environment. Most
desktop distributions will be able to drop you into some kind of
recovery environment (maybe just the initramfs) even if the main OS
can't boot.

   Depending on the exact failure (in dmesg) when you try to mount the
FS, it may be fixable. The first thing is to try to mount with
-orecovery=all. If that works, then everything should be sorted. If
not, it would be useful to see the output of dmesg when you get the
mount failure, and we can work out what to do from there.

   Hugo.

-- 
Hugo Mills             | I'm all for giving people enough rope to shoot
hugo@... carfax.org.uk | themselves in the foot.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Andreas Dilger
