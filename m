Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A604EEE6C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 15:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiDANsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 09:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDANsi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 09:48:38 -0400
X-Greylist: delayed 1766 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 06:46:46 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16F827F4FA
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 06:46:46 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1naH9P-0000nS-Qc; Fri, 01 Apr 2022 14:17:15 +0100
Date:   Fri, 1 Apr 2022 14:17:15 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Konstantinos Skarlatos <k.skarlatos@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org
Subject: Re: Adding a 4TB disk to a 2x4TB btrfs (data:single) filesystem and
 balancing takes extremely long (over a month). Filesystem has been deduped
 with bees
Message-ID: <20220401131715.GL18319@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Konstantinos Skarlatos <k.skarlatos@gmail.com>,
        linux-btrfs@vger.kernel.org, ce3g8jdj@umail.furryterror.org
References: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 01, 2022 at 02:13:58PM +0300, Konstantinos Skarlatos wrote:
> Hello,
> I am running btrfs on 2x 4TB HDDs (data: single, metadata: raid1) and i
> added another 4TB disk.
> According to btrfs wiki i should run balance after adding the new device.
> My problem is that this balance takes extremely long, it is running for 4
> days and it still has 91% left.
> Is this normal, and can i do anything to fix this?

   It's not normal for it to take that long, no. Do you have lots of
snapshots (like, thousands), and lots of small or heavily fragmented
files?

   Is the balance actually progressing, or has it got stuck? Are there
regular messages in dmesg about it balancing block groups? If not,
when was the last one?

   If your data is single, it's not really necessary to do the balance
anyway, so you may want to cancel it. The balance in this situation is
more about ensuring that all the space on the new disk is usable by
the higher RAID levels. For example, adding a single disk to a
nearly-full RAID-1 without balancing would leave you in a state where
you couldn't add more data chunks because there's only space on one
disk to do so, and RAID-1 needs two disks with space to allocate a
data chunk in. With single data, that's not a problem.

> kernel is linux-5.17.1, i have also tried with 5.16 kernels.
> mount options are: rw,relatime,compress-force=zstd:11,space_cache=v2
> I have been using bees for dedup, but it is disabled for the balance.
> I am not doing any IO on the disks, they have no smart errors, and none of
> them are SMR (2x WD40EFRX and 1x ST4000DM000)
> Autodefrag is disabled, and i also have checked that the disks are in stable
> drive cages in order to be sure i have no problems with vibration.
> Benchmarking them gives normal speeds. Quotas have never been enabled.

-- 
Hugo Mills             | "Damn and blast British Telecom!" said Dirk,
hugo@... carfax.org.uk | the words coming easily from force of habit.
http://carfax.org.uk/  |                                        Douglas Adams,
PGP: E2AB1DE4          |               Dirk Gently's Holistic Detective Agency
