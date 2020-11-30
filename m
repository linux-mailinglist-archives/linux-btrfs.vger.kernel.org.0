Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2262C8764
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 16:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgK3PEd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 10:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgK3PEd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 10:04:33 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C97C0613D2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 07:03:53 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1kjkin-0001pn-NH; Mon, 30 Nov 2020 15:04:09 +0000
Date:   Mon, 30 Nov 2020 15:04:09 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not allow -o compress-force to override
 per-inode settings
Message-ID: <20201130150409.GH1908@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Josef Bacik <josef@toxicpanda.com>, Roman Mamedov <rm@romanrm.net>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <a3cd057e747862eb7027ac6318bd26c6c36e0c49.1606743972.git.josef@toxicpanda.com>
 <20201130190805.48779810@natsu>
 <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92d0141-f68f-ce96-8099-e145ebc6f594@toxicpanda.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 30, 2020 at 09:50:13AM -0500, Josef Bacik wrote:
> On 11/30/20 9:08 AM, Roman Mamedov wrote:
> > On Mon, 30 Nov 2020 08:46:21 -0500
> > Josef Bacik <josef@toxicpanda.com> wrote:
> > 
> > > However some time later we got chattr -c, which is a user way of
> > > indicating that the file shouldn't be compressed.  This is at odds with
> > > -o compress-force.  We should be honoring what the user wants, which is
> > > to disable compression.
> > 
> > But chattr -c only removes the previously set chattr +c. There's no
> > "negative-c" to be forced by user in attributes. And +c is already unset on all
> > files by default. Unless I'm missing something? Thanks
> > 
> 
> The thing you're missing is that when we do chattr -c we're setting
> NOCOMPRESS on the file.  The thing that I'm missing is what exactly we're
> trying to allow.  If chattr -c is supposed to just be the removal of +c,
> then btrfs is doing the wrong thing by setting NOCOMPRESS.  We also do the
> same thing when we clear a btrfs.compression property.

   If I'm understanding this right, there's more than two states
here. There's a "default", and there's two "force" options -- forcing
nocompress, and forcing/allowing compression. If there's no c flag
set, the file could be in one of two states: default behaviour
(presumably defined by the value of the mount options), and
NOCOMPRESS. How do I tell which it is?

> I guess the question is what do we want?  Do we want to only allow the user
> to indicate we want compression, or do we want to allow them to also
> indicate that they don't want compression?  If we don't want to enable them
> to disable compression for a file, then this patch needs to be thrown away,
> but then we also need to fix up all the places we set NOCOMPRESS when we
> clear these flags.  Thanks,

   Hugo.

-- 
Hugo Mills             | The last man on Earth sat in a room. Suddenly, there
hugo@... carfax.org.uk | was a knock at the door.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                        Frederic Brown
