Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B43D5746
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhGZJhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:37:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231941AbhGZJhd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627294682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X9PHYAhpvrEOs6rPJaToyGJ45AcoghbB4ukIctpzIY0=;
        b=HDdSqVm6hRCYSXk75QHiQz60MRwc0ChoCorwYxT4lOWC3tD4YAlwBJomYUvTF5Y4JQzM2K
        RnpgCcx1SJ1lq/t5Iw1hf/yB/mUHvLkGxKqLiA0ROYzSzDwGRXPe8+W3zqXTr1hXo0QcvZ
        6Q/d6HKD+3Inu1s+jRhAMt4TEq5n1es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-RMNBg-cYNCaLayKGjYqRNw-1; Mon, 26 Jul 2021 06:16:39 -0400
X-MC-Unique: RMNBg-cYNCaLayKGjYqRNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18A4190D343;
        Mon, 26 Jul 2021 10:16:37 +0000 (UTC)
Received: from T590 (ovpn-13-107.pek2.redhat.com [10.72.13.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 789FB5C1D5;
        Mon, 26 Jul 2021 10:16:30 +0000 (UTC)
Date:   Mon, 26 Jul 2021 18:16:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] block: remove the GENHD_FL_UP check in
 blkdev_get_no_open
Message-ID: <YP6LfPENKbOontfT@T590>
References: <20210724071249.1284585-1-hch@lst.de>
 <20210724071249.1284585-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724071249.1284585-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 09:12:43AM +0200, Christoph Hellwig wrote:
> The GENHD_FL_UP check in blkdev_get_no_open is superflous.  The actual
> non-racy check happens later under open_mutex in blkdev_get_by_dev,
> and the inodes are removed from the inode hash early in del_gendisk,
> so it does not provide any useful short cut.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

