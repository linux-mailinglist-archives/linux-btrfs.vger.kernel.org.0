Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0534B6A471F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjB0Qhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 11:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjB0Qhb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 11:37:31 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E4234ED
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 08:37:28 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1pWgU2-0005m1-6t; Mon, 27 Feb 2023 16:36:14 +0000
Date:   Mon, 27 Feb 2023 16:36:14 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Philipp Gerlach <philipp.gerlach@gmx.de>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Question / Idea regarding fragmentation caused by COW operations
Message-ID: <20230227163614.GA17792@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Philipp Gerlach <philipp.gerlach@gmx.de>,
        linux-btrfs@vger.kernel.org
References: <05b1de7a-a8f1-0cda-4519-ffdd0576a555@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05b1de7a-a8f1-0cda-4519-ffdd0576a555@gmx.de>
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

On Mon, Feb 27, 2023 at 05:22:50PM +0100, Philipp Gerlach wrote:
> Hello,
> 
> I have a question, maybe an idea for a feature, regarding the way how
> COW is causing fragmentation of files.
> 
> As I understand it, COW in btrfs works roughly like this:
> 
> A file which -- because of its size -- uses several extents is edited.
> That means that the data within one of the extents will be changed. The
> changes are not written to the original extent, but the changed data for
> the extent is written to a new location. Afterwards, the reference to
> the extent is updated and will then point to the new extent in the new
> location, and pointing to the other unchanged extents in their original
> location as before. This way the extents of the file are partly in their
> original location and partly in a new location, i.e, the file becomes
> fragmented.
> 
> Do I understand this more or less correctly?
> 
> My Idea is the following:
> I assume that in many use cases the newest version of a file will be the
> one which is most often read and most probably further edited. Older
> versions are probably mostly kept for backup / snapshots / archive, so
> one could assume that they are rarely read and even less edited.
> 
> Therefore it may be beneficial to switch the way extents are written:
> 1. Instead of writing the changed extent to a new location, copy the
> original extent to a new location
> 2. Update all existing references to that extent to point to the new
> location
> 3. Then write the changed extent in the original location
> 4. Update the reference to the extent for the file which is currently
> edited to point again in the original location
> 
> This would mean that one has to pay a bit in terms of performance while
> writing, especially for extents which are referenced a lot (for updating
> the old references), but on the upside fragmentation would probably only
> rarely be encountered while reading. Plus, if e.g. older versions are
> indeed only used in snapshots for versioning purposes, the fragmented
> files would be deleted over time when old snapshots are deleted regularly.
> 
> Does this make sense?

   Yes. It's not a new idea. In fact, it's an old one.

   btrfs's CoW is technically RoW (redirect-on-write) -- the new
extent is redirected to a different location. What you've described is
actual CoW (copy-on-write), which is, for example, used in some
database servers, going back decades (Oracle, for example).

   I suspect you'd have to rewrite a large chunk of btrfs to make it
work with CoW rather than RoW, and you'd end up with what's
essentially a different filesystem at the end of it.

   Hugo.

-- 
Hugo Mills             | I'm on a 30-day diet. So far I've lost 18 days.
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
