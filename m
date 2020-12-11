Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0982D7C0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Dec 2020 18:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393299AbgLKRDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Dec 2020 12:03:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:42290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405125AbgLKRDA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:03:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C42B8ADCD;
        Fri, 11 Dec 2020 17:02:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 77B0CDA7C8; Fri, 11 Dec 2020 18:00:42 +0100 (CET)
Date:   Fri, 11 Dec 2020 18:00:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: fix invalid size check for extent items
Message-ID: <20201211170041.GN6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <c85b0bbcfff13bafec48f8cd266fb73b345c43c3.1605820453.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85b0bbcfff13bafec48f8cd266fb73b345c43c3.1605820453.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 19, 2020 at 04:14:20PM -0500, Josef Bacik wrote:
> While trying to run down a corruption problem I needed to use
> btrfs-image to generate known good states in between tests.  At some
> point this started failing with
> 
> either extent tree is corrupted or deprecated extent ref format
> 
> This is because the fs had an extent item that was large enough that it
> no longer had inline extent references, they were all keyed extent
> references.  The check is bogus, we can have extent items that are >=
> the extent item size, not just > than the extent item size.  Fix the
> check so that we can generate metadata dumps properly.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to devel, thanks.
