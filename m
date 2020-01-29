Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 063D014D13A
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2020 20:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgA2Tf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 14:35:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:41600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgA2Tf4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 14:35:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1B98AD72;
        Wed, 29 Jan 2020 19:35:54 +0000 (UTC)
Date:   Wed, 29 Jan 2020 11:25:50 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dsterba@suse.cz, dsterba@suse.com, nborisov@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] btrfs: optimize barrier usage for Rmw atomics
Message-ID: <20200129192550.nnfkkgde445nrbko@linux-p48b>
References: <20200129180324.24099-1-dave@stgolabs.net>
 <20200129191439.GN3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200129191439.GN3929@twin.jikos.cz>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 29 Jan 2020, David Sterba wrote:

>On Wed, Jan 29, 2020 at 10:03:24AM -0800, Davidlohr Bueso wrote:
>> Use smp_mb__after_atomic() instead of smp_mb() and avoid the
>> unnecessary barrier for non LL/SC architectures, such as x86.
>
>So that's a conflicting advice from what we got when discussing wich
>barriers to use in 6282675e6708ec78518cc0e9ad1f1f73d7c5c53d and the
>memory is still fresh. My first idea was to take the
>smp_mb__after_atomic and __before_atomic variants and after discussion
>with various people the plain smp_wmb/smp_rmb were suggested and used in
>the end.

So the patch you mention deals with test_bit(), which is out of the scope
of smp_mb__{before,after}_atomic() as it's not a RMW operation. atomic_inc()
and set_bit() are, however, meant to use these barriers.

>
>I can dig the email threads and excerpts from irc conversations, maybe
>Nik has them at hand too. We do want to get rid of all unnecessary and
>uncommented barriers in btrfs code, so I appreciate your patch.

Yeah, I struggled with the amount of undocumented barriers, and decided
not to go down that rabbit hole. This patch is only an equivalent of
what is currently there. When possible, getting rid of barriers is of
course better.

Thanks,
Davidlohr
