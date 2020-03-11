Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A791814AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 10:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgCKJWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Mar 2020 05:22:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34753 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgCKJWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Mar 2020 05:22:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so972678pfj.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Mar 2020 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FQS/j9yBfIirYA2mNXcbGrWYg1ZDauvghrhwsccQV4A=;
        b=Sq783TJeATMrIDaGzZADMUdAfdHZulX13J+tUsFedcvNkE+ly+fh/eKrehZdiL2Wvr
         UrtE49tkaAH10wB2XRGP8nur/aZBQt5ZTetqVVZwQpVFxx3fdt5ShYRFLLcsc7Kb7s6f
         GFss0FKyOUc+wxtFwH508IB/GGUo56TBAKLTcu7G/ppv+Ca4e2jN67XBSMROjAP9Zz6G
         kd9feIvyMuxPC5+ZhxyflMKVARzJIh/KQxdXdKdDgD+XEnry1Je/ez4RITCdme55S12w
         sOroshh0y1xukwopUyppEwucohK5JtnElT2wSP3uz3YNecDLNd4hl9UsvgbE5pc2OlNq
         bIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FQS/j9yBfIirYA2mNXcbGrWYg1ZDauvghrhwsccQV4A=;
        b=rWDugoQ566zgWWEiFdirI0RH4bixrU0KRFXm6mdO1KZb48Ay6L/VQnymV5dymc7F6V
         oV9sGnWSii4CE30y7YCXrYxokRH47rUZswlNcBHdxwcs/sjn2mZom/WgxTEqhxiyA1Xp
         LAt8hpD4gYggZ1zalkNFjmNeBT4dL59pRMJXojE2+13oVfKb0wSieqObT1k/+xabs0nS
         ObBZZ5PDbE7V5u+NtMDWC1EdBcK/8N8W9fOISr3WWlUVHVas+ZSgPQ1ifhKeS/wErpxP
         tw/izc4TFD9pjPTueSf7nsY0fEAoBTxXyaezyrJfn+9/fN3MlIyDUCse26kEMTc55aL9
         H5GA==
X-Gm-Message-State: ANhLgQ04INH3/J7iYZ80DSDvHHAfeTsuqiyG29tz9NISwh87x2mT3H+w
        FzXSQrAV8VtKAZmyXeYjnxD/4A==
X-Google-Smtp-Source: ADFU+vuP4RE0YFzSON6lz8GwqMtHLpKSd77dy3BpQmXJ7JpmouAA65o42nIZwJvg+N6o9Z/PmtjJjA==
X-Received: by 2002:a62:170f:: with SMTP id 15mr1948973pfx.12.1583918572568;
        Wed, 11 Mar 2020 02:22:52 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0::14a2])
        by smtp.gmail.com with ESMTPSA id p187sm4194865pgp.28.2020.03.11.02.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 02:22:52 -0700 (PDT)
Date:   Wed, 11 Mar 2020 02:22:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 00/15] btrfs: read repair/direct I/O improvements
Message-ID: <20200311092251.GG252106@vader>
References: <cover.1583789410.git.osandov@fb.com>
 <20200310163940.GE6361@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310163940.GE6361@lst.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 05:39:40PM +0100, Christoph Hellwig wrote:
> Adding Goldwyn,
> 
> as he has been looking into converting btrfs to the iomap direct
> I/O code.  This doesn't look like a major conflict, but he should
> be knowledgeable about the dio code by now after a few iterations
> of that.

Thanks, I did try to avoid conflicting with the iomap rework, and I'm
looking forward to the further improvement.

Btw, Christoph, I'd love to get your opinion on the RWF_ENCODED series
("[PATCH v4 0/9] fs: interface for directly reading/writing compressed
data").
