Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FFA2B8558
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKRULO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 15:11:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:40936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKRULN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 15:11:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58BB8AC1F;
        Wed, 18 Nov 2020 20:11:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9D1A3DA701; Wed, 18 Nov 2020 21:09:26 +0100 (CET)
Date:   Wed, 18 Nov 2020 21:09:26 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v2 05/24] btrfs: extent_io: extract the btree page
 submission code into its own helper function
Message-ID: <20201118200926.GF20563@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
 <20201113125149.140836-6-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113125149.140836-6-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 13, 2020 at 08:51:30PM +0800, Qu Wenruo wrote:
> +/*
> + * Submit one page of one extent buffer.
> + *
> + * Will try to submit all pages of one extent buffer, thus will skip some pages
> + * if it's already submitted.

I think I have a deja vu, reading the above is contradictory (submit one
vs submit all) and that I replied that it should be clarified.
