Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD411AC17
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 14:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfLKNdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 08:33:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbfLKNdD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 08:33:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54722AC22;
        Wed, 11 Dec 2019 13:33:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 21E5BDA883; Wed, 11 Dec 2019 14:33:02 +0100 (CET)
Date:   Wed, 11 Dec 2019 14:33:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCHi RFC] fstest: btrfs/158 fix miss-aligned stripe and device
Message-ID: <20191211133302.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, wqu@suse.com
References: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
 <1576044519-28313-1-git-send-email-anand.jain@oracle.com>
 <b89463c5-9f0d-b262-0198-2750e0b2aabc@gmx.com>
 <6025418e-25ce-19f9-3c53-6b094609098c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6025418e-25ce-19f9-3c53-6b094609098c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 11, 2019 at 03:23:06PM +0800, Anand Jain wrote:
> > And I tend to remove the fail_make_request requirement from some tests,
> > and direct read with multiple try should be enough to trigger repair for
> > test btrfs/142 and btrfs/143.
> > 
> 
> > In fact, I don't believe your current fix is good enough to handle both
> > old and new mkfs.btrfs.
> 
>   It was designed to handle only forward compatible.

If possible the tests should be robust and check assumptions and also
not hardcode eg. fixed block offset values that could change for various
reasons. Forward compatibility makes it hard to test backports, not only
on enterprise kernels but also on older stable kernels. We're in a state
where developers have list of tests to ignore because they known to be
bogus or unreliable.
