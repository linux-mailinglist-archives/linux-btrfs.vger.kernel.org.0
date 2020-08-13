Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CAD243D7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 18:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMQgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 12:36:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMQgY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 12:36:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B371CAD7A;
        Thu, 13 Aug 2020 16:36:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 00360DA6EF; Thu, 13 Aug 2020 18:35:20 +0200 (CEST)
Date:   Thu, 13 Aug 2020 18:35:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 13/23] btrfs: add the data transaction commit logic into
 may_commit_transaction
Message-ID: <20200813163520.GO2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Nikolay Borisov <nborisov@suse.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
 <20200721142234.2680-14-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721142234.2680-14-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 21, 2020 at 10:22:24AM -0400, Josef Bacik wrote:
> -	bytes_needed = (ticket) ? ticket->bytes : 0;
> +	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;

I'd rather write that as

	if (ticket)
		bytes_needed = ticket->bytes;
