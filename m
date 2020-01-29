Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DFD14D01E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 19:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgA2SIP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 13:08:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:40648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgA2SIO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 13:08:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DCB4BAD86;
        Wed, 29 Jan 2020 18:08:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72695DA730; Wed, 29 Jan 2020 19:07:53 +0100 (CET)
Date:   Wed, 29 Jan 2020 19:07:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        btrfs-list@steev.me.uk
Subject: Re: [PATCH v4 0/2] readmirror feature (sysfs and in-memory only
 approach)
Message-ID: <20200129180752.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        btrfs-list@steev.me.uk
References: <20200105151402.1440-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105151402.1440-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 05, 2020 at 11:14:00PM +0800, Anand Jain wrote:
> There were few RFCs [1] before, mainly to figure out storage
> (or in memory only) for the readmirror policy and the interface needed.

The persistent storage of the policy is not settled but adding the sysfs
value that's both read and write is safe enough so this patchset is in
the list of features for 5.7.

With the new raid1c34 profiles we'll need a better mirror selection to
utilize all the copies more effectively. Besides the default PID policy
we should have at least one more so it's not just the bare interface
without any real use.
