Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4595110FEA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfLCNXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 08:23:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:45214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726763AbfLCNXJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 08:23:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6919BB2D9;
        Tue,  3 Dec 2019 13:23:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F06A7DA7D9; Tue,  3 Dec 2019 14:23:02 +0100 (CET)
Date:   Tue, 3 Dec 2019 14:23:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC] GRUB: add support for RAID1C3 and RAID1C4
Message-ID: <20191203132302.GP2734@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
References: <20191202181928.3098-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202181928.3098-1-kreijack@libero.it>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 02, 2019 at 07:19:27PM +0100, Goffredo Baroncelli wrote:
> 
> The enclosed patch adds support for RAID1C3 and RAID1C4 to grub.
> I know that David already told that he want to write one; however
> recently I looked to the grub source and so I make a patch.

I sent the support patches some time ago, the were held back until the
kernel support lands. This happened in 5.5-rc1 and Daniel is about to
add the patch to grub git.

https://lists.gnu.org/archive/html/grub-devel/2019-11/msg00012.html
