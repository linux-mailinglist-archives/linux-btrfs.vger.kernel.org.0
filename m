Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7AA8B23DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbfIMQLb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 12:11:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45998 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfIMQLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 12:11:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so18334405pfb.12
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 09:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWe0ZZ0IXaRH+sh0PL+wEaOINivVRBqqrjGgRfDIXUI=;
        b=uWEeTnyo0jPB9qYZiIPIzr0BStfVVaqaKivJUitve+eh6/If4gCgUM8X11X8Dl4nBV
         amRf9b2oF4X4bhgU+MX2jLSe+49DKPvslccMPxa/P6IoNC6gCE2Uf3lsJlpWcayxJeM4
         6Dg0HnXVNvK888NI0K9Gt0HxjvoFkxq5dXKm3s8fWfkS8vB6HLjv7UMzHy9JdQQS+Axf
         Yye9UN0HtYo60dkWaItot65xLfOTmeJBFH0WG3Rap7bIl7h1MNK7AAbypUS/Kn7ku1sV
         Mqdv4lzCQNDtmST40jeKDbWpdsJfCWSDYz5A1NHYocNHfjX63XVk4f6PYWg9kbdQiDZy
         o/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWe0ZZ0IXaRH+sh0PL+wEaOINivVRBqqrjGgRfDIXUI=;
        b=aWHH5svg2+xg1Yh/jB3NTij9A2utEZrm0PurTxh6tNfDTP7zTw4INH/TdBTyPv2YGv
         pqIpK1ZQWib+OG4mv537G/XbVJP1ElyFqhNsYS2x1jDC/y563zcPuYe40SEuKrb5EGgA
         LTZdrF5bttTSgumdZAs7OVqCN5IQw5NXAx/Ii2Foa8k0IA7V1dmH956F1xjS6aCdpyZC
         VAXDwnA0mBb+HsX2Zf4yocmrsAxn9e/1Icrz76tii1wZqnQoCwDbtC9+TzhvefSeZEBF
         Qcp5BSFcakr8uzY0gUn6NDngzDeXuXlvgdKRArJkh654wfwdBwLsa+pa7bv9SsSg6GEE
         ZBZQ==
X-Gm-Message-State: APjAAAXR2To7moCVpjoViv0rRufDbjqu3Kq3Ss0oV+SIS2DL3QJQr+MO
        OAxjOm0mVQ2qCxnIstN8pnsINh4u4K125A==
X-Google-Smtp-Source: APXvYqxDstX47ziAB6ReNrQTINgsmKHIuBbM/fEMUzZzMkc8RtfrcivNG3ksvKL7UZtwfk945O12mg==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr5844608pjs.54.1568391089086;
        Fri, 13 Sep 2019 09:11:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:200::1d1c])
        by smtp.gmail.com with ESMTPSA id q13sm14149060pfn.150.2019.09.13.09.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 09:11:28 -0700 (PDT)
Date:   Fri, 13 Sep 2019 09:11:26 -0700
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Add assert to catch nested transaction commit
Message-ID: <20190913161125.n35ihlpgrhk5iqzi@macbook-pro-91.dhcp.thefacebook.com>
References: <20190912153144.26638-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912153144.26638-1-nborisov@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 12, 2019 at 06:31:44PM +0300, Nikolay Borisov wrote:
> A recent patch to btrfs showed that there was at least 1 case where a
> nesed transaction was committed. Nested transaction in this case  means
> a code which has a transaction handle calls some function which in turn
> obtains a copy of the same transaction handle. In such cases the correct
> thing to do is for the lower callee to call btrfs_end_transaction which
> contains appropriate checks so as to not commit the transaction which
> will result in stale trans handler for the caller.
> 
> To catch such cases add an assert in btrfs_commit_transaction ensuring
> btrfs_trans_handle::use_count is always 1.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
