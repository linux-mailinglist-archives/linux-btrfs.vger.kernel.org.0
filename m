Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB8EC0608
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2019 15:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfI0NKL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Sep 2019 09:10:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfI0NKL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Sep 2019 09:10:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EDC28AEB8;
        Fri, 27 Sep 2019 13:10:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EC82DA897; Fri, 27 Sep 2019 15:10:28 +0200 (CEST)
Date:   Fri, 27 Sep 2019 15:10:27 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: Remove special handing of 'dup' argument
 for btrfs
Message-ID: <20190927131027.GU2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190927105233.14926-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927105233.14926-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 27, 2019 at 01:52:32PM +0300, Nikolay Borisov wrote:
> _scratch_pool_mkfs special cases the command executed when 'dup' option
> is used when creating a filesystem. This is wrong since 'dup' works
> for all profiles and number of devices. This bug manifested while
> exercising btrfs' balance argument combinations test.

All profile combinations should be valid (mkfs, balance convert) since
4.5-ish, so

Reviewed-by: David Sterba <dsterba@suse.com>
