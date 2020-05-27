Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4951E42E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 15:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgE0NFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 09:05:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730142AbgE0NFR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 09:05:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C796AD5D;
        Wed, 27 May 2020 13:05:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D16E2DA72D; Wed, 27 May 2020 15:04:18 +0200 (CEST)
Date:   Wed, 27 May 2020 15:04:18 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Open code key_search
Message-ID: <20200527130418.GB18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200527101053.7340-1-nborisov@suse.com>
 <SN4PR0401MB3598A1745DF9F32092AFD2269BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d8b4ec4c-2741-f677-2667-61a249d37fc4@suse.com>
 <SN4PR0401MB35980C66F84370D7BD778A919BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB35980C66F84370D7BD778A919BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 27, 2020 at 12:39:01PM +0000, Johannes Thumshirn wrote:
> On 27/05/2020 14:36, Nikolay Borisov wrote:
> > True, AFAIK David is not a fan of multiple assignments on the same line ;)
> 
> Yes I remember him saying something like this.

I can point you to the kernel coding style any number of times:

https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation

"Don’t put multiple assignments on a single line either. Kernel coding
 style is super simple. Avoid tricky expressions."
