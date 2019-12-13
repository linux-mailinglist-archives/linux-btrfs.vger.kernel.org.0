Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3D111E94A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2019 18:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfLMRfb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 12:35:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbfLMRfb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 12:35:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EF350AF2B;
        Fri, 13 Dec 2019 17:35:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9995DA82A; Fri, 13 Dec 2019 18:35:27 +0100 (CET)
Date:   Fri, 13 Dec 2019 18:35:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Zaslonko Mikhail <zaslonko@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] btrfs: Use larger zlib buffer for s390 hardware
 compression
Message-ID: <20191213173526.GC3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zaslonko Mikhail <zaslonko@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191209152948.37080-1-zaslonko@linux.ibm.com>
 <20191209152948.37080-7-zaslonko@linux.ibm.com>
 <97b3a11d-2e52-c710-ee25-157e562eb3d0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97b3a11d-2e52-c710-ee25-157e562eb3d0@linux.ibm.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 05:10:10PM +0100, Zaslonko Mikhail wrote:
> Hello,
> 
> Could you please review the patch for btrfs below.
> 
> Apart from falling back to 1 page, I have set the condition to allocate 
> 4-pages zlib workspace buffer only if s390 Deflate-Conversion facility
> is installed and enabled. Thus, it will take effect on s390 architecture
> only.
> 
> Currently in zlib_compress_pages() I always copy input pages to the workspace
> buffer prior to zlib_deflate call. Would that make sense, to pass the page
> itself, as before, based on the workspace buf_size (for 1-page buffer)?

Doesn't the copy back and forth kill the improvements brought by the
hw supported decompression?

> As for calling zlib_deflate with Z_FINISH flush parameter in a loop until
> Z_STREAM_END is returned, that comes in agreement with the zlib manual.

The concerns are about zlib stream that take 4 pages on input and on the
decompression side only 1 page is available for the output. Ie. as if
the filesystem was created on s390 with dflcc then opened on x86 host.
The zlib_deflate(Z_FINISH) happens on the compresission side.
