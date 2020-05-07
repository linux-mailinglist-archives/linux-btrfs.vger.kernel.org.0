Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AE11C9CD3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgEGU6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:58:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgEGU6O (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:58:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D22FFB272;
        Thu,  7 May 2020 20:58:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 456BADA732; Thu,  7 May 2020 22:57:24 +0200 (CEST)
Date:   Thu, 7 May 2020 22:57:24 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're
 inherting snapshot to a new qgroup
Message-ID: <20200507205724.GN18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200402063735.32808-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402063735.32808-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 02, 2020 at 02:37:35PM +0800, Qu Wenruo wrote:
> Anyway, user shouldn't use qgroup inheritance during snapshot creation,
> and should add qgroup relationship after snapshot creation by 'btrfs
> qgroup assign', which has a much better UI to inform user about qgroup
> inconsistent and kick in rescan automatically.

If users shouldn't do something, there needs to be a documentation,
warning and deprecation of the interface at least. If it's there,
somebody will use it.

I'll apply the patch despite the qgroup_flags concerns as it's not
critical.
