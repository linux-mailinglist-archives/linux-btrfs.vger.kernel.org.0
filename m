Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F651CE989
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 02:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgELAMj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 11 May 2020 20:12:39 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:46670 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgELAMj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 20:12:39 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id DC42F6BBDFB; Mon, 11 May 2020 20:12:37 -0400 (EDT)
Date:   Mon, 11 May 2020 20:12:37 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Phil Karn <karn@ka9q.net>
Cc:     Alberto Bursi <bobafetthotmail@gmail.com>,
        Steven Fosdick <stevenfosdick@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Rich Rauenzahn <rrauenza@gmail.com>
Subject: Re: Western Digital Red's SMR and btrfs?
Message-ID: <20200512001237.GU10769@hungrycats.org>
References: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
 <20200504230857.GQ10769@hungrycats.org>
 <f7ae0b64-048d-3898-6e2d-5702e2f79f47@ka9q.net>
 <CAG_8rEcdEK4XAx4D3Xg=O38zfs85YNk-xhT_cVtqZybnKXBkQg@mail.gmail.com>
 <20200511050635.GT10769@hungrycats.org>
 <bb237d74-49ab-27e0-0286-5bdd880dd2cb@ka9q.net>
 <69847faf-5fb3-9eac-b819-373a0f814044@gmail.com>
 <9bbad15c-1bd1-e91a-ae50-bb1e643c19e2@ka9q.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9bbad15c-1bd1-e91a-ae50-bb1e643c19e2@ka9q.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 11, 2020 at 03:42:44PM -0700, Phil Karn wrote:
> On 5/11/20 14:13, Alberto Bursi wrote:
> >
> > Afaik drive-managed SMR drives (i.e. all drives that disguise
> > themselves as non-SMR) are acting like a SSD, writing in empty "zones"
> > first and then running garbage collection later to consolidate the
> > data. TRIM is used for the same reasons SSDs also use it.
> > This is the way they are working around the performance penalty of
> > SMR, as it's the same limitation NAND flash also has (you can write
> > only a full cell at a time).
> >
> > See here for example
> > https://support-en.wd.com/app/answers/detail/a_id/25185
> >
> > -Alberto
> 
> Right, I understand that (some?) SMR drives support TRIM for the same
> reason that SSDs do (well, a very similar reason). My question was
> whether there'd be any reason for a NON-SMR drive to support TRIM, or if
> TRIM support necessarily implies shingled recording. I didn't know
> shingled recording was in any general purpose 2.5" spinning laptop
> drives like mine, and there's no mention of SMR in the HGST manual.

According to

	https://hddscan.com/blog/2020/hdd-wd-smr.html

2.5" SMR drives appeared in 2016.

> Phil
> 
> 
> 
