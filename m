Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7484E329320
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 22:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhCAVCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 16:02:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243685AbhCAVAW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 16:00:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFC90AAC5;
        Mon,  1 Mar 2021 20:59:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 19388DA7AA; Mon,  1 Mar 2021 21:57:47 +0100 (CET)
Date:   Mon, 1 Mar 2021 21:57:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: add seeding device section for
 btrfs-man5
Message-ID: <20210301205746.GE7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20210214171738.23919-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214171738.23919-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 14, 2021 at 05:17:38PM +0000, Sidong Yang wrote:
> This patch adds a section about seeding device for btrfs-man5.
> Description and examples are from btrfs-wiki page.

Sorry, but the contents of the wiki page are useless as documentation.
There's no explanation of the usecase just a bunch of commands.
Meanwhile I've written something that I consider good enough for
documenation, it's now in devel. Feel free to proofread it and enhance
with additional updates or examples if you think they're missing.
