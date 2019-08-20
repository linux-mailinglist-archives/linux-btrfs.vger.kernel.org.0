Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FB96938
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfHTTOC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 15:14:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44391 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTTOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 15:14:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id 44so7341820qtg.11
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fU4u4/ERFH24E7SsPAYxeU7JgzK2rfjd/+7WYlrBICg=;
        b=12aMR5lUX0WewWwVAth5/Iqm6WTo9qRu1kWd2/QJLywinslEMVdnSBdVpwyXsXcE2h
         u630mUiQeRgUyJRFF70ww/lW2IWIvOxaHRbkgVrZLjlXs796N8bw/zL+8jvbNRlhj+aF
         jYLfbEl2wcTgMfkDORAE2+bk1w+CJ10KyqtVA293xClUstefmCF1kTeeetddvgiH1VZv
         VOR68GUrNrMb2prU35M/McU7mCwTCkdGAm3GaULfKhNE53GAJgvFxGAkiOw4PMnJktFr
         YKOOSjylovtwLHm3ENJoUL3aafL5KusElttxSfuRbb0PtgqB8XDf6mQO2Yr2VfbXyj67
         jGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fU4u4/ERFH24E7SsPAYxeU7JgzK2rfjd/+7WYlrBICg=;
        b=tIr0XhOgDVyGMESICv5CbHn2h4iu3+i7bQ8Lp9VbRlPJkgc4DQg/1Occ/FhmgW71NU
         4S4HNRQC1D70KjcKP5YAfjx9JRlgm+P3JunEvflxN0PPcMYeiVfyd+ue/hpZLVcjWj2P
         GCikjAaoUj6W+w0jTatVEmJo5M5sVeyf91K+IqafxeZhOCuj5X2YwRYiDiSzMNCSBgB2
         W2uLTvUjs8eO8x+pExqbeKfFFEm8y7AKzXr52+AEPzk/dOZR4WW3TsDJK1JNZcUwZe6j
         5OizPPC01lNPd6c8tNFtOLuctFcb3xecV97BxT3Rr7aGMia2rMkC91Z4wLyMfbI7YoJO
         CBPQ==
X-Gm-Message-State: APjAAAV2r6SSMLUIzLNBF4aXZmDUmmA3jKoDTOsHpN9L2JAEFiLs2pj/
        nyHjG3Jw2uqnDvoLBhpSpcFbtQ==
X-Google-Smtp-Source: APXvYqwsAcuUSPA9BSISVYFpWKPkR8YYckr/hCdZkAx7ToHTcbq3c9NI6Orcz+THjf11A04CWxnp8w==
X-Received: by 2002:ac8:6b45:: with SMTP id x5mr26620965qts.329.1566328440977;
        Tue, 20 Aug 2019 12:14:00 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b1sm8359986qkk.8.2019.08.20.12.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 12:14:00 -0700 (PDT)
Date:   Tue, 20 Aug 2019 15:13:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: always reserve our entire size for the global
 reserve
Message-ID: <20190820191357.um6mhnycbuhbs4vz@MacBook-Pro-91.local>
References: <20190816152019.1962-1-josef@toxicpanda.com>
 <20190816152019.1962-3-josef@toxicpanda.com>
 <c0657408-7291-fb4c-ac20-90d5fd913e61@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0657408-7291-fb4c-ac20-90d5fd913e61@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 20, 2019 at 05:23:29PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 18:20 ч., Josef Bacik wrote:
> > While messing with the overcommit logic I noticed that sometimes we'd
> > ENOSPC out when really we should have run out of space much earlier.  It
> > turns out it's because we'll only reserve up to the free amount left in
> > the space info for the global reserve, but that doesn't make sense with
> > overcommit because we could be well above our actual size.  This results
> > in the global reserve not carving out it's entire reservation, and thus
> > not putting enough pressure on the rest of the infrastructure to do the
> > right thing and ENOSPC out at a convenient time.  Fix this by always
> > taking our full reservation amount for the global reserve.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> 
> In effect you could possibly overcommit by increasing bytes_may_use you
> potentially cause callers of reserve_metadata_bytes to get ENOSPC, am I
> right? In any case the code itself looks ok:
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 

Right, again this is mostly for xfstests.  We need to be able to provide the
appropriate enospc pressure to make sure that we have enough space for the
global reserve.  In practice with real file systems we never end up pushing
ourselves into overcommit with the giant global reserve by itself.  Thanks,

Josef
