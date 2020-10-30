Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC0D2A0CEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 18:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJ3R5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 13:57:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgJ3R5C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 13:57:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 609A6AC9A;
        Fri, 30 Oct 2020 17:57:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9E5EADA80D; Fri, 30 Oct 2020 18:55:25 +0100 (CET)
Date:   Fri, 30 Oct 2020 18:55:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: device stats: add json output format
Message-ID: <20201030175525.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <20201004112557.5568-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004112557.5568-1-realwakka@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Oct 04, 2020 at 11:25:57AM +0000, Sidong Yang wrote:
> Add supports for json formatting, this patch changes hard coded printing
> code to formatted print with output formatter. Json output would be
> useful for other programs that parse output of the command. but it
> changes the text format.
> 
> Example text format:
> 
> device:                 /dev/vdb
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
>   "device-stats": {
>     "/dev/vdb": {
>       "device": "/dev/vdb",
>       "write_io_errs": "0",
>       "read_io_errs": "0",
>       "flush_io_errs": "0",
>       "corruption_errs": "0",
>       "generation_errs": "0"
>     }
>   },
> }

The overall structure looks good, ie. the separate object 'device-stats'
and then the contents. For that the device id should be either key to a
map, or we can put it into an array (where device id must be present
too).

A check if the format is usable you can try to write a sample tool that
parses some of the data and prints them. So eg. using python or jq and
print stats of device 1. Which points out that device id is missing for
example.
