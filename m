Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36A02A525B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgKCUtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 15:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731417AbgKCUtG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 15:49:06 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8F0C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 12:49:05 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id w5so8595021qvn.12
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 12:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tBmdjFfExePQoaL+smy5S24MNbu8QmS+sYm/z0n8zL8=;
        b=EYO+r/+hBkrb7ECH7ZWSrNPgY7evhVaQWBtWM0YZlFx73Ulu5bIfgEYPs42r5kTCAf
         Xs4FtWcuWAIOYyBGMyHYNc5YUlkgt+ONi3cqGJU+iK4+rK6SuwIlU78BYcBpRlrIcaWi
         w277K9iTEl8UXlY39963/h5xr8MFHCI+GrRNMtV4/vvynU4jyDhWZ3kmrXe63UbRLgzT
         zi5RN0Ys8m1KI7QAGMHYxWiX7mN0Pyi5IvAuaMT6s7IUIMvuBpbZqN8cgnhbVG9ryxcg
         IYNv/RZEPihEktrDoU8mYjHm8P2N1t0GAHx9NZWeowVRW7iUIMfX2/FMh9WxZUsypfX1
         +MPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tBmdjFfExePQoaL+smy5S24MNbu8QmS+sYm/z0n8zL8=;
        b=hY24XlWaSFEexPwEsMErkOc77kQdKhiwiqvfhjr33kT8iPCKkGtjflleHHGUopfPF2
         lErW1RVH4knJKadkpu6pAOM/dNg3fEffL91+irxRiR7rfO//tGs6tq2tLyCl35REX6bJ
         JQNfCuPpZVvzMcd9naL5lXlE4xrNlA+vTkGXAKoz78TBhkJCbn31YeKtTtADJo8pp77Y
         BXXUQ0QR7a5rR+41EfkrJpFcI8ovIZBfeSN36tdUERwfWivv/mglnW/sTH4nxk15W/l7
         iTeEaIl8mm36/TIpCJsxGh86oYsksmxCx/4eVhkoC4oT97w+b7lhtGL7SGIHErJDVBrV
         PJdw==
X-Gm-Message-State: AOAM530KN7k2uVQVd+hIFgtOwb88aX29txErZ/QdpeNbmdrfxrbu60bb
        fQBRM+ebWb8BHUQZeTI+d8LQ1g==
X-Google-Smtp-Source: ABdhPJxQPwgwJDdZAk9c0Zz7r3DU8Iu1DeurdZGeiUgRvgTUEcGIar78bHqGVJ1v++jpGQ2KLlfNUw==
X-Received: by 2002:a0c:ef02:: with SMTP id t2mr28488462qvr.7.1604436544665;
        Tue, 03 Nov 2020 12:49:04 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n81sm4943666qke.99.2020.11.03.12.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 12:49:04 -0800 (PST)
Subject: Re: [PATCH v9 39/41] btrfs: serialize log transaction on ZONED mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <e4622b1b8b94de9b4fe379c694f11524c4341bf6.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <0307b4f3-1a5f-cb21-fab0-561c9fab783b@toxicpanda.com>
Date:   Tue, 3 Nov 2020 15:49:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e4622b1b8b94de9b4fe379c694f11524c4341bf6.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> This is the 2/3 patch to enable tree-log on ZONED mode.
> 
> Since we can start more than one log transactions per subvolume
> simultaneously, nodes from multiple transactions can be allocated
> interleaved. Such mixed allocation results in non-sequential writes at the
> time of log transaction commit. The nodes of the global log root tree
> (fs_info->log_root_tree), also have the same mixed allocation problem.
> 
> This patch serializes log transactions by waiting for a committing
> transaction when someone tries to start a new transaction, to avoid the
> mixed allocation problem. We must also wait for running log transactions
> from another subvolume, but there is no easy way to detect which subvolume
> root is running a log transaction. So, this patch forbids starting a new
> log transaction when other subvolumes already allocated the global log root
> tree.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

This restriction makes the tree log really, really seem not worth it for zoned. 
  I'd rig up a fio test that does fsyncs into multiple subvolumes and tests this 
vs just committing the transaction.  If committing the transaction is better, 
just skip the log altogether for zoned.  Thanks,

Josef
