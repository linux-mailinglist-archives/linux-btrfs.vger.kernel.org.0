Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD9132A14
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 16:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgAGPdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 10:33:23 -0500
Received: from mail.itouring.de ([188.40.134.68]:38392 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgAGPdX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 10:33:23 -0500
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 10:33:22 EST
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id 073BB41603A0;
        Tue,  7 Jan 2020 16:25:32 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id B4C0FF01600;
        Tue,  7 Jan 2020 16:25:31 +0100 (CET)
Subject: Re: [PATCH v2 2/2] btrfs: sysfs, add read_policy attribute
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <a3e99d85-80c5-5ad3-cda3-75834e1f7441@toxicpanda.com>
 <1578372741-21586-1-git-send-email-anand.jain@oracle.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <b39e2e18-4116-f77b-df59-d39aa006ea93@applied-asynchrony.com>
Date:   Tue, 7 Jan 2020 16:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1578372741-21586-1-git-send-email-anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/7/20 5:52 AM, Anand Jain wrote:
> Add
> 
>   /sys/fs/btrfs/UUID/read_policy
> 
> attribute so that the read policy for the raid1 and raid10 chunks can be
> tuned.
> 
> When this attribute is read, it shall show all available policies, and
> the active policy is with in [ ], read_policy attribute can be written
> using one of the items showed in the read.
> 
> For example:
> cat /sys/fs/btrfs/UUID/read_policy
> [by_pid]
> echo by_pid > /sys/fs/btrfs/UUID/read_policy
> echo -n by_pid > /sys/fs/btrfs/UUID/read_policy

This may seem like pointless bikeshedding, but can we please name the policy
without the leading "by_", i.e. only "pid"? By definition what happens is always
"by" the chosen policy, so it's redundant.

Otherwise a great step forward, thank you!

cheers
Holger
