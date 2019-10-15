Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A563D760A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfJOMKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:10:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJOMKw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:10:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63768B2FC;
        Tue, 15 Oct 2019 12:10:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3BC04DA7E3; Tue, 15 Oct 2019 14:11:02 +0200 (CEST)
Date:   Tue, 15 Oct 2019 14:11:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/19] bitmap: genericize percpu bitmap region iterators
Message-ID: <20191015121102.GT2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
References: <cover.1570479299.git.dennis@kernel.org>
 <d2efb06e5e5400007a709bb1269b25e16b435169.1570479299.git.dennis@kernel.org>
 <20191007202612.mer74bok5ymyxae6@MacBook-Pro-91.local>
 <20191007222419.GA26876@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007222419.GA26876@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 06:24:19PM -0400, Dennis Zhou wrote:
> > > + * Bitmap region iterators.  Iterates over the bitmap between [@start, @end).
> > 
> > Gonna be that guy here, should be '[@start, @end]'
> 
> I disagree here. I'm pretty happy with [@start, @end). If btrfs wants to
> carry their own iterators I'm happy to copy and paste them, but as far
> as percpu goes I like [@start, @end).

It's not clear what the comment was about, if it's the notation of
half-closed interval or request to support closed interval in the
lookup. The orignal code has [,) and that shouldn't be changed when
copying. Or I'm missing something.
