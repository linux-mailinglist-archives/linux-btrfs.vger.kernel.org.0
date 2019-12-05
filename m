Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E311141DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfLENp7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 08:45:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:34714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729165AbfLENp6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 08:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 616C0B0A5;
        Thu,  5 Dec 2019 13:45:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3671EDA733; Thu,  5 Dec 2019 14:45:52 +0100 (CET)
Date:   Thu, 5 Dec 2019 14:45:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     dsterba@suse.cz, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: fix cloning range with a hole when using the
 NO_HOLES feature
Message-ID: <20191205134551.GN2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20191119120732.24729-1-fdmanana@kernel.org>
 <20191125134621.GC2734@twin.jikos.cz>
 <CAL3q7H4OK9nXTi9B5MOo59+AD0e_=OdiiV-YRZU2fV6ZO8p48Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4OK9nXTi9B5MOo59+AD0e_=OdiiV-YRZU2fV6ZO8p48Q@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 11:22:57AM +0000, Filipe Manana wrote:
> On Mon, Nov 25, 2019 at 1:46 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Nov 19, 2019 at 12:07:32PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > [...]
> >
> > Added to misc-next, thanks.
> 
> I have an updated version for this. Do you prefer me to send a new
> patch version, an incremental full patch or just the diff and then
> fold it?

I think sending v2 of the patch is easier for you. Thanks.
