Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3367180622
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390194AbfHCMYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 08:24:25 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:33266 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389812AbfHCMYY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Aug 2019 08:24:24 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1htt5D-0001p3-0e
        for linux-btrfs@vger.kernel.org; Sat, 03 Aug 2019 14:24:23 +0200
Date:   Sat, 3 Aug 2019 14:24:23 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs on RHEL7 (kernel 3.10.0) production ready?
Message-ID: <20190803122423.GA6703@angband.pl>
References: <20190803100928.GB29941@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190803100928.GB29941@tik.uni-stuttgart.de>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Aug 03, 2019 at 12:09:28PM +0200, Ulli Horlacher wrote:
> I have RHEL 7 and CentOS 7.6 servers with kernel 3.10.0 and btrfs-progs v4.9.1
> Is btrfs there ready for production usage(*)?

Hell no!

It's a truly ancient kernel, from the times btrfs wasn't considered stable.
There's a lot of backports atop it, which for a quickly evolving filesystem
are pretty unsafe unless there's a large team doing that work.

And unlike SLES, there's none.  This led to notorious breakages, with Red
Hat finally declaring btrfs unsupported on their distributions.

Thus, if you care about your data at all, please use a modern kernel.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢰⠒⠀⣿⡁ Imagine there are bandits in your house, your kid is bleeding out,
⢿⡄⠘⠷⠚⠋⠀ the house is on fire, and seven big-ass trumpets are playing in the
⠈⠳⣄⠀⠀⠀⠀ sky.  Your cat demands food.  The priority should be obvious...
