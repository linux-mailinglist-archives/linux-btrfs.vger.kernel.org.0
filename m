Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9C285C6C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Oct 2020 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgJGKID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Oct 2020 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgJGKIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Oct 2020 06:08:02 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [IPv6:2001:41d0:602:dbe::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C1EC061755
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Oct 2020 03:08:02 -0700 (PDT)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1kQ6MY-00058j-0b; Wed, 07 Oct 2020 12:07:58 +0200
Date:   Wed, 7 Oct 2020 12:07:58 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Eric Levy <ericlevy@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: de-duplicating +C files
Message-ID: <20201007100757.GB11861@angband.pl>
References: <CA++hEgxkGhnbKBhwuwSAJn2BtZ+RAPuN+-ovkKLsUUfTRnD1_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA++hEgxkGhnbKBhwuwSAJn2BtZ+RAPuN+-ovkKLsUUfTRnD1_g@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 07, 2020 at 02:29:34AM -0400, Eric Levy wrote:
> Recently a discussion [1] began about the desirability or risk of
> applying a de-duplication operation on files with a C (no-CoW)
> attribute set. The controversy rests largely on the observation that
> calls to Btrfs currently fail for de-duplication between two files if
> exactly one has the attribute set, but succeed in other cases, even in
> which both have the attribute set. It may seem more natural that
> success depends on neither file having the attribute set.

Why?  It's just that the flag is misnamed, it should be "overwrite in-place"
as it doesn't block CoW in any way.  It works like most uses of the word
"CoW" elsewhere: a page is CoWed once whenever it's written to when its
refcount is more than 1.

You can already reflink by snapshotting the subvolume that contains your
file, thus there's no point in blocking explicit deduplication.

The behaviour when trying to dedupe a -C extent with a +C one is less clear.
I'd argue to either:
 * prefer the -C copy, or
 * refuse (current state)


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Imagine there are bandits in your house, your kid is bleeding out,
⢿⡄⠘⠷⠚⠋⠀ the house is on fire, and seven giant trumpets are playing in the
⠈⠳⣄⠀⠀⠀⠀ sky.  Your cat demands food.  The priority should be obvious...
