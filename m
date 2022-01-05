Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0E484BD6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 01:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiAEAoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 19:44:24 -0500
Received: from zmcc-3-mx.zmailcloud.com ([34.200.143.36]:59288 "EHLO
        zmcc-3-mx.zmailcloud.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiAEAoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 19:44:23 -0500
Received: from zmcc-3.zmailcloud.com (zmcc-3-mta-1.zmailcloud.com [104.154.87.183])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by zmcc-3-mx.zmailcloud.com (Postfix) with ESMTPS id 2BFF5405C0
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 18:45:10 -0600 (CST)
Received: from zmcc-3.zmailcloud.com (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPS id E0FBB803540A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 18:44:22 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTP id D2EBA8035415
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 18:44:22 -0600 (CST)
Received: from zmcc-3.zmailcloud.com ([127.0.0.1])
        by localhost (zmcc-3-mta-1.zmailcloud.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LFOI8GCK-rph for <linux-btrfs@vger.kernel.org>;
        Tue,  4 Jan 2022 18:44:22 -0600 (CST)
Received: from epl-dy1-mint (unknown [154.21.21.52])
        by zmcc-3-mta-1.zmailcloud.com (Postfix) with ESMTPSA id 93810803540A
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Jan 2022 18:44:22 -0600 (CST)
Message-ID: <ca2d0ec03b6ec81add904d44e432ec063777b6e0.camel@ericlevy.name>
Subject: Re: "hardware-assisted zeroing"
From:   Eric Levy <contact@ericlevy.name>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Date:   Tue, 04 Jan 2022 19:44:21 -0500
In-Reply-To: <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <2c80ca8507181b1e65a67bbd4dca459d24a47da2.camel@ericlevy.name>
         <b0d434dd-e76d-fdfa-baa2-bb7e00d28b01@gmx.com>
         <487b4d965a6942d6c2d1fad91e4e5a4aa29e2871.camel@ericlevy.name>
         <e3fd9851-ccf4-6f04-b376-56c6f7383de7@gmx.com>
         <faa7edb08a5cf68e8668546facbb8c60ae5a22e7.camel@ericlevy.name>
         <YdSy09eCHqU5sgez@hungrycats.org>
         <f264615001da2f24ca418fdaa4b4567b7ff4cb22.camel@ericlevy.name>
         <2193547e-d88e-9f53-6777-793b58130afd@gmx.com>
         <SYXPR01MB1918C7BCE283C34FE862387E9E4B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2022-01-05 at 00:38 +0000, Paul Jones wrote:

> It's also needed to keep throughput high on near full drives, as
> flash can't write at anywhere near the rated speed of the drive. If
> there is not enough free blocks to dump incoming data then the drive
> needs to stop and wait for in-progress data to finish writing/erasing
> before processing the next command.

Isn't the address of a free block, for writing new data, resolved by
the file system, based on the allocation data it maintains, not by the
hardware?

