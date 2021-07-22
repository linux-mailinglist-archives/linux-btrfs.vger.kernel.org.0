Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A131F3D1FDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhGVHv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230048AbhGVHvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626942747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZ1+6HeYT2ED4bM+Pad+8J83+hcuj946cQYelhBSjI8=;
        b=XyDArjg9iJdD9raH2QvNxwcT7zpL0IGhg3OkLcFpI9h6GLQoDb44hg78Uk1giIUBTi39Gp
        8RKOgoFQnrjcBWSeL0AQMcS3CMdm+10PFU39YHuH2vshYuiXloykaMXwwPAAC3VTHsXmB8
        Q+AOHJdvYgPrf9VEvXHPsOxuxUufUAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-pQ6N-3WJOZqxlmoRQrG2tA-1; Thu, 22 Jul 2021 04:32:26 -0400
X-MC-Unique: pQ6N-3WJOZqxlmoRQrG2tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6B7B804311;
        Thu, 22 Jul 2021 08:32:24 +0000 (UTC)
Received: from T590 (ovpn-13-219.pek2.redhat.com [10.72.13.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7973E5D6B1;
        Thu, 22 Jul 2021 08:32:17 +0000 (UTC)
Date:   Thu, 22 Jul 2021 16:32:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] block: allocate bd_meta_info later in add_partitions
Message-ID: <YPktCxEGFsRvWlhz@T590>
References: <20210722075402.983367-1-hch@lst.de>
 <20210722075402.983367-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722075402.983367-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 22, 2021 at 09:53:57AM +0200, Christoph Hellwig wrote:
> Move the allocation of bd_meta_info after initializing the struct device
> to avoid the special bdput error handling path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

