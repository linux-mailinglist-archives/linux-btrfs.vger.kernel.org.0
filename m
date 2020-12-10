Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D563E2D6935
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 21:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbgLJUzj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 15:55:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:45318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404659AbgLJUz1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 15:55:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C952DAC6A;
        Thu, 10 Dec 2020 20:54:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C88EDA842; Thu, 10 Dec 2020 21:53:09 +0100 (CET)
Date:   Thu, 10 Dec 2020 21:53:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs-progs: device stats: add json output format
Message-ID: <20201210205308.GJ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201111163909.3968-1-realwakka@gmail.com>
 <20201111163909.3968-2-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111163909.3968-2-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 11, 2020 at 04:39:09PM +0000, Sidong Yang wrote:
> Add supports for json formatting, this patch changes hard coded printing
> code to formatted print with output formatter. Json output would be
> useful for other programs that parse output of the command. but it
> changes the text format.
> 
> Example text format:
> 
> device:                 /dev/vdb
> devid			1
> write_io_errs:          0
> read_io_errs:           0
> flush_io_errs:          0
> corruption_errs:        0
> generation_errs:        0
> 
> Example json format:
> 
> {
>   "__header": {
>     "version": "1"
>   },
>   "device-stats": [
>     {
>       "device": "/dev/vdb",
>       "devid": "1",
>       "write_io_errs": "0",
>       "read_io_errs": "0",
>       "flush_io_errs": "0",
>       "corruption_errs": "0",
>       "generation_errs": "0"
>     }
>   ],
> }

This looks good, regarding the stats this should be sufficient. We could
add some more filesystem information, but as it would be probably
another hash key.
