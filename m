Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021A73D1B9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 04:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhGVBZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 21:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229932AbhGVBZ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 21:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626919594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9UphVIxBs/0VzOINiOwenw5jk+bFkLxhRY8dih8ET0k=;
        b=au+71rmTpo4OByUIvOemNSwyxuhbFHlYNAyT/0qhm521Cu0/o2YKR2HNlEs1mmmXMZ3YWb
        AefJHoEXNvX6cWgAGTQB6ms6L6vGnef1fNGZDntgBr/hZ4MHaV0P++8F82KvP0E//FBYz6
        vPBBo63PxAwxUnsWOV0PaqG58KLWtSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-AAQhltx4MVarSW8x7RqaBQ-1; Wed, 21 Jul 2021 22:06:32 -0400
X-MC-Unique: AAQhltx4MVarSW8x7RqaBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47908190A7A0;
        Thu, 22 Jul 2021 02:06:31 +0000 (UTC)
Received: from T590 (ovpn-13-66.pek2.redhat.com [10.72.13.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3814F5D9DD;
        Thu, 22 Jul 2021 02:06:23 +0000 (UTC)
Date:   Thu, 22 Jul 2021 10:06:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/8] block: assert the locking state in delete_partition
Message-ID: <YPjSmyvo6IbfRNO/@T590>
References: <20210721153523.103818-1-hch@lst.de>
 <20210721153523.103818-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721153523.103818-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 21, 2021 at 05:35:17PM +0200, Christoph Hellwig wrote:
> Add a lockdep assert instead of the outdated locking comment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

