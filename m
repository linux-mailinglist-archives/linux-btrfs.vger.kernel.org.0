Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB542E9BB3
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jan 2021 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhADRGm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jan 2021 12:06:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbhADRGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Jan 2021 12:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609779915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9h3z5LlCHcMQVpKavCUMhYApeAZMVwa2YCWREDiwFCo=;
        b=gZI0jWf/UkXAhgXbjJbVTssDyKl98XHJLMiTcDb9VRTu7PHE8vQxvYBGsc0DeRi7FxTdFJ
        kiM394trFf+WBzHW/RgUCV67f+quXj8LW+NvOFq6m3BJIlPMm48SVKB9LUsfNwyJGxgC5U
        QTMhX6/IsAu6/f9MWsUOpJwho/CqHvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-3mz7Dk5uO--KELV8SwwKQQ-1; Mon, 04 Jan 2021 12:05:11 -0500
X-MC-Unique: 3mz7Dk5uO--KELV8SwwKQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B75F19251A0;
        Mon,  4 Jan 2021 17:05:09 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A3595D751;
        Mon,  4 Jan 2021 17:05:02 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 104H51GA002921;
        Mon, 4 Jan 2021 12:05:01 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 104H4xUR002896;
        Mon, 4 Jan 2021 12:04:59 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 4 Jan 2021 12:04:59 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ignat Korchagin <ignat@cloudflare.com>
cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org,
        ebiggers@kernel.org, Damien.LeMoal@wdc.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com,
        nobuto.murata@canonical.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        mail@maciej.szmigiero.name
Subject: Re: [PATCH v3 0/2] dm crypt: some fixes to support dm-crypt running
 in softirq context
In-Reply-To: <20210104145948.1857-1-ignat@cloudflare.com>
Message-ID: <alpine.LRH.2.02.2101041204010.2157@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210104145948.1857-1-ignat@cloudflare.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On Mon, 4 Jan 2021, Ignat Korchagin wrote:

> Changes from v1:
>   * 0001: handle memory allocation failure for GFP_ATOMIC
> 
> Changes from v2:
>   * reordered patches
>   * 0002: crypt_convert will be retried from a workqueue, when a crypto request
>     allocation fails with GFP_ATOMIC instead of just returning an IO error to
>     the user
> 
> Ignat Korchagin (2):
>   dm crypt: do not wait for backlogged crypto request completion in
>     softirq
>   dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq
> 
>  drivers/md/dm-crypt.c | 138 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 123 insertions(+), 15 deletions(-)
> 
> -- 
> 2.20.1
> 

Acked-by: Mikulas Patocka <mpatocka@redhat.com>

