Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A19478B7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 13:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbhLQMfW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 07:35:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45458 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhLQMfV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 07:35:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C123A212C1
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639744520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=HrM8eoC4lh2oubzUFr8jQvyJJq7GWL4Iwo2NFJIg2rA=;
        b=w0t+bc4zrSXmiB4RkPls5kj3mj9SJIrPlUOqZb51MbpxVMY+URvoS7X1KzKEh3XHD23Gzj
        yg3vHlm4jNCpMid4KGflzLZmrN3AeWcUZ9YUxwNAUT9xU4ftCTSQjLnbZgc6pDk7BEOhjL
        L93AA8CsRwhdrxDwudN0cMPWZ3aJ6b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639744520;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type;
        bh=HrM8eoC4lh2oubzUFr8jQvyJJq7GWL4Iwo2NFJIg2rA=;
        b=MYEIhPTuYV1rteoXaR854thItdCe61Kn43Tc+FINoMTYl6ejv0bOmQdAsAYDVBmzDlaWgi
        0S1E9yS4t++c5MDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BAA02A3B88;
        Fri, 17 Dec 2021 12:35:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 00362DA781; Fri, 17 Dec 2021 13:35:00 +0100 (CET)
Date:   Fri, 17 Dec 2021 13:35:00 +0100
From:   David Sterba <dsterba@suse.cz>
To:     linux-btrfs@vger.kernel.org
Subject: Announcement: https://btrfs.readthedocs.org is live
Message-ID: <20211217123500.GF28560@twin.jikos.cz>
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

the mission to claim the name 'btrfs' project in RTD has been successful and
the new documentation is available at https://btrfs.readthedocs.io or
https://btrfs.rtfd.io .

In the long run all the static content from wiki will be moved there, leaving
only references to keep link continuity.

Content:

- all manual pages
- feature pages
- overview page

TODO:

- references to other pages, external manual pages
- revise and move more from wiki
- pages in the TODO section

It's hosted in the btrfs-progs git, please use the issues or pull
requests for updates. I'll continue to monitor wiki for relevant changes
so they won't be lost.
