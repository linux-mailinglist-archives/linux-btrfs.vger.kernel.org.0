Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B462442850
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407100AbfFLOCC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:37366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392019AbfFLOCC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:02:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3459BAFDD;
        Wed, 12 Jun 2019 14:02:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C02DEDA88C; Wed, 12 Jun 2019 16:02:51 +0200 (CEST)
Date:   Wed, 12 Jun 2019 16:02:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: correctly validate compression type
Message-ID: <20190612140251.GK3563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20190606100715.14429-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606100715.14429-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 06, 2019 at 12:07:15PM +0200, Johannes Thumshirn wrote:
> Nikolay reported the following KASAN splat when running btrfs/048:
> 
> Fixes: 272e5326c783 ("btrfs: prop: fix vanished compression property after failed set")
> Reported-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Added to misc-next, thanks.
