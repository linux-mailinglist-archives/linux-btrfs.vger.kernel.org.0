Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD491FC1
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 11:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHSJPH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 05:15:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57458 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbfHSJPG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 05:15:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8051AEFD
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 09:15:05 +0000 (UTC)
Date:   Mon, 19 Aug 2019 11:15:05 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] btrfs: create structure to encode checksum type
 and length
Message-ID: <20190819091505.GB8571@x250>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <cover.1564046812.git.jthumshirn@suse.de>
 <944b685765a68c3389888159d3fe228c2e78eb22.1564046812.git.jthumshirn@suse.de>
 <93b6f356-e6bc-a1c6-0266-2b1c12178bed@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93b6f356-e6bc-a1c6-0266-2b1c12178bed@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 12:07:44PM +0300, Nikolay Borisov wrote:
> 
> 
> On 25.07.19 г. 12:33 ч., Johannes Thumshirn wrote:
> > Create a structure to encode the type and length for the known on-disk
> > checksums. Also add a table and a convenience macro for adding the
> > checksum types to the table.
> > 
> > This makes it easier to add new checksums later.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> > ---
> >  fs/btrfs/ctree.h | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index da97ff10f421..099401f5dd47 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -82,9 +82,15 @@ struct btrfs_ref;
> >   */
> >  #define BTRFS_LINK_MAX 65535U
> >  
> > -/* four bytes for CRC32 */
> > -static const int btrfs_csum_sizes[] = { 4 };
> > -static const char *btrfs_csum_names[] = { "crc32c" };
> > +#define BTRFS_CHECKSUM_TYPE(_type, _size, _name) \
> > +	[_type] = { .size = _size, .name = _name }
> > +
> > +static const struct btrfs_csums {
> > +	u16		size;
> > +	const char	*name;
> > +} btrfs_csums[] = {
> > +	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_CRC32, 4, "crc32c"),
> > +};
> 
> 
> Considering we won't support more than 4-5 csums  I'd rather you remove
> the macro.

Yeah already dropped it, though I thought it might help a bit on the
readability/self-describing side.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
