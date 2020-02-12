Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2415A9B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgBLNHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 08:07:05 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLNHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 08:07:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so1459047qtr.8
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mHdCILFKkUG6WkOpI2Vw27Zx0R8ms5UtGVq7fElTqTY=;
        b=1zvKAYTOPAgT4gL1y9t+13uQ7MUUYts6IVbpOZ1wHZnFzs7LKSU1WpcO03hHQZY1Rt
         M8yBWgJwftez2yC6KO6yFr8EsL4X5JKJYlq7O3UIKpxTSGlWGL13BnqlheuIvH87EN9e
         3NJXlgsAgsZViO2M166q5CcwiOg5MNatn97ekuOx4nB/Zt2Ymi791MrrBRjZsBu/OLI2
         0bBTbSh7O2HMmNNmI7wvHgB2WAA3XfzJljE5eWfk4/oKeX6uwKKk/qumqoLwtqoVtpdj
         2v352xtobfMb2z7U6OmaASzYYW9FOeUQV+HdTVm4VfkGiR+SU9SMUHWiJugrjIcJvCM2
         uOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mHdCILFKkUG6WkOpI2Vw27Zx0R8ms5UtGVq7fElTqTY=;
        b=iwB98ozPSAypZ6tFB2FHyMHZT2ZkZm+iUywXu5wX+qeXEYrBIq2ZmCcG5p1ssEknRa
         d2FAD9A14YXQHh+IY4+8cG/SxMhyAc8UI5cHgy5lh8ZgLLJ745qLk/fCdwcXwPk3UgBu
         m504VRD3gscVkSmIhjWoe3zFFzM+zJvnsvZKBFujZqMv2wqe7OQWHfm3evYsq7L8eIQ+
         TC5DRsLfeBoJo6rVbUKKt1HVlFUJHP3wrh08rUVaDvGhxEDM4CWGkweDtCnypCWe+tOU
         o61Faw+53jL87iZDbEOP2brYmwfKq4SX+JRN8Hv4/l8S9LpofSENnBQTUd/IXB6rvezC
         AzLg==
X-Gm-Message-State: APjAAAV9LfGD7oU+ovj0JzVH25EWqacz8Z+a8wMcUyNILkx2Jdotq6vA
        ttzussa7B0a2fjZqeVVNUoQslQ==
X-Google-Smtp-Source: APXvYqzV1noKAUlY5/0Nf2fkFT/eTy2TBcOZYv+Ywb3SC/7k6aOcArPifulZw0Wj82+kMYGUdBbiCw==
X-Received: by 2002:ac8:7cb0:: with SMTP id z16mr7017910qtv.276.1581512823764;
        Wed, 12 Feb 2020 05:07:03 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::de08])
        by smtp.gmail.com with ESMTPSA id y194sm136943qkb.113.2020.02.12.05.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 05:07:02 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: destroy qgroup extent records on transaction
 abort
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
References: <20200211072537.25751-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ccc3f912-b4f9-f8ed-37b9-9bb71f0052ee@toxicpanda.com>
Date:   Wed, 12 Feb 2020 08:06:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200211072537.25751-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/11/20 2:25 AM, Qu Wenruo wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> We clean up the delayed references when we abort a transaction but
> we leave the pending qgroup extent records behind, leaking memory.
> 
> This patch destroyes the extent records when we destroy the delayed
> refs and checks to ensure they're gone before releasing the transaction.
> 
> Fixes: 3368d001ba5df (btrfs: qgroup: Record possible quota-related extent for qgroup.)
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> [Rebased to latest upstream, remove to_qgroup() helper, use
>   rbtree_postorder_for_each_entry_safe() wrapper]
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
