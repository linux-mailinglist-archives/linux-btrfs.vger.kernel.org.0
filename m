Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4051D70059
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jul 2019 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbfGVM7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jul 2019 08:59:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728619AbfGVM7M (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jul 2019 08:59:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CDCCB009;
        Mon, 22 Jul 2019 12:59:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36CA7DA882; Mon, 22 Jul 2019 14:59:46 +0200 (CEST)
Date:   Mon, 22 Jul 2019 14:59:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs-progs: Avoid unnecessary block group item
 COW if the content hasn't changed
Message-ID: <20190722125946.GQ20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, WenRuo Qu <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190708073352.6095-1-wqu@suse.com>
 <20190708073352.6095-3-wqu@suse.com>
 <ab1626ad-ccfe-e913-91e2-47e1710cfd83@suse.com>
 <3221b824-4758-81d2-edb1-9bbc2fdc0775@gmx.com>
 <5ab3dfd9-6326-a79a-49a4-66a5aacbcb9f@suse.com>
 <77bee387-5693-3cdb-cddb-130b1a118ec0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77bee387-5693-3cdb-cddb-130b1a118ec0@gmx.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 08, 2019 at 09:30:04PM +0800, Qu Wenruo wrote:
> On 2019/7/8 下午9:07, Nikolay Borisov wrote:
> > On 8.07.19 г. 15:50 ч., Qu Wenruo wrote:
> >> On 2019/7/8 下午6:43, Nikolay Borisov wrote:
> >>> On 8.07.19 г. 10:33 ч., Qu Wenruo wrote:
> > If that's the case then I'd rather see the 2nd patch dropped. It adds
> > more code for no gain.
> 
> Makes sense. I'm OK to drop it.

Ok, dropped.
