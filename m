Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF6B03C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfIKSnT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 14:43:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42180 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfIKSnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 14:43:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id c17so7193128qtv.9
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Slxu4uoo+Zmzumy/BkMxF3YmBPycJLj5V2xEG3Usynw=;
        b=aB6smhdFTezl3uxNAaRGrw9/SV4+28l02ruRZfT8u1yh/x2S8KAeku8vRljj/7/NBz
         9ew45p2pxU5F1j3eX7L51U728CgVDWNLIWuT613SOL9dS1blfwU/M3xAmx52VGOQsCvK
         GnUwo86+zpo++nu3j2Q784YPd1BwJqR+fl/AbnnqWMEQQIFmtHWJzWUQgsPIFSSWkCcd
         BMxMVUA2Myeq9PLmrWxLemXvnDd3kcuCasJQyXnBtDPtcVCfGW6T2CsYBRP5Rw9eev4u
         IPfySfmMW+Ffj9QIATEqaCq9H9ks3Kmq3vx0GBgzESWMz1H8KnITJ3kcSrYEErHWxS3N
         LZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Slxu4uoo+Zmzumy/BkMxF3YmBPycJLj5V2xEG3Usynw=;
        b=inLJ1aEZYE+h3q4eRIyCJ4T5b43BWG4WuO5jdhfLTpRLuAycmx70nUazaWga9Bg/8J
         3g4RQPPx+OuUX3WtQSiBn27KVzb90NHez7IGCxJ1Wv3Vd3XO4537rMySE/8zTUrnjo6W
         bNivEKtfYDFGGUwvzdeauAnha6jx4sG1IwA3wsB7MYTAZ1lSftqsyHQmXMpgVcX0cvpc
         dkRGa+BI/BOpQmqTPgLdC9gHkYslgJ1G3XhbrWlmtoHCgqgnB9PG0AQANmYMV50eoQPY
         73fJjmQutzQlo8zANJui3jQJbr6h7ZRKPKu0qRnwOCEUjQe1lImUZahOyg0hMaxNYAAA
         H/Gw==
X-Gm-Message-State: APjAAAXi6zAm1KuQWQlu5LLIGrEZv3bK+cwViHpvjVEE6UqZGeHG9SlF
        O20YJyH+h7R7tzj/zUHfP6CYcQ==
X-Google-Smtp-Source: APXvYqy/vzkSerD7blvkUYnv+MqtTIssAo0nqUQEz0FWEDgn7us2ji3nRUoRPFhFg0xwY7Yc3B2EKA==
X-Received: by 2002:a0c:e946:: with SMTP id n6mr23626300qvo.214.1568227398714;
        Wed, 11 Sep 2019 11:43:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::87bd])
        by smtp.gmail.com with ESMTPSA id g12sm9409007qkm.25.2019.09.11.11.43.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:43:17 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:43:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix missing error return if writeback for extent
 buffer never started
Message-ID: <20190911184315.g3c7kbibbvqox5pn@macbook-pro-91.dhcp.thefacebook.com>
References: <20190911164228.13507-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911164228.13507-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 05:42:28PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If lock_extent_buffer_for_io() fails, it returns a negative value, but its
> caller btree_write_cache_pages() ignores such error. This means that a
> call to flush_write_bio(), from lock_extent_buffer_for_io(), might have
> failed. We should make btree_write_cache_pages() notice such error values
> and stop immediatelly, making sure filemap_fdatawrite_range() returns an
> error to the transaction commit path. A failure from flush_write_bio()
> should also result in the endio callback end_bio_extent_buffer_writepage()
> being invoked, which sets the BTRFS_FS_*_ERR bits appropriately, so that
> there's no risk a transaction or log commit doesn't catch a writeback
> failure.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
