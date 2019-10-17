Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81E1DAB1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 13:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405905AbfJQLYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 07:24:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:50574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405863AbfJQLYD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 07:24:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DA00AFB2;
        Thu, 17 Oct 2019 11:24:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9BCAFDA808; Thu, 17 Oct 2019 13:24:11 +0200 (CEST)
Date:   Thu, 17 Oct 2019 13:24:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/15] btrfs: switch compression callbacks to direct calls
Message-ID: <20191017112406.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1571054758.git.dsterba@suse.com>
 <e8b9ace10f2df3e902158fa8f2ed2976993a759b.1571054758.git.dsterba@suse.com>
 <0f4ddb93-5295-87a6-c7ff-4a45b9b75b24@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4ddb93-5295-87a6-c7ff-4a45b9b75b24@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 17, 2019 at 11:42:53AM +0200, Johannes Thumshirn wrote:
> On 14/10/2019 14:22, David Sterba wrote:
> > +static int compression_decompress_bio(int type, struct list_head *ws,
> > +		struct compressed_bio *cb)
> > +{
> > +	switch (type) {
> > +	case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
> > +	case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
> > +	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
> > +	case BTRFS_COMPRESS_NONE:
> > +	default:
> > +		/*
> > +		 * This can't happen, the type is validated several times
> > +		 * before we get here.
> > +		 */
> > +		BUG();
> > +	}
> > +}
> > +
> > +static int compression_decompress(int type, struct list_head *ws,
> > +               unsigned char *data_in, struct page *dest_page,
> > +               unsigned long start_byte, size_t srclen, size_t destlen)
> > +{
> > +	switch (type) {
> > +	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_page,
> > +						start_byte, srclen, destlen);
> > +	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_page,
> > +						start_byte, srclen, destlen);
> > +	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_page,
> > +						start_byte, srclen, destlen);
> > +	case BTRFS_COMPRESS_NONE:
> > +	default:
> > +		/*
> > +		 * This can't happen, the type is validated several times
> > +		 * before we get here.
> > +		 */
> > +		BUG();
> > +	}
> > +}
> 
> Hmm should we really BUG() here? Maybe throw in an ASSERT(), so we can
> catch it in debug builds but not halt the machine (even if it
> theoretically can't happen).

Debug builds would catch it for sure, regardless of bug or assert, but
assert would not be on builds without CONFIG_BTRFS_ASSERT and continuing
here is not correct. If the code reatches the switch with a wrong value,
then the wrong value has been used to dereference an array in the
caller, so the state of the system is not defined. I don't see a better
option than BUG, thouth we don't want to add new ones. At least with the
comment it should be clear that it's not somebody's laziness to do
proper error handling, here it's not possible to do it at all.
