Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB0610B427
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK0RK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 12:10:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0RK6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 12:10:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 343E7AAF1;
        Wed, 27 Nov 2019 17:10:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 31748DA733; Wed, 27 Nov 2019 18:10:55 +0100 (CET)
Date:   Wed, 27 Nov 2019 18:10:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: mkfs: Make no-holes as default mkfs incompat
 features
Message-ID: <20191127171054.GX2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191111065004.24705-1-wqu@suse.com>
 <20191111180256.GR3001@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111180256.GR3001@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 07:02:56PM +0100, David Sterba wrote:
> Making it default in progs release 5.4 is IMO doable, there are probably
> 2-3 weeks before the release, but this task needs one or more persons
> willing to do the above.

For the record, defaults for mkfs will not change in 5.4.
