Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28D923FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2019 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfHSM5E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Aug 2019 08:57:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41233 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSM5E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Aug 2019 08:57:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so1262776qkk.8
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2019 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jCX1AJzISrHkBt0QsMJbNF7davhKlnyeAHP/Wchb5bM=;
        b=hPRBId9yassQH7MOMQSlz7wBw5Zjn2f/YvXZR18psnESw4JzG7IQGTl6LVyy4UsOhv
         nlP9bC2LYonGGmYNW/uMKDORHWXSxxzEmgkhtENT15Uu4KQPwK0Zsv0wArSVVnvBZaDF
         aSU+I1LE4RcQwbMVVOSp84/Qcvbs9JxtPl0vU3WkRAjIyJ6WgrxBriIuoLVx3l2/OxTB
         p8GC1hzbXHDZoJwg1FuuHiMgLSO1Xj551mw6qbHYCVUdh+HdkLQxjtHOpRi/hTtT3J9U
         Neg1Zt9A8Rr/lL0ku/xSWizw8cKXPL+QzWKFM/UBcvvvRZRA9r2e5BbSMbS5+4l+eYwo
         rOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jCX1AJzISrHkBt0QsMJbNF7davhKlnyeAHP/Wchb5bM=;
        b=RcR7ZOM+7kGjTODIhXYyrmno042Gf2+FwF5yj4TNRbvUGC5U8hyJbqhNwToSI8E/Rm
         t2+xQYbAxKOKSKev5KBa5rZC9cyxafK+QLNfH0NVAJfswq2T8fujiMdSyV4XHGYowy0f
         yKiVGIlB67P1107Nr+FasRwC5acSCgfxyGSNH/khTD5BKfPsJB59MfKVk701chUmRaMh
         vI2EPDeWm0Yfw/eFMaM1A/S758eLB60BIXLDWa4KX45GMJ7rnmlb+pz3PMVNY7ZsKHs+
         QDdTu2T9+SN+5JLlJLhZP0iAves5B0hNEkCDK+JGmNBjtR2MiGXkwszsKpaj7zn/rwjt
         q+qw==
X-Gm-Message-State: APjAAAUiLq0UbbjQWtDFIovelnnby4ZVevbAnGphTx3MoamIeJ0FLeqv
        mroLh3rO6B6G25Azm3xkfui594w3PFFxwg==
X-Google-Smtp-Source: APXvYqwGHMYuD2z4/qVGPwZsYWCZTaqFaus8NCDX3tb9YEga1XT5R6DzTcOjBGPhoZGkFi4oBrsesw==
X-Received: by 2002:a37:6248:: with SMTP id w69mr20483809qkb.225.1566219423813;
        Mon, 19 Aug 2019 05:57:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q42sm8314047qtc.52.2019.08.19.05.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 05:57:03 -0700 (PDT)
Date:   Mon, 19 Aug 2019 08:57:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/8] btrfs: do not allow reservations if we have pending
 tickets
Message-ID: <20190819125701.yozw7ztdflehmg66@MacBook-Pro-91.local>
References: <20190816141952.19369-1-josef@toxicpanda.com>
 <20190816141952.19369-2-josef@toxicpanda.com>
 <76d54bb3-390c-772e-83e9-0f8bc2a18cba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76d54bb3-390c-772e-83e9-0f8bc2a18cba@suse.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 19, 2019 at 03:54:29PM +0300, Nikolay Borisov wrote:
> 
> 
> On 16.08.19 г. 17:19 ч., Josef Bacik wrote:
> > If we already have tickets on the list we don't want to steal their
> > reservations.  This is a preparation patch for upcoming changes,
> > technically this shouldn't happen today because of the way we add bytes
> > to tickets before adding them to the space_info in most cases.
> 
> nit: IMO this changelog should be a bit more explicit since this commit
> really makes reservations in FIFO order. Have you also quantified what's
> the latency impact as I suspect this will introduce such latencies?

Reservations were already in FIFO order because we would add new space to
existing tickets.  This doesn't change the behavior, just makes it so we get the
same behavior without refilling.  Thanks,

Josef
