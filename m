Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB32330BD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgG3LKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 07:10:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgG3LKO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 07:10:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59646ABCE;
        Thu, 30 Jul 2020 11:10:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4BB54DA842; Thu, 30 Jul 2020 13:09:43 +0200 (CEST)
Date:   Thu, 30 Jul 2020 13:09:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: do not evaluate the expression with
 !CONFIG_BTRFS_ASSERT
Message-ID: <20200730110943.GE3703@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200724164147.39925-1-josef@toxicpanda.com>
 <20200727165501.GQ3703@twin.jikos.cz>
 <429f7cc2-4664-440d-6151-8e371f08ff47@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429f7cc2-4664-440d-6151-8e371f08ff47@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 27, 2020 at 01:27:12PM -0400, Josef Bacik wrote:
> On 7/27/20 12:55 PM, David Sterba wrote:
> > On Fri, Jul 24, 2020 at 12:41:47PM -0400, Josef Bacik wrote:
> >> While investigating a performance issue I noticed that turning off
> >> CONFIG_BTRFS_ASSERT had no effect in what I was seeing in perf,
> >> specifically check_setget_bounds() was around 5% for this workload.
> > 
> > Can you please share the perf profile and .config?  I find it hard to
> > believe that check_setget_bounds would be taking 5% overall. Also you
> > said that this was with integrity-checker compiled in so this kind of
> > invalidates any performance claims.
> > 
> 
> How?  It was a straight A/B test, do you think I'm making this up?

No, I want to understand it and reproduce eventually to see if deleting
the check is the only option to get the percents back.

> > Vast majority of the assert expressions are simple expressions without
> > side effects, but compiler still generates the code. In most cases it's
> > a few no-op movs, so this leaves the impact on the function calls.
> > 
> > Making the assert a true no-op saves some asm code and gains some
> > performance, but I don't want to remove the check_setget_bounds calls as
> > it's another line of defence against random in-memory corruptions.
> > 
> > Given that it's called deep inside many functions, it would be
> > impractical to add checking of each call. Instead, we can set a bit and
> > do a delayed abort in case it's found. I have that as a prototype and
> > will post it later.
> 
> Then make it configurable, because with ECC memory the performance overhead 
> isn't worth it.

ECC would protect against bitflips but what I had in mind were memory
corruptins caused by code bugs (use after free, page reference count
bugs). I've analyzed enough crash dumps to realize that cheap early
checks can save a lot of trouble later.

Regarding the configurability, that would cover wider range of
performance/safety trade offs, like the pre-write/post-read checks and
others. That sounds like a specific need for a deployment that can
afford that.

> >> This is useless, and has a marked impact on performance.  This
> >> microbenchmark is the watered down version of an application that is
> >> experiencing performance issues, and does renames and creates over and
> >> over again.  Doing these operations 200k times without this patch takes
> >> 13 seconds on my machine.  With this patch it takes 7 seconds.
> > 
> > Do you have that as a script?
> 
> Yeah, you can find it here.  It was written by somebody internally to illustrate 
> an issue they're seeing with their application.
> 
> https://paste.centos.org/view/f01126bf

Thanks, that helped.

The tool is set to do 2M operations, I switched it to 200k. The backing
device was a 4G file in /dev/shm, mkfs -d single -m single. I did a few
rounds with the following results:

1. baseline, asserts on, setget check on

run time:		46s
run time with perf:	48s

2. asserts on, comment out setget check

run time:		44s
run time with perf:	47s

So this is confirms the 5% difference

3. asserts on, optimized seget check

run time:		44s
run time with perf:	47s

The optimizations are reducing the number of ifs to 1 and inlining the
hot path. Low-level stuff, gets the performance back. Patch below.

4. asserts off, no setget check

run time:		44s
run time with perf:	45s

This verifies that asserts other than the setget check have negligible
impact on performance and it's not harmful to keep them on.


Analysis where the performance is lost:

* check_setget_bounds is short function, but it's still a function call,
  changing the flow of instructions and given how many times it's
  called the overhead adds up

* there are two conditions, one to check if the range is
  completely outside (member_offset > eb->len) or partially inside
  (member_offset + size > eb->len)


The range checks were present in map_private_extent_buffer,that got
replaced by check_setget_bounds:

    if (start + min_len > eb->len) {
            WARN(1, KERN_ERR "btrfs bad mapping eb start %llu len %lu, wanted %lu %lu\n",
                   eb->start, eb->len, start, min_len);
            return -EINVAL;
    }

This is the interesting one, two conditions are just for reporting
purposes and this one is enough to detect the overflow. So first step is
to reduce that to

+        if (unlikely(member_offset + size > eb->len)) {
+                btrfs_warn(eb->fs_info,
+        "bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
+                        (member_offset > eb->len ? "start" : "end"),
+                        (unsigned long)ptr, eb->start, member_offset, size);
+                return false;
+        }

Whether it's partial or complete overflow can be determined at the time
of message print. So we have the same as before, with just one
condition.

Removing the function call is straightforward, when the function is
static inline and separates the reporting to a normal function:

static inline void check_setget_bounds(const struct extent_buffer *eb,
                                const void *ptr, unsigned off, int size)
{
        const unsigned long member_offset = (unsigned long)ptr + off;

        if (unlikely(member_offset + size > eb->len))
               report_setget_bounds(eb, ptr, off, size);
}

This generates efficient assembly code and does not affect performance
noticeably. Further, report_setget_bounds could do some heavier
operations like saving the bogus values, setting a bit to filesystem for
a delayed transaction abort.
