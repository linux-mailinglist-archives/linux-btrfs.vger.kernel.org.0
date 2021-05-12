Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0256837EF8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhELXNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 19:13:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238856AbhELWH7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 18:07:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C4C84AE6D;
        Wed, 12 May 2021 22:06:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C96A4DA919; Thu, 13 May 2021 00:04:13 +0200 (CEST)
Date:   Thu, 13 May 2021 00:04:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [Patch v2 39/42] btrfs: reject raid5/6 fs for subpage
Message-ID: <20210512220413.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-40-wqu@suse.com>
 <CAEg-Je-Q4FfbjipyxZnHVrhyzx9kp_gv=s3Cb1v3q0LkRevqvQ@mail.gmail.com>
 <fb5fed4f-0ca0-075a-5faa-3a36fd902410@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb5fed4f-0ca0-075a-5faa-3a36fd902410@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 07:11:31AM +0800, Qu Wenruo wrote:
> > Couldn't this be restricted to ro-only safely?
> 
> I'm not confident, as there are too many BUG_ON()s related to PAGE_SIZE.

In such cases I think the approach we take is to make the initial
version more restricted and then revise the usecases and allow more
eventually. The other way around is harder, once people start using it
for some usecase it takes time and mails and explaining why it won't
work.

Read only support sounds useful but I won't insist to make it work, it's
nice to have once the basic subpage support is complete. 
