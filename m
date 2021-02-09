Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2923158AA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 22:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbhBIVac (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 16:30:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:60730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234323AbhBIVNn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 16:13:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE373AD24;
        Tue,  9 Feb 2021 21:12:05 +0000 (UTC)
Date:   Tue, 9 Feb 2021 21:12:00 +0000
From:   Michal Rostecki <mrostecki@suse.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com
Subject: Re: [PATCH v4 1/3] btrfs: add read_policy latency
Message-ID: <20210209211200.GA1662@wotan.suse.de>
References: <cover.1611114341.git.anand.jain@oracle.com>
 <63f6f00e2ecc741efd2200c3c87b5db52c6be2fd.1611114341.git.anand.jain@oracle.com>
 <20210120121416.GX6430@twin.jikos.cz>
 <e46000d9-c2e1-ec7c-d6b1-a3bd16aa05f4@oracle.com>
 <20210121175243.GF6430@twin.jikos.cz>
 <28b7ef3d-b5b9-f4a6-8d6f-1e6fc1103815@oracle.com>
 <9f406301-c16a-72a5-4ff3-d3bda127895e@oracle.com>
 <34cecc3d-235e-2f47-0992-675dc576b5be@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34cecc3d-235e-2f47-0992-675dc576b5be@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 04, 2021 at 08:30:01PM +0800, Anand Jain wrote:
> 
> Hi Michal,
> 
>  Did you get any chance to run the evaluation with this patchset?
> 
> Thanks, Anand
> 

Hi Anand,

Yes, I tested your policies now. Sorry for late response.

For the singlethreaded test:

  [global]
  name=btrfs-raid1-seqread
  filename=btrfs-raid1-seqread
  rw=read
  bs=64k
  direct=0
  numjobs=1
  time_based=0

  [file1]
  size=10G
  ioengine=libaio

results are:

- raid1c3 with 3 HDDs:
  3 x Segate Barracuda ST2000DM008 (2TB)
  * pid policy
    READ: bw=215MiB/s (226MB/s), 215MiB/s-215MiB/s (226MB/s-226MB/s),
    io=10.0GiB (10.7GB), run=47537-47537msec
  * latency policy
    READ: bw=219MiB/s (229MB/s), 219MiB/s-219MiB/s (229MB/s-229MB/s),
    io=10.0GiB (10.7GB), run=46852-46852msec
  * device policy - didn't test it here, I guess it doesn't make sense
    to check it on non-mixed arrays ;)
- raid1c3 with 2 HDDs and 1 SSD:
  2 x Segate Barracuda ST2000DM008 (2TB)
  1 x Crucial CT256M550SSD1 (256GB)
  * pid policy
    READ: bw=219MiB/s (230MB/s), 219MiB/s-219MiB/s (230MB/s-230MB/s),
    io=10.0GiB (10.7GB), run=46749-46749msec
  * latency policy
    READ: bw=517MiB/s (542MB/s), 517MiB/s-517MiB/s (542MB/s-542MB/s),
    io=10.0GiB (10.7GB), run=19823-19823msec
  * device policy
    READ: bw=517MiB/s (542MB/s), 517MiB/s-517MiB/s (542MB/s-542MB/s),
    io=10.0GiB (10.7GB), run=19810-19810msec

For the multithreaded test:

  [global]
  name=btrfs-raid1-seqread
  filename=btrfs-raid1-seqread
  rw=read
  bs=64k
  direct=0
  numjobs=1
  time_based=0

  [file1]
  size=10G
  ioengine=libaio

results are:

- raid1c3 with 3 HDDs:
  3 x Segate Barracuda ST2000DM008 (2TB)
  * pid policy
    READ: bw=1608MiB/s (1686MB/s), 201MiB/s-201MiB/s (211MB/s-211MB/s),
    io=80.0GiB (85.9GB), run=50948-50949msec
  * latency policy
    READ: bw=1515MiB/s (1588MB/s), 189MiB/s-189MiB/s (199MB/s-199MB/s),
    io=80.0GiB (85.9GB), run=54081-54084msec
- raid1c3 with 2 HDDs and 1 SSD:
  2 x Segate Barracuda ST2000DM008 (2TB)
  1 x Crucial CT256M550SSD1 (256GB)
  * pid policy
    READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
    io=80.0GiB (85.9GB), run=44449-44450msec
  * latency policy
    READ: bw=4213MiB/s (4417MB/s), 527MiB/s-527MiB/s (552MB/s-552MB/s),
    io=80.0GiB (85.9GB), run=19444-19446msec
  * device policy
    READ: bw=4196MiB/s (4400MB/s), 525MiB/s-525MiB/s (550MB/s-550MB/s),
    io=80.0GiB (85.9GB), run=19522-19522msec

To sum it up - I think that your policies are indeed a very good match
for mixed (nonrot and rot) arrays.

They perform either slightly better or worse (depending on the test)
than pid policy on all-HDD arrays.

I've just sent out my proposal of roundrobin policy, which seems to give
better performance for all-HDD than your policies (and better than pid
policy in all cases):

https://patchwork.kernel.org/project/linux-btrfs/patch/20210209203041.21493-7-mrostecki@suse.de/

Cheers,
Michal
