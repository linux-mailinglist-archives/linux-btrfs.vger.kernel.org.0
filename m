Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B6D1187EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 13:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJMUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 07:20:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:42790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbfLJMUF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 07:20:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C871DB042;
        Tue, 10 Dec 2019 12:20:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B46EFDA7A1; Tue, 10 Dec 2019 13:19:55 +0100 (CET)
Date:   Tue, 10 Dec 2019 13:19:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sebastian <sebastian.scherbel@fau.de>
Cc:     dsterba@suse.com, josef@toxicpanda.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@i4.cs.fau.de
Subject: Re: [PATCH 0/5] btrfs: code cleanup
Message-ID: <20191210121955.GT2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sebastian <sebastian.scherbel@fau.de>,
        dsterba@suse.com, josef@toxicpanda.com, clm@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@i4.cs.fau.de
References: <20191210071357.5323-1-sebastian.scherbel@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210071357.5323-1-sebastian.scherbel@fau.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 10, 2019 at 08:13:52AM +0100, Sebastian wrote:
> From: Sebastian Scherbel <sebastian.scherbel@fau.de>
> 
> This patch series changes several instances in btrfs where the coding style
> is not in line with the Linux kernel guidelines to improve readability.

Please don't do that. This has happened enough times that we have a FAQ
entry about that and I can recommend reading the whole section, from
which I quote the first part:

https://btrfs.wiki.kernel.org/index.php/Developer%27s_FAQ#How_not_to_start

"It might be tempting to look for coding style violations and send
patches to fix them. This happens from time to time and the community
does not welcome that. [...]"
