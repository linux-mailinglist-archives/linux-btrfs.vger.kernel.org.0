Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006302DB215
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgLORBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 12:01:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:36418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbgLORBR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 12:01:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1AF5AC7F;
        Tue, 15 Dec 2020 17:00:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 97C10DA7C3; Tue, 15 Dec 2020 17:58:57 +0100 (CET)
Date:   Tue, 15 Dec 2020 17:58:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/6] btrfs: Remove useless ASSERTS
Message-ID: <20201215165857.GX6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20201207153237.1073887-1-nborisov@suse.com>
 <20201207153237.1073887-4-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207153237.1073887-4-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 07, 2020 at 05:32:34PM +0200, Nikolay Borisov wrote:
> The invariants the asserts are checking are already verified by the
> tree checker, just remove them.

I haven't found where exactly does tree-checker verify the invariant and
also think that we can safely leave the asserts there. Even if it's for
a normally impossible case, assertions usually catch bugs after changing
some other code.
