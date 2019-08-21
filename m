Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0A97BE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 16:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfHUOCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 10:02:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUOCd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 10:02:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BB16DAF78;
        Wed, 21 Aug 2019 14:02:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BE623DA7DB; Wed, 21 Aug 2019 16:02:58 +0200 (CEST)
Date:   Wed, 21 Aug 2019 16:02:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: dev stat drop useless goto
Message-ID: <20190821140257.GG18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20190821092634.6778-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821092634.6778-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 05:26:32PM +0800, Anand Jain wrote:
> In the function btrfs_init_dev_stats() goto out is not needed, because the
> alloc has failed. So just return -ENOMEM.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I'll add 1 and 2 to misc-next, 3 seems to be buggy.
