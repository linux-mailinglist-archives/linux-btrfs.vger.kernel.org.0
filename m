Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C16D2CAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 16:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbfJJOid (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 10:38:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40881 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfJJOid (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 10:38:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so9022811qte.7
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qD0qJs4tdhaeb/bkU/kFfvUeLlin5sCwoXVjyKsqiTM=;
        b=XzcICxBk16ptZSYZb+O9CFHv2wBu8YvS3gqR+13to2n5/vdgisxnrvOv+qxk7go2VS
         uKFLmgmPXMh1MaflB0oN4Rba5nH4honCsj+7wMa1TX87T1WDUz/md8pt53KH6EB8Imvy
         SzACEjFaSIQo8IvuhGFau5O+2r5YhycY2niusfwDDbbXArHjh9LUqhPNlmqNxUfuCjRw
         IeYHJuXDF3f3PtTESNaMQAW26fWSibiV0VefftA1gNLehPQAZbOyq3YuUw5uXESZbAop
         WiXP79BF9ryZaU2XqOjhX4ZTDwiCiWXcxlo1rYa0hvD3Wf8hI0crxMIIixziNkabbDrw
         W+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qD0qJs4tdhaeb/bkU/kFfvUeLlin5sCwoXVjyKsqiTM=;
        b=HaTBEG6oEP4b6mlKHcN+iYE70dPGm6tmWqmHphgSfB76F1OfbeCa3HQ2O0H9c3eSbP
         sRUSOl4T7i5PvR3iYWAaGvF75zYOdA/awDXQjMPvjT80xZTiX1eO4DYtITLH1eRlET5k
         5FxxBx+44cjcNUSALqpfKmmryt2AiCWWWydPqwzejT+dCRABqCJuquHwDUwROOxTx1QD
         LgZ09NlxvV2DHyJ8MEUj6SVzpTfasXqpfXzj8nptpPx/O/0ojHtG84gdQi9nNry58vFK
         klENSkkYU/PfJVc4ZibHbG/AUoSidCADTRofBkyUIVOwH/QwwUEkRJq1yHksSk6EEvi+
         QDFQ==
X-Gm-Message-State: APjAAAVGemypxaMGCVDog8yt999B3Kap7AgkBAq5gP2u4HJi1/mRsXyE
        CHmkgNyAT54FFyOaIpGU3tqt0w==
X-Google-Smtp-Source: APXvYqyQKgSBoEEZLFlyGaraOm4/QCBP/QVy8R8i4XxFTr0Wf0CQ+sks53uuS/yJVmJUwX9WGuGsjA==
X-Received: by 2002:ac8:65cf:: with SMTP id t15mr5635735qto.357.1570718312011;
        Thu, 10 Oct 2019 07:38:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id t32sm3610805qtb.64.2019.10.10.07.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:38:31 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:38:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/19] btrfs: add the beginning of async discard, discard
 workqueue
Message-ID: <20191010143828.adkm6h2ktxfcgr3v@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <b2f59782f8a7b02fee6c3a2994154b01134b09dc.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f59782f8a7b02fee6c3a2994154b01134b09dc.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:36PM -0400, Dennis Zhou wrote:
> When discard is enabled, everytime a pinned extent is released back to
> the block_group's free space cache, a discard is issued for the extent.
> This is an overeager approach when it comes to discarding and helping
> the SSD maintain enough free space to prevent severe garbage collection
> situations.
> 
> This adds the beginning of async discard. Instead of issuing a discard
> prior to returning it to the free space, it is just marked as untrimmed.
> The block_group is then added to a LRU which then feeds into a workqueue
> to issue discards at a much slower rate. Full discarding of unused block
> groups is still done and will be address in a future patch in this
> series.
> 
> For now, we don't persist the discard state of extents and bitmaps.
> Therefore, our failure recovery mode will be to consider extents
> untrimmed. This lets us handle failure and unmounting as one in the
> same.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
