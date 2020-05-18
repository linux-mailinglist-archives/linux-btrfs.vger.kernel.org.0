Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA51D84A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgERSNA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 14:13:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730704AbgERSNA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 14:13:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3E69B28D;
        Mon, 18 May 2020 18:13:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9021DA7AD; Mon, 18 May 2020 20:12:04 +0200 (CEST)
Date:   Mon, 18 May 2020 20:12:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     robbieko <robbieko@synology.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: reduce lock contention when create snapshot
Message-ID: <20200518181204.GZ18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, robbieko <robbieko@synology.com>,
        linux-btrfs@vger.kernel.org
References: <20200514091918.30294-1-robbieko@synology.com>
 <20200518170102.GY18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518170102.GY18421@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 07:01:03PM +0200, David Sterba wrote:
> This should also speed up creating new subvolumes as they don't need any
> pre-flushing at all. Added to misc-next, thanks.

Never mind, this is not true, plain subvolumes take a different call path.
