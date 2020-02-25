Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E516EBB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 17:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgBYQt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Feb 2020 11:49:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:43810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgBYQt7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Feb 2020 11:49:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DAB1DAF05;
        Tue, 25 Feb 2020 16:49:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C956DDA726; Tue, 25 Feb 2020 17:49:38 +0100 (CET)
Date:   Tue, 25 Feb 2020 17:49:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: Remove the unnecesaary spin lock
 for qgroup_rescan_running|queued
Message-ID: <20200225164938.GH2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <20200207053821.25643-1-wqu@suse.com>
 <20200207053821.25643-3-wqu@suse.com>
 <20200224164541.GY2902@twin.jikos.cz>
 <e797ac40-e5a2-b1a1-90f2-756c0b1fd67a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e797ac40-e5a2-b1a1-90f2-756c0b1fd67a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 25, 2020 at 07:44:12AM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/2/25 上午12:45, David Sterba wrote:
> > On Fri, Feb 07, 2020 at 01:38:21PM +0800, Qu Wenruo wrote:
> >> Those two members are all protected by
> >> btrfs_fs_info::qgroup_rescan_lock, thus no need for the extra spinlock.
> > 
> > Two members refers to btrfs_fs_info::qgroup_rescan_lock and what else?
> > Byt the subject it's something 'queued' but I can't find what it's
> > referring to.
> > 
> My bad, with the latest version, there is only qgroup_rescan_running, no
> qgroup_rescan_queued.
> 
> Just one member now.
> 
> Do I need to resend the patch with commit message updated?

Not needed, I only wanted to clarify if I'm not missing something. I'll
update changelog and push to misc-next.
