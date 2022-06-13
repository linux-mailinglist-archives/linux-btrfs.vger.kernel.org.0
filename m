Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F43549E3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jun 2022 21:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbiFMT7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 15:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbiFMT5u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 15:57:50 -0400
X-Greylist: delayed 1362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 11:29:12 PDT
Received: from rin.romanrm.net (rin.romanrm.net [51.158.148.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AF12E090
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jun 2022 11:29:11 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by rin.romanrm.net (Postfix) with SMTP id 29D75245;
        Mon, 13 Jun 2022 18:29:09 +0000 (UTC)
Date:   Mon, 13 Jun 2022 23:29:07 +0500
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
Message-ID: <20220613232907.6d71be87@nvm>
In-Reply-To: <20220613181322.GP1664812@merlins.org>
References: <CAK-xaQYc1PufsvksqP77HMe4ZVTkWuRDn2C3P-iMTQzrbQPLGQ@mail.gmail.com>
 <20220611145259.GF1664812@merlins.org>
 <20220613022107.6eafbc1c@nvm>
 <20220613181322.GP1664812@merlins.org>
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

On Mon, 13 Jun 2022 11:13:22 -0700
Marc MERLIN <marc@merlins.org> wrote:

> On Mon, Jun 13, 2022 at 02:21:07AM +0500, Roman Mamedov wrote:
> > I'd suggest to put the LUKS volume onto an LV still (in case you don't), so you
> > can add and remove cache just to see how it works; unlike with bcache, an LVM
> 
> In case I decide to give that a shot, what would the actual LVM
> command(s) look like to create a null LVM? You'd just make a single PV
> using the cryptestup decrypted version of the mdadm raid5 

It is a question of whether you want to cache encrypted, or plain-text data. I
guess the former should be preferable, for a complete peace-of-mind against
data forensics vs the cache device, but with a toll on performance, due to the
need to re-decrypt even the cache hits each time.

In case of caching encrypted, it's:

mdraid => PV => LV => LUKS
                |
             (cache)

Otherwise:

mdraid => LUKS => PV => LV
                        |
                     (cache)

For the actual commands see e.g.
https://tomlankhorst.nl/setup-lvm-raid-array-mdadm-linux#set-up-logical-volume-management-lvm

> an LV that takes all of it, but after the fact you can modify the LV and add
> a cache?

Yes.

-- 
With respect,
Roman

