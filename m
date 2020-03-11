Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3731813B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgCKIsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 04:48:24 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33901 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgCKIsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 04:48:23 -0400
Received: by mail-pj1-f66.google.com with SMTP id 39so1307001pjo.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vf3XSakNYDZV7p89XfntbfIpO2pPQWcXGvKBbC8BKVg=;
        b=GRKeuBwTzaKrVSHE8lQc0lHbHoX9FCcouEQyUxBUzMCYYkG9RyYHM+58mK6dHp0ZPr
         WHqfMATO5nzTJBFh+yU6QP2jvNJZBiKXhVw53AYLM1t6yB+UC67AB4W9WjS0RHqhkApo
         5xAZbrAeBHgdjKMQWYZECptrwj+cDKOv7PnULlDZD+RDD9fbepTHnp4tDnPUNC/kMZE3
         2n6rY19t02qP0UkHW8xEmt6Kd7P5yLN8P956PsTB7g+tToR+H8XUOkpw2xC2Cv78S1aX
         BWbJzkfbWZuM5BCWjcTj2ImQ5KJngxOm+cBhl3smd6ebvnYCGLd9rUHFVfNTbcjP/F/z
         bcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vf3XSakNYDZV7p89XfntbfIpO2pPQWcXGvKBbC8BKVg=;
        b=FlgtTFiEnEU5iAHlkjNIuQ4BVGD52JfeLSbED6Z21/ck5HzSQ5WpX4tTvQRNjJVCpd
         d6D88cl9DLrltdk+LriN3bpEX8PkhvV0DEARmDe7KmCXuF3mJzlFNgEipGbEV9yNgxPc
         8F43EYge6kdnmwCDYuQTjeyYf4ajEAVXj9uwtxhadaimAL2oEGffd6iUscn2TltvmxCb
         0aUpSnRU8NuM2GqfmgIc4X55y2UlCmFFbStwrCIXkJSkbhIKEm0sLpdSoCRS30dgPDSZ
         srepwWDibfsoDkb1PNzjctVprJzA/CQXaunxI2QPw8Zk815c/gfyDuMS7YQpm7CfpgAZ
         SA0Q==
X-Gm-Message-State: ANhLgQ101uEILeh2YLUli7S7nT/aqyLNJbyTHbcRJUqevqL5K/zDquQi
        6QxRnoDkK1ugwOfEVKWxv/B0cQ==
X-Google-Smtp-Source: ADFU+vvlf3NicvQdNvhV/mW7sCBRylMT6zo78on4S01BDb2W4YlvqvtsvbEEixMTCZW5aadhqa3pXg==
X-Received: by 2002:a17:90b:238e:: with SMTP id mr14mr2306244pjb.146.1583916502625;
        Wed, 11 Mar 2020 01:48:22 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id i5sm32065624pfo.173.2020.03.11.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:48:22 -0700 (PDT)
Date:   Wed, 11 Mar 2020 01:48:21 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/15] btrfs: move btrfs_dio_private to inode.c
Message-ID: <20200311084821.GC252106@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <7cb31cf9673d1d232e770145924ef779d3681058.1583789410.git.osandov@fb.com>
 <SN4PR0401MB359894547AE34B1ABE590D409BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359894547AE34B1ABE590D409BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 02:56:55PM +0000, Johannes Thumshirn wrote:
> There's still a forward declaration in ctree.h:
> johannes@redsun60:linux(btrfs-misc-next)$ git grep -n btrfs_dio_private
> [...]
> fs/btrfs/ctree.h:2808:struct btrfs_dio_private;
> [...]

Good catch, I'll remove that.
