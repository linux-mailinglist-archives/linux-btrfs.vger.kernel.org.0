Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8116C1BA4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2019 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfEMPof (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 May 2019 11:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:51690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfEMPoe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 May 2019 11:44:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68E4DAC4E;
        Mon, 13 May 2019 15:44:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7A61FDA851; Mon, 13 May 2019 17:45:34 +0200 (CEST)
Date:   Mon, 13 May 2019 17:45:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] Btrfs: prevent send failures and crashes due to
 concurrent relocation
Message-ID: <20190513154534.GC3138@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20190422154409.16323-1-fdmanana@kernel.org>
 <CAL3q7H4nrAJSwXoX9c5LX2oFb-CFdHQ-enMON3ZqgNWoRqP33g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4nrAJSwXoX9c5LX2oFb-CFdHQ-enMON3ZqgNWoRqP33g@mail.gmail.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 13, 2019 at 03:04:13PM +0100, Filipe Manana wrote:
> David, are you picking this for this merge window or have any other plans?

Post-merge window, with the other fixes.
