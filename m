Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AA235CF7
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 14:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfFEMgR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 08:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727663AbfFEMgR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 08:36:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC252AC24
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jun 2019 12:36:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C869DA843; Wed,  5 Jun 2019 14:37:07 +0200 (CEST)
Date:   Wed, 5 Jun 2019 14:37:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: Introduce struct btrfs_io_geometry
Message-ID: <20190605123707.GA15290@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190603090505.16800-1-nborisov@suse.com>
 <20190603090505.16800-2-nborisov@suse.com>
 <20190605073532.GA27972@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605073532.GA27972@x250>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 05, 2019 at 09:35:33AM +0200, Johannes Thumshirn wrote:
> I'd merge this patch into the next one, so you only introduce
> btrfs_io_geometry when there are actual users for it.
> 
> But that's personal preference I guess.

Yeah 1+2 is a good idea, I'll to that.
