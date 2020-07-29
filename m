Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28898232262
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2QOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 12:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QOP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 12:14:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8C04AC37;
        Wed, 29 Jul 2020 16:14:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 76B9DDA882; Wed, 29 Jul 2020 18:13:44 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:13:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v3] btrfs: only search for left_info if there is no
 right_info
Message-ID: <20200729161344.GB3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Sebastian =?iso-8859-1?Q?D=F6ring?= <moralapostel@gmail.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200727142805.4896-1-josef@toxicpanda.com>
 <20200728144346.GW3703@twin.jikos.cz>
 <CADkZQam9aJgNYy6bUXREYtS_fv1TLqyHbmkvs+aX9087AM62+g@mail.gmail.com>
 <e7370ce1-a799-3307-cfa3-f1a660d308c2@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7370ce1-a799-3307-cfa3-f1a660d308c2@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 29, 2020 at 11:43:40AM -0400, Josef Bacik wrote:
> On 7/29/20 11:42 AM, Sebastian Döring wrote:
> > For reasons unrelated to btrfs I've been trying linux-next-20200728 today.
> > 
> > This patch causes Kernel Oops and call trace (with
> > try_merge_free_space on top of stack) on my system. Because of
> > immediate system lock-up I can't provide a dmesg log and there's
> > nothing in /var/log (probably because it immediately goes read-only),
> > but removing this patch and rebuilding the kernel fixed my issues. I'm
> > happy to help if you need more info in order to reproduce.
> > 
> 
> Lol I literally just hit this and sent the fixup to Dave when you posted this. 
> My bad, somehow it didn't hit either of us until just now.  Thanks,

Updated misc-next pushed, for-next will follow.
