Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E135D484ACE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 23:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiADWhJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 17:37:09 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:58108 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiADWhI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 17:37:08 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 52F06404D6
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 16:37:54 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id 1D25080353F7
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 16:37:07 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id 0F2478035415
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 16:37:07 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8kX_651HXRRD for <linux-btrfs@vger.kernel.org>;
        Tue,  4 Jan 2022 16:37:07 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id C1EAF80353F7
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 16:37:06 -0600 (CST)
Message-ID: <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
Subject: Re: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Tue, 04 Jan 2022 17:37:05 -0500
In-Reply-To: <YdSy09eCHqU5sgez@hungrycats.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
         <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
         <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
         <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
         <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
         <YdSy09eCHqU5sgez@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2022-01-04 at 15:49 -0500, Zygo Blaxell wrote:

> Cheap SSD devices wear out faster when issued a lot of discards mixed
> with small writes, as they lack the specialized hardware and firmware
> necessary to make discards low-wear operations.  The same flash
> component
> is used for both FTL persistence (where discards cause wear) and user
> data (where writes cause wear), so interleaved short writes and
> discards
> cause double the wear compared to the same short writes without
> discards.
> The fstrim man page advises not running trim more than once a week to
> avoid prematurely aging SSDs in this category, while the discard
> mount
> option is equivalent to running fstrim 2000-3000 times a day.

It seems much of the discussion relates to the design of physical
hardware. I would need to learn more about SDD to understand why the
operations are useful on them, as my thought had been that they would
be helpful for thin-provisioned logical volumes, but not meaningful on
physical devices.

I wonder whether the same or a different set of concerns from the ones
raised would be most helpful when considering management of non-
physical devices.

