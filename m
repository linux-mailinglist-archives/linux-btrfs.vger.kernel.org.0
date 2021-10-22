Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE284378D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhJVOOs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 10:14:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57190 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhJVOOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 10:14:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E04A421639
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634911949;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=KpTMmDao7HKkNaJmMq5aGP24S7L/d7zdenaHQYJeX8g=;
        b=E4MaUNDmaJW0mZtosEhdtc44GPA1RwgmVeQ/SWbw0qRRHXrIY9s0cRLTyjjy9uCG5oR9lT
        1gVuBNibv4JH7qWjfDz46ou6hdk+6zMBAx71MoMCuFsOuYdULoTYk32yRzVFQVTTaRK9g+
        GNwBY01CA/6hsG1yBW7JowCA9UUvbkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634911949;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=KpTMmDao7HKkNaJmMq5aGP24S7L/d7zdenaHQYJeX8g=;
        b=R8SBvI5rDJTs95u/7azljUPa/huHfUP+eNRAMZRsTWef3At3yXUjoH9qNJ1c562LUTCf3c
        WXb9/2tmkuJdXwBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DACA3A3B81;
        Fri, 22 Oct 2021 14:12:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9BD69DA7A9; Fri, 22 Oct 2021 16:12:00 +0200 (CEST)
Date:   Fri, 22 Oct 2021 16:12:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs.wiki.k.org and git-based update workflow
Message-ID: <20211022141200.GK20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'd like to change the way wiki contents is going to be updated, and
would like to get some feedback eventually.

Current status is quite unpleasant, the number of active editors is 1
(me), with other occasional contributions. I somehow feel that the wiki
concept as community editing does not work, specifically for our wiki,
or maybe in general, anymore.

I don't intend to remove the wiki, it's been linked from various places
and people are probably used to looking up the info there. What I'd like
to change is how the updates appear there.

I think the first hurdle is the separate registration. There's 1 new
account request per two weeks, but no actual edits following.

In addition to direct wiki edits, I'd like to provide a git based
workflow, on github. A separate repository would be clean but IMHO
harder to discover, so the idea is to reuse btrfs-progs for that purpose.

Selected pages from wiki will be "locked", with a disclaimer that they
need to be edited via git. Then in btrfs-progs/Documentation will be the
raw mediawiki source file. Edit this and send a pull request. I'll do
the sync to wiki periodically.

The manual pages are now synced like that, so this would allow us to
also use the asciidoc format as source.

For me personally using a local editor for writing documentation is much
more comfortable than the browser textarea. If this would motivate
someone else to contribute too, it's worth it.

(Other option researched: readthedocs.com, git-based but it has a
different structure than wiki and is on another site.)

d.
