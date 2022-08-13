Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B949E591C2A
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiHMRgV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiHMRgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 13:36:20 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E613E03
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 10:36:16 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 488945D0;
        Sat, 13 Aug 2022 17:36:14 +0000 (UTC)
Date:   Sat, 13 Aug 2022 22:36:13 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Ash Logan <ash@heyquark.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Corrupt leaf, trying to recover
Message-ID: <20220813223613.0245732f@nvm>
In-Reply-To: <593e9196-7455-1874-750f-2f11443d7841@heyquark.com>
References: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
        <0b4a3bca-cafd-b47d-d03c-a97922e49228@gmx.com>
        <c1b246ad-6665-1216-166c-a1ad32222b35@heyquark.com>
        <a9d3eb38-e939-4751-4dc8-896fa653be73@gmx.com>
        <593e9196-7455-1874-750f-2f11443d7841@heyquark.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, 13 Aug 2022 18:28:36 +1000
Ash Logan <ash@heyquark.com> wrote:

> > That new sanity check introduced in v5.11 should save a lot of hassle
> > like this.
> 
> Debian doesn't ship it, though.. Will have to see what my options are 
> there. Maybe time to build my own.

Kernel 5.18 is available in the backports repository for Debian 11:
https://packages.debian.org/search?keywords=linux-image-5.18

See https://backports.debian.org/Instructions/

As for bitflip, I would be concerned to keep using this hardware (RAM). It
might be that you are using tests that are not rigorous enough. For instance
once I got some sticks which were "stable" in MemTest86+, but TestMem5 with
its custom 'extreme' profiles has reported errors.

Or at least next time you get a weird Btrfs issue, which is quite good, with
its currently present write-time/read-time sanity checks, at tripping on any
bad RAM in a loud way, you will know there is definitely something wrong with
it.

-- 
With respect,
Roman
