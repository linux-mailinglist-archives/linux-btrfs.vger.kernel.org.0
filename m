Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2320DED8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jun 2020 23:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbgF2U3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jun 2020 16:29:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:34436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731827AbgF2U3s (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jun 2020 16:29:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18AFAAB76;
        Mon, 29 Jun 2020 20:29:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15815DA791; Mon, 29 Jun 2020 22:29:31 +0200 (CEST)
Date:   Mon, 29 Jun 2020 22:29:31 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v6 3/3] btrfs: refactor btrfs_check_can_nocow() into two
 variants
Message-ID: <20200629202931.GM27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>
References: <20200628051839.63142-1-wqu@suse.com>
 <20200628051839.63142-4-wqu@suse.com>
 <SN4PR0401MB359839A2E5EA48ED5D0B2E2B9B6E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <239aeeb4-df67-6a9b-d71e-8855404ad004@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <239aeeb4-df67-6a9b-d71e-8855404ad004@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 29, 2020 at 03:20:42PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/6/29 下午3:13, Johannes Thumshirn wrote:
> > On 28/06/2020 07:19, Qu Wenruo wrote:
> >> -		btrfs_drew_write_unlock(&BTRFS_I(inode)->root->snapshot_lock);
> >> +		btrfs_check_nocow_unlock(BTRF_I(inode));
> > 
> > Huhz?
> > 
> That's why there is a v7 update...

vger.kernel.org was down today, I replied that you should not have sent
v7 but rather point out the issue.
