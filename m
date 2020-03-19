Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D1918B976
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Mar 2020 15:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCSOe7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Mar 2020 10:34:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgCSOe6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Mar 2020 10:34:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D26FAAC58;
        Thu, 19 Mar 2020 14:34:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 03F47DA70E; Thu, 19 Mar 2020 15:34:28 +0100 (CET)
Date:   Thu, 19 Mar 2020 15:34:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: use nofs allocations for running delayed items
Message-ID: <20200319143428.GD12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200319141132.3127-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319141132.3127-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 19, 2020 at 10:11:32AM -0400, Josef Bacik wrote:
> This is because we hold that delayed node's mutex while doing tree
> operations.  Fix this by just wrapping the searches in nofs.

For the time being we have to do the explicit NOFS so in the code it's
a bit awkward. The hint is a function that takes transaction as
argument.

I'm working on the scope NOFS (marked by the transaction start/end), it's
intrusive, all over the code and there are some cases when I want to add
assertions that turns out to be tricky for some functions.
