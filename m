Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32E58BCB8B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 17:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfIXPeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 11:34:16 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:53436 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390182AbfIXPeQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 11:34:16 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1iCmpP-0002aR-D4; Tue, 24 Sep 2019 17:34:11 +0200
Date:   Tue, 24 Sep 2019 17:34:11 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 08/12] btrfs-progs: add option for checksum type to
 mkfs
Message-ID: <20190924153411.GA8395@angband.pl>
References: <20190903150046.14926-1-jthumshirn@suse.de>
 <20190903150046.14926-9-jthumshirn@suse.de>
 <20190924142653.GT2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190924142653.GT2751@twin.jikos.cz>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 04:26:53PM +0200, David Sterba wrote:
> On Tue, Sep 03, 2019 at 05:00:42PM +0200, Johannes Thumshirn wrote:
> > Add an option to mkfs to specify which checksum algorithm will be used for
> > the filesystem.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> I'll change the option to '-c' so we have the most common options as
> lowercase letters.

-c is used for compression elsewhere, I'd rather avoid this confusion.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ A MAP07 (Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol,
⣾⠁⢠⠒⠀⣿⡁ 1kg raspberries, 0.4kg sugar; put into a big jar for 1 month.
⢿⡄⠘⠷⠚⠋⠀ Filter out and throw away the fruits (can dump them into a cake,
⠈⠳⣄⠀⠀⠀⠀ etc), let the drink age at least 3-6 months.
