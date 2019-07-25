Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915AC752F0
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfGYPjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 11:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728392AbfGYPjK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 11:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B6C0AE44;
        Thu, 25 Jul 2019 15:39:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3D2F0DA7DE; Thu, 25 Jul 2019 17:39:46 +0200 (CEST)
Date:   Thu, 25 Jul 2019 17:39:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use common vfs LABEL ioctl definitions
Message-ID: <20190725153946.GT2868@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eric Sandeen <sandeen@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6e074252-3d02-9436-0ae9-a6e034acda43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e074252-3d02-9436-0ae9-a6e034acda43@redhat.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 17, 2019 at 12:39:20PM -0500, Eric Sandeen wrote:
> I lifted the btrfs label get/set ioctls to the vfs some time ago, but
> never followed up to use those common definitions directly in btrfs.
> 
> This patch does that.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Added to misc-next, thanks.
