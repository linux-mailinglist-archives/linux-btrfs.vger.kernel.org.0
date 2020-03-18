Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9603A18A7B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 23:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCRWIE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 18:08:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:35212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRWIE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 18:08:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CEE75AD1E;
        Wed, 18 Mar 2020 22:08:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E914EDA70E; Wed, 18 Mar 2020 23:07:33 +0100 (CET)
Date:   Wed, 18 Mar 2020 23:07:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200318220733.GA12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Christoph Hellwig <hch@lst.de>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 09, 2020 at 02:32:26PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> This series includes several fixes, cleanups, and improvements to direct
> I/O and read repair. It's preparation for adding read repair to my
> RWF_ENCODED series [1], but it can go in independently.

Overall it looks good, but also scary. There are some comments to
address, I haven't reviewed it thoroughly yes so please don't resend
unless there's something that would harm testing. I'll put the branch to
for-next for some coverage.
