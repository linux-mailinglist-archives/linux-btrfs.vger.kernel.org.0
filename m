Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3359223D8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbfETQdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 12:33:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:53120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388890AbfETQdB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 12:33:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E5A3AED4;
        Mon, 20 May 2019 16:33:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5753DA86E; Mon, 20 May 2019 18:33:57 +0200 (CEST)
Date:   Mon, 20 May 2019 18:33:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: 5.1.3: unable to handle kernel NULL pointer dereference in
 btrfs_reloc_pre_snapshot
Message-ID: <20190520163356.GF3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20190518230330.GK20359@hungrycats.org>
 <CAL3q7H5veRD4gNV19L_7ZQAzK_zWpSRZ_-9M8U1mzECcmCRNww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5veRD4gNV19L_7ZQAzK_zWpSRZ_-9M8U1mzECcmCRNww@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, May 19, 2019 at 11:25:19AM +0100, Filipe Manana wrote:
> On Sun, May 19, 2019 at 12:50 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >         [ 6232.433929][ T4605] RIP: 0010:btrfs_reloc_pre_snapshot+0x24/0x50
> 
> Known problem, should be fixed by:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10995c0491204c861948c9850939a7f4e90760a4
> 
> Which is not on 5.1.x (at least yet).

Thanks for the pointer, I'll forward the fix to stable as the patch did
not have the tags for some reason.
