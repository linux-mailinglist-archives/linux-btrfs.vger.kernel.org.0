Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B965C1EA6EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgFAPex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:34:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:33426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAPex (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:34:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 28797B1EF;
        Mon,  1 Jun 2020 15:34:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1D5EDA79B; Mon,  1 Jun 2020 17:34:49 +0200 (CEST)
Date:   Mon, 1 Jun 2020 17:34:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 1/3] btrfs: remove pointless out label in
 find_first_block_group
Message-ID: <20200601153449.GY18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
 <20200527081227.3408-2-johannes.thumshirn@wdc.com>
 <20200527130627.GC18421@twin.jikos.cz>
 <SN4PR0401MB3598E23D6533D813874F4E3C9BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598E23D6533D813874F4E3C9BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 01:45:47PM +0000, Johannes Thumshirn wrote:
> On 27/05/2020 15:07, David Sterba wrote:
> > On Wed, May 27, 2020 at 05:12:25PM +0900, Johannes Thumshirn wrote:
> >> The 'out' label in find_first_block_group() does not do anything in terms
> >> of cleanup.
> >>
> >> It is better to directly return 'ret' instead of jumping to out to not
> >> confuse readers. Additionally there is no need to initialize ret with 0.
> > 
> > https://www.kernel.org/doc/html/latest/process/coding-style.html#centralized-exiting-of-functions
> > 
> 
> To cite the Link you posted:
> 
> "The goto statement comes in handy when a function exits from multiple 
> locations and some common work such as cleanup has to be done. If there 
> is no cleanup needed then just return directly."

The preference in btrfs code has been to avoid returns from the middle
of while loops. The kernel coding style does not cover everything, we've
settled on some style in btrfs and that's what I'm arguing for and
fixing up in many patches so it's consistent.
