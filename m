Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4376345EB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfFNNpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 09:45:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36621 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbfFNNpF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 09:45:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id p15so2497248qtl.3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 06:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoE9TTwZ2oX4l67lO4UKKcsLXQImUKGP20eXDpNCJrQ=;
        b=CmA0VwwEqJigtFceHJxQeYm3whQH2/+4pEJ/T/TOOR81IIrusYRBFbvLnkk2d8y9zK
         n1zgsO3A3KhD6bJjzcoi53PSKIjlVu7yoeqsxOpjp0j0dLgQPuSs84L29BAT52XfCqPT
         0l9Luwh6m1xaqa5JgO0hohC6Kgb3fA6L1z+xJnvYDCe1p1/uQVjEmDenWKlttKNMi694
         O2zTv0sNHEM8H6IXKqNLita+OS5cAnoiCLwBMN8+xxSjPZvbkjNWrxPhgBUR84mn84bD
         iTnsipFfh1WbMAjWOuKPoxmuL5PsSVfcthoirTwInDvf05QM2YmJfPADbHinscIK24+J
         HwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoE9TTwZ2oX4l67lO4UKKcsLXQImUKGP20eXDpNCJrQ=;
        b=T4efOdw/o/c6EhpvQ0MeJu5JgovgPt3NO6xF8y9qU1rZs98ZnwmTt0urU+kAj2/Np2
         vHFC6/kJ67udQUncFd04RiUC2+ZptKpyprwvQiOAQ62tAjug9aVoUrIImsOglBcIqT2r
         FSJ0rUeha4thrfjX/nSoVit/loCsRQGPefLDPgwwGuwgBNqMkxh31Yu3tgIJiqXbvNlm
         asHNq8N/KOIfyF8ExVTIvQBU7RlNK+2rLgPyp7m/TsD9HzgOn2O6sszGXO+TjIVAq6lj
         zzWwgd1sTUvFWoLHTeXRVUSzDrn9qQ62KYxrLUsX1oJZ2WMOtFlTlpcswNeUnde7Uy3u
         U1UA==
X-Gm-Message-State: APjAAAXUupGP8+S2aTI/C2z3nDTXN5S+RwN8nX9Zr7cPEU3ltI+bRbsi
        9s6P6v+h55Fu238PJSA3EGN9KA==
X-Google-Smtp-Source: APXvYqzK0goCeSYPjF5bhIPBakUW9p6CVwC+vyGH1n/OjNW5KJjnzAEtFGiENd0PQTCzCI2Gq26ImQ==
X-Received: by 2002:ac8:374b:: with SMTP id p11mr77934298qtb.316.1560519904543;
        Fri, 14 Jun 2019 06:45:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id c30sm1843863qta.25.2019.06.14.06.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:45:03 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:45:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] Btrfs: stop using btrfs_schedule_bio()
Message-ID: <20190614134501.cjnrsb5n6jtteqex@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-5-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:46PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> btrfs_schedule_bio() hands IO off to a helper thread to do the actual
> submit_bio() call.  This has been used to make sure async crc and
> compression helpers don't get stuck on IO submission.  To maintain good
> performance, over time the IO submission threads duplicated some IO
> scheduler characteristics such as high and low priority IOs and they
> also made some ugly assumptions about request allocation batch sizes.
> 
> All of this cost at least one extra context switch during IO submission,
> and doesn't fit well with the modern blkmq IO stack.  So, this commit stops
> using btrfs_schedule_bio().  We may need to adjust the number of async
> helper threads for crcs and compression, but long term it's a better
> path.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
