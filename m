Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD4143F61
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2020 15:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgAUOWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jan 2020 09:22:54 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33446 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUOWy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jan 2020 09:22:54 -0500
Received: by mail-qv1-f67.google.com with SMTP id z3so1524548qvn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2020 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D+FVxDgPLm35FxPtevTHxMCjXyJXcMVvcIGAtCBFnFQ=;
        b=aKfe/B2FwWblKxNQnSJ3HY7tYIXpCCWXuPW4aWk/4qfz6kIhP/0If86z5dRpSJwuZN
         TLwFHRARD9ycpuA1O05rO9TTUQQKIUSg2vw5LAdZr4u2Z6k8T32C9kYgto7E653aUFxW
         xb0Qx1SzHJV062wjfsvZnFSHwthNd1RllbdjJwnTyZiS4LyQbkVSkjQFgLSkrI1KjjGx
         3VNtPHYdgpwiLs1D9BxsjIovWnpEWnXlqSbc45mBYa9xDu5apc8HTQ/7jo89LZt5wDeo
         SlqLzJjfF7DW02swNCbu82W8WHFbjBTpYsn+ql9ZqZw3RXUv+dKfKt60IE1dIsEC7rPA
         Nhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+FVxDgPLm35FxPtevTHxMCjXyJXcMVvcIGAtCBFnFQ=;
        b=AXmJZ1NxtYl7cJi3jZrQCsyIJ5i9G9HjBM3TEmuh38ioYtfDzalIC16LDrIqYksYT/
         R7jgHAvkUUZYIXETrt/cbCQS/H9X6+iJdiVCwKPQEOjRNqOGmlUeHy54Vnp78QNcSI7R
         5pEjCfvM1uBldiamhuMJWe2Sdc6GD2tyqnS67ZB1mUa6dDzsHq6XBSJM9YDupNiWpPgj
         opnRLNQus1fowcFdUecthx2t3w6wETJ5FU2EGuJhthgcVfFdHL59bHNN5WsT+RYjrze2
         X2uFJK3GTl+gXiWDU+glCLgbXnlH+CdAzF6+jpOpiFpVcQsfRjAkhWgSLbpjq6OwQ8lb
         UdZQ==
X-Gm-Message-State: APjAAAXV316VYNwyhK8i0cAR242Si3CxKqCafh8q5Y8wMWQ77aB3bnOI
        Mqan/8LFa/m6I/hPEkxMmghc1xrNk2uuLA==
X-Google-Smtp-Source: APXvYqyQDSk4Yb98+Lvbk7TfUP9hn9peLYP9J9GxNcSDONaSehfQZ4wD8980d08mkY2exGiisyGOxQ==
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr5019876qvm.182.1579616572973;
        Tue, 21 Jan 2020 06:22:52 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x27sm17147592qkx.81.2020.01.21.06.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:22:51 -0800 (PST)
Subject: Re: [PATCH 01/11] btrfs: Perform pinned cleanup directly in
 btrfs_destroy_delayed_refs
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-2-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a40ccbc3-2c9e-590f-86fc-bb362d6989f4@toxicpanda.com>
Date:   Tue, 21 Jan 2020 09:22:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-2-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> Having btrfs_destroy_delayed_refs call btrfs_pin_extent is problematic
> for making pinned extents tracking per-transaction since
> btrfs_trans_handle cannot be passed to btrfs_pin_extent in this context.
> Additionally delayed refs heads pinned in btrfs_destroy_delayed_refs
> are going to be handled very closely, in btrfs_destroy_pinned_extent.
> 
> To enable btrfs_pin_extent to take btrfs_trans_handle simply open code
> it in btrfs_destroy_delayed_refs and call btrfs_error_unpin_extent_range
> on the range. This enables us to do less work in
> btrfs_destroy_pinned_extent and leaves btrfs_pin_extent being called in
> contexts which have a valid btrfs_trans_handle.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
