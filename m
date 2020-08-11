Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC79241676
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHKGrm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 02:47:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgHKGrm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 02:47:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DF0DAD3F;
        Tue, 11 Aug 2020 06:48:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32708DAFD3; Tue, 11 Aug 2020 08:46:39 +0200 (CEST)
Date:   Tue, 11 Aug 2020 08:46:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: fix NULL pointer dereference at
 btrfs_sysfs_del_qgroups()
Message-ID: <20200811064638.GH2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200803062011.17291-1-wqu@suse.com>
 <20200810170255.GF2026@twin.jikos.cz>
 <5a2bbe37-ddb4-ccd3-8d43-49bdb9697777@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2bbe37-ddb4-ccd3-8d43-49bdb9697777@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 10:06:31AM +0800, Qu Wenruo wrote:
> > Added to misc-next, thanks.

> Just to add a note, kobject guys are going to restore the NULL-awareness
> behavior, so the patch here is just to be extra safe.

We have the additional pointer checks in other locations too, so adding
it here is fine.
