Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFCB3D24F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhGVNRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 09:17:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50616 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhGVNRD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 09:17:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 757532265E;
        Thu, 22 Jul 2021 13:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626962257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eklFVti9ar6Z3tWnJTDuW2sdBTF3JXvd/wsUPMKt4Lk=;
        b=Y5FCmeMJMuh/CNCsphqP4YuNspNPtA5PCrVx3fF3f1koVUcL75a2wxrUCA6EkosLkaUA6W
        lR8KD/Jkr/Cac/1jZMrq52UlVXevnfDD+JxVb6KhSzCz9coMtTcKQTsJcZmIBtzFTuYH1+
        GEYfYxzFd6v++n+uLFwVmH2icuM1GHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626962257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eklFVti9ar6Z3tWnJTDuW2sdBTF3JXvd/wsUPMKt4Lk=;
        b=XuvF496jumDx4VbGTFcFMHgiCFHsmgmR2KrXP+eI26qPqZD0BzmkB6+WftYV3YBceCyQ9b
        tU/cK3DuEcZSKEAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 56691A48A9;
        Thu, 22 Jul 2021 13:57:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5531DAF95; Thu, 22 Jul 2021 15:54:55 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:54:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: Maybe we want to maintain a bad driver list? (Was 'Re: "bad tree
 block start, want 419774464 have 0" after a clean shutdown, could it be a
 disk firmware issue?')
Message-ID: <20210722135455.GU19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jorge Bastos <jorge.mrbastos@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <CAHzMYBT+pMxrnDXrbTJqP-ZrPN5iDHEsW_nSjjD3R_w3wq5ZLg@mail.gmail.com>
 <20210721174433.GO19710@twin.jikos.cz>
 <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b830dc8-11d4-9b21-abe4-5f44e6baa013@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 08:18:21AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/22 上午1:44, David Sterba wrote:
> > On Fri, Jul 16, 2021 at 11:44:21PM +0100, Jorge Bastos wrote:
> >> Hi,
> >>
> >> This was a single disk filesystem, DUP metadata, and this week it stop
> >> mounting out of the blue, the data is not a concern since I have a
> >> full fs snapshot in another server, just curious why this happened, I
> >> remember reading that some WD disks have firmware with write caches
> >> issues, and I believe this disk is affected:
> >>
> >> Model family:Western Digital Green
> >> Device model:WDC WD20EZRX-00D8PB0
> >> Firmware version:80.00A80
> >
> > For the record summing up the discussion from IRC with Zygo, this
> > particular firmware 80.00A80 on WD Green is known to have problematic
> > firmware and would explain the observed errors.
> >
> > Recommendation is not to use WD Green or periodically disable the write
> > cache by 'hdparm -W0'.
> 
> Zygo is always the god to expose bad hardware.
> 
> Can we maintain a list of known bad hardware inside btrfs-wiki?
> And maybe escalate it to other fses too?

Yeah a list on wiki would be great, though I'm a bit skeptical about
keeping it up up to date, there are very few active wiki editors, the
knowledge is still mostly stored in the IRC logs. But without a landing
page on wiki we can't even start, so I'll create it.
