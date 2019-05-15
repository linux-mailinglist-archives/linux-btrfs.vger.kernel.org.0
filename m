Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8511F686
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2019 16:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEOO2M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 10:28:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:47776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726911AbfEOO2M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 10:28:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F9F8AFBD;
        Wed, 15 May 2019 14:28:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A78EADA8A7; Wed, 15 May 2019 16:29:11 +0200 (CEST)
Date:   Wed, 15 May 2019 16:29:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: scan: pass blkid_get_cache error code
Message-ID: <20190515142911.GT3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <1553838594-26013-1-git-send-email-anand.jain@oracle.com>
 <1553838594-26013-2-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553838594-26013-2-git-send-email-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 29, 2019 at 01:49:54PM +0800, Anand Jain wrote:
> blkid_get_cache() returns error code which is -errno. So we can use them
> directly.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Ref:
> blkid_get_cache() code:
> https://github.com/karelzak/util-linux/blob/master/libblkid/src/cache.c#L93
> https://github.com/karelzak/util-linux/blob/master/libblkid/src/blkidP.h#L307

This is internal header of blkid and incidentally the error numbers
match errnos, but I don't think we should rely on that. Does blkid have
a function that translates the code to string, similar to strerror?
