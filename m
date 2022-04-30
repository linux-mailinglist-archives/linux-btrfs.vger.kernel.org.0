Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29760516049
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbiD3USZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiD3USX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 16:18:23 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B375E4E
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 13:15:00 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1nktUY-0005Pm-9c; Sat, 30 Apr 2022 21:14:58 +0100
Date:   Sat, 30 Apr 2022 21:14:58 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     John Center <jlcenter15@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: How to convert a directory to a subvolume
Message-ID: <20220430201458.GG15632@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        John Center <jlcenter15@gmail.com>, linux-btrfs@vger.kernel.org
References: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87238001-69C5-4FA8-BE83-C35338BC8C81@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Apr 30, 2022 at 04:08:59PM -0400, John Center wrote:
> Hi,
> 
> I just installed Ubuntu 22.04 with a btrfs raid1 root filesystem.  I want to convert a directory, like /opt, into a subvolume. I haven’t been having much luck.  /opt is empty right now, so it’s a good candidate for conversion.  Could someone please explain how to do it?  I’ve been at a dozen different websites, & tried different variations of the “btrfs subvolume create” command, but nothing works when I go to mount it.  I think I’m missing something simple, but not sure what it is.

   You can't convert a directory into a subvolume.

   Since the directory in question is empty, just delete it and create
a subvol there instead:

# rmdir /opt
# btrfs sub create /opt

   If there's stuff in there, you need to create the subvolume with a
different name, copy the contents of the directory into it (optionally
with --reflink=always) and then delete the original directory and move
the subvolume into its place.

   Hugo.

-- 
Hugo Mills             | UNIX: British manufacturer of modular shelving units
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
