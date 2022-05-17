Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E8852AB61
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 21:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349950AbiEQTAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbiEQTAi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 15:00:38 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E21150047
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 12:00:36 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1nr2Qr-0003D7-0o; Tue, 17 May 2022 20:00:33 +0100
Date:   Tue, 17 May 2022 20:00:32 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>
Cc:     Btrfs ML <linux-btrfs@vger.kernel.org>
Subject: Re: extend BTRFS partition
Message-ID: <20220517190032.GC22627@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        "Lentes, Bernd" <bernd.lentes@helmholtz-muenchen.de>,
        Btrfs ML <linux-btrfs@vger.kernel.org>
References: <1489308571.65954054.1652813156598.JavaMail.zimbra@helmholtz-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489308571.65954054.1652813156598.JavaMail.zimbra@helmholtz-muenchen.de>
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

On Tue, May 17, 2022 at 08:45:56PM +0200, Lentes, Bernd wrote:
> Hi,
> 
> i have a BTRFS partition on a harddisk which is filling up.
> I read in the man-pages from btrfs that i can add another harddisk/partition.
> 
> Can i do s.th. like "btrfs device add /dev/vda[x] /path_to_BTRFS_filesystem" ?
> Is there something to take care off ?

   That's pretty much it to get the extra space in. Afterwards, you
should also do:

   btrfs balance start -mconvert=raid1,soft /path/to/btrfs/filesystem

which will convert your metadata to RAID-1 and ensure that there's one
copy on each of the two devices (for robustness).

   Hugo.

-- 
Hugo Mills             | emacs: Emacs Makes A Computer Slow.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
