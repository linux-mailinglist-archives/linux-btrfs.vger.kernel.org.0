Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAE63D2035
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 10:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhGVIQ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 04:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhGVIQ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 04:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626944252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlukC45qRYlbnd8cgO3tOzCzBLVfqt85AH8OGPwDcnU=;
        b=isWfoVMNDkPPqsr5YXlK50w78jXo2ko53B9gLIqGbWVOTwpG8n6EeN9mXIlGMHMyEYNoLP
        HSv33uCVpf+J2G4cPR98/Tl1cYojhoQGHHVwcO4HSGICGNScWcqQ+F/cN6nOy9+pP0z4jt
        r7gdvnDOWTTDkrH5g3LTkh6zVahRcB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-D-rS2v6MMBu2uggajGeVKA-1; Thu, 22 Jul 2021 04:57:30 -0400
X-MC-Unique: D-rS2v6MMBu2uggajGeVKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 821733E75E;
        Thu, 22 Jul 2021 08:57:29 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 33AB31970E;
        Thu, 22 Jul 2021 08:57:20 +0000 (UTC)
Date:   Thu, 22 Jul 2021 16:57:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 7/9] loop: don't grab a reference to the block device
Message-ID: <YPky6x2jhwm3p6Fj@T590>
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722075402.983367-8-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 09:54:00AM +0200, Christoph Hellwig wrote:
> The whole device block device won't be removed while the disk is still
> alive, so don't bother to grab a reference to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Ming Lei <ming.lei@rehat.com>

-- 
Ming

