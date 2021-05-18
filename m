Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39B38819E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbhERUut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 16:50:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238356AbhERUut (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 16:50:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F4ABAFD5;
        Tue, 18 May 2021 20:49:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AE92DB228; Tue, 18 May 2021 22:46:56 +0200 (CEST)
Date:   Tue, 18 May 2021 22:46:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210518204655.GT7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <1e90eb63-60a1-63b4-8e26-121e8bda1ba2@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e90eb63-60a1-63b4-8e26-121e8bda1ba2@applied-asynchrony.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 18, 2021 at 06:52:50PM +0200, Holger Hoffstätte wrote:
> On 2021-05-18 16:49, David Sterba wrote:
> > Add sysfs interface to limit io during scrub. We relied on the ionice
> > - raw value is in bytes
> 
> ..for this to be in megabytes only (maybe also renaming scrub_speed_max to
> scrub_speed_max_mb?), because otherwise everyone will forget the unit and wonder
> why scrub is running with 50 bytes/sec. IMHO bytes/kbytes are not really practical
> scrub speeds.

The granularity is 128K and it's implemented to check if the io is over
the quota, so if it's 50 b/sec it'll become 128 K/sec.

Regarding the units, Zygo mentioned usecase when the limit was set to
~100K/s while the system was booting and then lifted as needed so it
would be at least kilobytes.

I understand the concerns about units, it's not consistent among sysfs
files, at least there's convention to use "_kb" suffix, but not
consistent. My idea is that the suffix when specified is user friendly
enough and allows to nicely specify wide range of numbers without extra
multiplication when the unit is fixed. Eg. 'echo 500K', 'echo 5M' or
even 'echo 1G' looks obvious, but typos can happen when it's KB and it
becomes 50000 instead of 500000.

> Other than that have a:
> 
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Thanks!
