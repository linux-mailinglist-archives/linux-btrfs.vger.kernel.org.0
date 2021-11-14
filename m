Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753C44FA18
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 20:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhKNTTW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 14:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhKNTTV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 14:19:21 -0500
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Nov 2021 11:16:26 PST
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50341C061746
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Nov 2021 11:16:25 -0800 (PST)
Received: from tux.applied-asynchrony.com (p5ddd7948.dip0.t-ipconnect.de [93.221.121.72])
        by mail.itouring.de (Postfix) with ESMTPSA id 3F063CC2FA5;
        Sun, 14 Nov 2021 20:06:47 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id F3B08F01606;
        Sun, 14 Nov 2021 20:06:46 +0100 (CET)
Subject: Re: Large BTRFS array suddenly says 53TiB Free, usage inconsistent
To:     =?UTF-8?Q?Max_Splieth=c3=b6ver?= <max@spliethoever.de>,
        Joshua <joshua@mailmag.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2f87defb6b4c199de7ce0ba85ec6b690@mailmag.net>
 <b219d9de-ac42-1ec4-0fff-c8be2c36bfae@spliethoever.de>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <77924dab-1bc9-ce56-056f-da795998365c@applied-asynchrony.com>
Date:   Sun, 14 Nov 2021 20:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <b219d9de-ac42-1ec4-0fff-c8be2c36bfae@spliethoever.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-11-14 19:45, Max Spliethöver wrote:
> Hello everyone. I observed the exact same behavior on my 2x4TB RAID1.
> After an update of my server that runs a btrfs RAID1 as data storage
> (root fs runs on different, non-btrfs disks) and running `sudo btrfs
> filesystem usage /tank`, I realized that the "Data ratio" and
> "Metadata ratio" had dropped from 2.00 (before upgrade) to 1.00 and
> that the Unallocated space on both drives jumped from ~550GB to
> 2.10TB. I sporadically checked the files and everything seems to be
> still there.
> 
> I would appreciate any help with explaining what happened and how to
> possibly fix this issue. Below I provided some information. If
> further outputs are required, please let me know.
> 
> ```
> $ btrfs --version
> btrfs-progs v5.15
   ---------------^^

https://github.com/kdave/btrfs-progs/issues/422

Try to revert progs to 5.14.x.

cheers
Holger
