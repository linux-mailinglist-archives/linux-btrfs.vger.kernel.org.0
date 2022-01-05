Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09447484C16
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 02:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiAEB0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 20:26:47 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:59552 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbiAEB0q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 20:26:46 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 38518405D3
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:27:33 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id EAAE58035419
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:26:45 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id DE81A8035415
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:26:45 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JslJ7I0tCY2m for <linux-btrfs@vger.kernel.org>;
        Tue,  4 Jan 2022 19:26:45 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id A0A3B803540A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 19:26:45 -0600 (CST)
Message-ID: <18d02df50fc7f9c63ff07b5433a445d911538be6.camel@ericlevy.name>
Subject: Re: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Tue, 04 Jan 2022 20:26:41 -0500
In-Reply-To: <YdTytv47JUGujVl5@hungrycats.org>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
         <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
         <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
         <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
         <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
         <YdSy09eCHqU5sgez@hungrycats.org>
         <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
         <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
         <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
         <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
         <YdTytv47JUGujVl5@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2022-01-04 at 20:21 -0500, Zygo Blaxell wrote:

> ZNS SSD devices do address mapping entirely in reverse--in a write
> command, the host says "append this block to zone Z", the drive
> chooses
> a block address for the data within that zone, and sends the written
> block address back to the host filesystem as part of the command
> reply.
> This allows the drive to implement writes in parallel (so they are
> subject to reordering) without having to store where it put user data
> in the SSD's own memory.

How does the host remember the mapping, and where does it get applied
during followup access?

