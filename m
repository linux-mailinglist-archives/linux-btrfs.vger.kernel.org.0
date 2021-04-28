Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF536D698
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 13:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhD1LhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 07:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29645 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232607AbhD1LhU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 07:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619609795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7aKoQR+eie4eZGaFpJxqc5kuUv3lh07wOx/sg0Ymk8=;
        b=RfkrTA1TclZN6Z2p7hRXZIxR12eDQ/BwqrJr1KQsPSrTQL2b5v08LGRBpjv7n9X67hmYcU
        DT3Ug91s4FIxbmzhO4w5K0nmNyBE5LK6GfC3br52TgVV2lvG0RL/PUeUFTEkDsV9AgpXuN
        aU5mwHzD/uQIi79XkZsUsiHkDvigD+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-kil4ggLvPT-19GCcfTYulw-1; Wed, 28 Apr 2021 07:36:31 -0400
X-MC-Unique: kil4ggLvPT-19GCcfTYulw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C5691936B83;
        Wed, 28 Apr 2021 11:36:30 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 134005DF26;
        Wed, 28 Apr 2021 11:36:28 +0000 (UTC)
Date:   Wed, 28 Apr 2021 13:36:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 0/3] implement zone-aware probing/wiping for zoned
 btrfs
Message-ID: <20210428113626.lq3hy5qci5bwnyru@ws.net.home>
References: <20210426055036.2103620-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426055036.2103620-1-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 26, 2021 at 02:50:33PM +0900, Naohiro Aota wrote:
> Naohiro Aota (3):
>   blkid: implement zone-aware probing
>   blkid: add magic and probing for zoned btrfs
>   blkid: support zone reset for wipefs
> 
>  include/blkdev.h                 |   9 ++
>  lib/blkdev.c                     |  29 ++++++
>  libblkid/src/blkidP.h            |   5 +
>  libblkid/src/probe.c             |  99 +++++++++++++++++--
>  libblkid/src/superblocks/btrfs.c | 159 ++++++++++++++++++++++++++++++-
>  5 files changed, 292 insertions(+), 9 deletions(-)

Merged to the "next" branch (on github) and it will be merged to the
"master" later after v2.37 release. 

Thanks! (and extra thank for the examples :-)

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

