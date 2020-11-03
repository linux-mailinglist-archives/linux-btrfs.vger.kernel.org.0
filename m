Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEE02A4F81
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 19:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCS7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 13:59:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:57328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgKCS7c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 13:59:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6BDCAB8F;
        Tue,  3 Nov 2020 18:59:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 08C77DA7D2; Tue,  3 Nov 2020 19:57:53 +0100 (CET)
Date:   Tue, 3 Nov 2020 19:57:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH] Revert "btrfs: qgroup: return ENOTCONN instead of
 EINVAL when quotas are not enabled"
Message-ID: <20201103185753.GB6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <33ce2f6df841772666ca1cf3a4876b0ff6612983.1603921124.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ce2f6df841772666ca1cf3a4876b0ff6612983.1603921124.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 28, 2020 at 02:42:38PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This reverts commit 8a36e408d40606e21cd4e2dd9601004a67b14868.
> 
> At Facebook, we have some userspace code that calls
> BTRFS_IOC_QGROUP_CREATE when qgroups may be disabled and specifically
> handles EINVAL. When we updated to 5.6, this started failing with the
> new error code and broke the application. ENOTCONN is indeed better, but
> this is effectively an ABI breakage.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> The userspace code in question is actually unit testing code for our
> container system, so it's trivial for us to update that to handle the
> new error. However, this may be considered an ABI breakage, so I wanted
> to throw this out there and see if anyone thinks this is important
> enough to revert.

Making the errors fine grained is a change but I don't consider it an
ABI breakage, it's not changing behaviour (like suddenly to succeed). It
fails and gives a better reason so the application should make use of
that.
