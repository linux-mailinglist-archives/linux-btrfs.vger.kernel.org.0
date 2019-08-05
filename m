Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688AC82426
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHERnh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 13:43:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbfHERnh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 13:43:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A288EB034
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 17:43:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 29AF1DABC7; Mon,  5 Aug 2019 19:44:09 +0200 (CEST)
Date:   Mon, 5 Aug 2019 19:44:09 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] Sysfs updates
Message-ID: <20190805174408.GC28208@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1564505777.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1564505777.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 30, 2019 at 07:10:07PM +0200, David Sterba wrote:
> Export the potential debugging data in the per-filesystem directories we
> already have, so we can drop debugfs. The new directories depend on
> CONFIG_BTRFS_DEBUG so they're not affecting normal builds.
> 
> David Sterba (2):
>   btrfs: sysfs: add debugging exports
>   btrfs: delete debugfs code

Pushed to misc-next.
