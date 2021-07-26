Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7274F3D5744
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhGZJg5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231639AbhGZJg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627294645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvooalKqaksodbnEb98trPc90g6gz5WIFCvmG4lsvoU=;
        b=clbK5F72IgQWclwfvnJMXBs8YY1vXbbMYiz1y8P1dlye9T2ZTTpys/beYEPtI/yL478iIM
        0uuZY3HESsjqwmJXEVDoMsPC3862xz8aB/z1h15US1BTuJPMSTfuczP+JXGmrcMiEXdKig
        xF2UnFVyJ923uNwxplLWjLjLwFv0SyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-lbQTvKNUPMerpFZL-JCigQ-1; Mon, 26 Jul 2021 06:17:22 -0400
X-MC-Unique: lbQTvKNUPMerpFZL-JCigQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D145800D55;
        Mon, 26 Jul 2021 10:17:20 +0000 (UTC)
Received: from T590 (ovpn-13-107.pek2.redhat.com [10.72.13.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 920095D9D3;
        Mon, 26 Jul 2021 10:17:13 +0000 (UTC)
Date:   Mon, 26 Jul 2021 18:17:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] block: change the refcounting for partitions
Message-ID: <YP6Lp5LRSlMOacic@T590>
References: <20210724071249.1284585-1-hch@lst.de>
 <20210724071249.1284585-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724071249.1284585-7-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 09:12:45AM +0200, Christoph Hellwig wrote:
> Instead of acquiring an inode reference on open make sure partitions
> always hold device model references to the disk while alive, and switch
> open to grab only a device model reference to the opened block device.
> If that is a partition the disk reference is transitively held by the
> partition already.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

