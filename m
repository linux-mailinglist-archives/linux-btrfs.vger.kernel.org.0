Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70D63D242E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhGVMVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 08:21:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41512 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhGVMVH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 08:21:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 938432261C;
        Thu, 22 Jul 2021 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626958901;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xUdPc/hG2dsiqci235bXPQfzG/mD8JEN84kQSrasT4=;
        b=0AjfIRXl8RVtnIjJ9Gff6PkA6n62qdGmD38knXThAK8IlJaMpBDJn4A3s8/hiKl/YGILjd
        830JKp/D0JmMkf9qhw33PLkbhMdEs8cuh+jcR+HwLbZb0yq5kE935c1ju6jla9XYBKUkYy
        dh0E0+ccg4WHyQQm90Hmm2HRoa/sap0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626958901;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xUdPc/hG2dsiqci235bXPQfzG/mD8JEN84kQSrasT4=;
        b=mP7jcHWZBX7wcR56NyPqa1xT16hm7Y1FPhVibQDjFM238fVLT2pp99pqeZJ27TVY+iZw+S
        bAcfmKTqzLhnNvCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5BEFCA3B99;
        Thu, 22 Jul 2021 13:01:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AF0A9DAF95; Thu, 22 Jul 2021 14:58:59 +0200 (CEST)
Date:   Thu, 22 Jul 2021 14:58:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/9] btrfs: store a block_device in struct
 btrfs_ordered_extent
Message-ID: <20210722125859.GR19710@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722075402.983367-7-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 09:53:59AM +0200, Christoph Hellwig wrote:
> Store the block device instead of the gendisk in the btrfs_ordered_extent
> structure intead of acquiring a reference to it later.
            instead

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Sterba <dsterba@suse.com>

I can add the patch to the next pull request so you can rebase your
series on top of it and don't need to carry it until the next merge
window.
