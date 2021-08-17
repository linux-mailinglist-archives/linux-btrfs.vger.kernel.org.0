Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324C03EF033
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhHQQbq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 17 Aug 2021 12:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhHQQbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 12:31:45 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD949C0613C1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Aug 2021 09:31:11 -0700 (PDT)
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a64:bb00:279:2943:e3ef:f04])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 02D9B2A3F24;
        Tue, 17 Aug 2021 18:31:05 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Sebastian =?ISO-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Corruption errors on Samsung 980 Pro
Date:   Tue, 17 Aug 2021 18:31:05 +0200
Message-ID: <2461604.9INPc8UTF4@ananda>
In-Reply-To: <CAJCQCtROaJTj1J7t7fbX0Tjj5C7CvO=2sv02yRYHod_nQZmODQ@mail.gmail.com>
References: <2729231.WZja5ltl65@ananda> <CADkZQamczB9yqw_Eump8uJJ11ez_kmr2V=HU8S_vnO1Q-Ux9KA@mail.gmail.com> <CAJCQCtROaJTj1J7t7fbX0Tjj5C7CvO=2sv02yRYHod_nQZmODQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy - 13.08.21, 20:14:40 CEST:
> On Fri, Aug 13, 2021 at 3:50 AM Sebastian Döring 
<moralapostel@gmail.com> wrote:
> > >It is BTRFS single profile on LVM on LUKS. Mount options are:
> > ...
> > 
> > >I thought that a Samsung 980 Pro can easily handle "discard=async"
> > >so I> 
> > used it.
> > 
> > LUKS doesn't do discard unless you explicitly enable and force it.
> > Have you?
> `cryptsetup open` doesn't allow discards by default, but some distro
> installers do enable it by default. The most likely place to find out
> is looking at /etc/crypttab

It has option "discard" in there.

A few days ago BTRFS for /home had corruption errors that lead to it 
being marked read only and then being unmountable until I used "btrfs 
rescue zero-log". After that I was able to rsync almost all files to a 
freshly created BTRFS LVM LV and recover the rest from backup. This 
happened after an unintended laptop battery outage.

But I better report it in a different thread.

Best,
-- 
Martin


