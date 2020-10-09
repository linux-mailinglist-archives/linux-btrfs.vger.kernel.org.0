Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDEF288716
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 12:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbgJIKjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 06:39:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgJIKjz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Oct 2020 06:39:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602239992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=dS2NT1y9GX4JESbiMPaLCPMh7xAsZxI9VGwucAC6F6w=;
        b=PJDozDcKlr7eDIulgVRp12JvxCJNGxgmkOVrJUz+SGQr9rhrDqxx06str6R4i2Cemr4jfR
        dYARDd9J/6KkpSlsnYQnawC5GO1Tg7f/N6dexWdIbsKJI/APHGv2Nh6Q8p9KuME3aJuzDV
        pfwl5QhQrgY3ooqX/CZQoBVL3R9R5pQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CEAD6B281;
        Fri,  9 Oct 2020 10:39:52 +0000 (UTC)
Subject: Re: [PATCH v2 00/11] Improve preemptive ENOSPC flushing
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1602189832.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <09dd58a3-970e-59a9-d9fc-a4c4d1858450@suse.com>
Date:   Fri, 9 Oct 2020 13:39:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.10.20 г. 23:48 ч., Josef Bacik wrote:
> There's a lot of individual changes, but most of it revolves around fixing the
> O_DIRECT regression that Nikolay noted.  With this set of patches we get
> slightly better performance in the buffered case than before, and the O_DIRECT
> case is slightly improved from baseline as well.
> 
> v1->v2:
> - Added a FORCE_COMMIT_TRANS flush operation so we can keep the flush_space
>   stuff consistent and get all the normal tracepoints.
> - Renamed fs_info->dio_bytes to ->ordered_bytes and changed it to count all
>   ordered extents that were pending, not just DIO ordered extents that were
>   pending.
> - Reworked the clamping to not apply if we're not doing a lot of delalloc
>   reservations.
> - Reworked the preempt flushing loop to be more straightforward.
> - Fixed the need_preemptive_flushing() helper to take into account DIO heavy
>   workloads.
> 
<snip>

So indeed it seems to result in slightly better results: 

dio-josef-v2:
  WRITE: bw=48.6MiB/s (50.0MB/s), 48.6MiB/s-48.6MiB/s (50.0MB/s-50.0MB/s), io=8192MiB (8590MB), run=168534-168534msec
  WRITE: bw=50.4MiB/s (52.8MB/s), 50.4MiB/s-50.4MiB/s (52.8MB/s-52.8MB/s), io=8192MiB (8590MB), run=162601-162601msec
  WRITE: bw=50.9MiB/s (53.4MB/s), 50.9MiB/s-50.9MiB/s (53.4MB/s-53.4MB/s), io=8192MiB (8590MB), run=160964-160964msec
  WRITE: bw=50.6MiB/s (53.0MB/s), 50.6MiB/s-50.6MiB/s (53.0MB/s-53.0MB/s), io=8192MiB (8590MB), run=161938-161938msec
  WRITE: bw=49.8MiB/s (52.2MB/s), 49.8MiB/s-49.8MiB/s (52.2MB/s-52.2MB/s), io=8192MiB (8590MB), run=164577-164577msec


buffered-josef-v2:

  WRITE: bw=32.0MiB/s (33.6MB/s), 32.0MiB/s-32.0MiB/s (33.6MB/s-33.6MB/s), io=8192MiB (8590MB), run=255670-255670msec
  WRITE: bw=29.5MiB/s (30.9MB/s), 29.5MiB/s-29.5MiB/s (30.9MB/s-30.9MB/s), io=8192MiB (8590MB), run=277829-277829msec
  WRITE: bw=31.8MiB/s (33.4MB/s), 31.8MiB/s-31.8MiB/s (33.4MB/s-33.4MB/s), io=8192MiB (8590MB), run=257554-257554msec
  WRITE: bw=29.8MiB/s (31.3MB/s), 29.8MiB/s-29.8MiB/s (31.3MB/s-31.3MB/s), io=8192MiB (8590MB), run=274516-274516msec
  WRITE: bw=29.8MiB/s (31.2MB/s), 29.8MiB/s-29.8MiB/s (31.2MB/s-31.2MB/s), io=8192MiB (8590MB), run=274975-274975msec

In comparison with V1 posting: 

buffered-josef-v1:
 WRITE: bw=29.1MiB/s (30.5MB/s), 29.1MiB/s-29.1MiB/s (30.5MB/s-30.5MB/s), io=8192MiB (8590MB), run=281678-281678msec
 WRITE: bw=30.0MiB/s (32.5MB/s), 30.0MiB/s-30.0MiB/s (32.5MB/s-32.5MB/s), io=8192MiB (8590MB), run=264337-264337msec
 WRITE: bw=29.6MiB/s (31.1MB/s), 29.6MiB/s-29.6MiB/s (31.1MB/s-31.1MB/s), io=8192MiB (8590MB), run=276312-276312msec
 WRITE: bw=29.8MiB/s (31.2MB/s), 29.8MiB/s-29.8MiB/s (31.2MB/s-31.2MB/s), io=8192MiB (8590MB), run=274916-274916msec
 WRITE: bw=30.4MiB/s (31.9MB/s), 30.4MiB/s-30.4MiB/s (31.9MB/s-31.9MB/s), io=8192MiB (8590MB), run=269030-269030msec

buffered-misc-next-no-josef:
  WRITE: bw=20.2MiB/s (21.2MB/s), 20.2MiB/s-20.2MiB/s (21.2MB/s-21.2MB/s), io=8192MiB (8590MB), run=404831-404831msec
  WRITE: bw=20.8MiB/s (21.8MB/s), 20.8MiB/s-20.8MiB/s (21.8MB/s-21.8MB/s), io=8192MiB (8590MB), run=394749-394749msec
  WRITE: bw=20.8MiB/s (21.8MB/s), 20.8MiB/s-20.8MiB/s (21.8MB/s-21.8MB/s), io=8192MiB (8590MB), run=393291-393291msec
  WRITE: bw=20.7MiB/s (21.8MB/s), 20.7MiB/s-20.7MiB/s (21.8MB/s-21.8MB/s), io=8192MiB (8590MB), run=394918-394918msec
  WRITE: bw=21.1MiB/s (22.1MB/s), 21.1MiB/s-21.1MiB/s (22.1MB/s-22.1MB/s), io=8192MiB (8590MB), run=388499-388499msec

buffered-4.19.x:
  WRITE: bw=23.3MiB/s (24.4MB/s), 23.3MiB/s-23.3MiB/s (24.4MB/s-24.4MB/s), io=6387MiB (6697MB), run=274460-274460msec
  WRITE: bw=23.3MiB/s (24.5MB/s), 23.3MiB/s-23.3MiB/s (24.5MB/s-24.5MB/s), io=6643MiB (6966MB), run=284518-284518msec
  WRITE: bw=23.4MiB/s (24.5MB/s), 23.4MiB/s-23.4MiB/s (24.5MB/s-24.5MB/s), io=6643MiB (6966MB), run=284372-284372msec
  WRITE: bw=23.6MiB/s (24.7MB/s), 23.6MiB/s-23.6MiB/s (24.7MB/s-24.7MB/s), io=6387MiB (6697MB), run=271200-271200msec
  WRITE: bw=23.4MiB/s (24.6MB/s), 23.4MiB/s-23.4MiB/s (24.6MB/s-24.6MB/s), io=6387MiB (6697MB), run=272670-272670msec

And dio: 

dio-josef-v1:
  WRITE: bw=47.1MiB/s (49.4MB/s), 47.1MiB/s-47.1MiB/s (49.4MB/s-49.4MB/s), io=8192MiB (8590MB), run=174049-174049msec
  WRITE: bw=48.5MiB/s (50.8MB/s), 48.5MiB/s-48.5MiB/s (50.8MB/s-50.8MB/s), io=8192MiB (8590MB), run=169045-169045msec
  WRITE: bw=45.0MiB/s (48.2MB/s), 45.0MiB/s-45.0MiB/s (48.2MB/s-48.2MB/s), io=8192MiB (8590MB), run=178196-178196msec
  WRITE: bw=46.1MiB/s (48.3MB/s), 46.1MiB/s-46.1MiB/s (48.3MB/s-48.3MB/s), io=8192MiB (8590MB), run=177861-177861msec
  WRITE: bw=46.4MiB/s (48.7MB/s), 46.4MiB/s-46.4MiB/s (48.7MB/s-48.7MB/s), io=8192MiB (8590MB), run=176376-176376msec

dio-misc-next-no-josef:
  WRITE: bw=50.1MiB/s (52.6MB/s), 50.1MiB/s-50.1MiB/s (52.6MB/s-52.6MB/s), io=8192MiB (8590MB), run=163365-163365msec
  WRITE: bw=50.3MiB/s (52.8MB/s), 50.3MiB/s-50.3MiB/s (52.8MB/s-52.8MB/s), io=8192MiB (8590MB), run=162753-162753msec
  WRITE: bw=50.6MiB/s (53.1MB/s), 50.6MiB/s-50.6MiB/s (53.1MB/s-53.1MB/s), io=8192MiB (8590MB), run=161766-161766msec
  WRITE: bw=50.2MiB/s (52.7MB/s), 50.2MiB/s-50.2MiB/s (52.7MB/s-52.7MB/s), io=8192MiB (8590MB), run=163074-163074msec
  WRITE: bw=50.5MiB/s (52.9MB/s), 50.5MiB/s-50.5MiB/s (52.9MB/s-52.9MB/s), io=8192MiB (8590MB), run=162252-162252msec

With this: 

Tested-by: Nikolay Borisov <nborisov@suse.com>
