Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D991FF657
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jun 2020 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgFRPOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jun 2020 11:14:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRPOf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jun 2020 11:14:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC793ADE3;
        Thu, 18 Jun 2020 15:14:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 20AE2DA703; Thu, 18 Jun 2020 17:14:23 +0200 (CEST)
Date:   Thu, 18 Jun 2020 17:14:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] btrfs: add comments for check_can_nocow() and
 can_nocow_extent()
Message-ID: <20200618151422.GY27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20200618074950.136553-1-wqu@suse.com>
 <20200618074950.136553-2-wqu@suse.com>
 <SN4PR0401MB3598829DD37CA07C8B130F9B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <d3bf5a2e-7216-eaa6-e253-0004353b9e86@gmx.com>
 <SN4PR0401MB3598970C6EBE38409083EC8B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB3598970C6EBE38409083EC8B9B9B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 18, 2020 at 12:14:00PM +0000, Johannes Thumshirn wrote:
> On 18/06/2020 14:00, Qu Wenruo wrote:
> > 
> > 
> > On 2020/6/18 下午7:57, Johannes Thumshirn wrote:
> >> On 18/06/2020 09:50, Qu Wenruo wrote:
> >>> These two functions have extra conditions that their callers need to
> >>> meet, and some not-that-common parameters used for return value.
> >>>
> >>> So adding some comments may save reviewers some time.
> >>
> >> These comments have a style/formatting similar to kerneldoc, can you make
> >> them real kerneldoc?
> > 
> > Mind to give an example? It must be a coincident to match some existing
> > format.
> > 
> 
> Sure:
> 
> /**
>  * check_can_nocow() - Check if we can write into [@offset, @offset + @len) of @inode.
>  *
>  * @offset:	File offset
>  * @len:	The length to write, will be updated to the nocow writable
>  * 		range
>  * @orig_start:	Return the original file offset of the file extent (Optional)
>  * @orig_len:	Return the original on-disk length of the file extent (Optional)
>  * @ram_bytes:	Return the ram_bytes of the file extent (Optional)
>  *
>  * Return: >0 and update @len if we can do nocow write into [@offset, @offset + @len),
>  * 0 if we can't do nocow write or <0 if error happened.
>  *
>  * NOTE: This only checks the file extents, caller is responsible to wait for
>  *	 any ordered extents.
>  *
>  */
> 
> See also Documentation/doc-guide/kernel-doc.rst for a detailed description

The kernel doc is relatively good, but for our internal helpers I see
much point using it and keep the function comment style more relaxed.

The short summary, argument description, long description and return
values. No strict formatting of the parameters but the "@name: text"
looks ok.
