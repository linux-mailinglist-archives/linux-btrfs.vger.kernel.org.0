Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA729064F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHPQ73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 12:59:29 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38234 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHPQ73 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 12:59:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id u190so5274022qkh.5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYcVJdXTVkl3Ik3a4wSolvh5dSr/1mrUma/NCVtz448=;
        b=VDSyVe0WVri6OAIqMuyRwQtXldlDlOVZWl4kdL2c16WhAFi0wfBz9s70nHuQc4zG3R
         YQA6arX9SF5M+Fjj75yURI0vGIbwL1WH17nw5RV5mClzpF6m/PaplVJG5sl4d/dcWeo0
         G7g1IRm2GNJCsR32BgNMj2lInEGEGUCUodV/BQAHe90QGZNib39YSGt3bLjYxvA6ohmD
         17KHdx7lfJDk2hrZplm3rWFmvAafbiFqkaZWck6JLmNb2Yul4iIzx3lBXGPbF+7z2zP3
         Mub4raiKadw2r6SPRfTTJZrHAX+Zv18aBSxs1X3wTjRuyqMlI+fQlocBA6nRn39smlCz
         ar3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYcVJdXTVkl3Ik3a4wSolvh5dSr/1mrUma/NCVtz448=;
        b=p6qpmchMAWkq5FvkugonCTqLvq8WuhkPIm7Ypqar3XJlSyfALu343J/nYaykju82Cg
         nRVTougnfAb6wD6PBd2naNQkPDnhkCjG5o8B981ltiNX9bzMGCjQivqtoY3Z9ktJOj0q
         5B/ukdZFQViUzOdhf9huvX/YqBCoLZALPduN5oa9ILdCFBuXUswzExAB8eCLE+OroeaS
         Ac7basLtjCzB7GKZsSzAUjnkvuMTZ7lqe0wha6tvjyfv95m+vSl8qL16ZDPDGxfDmElb
         Hry+1/v5Rm3qTED9nykb8cyrnVAJlWwqFQ574ExF69TqCl/CNzD8JGyseZleoI5ETYME
         z9ig==
X-Gm-Message-State: APjAAAUE9ZqOllDB4HytYJwkGYl0Lxv/Jl97xgRNR2fWENto8c0JapHI
        gBHuYPrsPTH1IKJVlu6a6dKV1g==
X-Google-Smtp-Source: APXvYqzPPlJ1Yc8e5KtWtFuEW2imb8KbG8xS/GG1IQe3uitMhU4b5J7t9BO9EpcxfBIRHgtMmheTZA==
X-Received: by 2002:ae9:e413:: with SMTP id q19mr9685592qkc.227.1565974768365;
        Fri, 16 Aug 2019 09:59:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z187sm3646860qke.99.2019.08.16.09.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 09:59:27 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:59:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] Btrfs: treat RWF_{,D}SYNC writes as sync for CRCs
Message-ID: <20190816165925.3kkpx5o6mmnfecsh@MacBook-Pro-91.local>
References: <cover.1565900769.git.osandov@fb.com>
 <ba7aa871e255c0e264a782b863513b9afd499f91.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7aa871e255c0e264a782b863513b9afd499f91.1565900769.git.osandov@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:03PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> In btrfs_file_write_iter(), we treat a write as synchrononous if the
> file is marked as synchronous. However, with pwritev2(), a write with
> RWF_SYNC or RWF_DSYNC is also synchronous even if the file isn't by
> default. Make sure we bump the sync_writers counter in that case, too,
> so that we'll do the CRCs synchronously.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
