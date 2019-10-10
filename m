Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8046D2F04
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfJJQxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 12:53:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35147 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJQxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 12:53:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so6257441qkf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PxQrbKz7G/kzZPsqDCuYAgClKxKHuF5bkewDB/MNXQ0=;
        b=dRg8tENLLSJOb/0gPPrVOY3cIF6uEFyc7CdJt+ktKCUtbtNV4hcVoM1ot40bcMdYQF
         okhrMOy6VC2Ie/teSGD+GtBb+xN51bjCVm0IItSdvcQmwFO1VDckjEZvAr7gpjmyxqQZ
         mV2kl7Ati31DiddAkg13HuPMrM6E2Mb3HbDAUo94/SeXZNkFsKLHJgLFA/e1ks6uEG1n
         b74sktrAYqE8dXSy0v3tT1eTajih67NT3dYMSiPVkrEF89Rl+PGfDiFuWisoGV+WyUOD
         t/xXmMPj11BWzi3+dDk40HDfVJPHLbkEv2RkaM5wf7XAg5Ytd2nBHMAOrCfSAt6c6Gkp
         4mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PxQrbKz7G/kzZPsqDCuYAgClKxKHuF5bkewDB/MNXQ0=;
        b=gX9duC8fE6LxkZkYTMtqnmBshc/kGibMsmAZ/re3I+uB+1dFtV1FN/7PgB5CTXdHSw
         qj18zb20AmyjsZEZXveq9QdCU73/zBHya3Smkj2xDZojCPvc9kgzMhkDzvMXkZDKKD/J
         +YyxyRPk8M0Oat2p/XzpP08eijDZgjIwtaoMJ05QbCMOIaW68nyIGhrSbGU+T3pDab78
         ZtUCwwkGjkw0s5GdDpXqR/3WT6qFjjkxB7sk/tJPgwXxHtu7Gm9fBNyF41y0s9IJveLP
         6Eh4IS7CycSBhNKiO4JuSVU3LilhtWCiymgZFLDjgOqegye6Oaulf2/q3i7rkyVJsTx/
         dppQ==
X-Gm-Message-State: APjAAAXFmY17eXxTFaHvWvHMpbCzqmbKgfZNdcycuEA3u1oZvms4DHjg
        QS/H718os2Xn3nvwkD5sSNk5JQ==
X-Google-Smtp-Source: APXvYqx+MuvJq9zI+qzgj2LL+MvZe6fYJiPTxgM4qhY1FzwhsTuihLwOPnM7A6Cz6rR0ZK9+alwBpA==
X-Received: by 2002:a05:620a:74f:: with SMTP id i15mr11103960qki.265.1570726396353;
        Thu, 10 Oct 2019 09:53:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id r7sm2894943qkf.124.2019.10.10.09.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 09:53:15 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:53:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/19] btrfs: only keep track of data extents for async
 discard
Message-ID: <20191010165313.mzryz7rv6chijonz@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <679c631d04f50a54f011c6317b99d96798a3ca4d.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679c631d04f50a54f011c6317b99d96798a3ca4d.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:45PM -0400, Dennis Zhou wrote:
> As mentioned earlier, discarding data can be done either by issuing an
> explicit discard or implicitly by reusing the LBA. Metadata chunks see
> much more frequent reuse due to well it being metadata. So instead of
> explicitly discarding metadata blocks, just leave them be and let the
> latter implicit discarding be done for them.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
