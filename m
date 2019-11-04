Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56A8EE171
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 14:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfKDNkb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 08:40:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:58178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbfKDNkb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 08:40:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FCFAB3D3;
        Mon,  4 Nov 2019 13:40:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1752ADA818; Mon,  4 Nov 2019 14:40:37 +0100 (CET)
Date:   Mon, 4 Nov 2019 14:40:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] RAID1 with 3- and 4- copies
Message-ID: <20191104134036.GX3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        Neal Gompa <ngompa13@gmail.com>, David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cover.1572534591.git.dsterba@suse.com>
 <CAEg-Je_oNz5BtpRAF3fzfX1G-Dhh7yjpshyy47NwLaREWv0wBQ@mail.gmail.com>
 <20191101150908.GU3001@twin.jikos.cz>
 <6e3f215f-e3e1-c7f9-c5dc-b89762ef6886@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e3f215f-e3e1-c7f9-c5dc-b89762ef6886@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 03, 2019 at 01:35:34AM +0100, waxhead wrote:
> Would GRUB be able to boot from RAID1c34 by treating it as "regular" 
> RAID1?! If not I think a warning could be useful.

Currently grub will refuse to boot from that with 'unknown profile'
message. Adding the support seems to be fairly easi, I'll send the
patches.
