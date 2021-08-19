Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D473F1FBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 20:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhHSSQY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 14:16:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34664 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhHSSQX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 14:16:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B1BD722164;
        Thu, 19 Aug 2021 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629396946;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMdepOOY7lT7S97Kml2MRMO7FkIj7iz/zZgkwxt9bp4=;
        b=g5NeuJZYIVk/luaQjNwiJ7qmU/QdyqDnphHa0QFosGT/yLBsaIYIzf7g5gBlLvinqIriEt
        luV5QsJNnckwzXfyiKKup7FwpezG+EUXnp8Pn2XsJOzibqKj5Onf4gZe3dTFTuIH9k3yF3
        de/Tgv+nVqdZpscUOMXYPcAyq4IDf+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629396946;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMdepOOY7lT7S97Kml2MRMO7FkIj7iz/zZgkwxt9bp4=;
        b=1PzMbJrbLAF6TL9d+IgD7/omHk76VHbUiiFOLUADT5EVdyCgr41pxhGIsPz855k8qHemoM
        uB8Zlhm3xSOu5VBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id AC6DCA3BA3;
        Thu, 19 Aug 2021 18:15:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5B89EDA72C; Thu, 19 Aug 2021 20:12:49 +0200 (CEST)
Date:   Thu, 19 Aug 2021 20:12:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: reflink: Assure length != 0 in btrfs_extent_same()
Message-ID: <20210819181249.GJ5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sidong Yang <realwakka@gmail.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20210818160815.1820-1-realwakka@gmail.com>
 <e6423897-3886-73b1-42dc-5e24ca792682@suse.com>
 <20210819153216.GD1987@realwakka>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210819153216.GD1987@realwakka>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 19, 2021 at 03:32:16PM +0000, Sidong Yang wrote:
> On Thu, Aug 19, 2021 at 11:04:58AM +0300, Nikolay Borisov wrote:
> > 
> > 
> > On 18.08.21 г. 19:08, Sidong Yang wrote:
> > > btrfs_extent_same() cannot be called with zero length. Because when
> > > length is zero, it would be filtered by condition in
> > > btrfs_remap_file_range(). But if this function is used in other case in
> > > future, it can make ret as uninitialized.
> > > 
> > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > 
> > This is not sufficient, with the assert compiled out the error would
> > still be in place. It seem that it is sufficient to initialize ret to
> > some non-arbitrary value i.e -EINVAL ?
> 
> I agree. It's better way to assign intial value than adding assert. If
> there is code that initialize ret, It seems that assert is no need for
> this.

Patch with assert removed, please send the one initializing the return
value, thanks.
