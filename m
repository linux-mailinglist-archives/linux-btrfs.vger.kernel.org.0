Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD71CDAB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgEKND3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 09:03:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:39504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKND3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 09:03:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCDC6B02A;
        Mon, 11 May 2020 13:03:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C7740DA823; Mon, 11 May 2020 15:02:37 +0200 (CEST)
Date:   Mon, 11 May 2020 15:02:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/19] btrfs: drop eb parameter from set/get token helpers
Message-ID: <20200511130237.GP18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1588853772.git.dsterba@suse.com>
 <b8b135176911726d988ea5f686b93fbd351e47e2.1588853772.git.dsterba@suse.com>
 <SN4PR0401MB3598EFE7FF6F223E36404FA19BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598EFE7FF6F223E36404FA19BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 08, 2020 at 12:09:15PM +0000, Johannes Thumshirn wrote:
> On 07/05/2020 22:20, David Sterba wrote:
> > +		push_space = push_space - btrfs_token_item_size(&token, item);
> 
> Nit: push_space -= btrfs_token_item_size(&token, item);

Yeah it could be done that way but I'd rather avoid mixing such small
fixups to a patch that's otherwise a mechanical change.
