Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200DD387E1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351004AbhERRCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 13:02:44 -0400
Received: from mail.itouring.de ([85.10.202.141]:58398 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232496AbhERRCn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 13:02:43 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 May 2021 13:02:43 EDT
Received: from tux.applied-asynchrony.com (p5b07e8e5.dip0.t-ipconnect.de [91.7.232.229])
        by mail.itouring.de (Postfix) with ESMTPSA id E9FF3E0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 18:52:50 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 98326F01600
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 18:52:50 +0200 (CEST)
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
To:     linux-btrfs@vger.kernel.org
References: <20210518144935.15835-1-dsterba@suse.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <1e90eb63-60a1-63b4-8e26-121e8bda1ba2@applied-asynchrony.com>
Date:   Tue, 18 May 2021 18:52:50 +0200
MIME-Version: 1.0
In-Reply-To: <20210518144935.15835-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-05-18 16:49, David Sterba wrote:
> Add sysfs interface to limit io during scrub. We relied on the ionice

This is very useful, thank you! Running scrubs on three devices with
10M/20M/30M bandwidth limit showed up in iotop/nmon exactly as expected,
and dynamically changing the values to speed up/slow down also worked
right away - very nice.

My only suggestion would be:

> - raw value is in bytes

..for this to be in megabytes only (maybe also renaming scrub_speed_max to
scrub_speed_max_mb?), because otherwise everyone will forget the unit and wonder
why scrub is running with 50 bytes/sec. IMHO bytes/kbytes are not really practical
scrub speeds. Other than that have a:

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

cheers,
Holger
