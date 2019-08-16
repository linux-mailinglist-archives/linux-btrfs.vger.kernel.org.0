Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822C790653
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfHPQ77 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 12:59:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38852 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHPQ77 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 12:59:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id x4so6799717qts.5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 09:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cHw+dQ4jZIlg2//eN4e++VzWq1BOHhGLHzuaEHbvc2c=;
        b=RO4s5LMaeIiOaJ1d9OmvPVtwGERT1Q9T73BbASoC/npdjvatH4/OZwyQD/y3T1moMI
         LKYQ9DVceFjkEu2nIiZlsyjN0EXnBaZZaKTPy7lxvmmlrKcay5FTKdCH6d2PEUsuCtpA
         ywigUFoReRmy0QdSZWpt2x7NSzCamF3DRU8CWYZO7Xptmcme0O4//rCnJOO2A9H6g4sT
         7OMt5g18fgxwOosr0Yb7J7Pv2v1XcdjngG2HxPk8XzDTLsiuC8B0XWLDmmGWEij9WdYC
         BQNp6cXVn0N2k4Xz5Q4nOFnMr7bGNBjFY3FO6RGbNHYhd3jUW9oAIOj9UVj/Pjh1Oihj
         faBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHw+dQ4jZIlg2//eN4e++VzWq1BOHhGLHzuaEHbvc2c=;
        b=uB59XEfHYi2DT2qjTguonyrkkHwdGRkqgmul6lwr803SY/9vz5ZVaJzn6klECr+/7L
         p//f/kgP19Qv8heKid2zm7fQfa41LT16QgCQ69nt5UBdGEbrpFR2oPszS2bGHPi7G7r7
         jck36FmfwBm5pDiYOBR0BQghGSO3putLLB3wlZmHEwws/1cBGN7DqL/x+SKSSYtHUjw1
         j09kRV5soaMr4pxw8UKixiCGVCV1YFuW3ImVIEHVHVZzVK1mVRrfC6UzHeAS573D9RM9
         bAp63x2NKrHw7ZDhwvFqUQy42yGSyUle22D0lKSVFGbFVqSksQwyOy86ro2AnGKYIpZm
         zypQ==
X-Gm-Message-State: APjAAAUhJfnWGA60L9fib3bFIiNXbVKmVtxaEyFo3dwhB4Oazw2CkoBJ
        NOcra6WprC/L0cvi83IFwzPhfQ==
X-Google-Smtp-Source: APXvYqwh7vjxVs6omU+pFo0FxgcSNarEt1g14imvMxGw8LchQHDgzf+dOfYjMj/7ACI1KzLSmoDQQA==
X-Received: by 2002:ac8:50b:: with SMTP id u11mr9491577qtg.308.1565974797937;
        Fri, 16 Aug 2019 09:59:57 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i12sm2966486qki.122.2019.08.16.09.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 09:59:57 -0700 (PDT)
Date:   Fri, 16 Aug 2019 12:59:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/5] Btrfs: stop clearing EXTENT_DIRTY in inode I/O tree
Message-ID: <20190816165955.6pob2pqfubnbtz7j@MacBook-Pro-91.local>
References: <cover.1565900769.git.osandov@fb.com>
 <8aa3a13a33ef65994613409ea605e22280a23480.1565900769.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa3a13a33ef65994613409ea605e22280a23480.1565900769.git.osandov@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 15, 2019 at 02:04:04PM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Since commit fee187d9d9dd ("Btrfs: do not set EXTENT_DIRTY along with
> EXTENT_DELALLOC"), we never set EXTENT_DIRTY in inode->io_tree, so we
> can simplify and stop trying to clear it.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Ship this, dear lord,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
