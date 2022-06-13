Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23A549DDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345440AbiFMTkN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243372AbiFMTkA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:40:00 -0400
Received: from rin.romanrm.net (rin.romanrm.net [IPv6:2001:bc8:2dd2:1000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38E71A2F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:06:31 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 9B84D5D4;
        Mon, 13 Jun 2022 18:06:26 +0000 (UTC)
Date:   Mon, 13 Jun 2022 23:06:25 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Suggestions for building new 44TB Raid5 array
Message-ID: <20220613230625.78631b8a@nvm>
In-Reply-To: <20220613174640.GL1664812@merlins.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
        <20220611145259.GF1664812@merlins.org>
        <20220613022107.6eafbc1c@nvm>
        <20220613174640.GL1664812@merlins.org>
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

On Mon, 13 Jun 2022 10:46:40 -0700
Marc MERLIN <marc@merlins.org> wrote:

> bcache by the way, you can set it up without a backing device and then
> use it normally without the cache layer. I think it's actually pretty
> similar, but you have to set it up beforehand (just like LVM)

What I mean is bcache in this way stays bcache-without-a-cache forever, which
feels odd; it still goes through the bcache code, has the module loaded, keeps
the device name, etc;

Whereas in LVM caching is a completely optional side-feature, and many people
would just run LVM in any case, not even thinking about enabling cache. LVM is
basically "the next generation" of disk partitions, with way more features,
but not much more overhead.

-- 
With respect,
Roman
