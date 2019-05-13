Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954151B66E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbfEMMxo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 08:53:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:40780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727462AbfEMMxn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 08:53:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD0F5AF81
        for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2019 12:53:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73DE6DB1F8; Mon, 13 May 2019 14:54:38 +0200 (CEST)
Date:   Mon, 13 May 2019 14:54:38 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 17/17] btrfs: add sha256 as another checksum algorithm
Message-ID: <20190513125437.GA20156@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-18-jthumshirn@suse.de>
 <e529d2ee-566c-d9f6-d7ed-77616fee2955@suse.com>
 <20190513071114.GC12653@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513071114.GC12653@x250>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 09:11:14AM +0200, Johannes Thumshirn wrote:
> On Fri, May 10, 2019 at 03:30:36PM +0300, Nikolay Borisov wrote:
> [...]
> > 
> > nit: Might be a good idea to turn that into an enum for self-documenting
> > purposes. Perhaps in a different patch.
> 
> Thought about this as well, but I thought I remembered a patch series from
> David where he turned everything not being an on-disk format to enums.
> 
> This discuraged me from actually doing the switch. I'd be more than happy if I
> could just use an enum.

Enum is fine, but named constants that are part of on-disk format should
be spell the exact value, ie. not relying on the auto-increment of enum
values.
