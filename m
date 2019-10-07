Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3284ACED65
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfJGU1G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:27:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44444 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbfJGU1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:27:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so13933234qkk.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cMT6jKMUCJCSl+oBrbOZ7jTycjM9iIzQPma+jm0I5II=;
        b=PIuwqojbXNCbhNuPiFIQmjXMryeXD0nz1qOmbq7k3ebnejGAlD31ygi4B8K+C3e4Sm
         QERRey5u4dQiYvL0pQzZP6BYJ2SEDRYwYLySimn3b2OsCyV+Aos8hNz8P3rEgInrbn2n
         8lxeqKhU8SvzdpEF7HyK9PWNyCvjBcksc4YT6GnXaY6BIUyPHaRfzWHcN1iODxrEZDx2
         pNssGNPNwuto8HZl2TSlxgYcOL+8M2/k+3AeHPdBlqZ4gxrpOLrKlab6cKiXbOfFOQHG
         yC5KorVAAFL4TND3S9EVowHudJ1oodLe9YCfq+7rdu7eCiOPLLKf+WACHyPTMAsH2P/+
         i4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cMT6jKMUCJCSl+oBrbOZ7jTycjM9iIzQPma+jm0I5II=;
        b=NYLtFpcG47dZhMrNzP8sN9/eZBR/l5Pm/Vm4R2ECONp5PUg2SJcWVP2Uxfzt0CD1ry
         dxRKseEmqkR4jlgdBGP1wNYwYLqOxNS8RF9BPgjQ15rRFq9qnQMcECOVa3D+C20Kh1fO
         9gh8pQy0+2f/nypKRd7P/CREdhvUtwusF8Jly42RmL7FxO+AJ+4BhXxIcado4wnCxl7c
         prGFC7UGV5EfXNHlySLy7S1seBmVpNtbWLPaodE8jLqYYIy47Yobqmm7a4BDnH2pyYdp
         VskaTQbKKE/V7mBimR7eEbdgATzQQB1p2uOUXQWsI+Sj2pshkAm+dKp8dc0SNicFX9+U
         yFLg==
X-Gm-Message-State: APjAAAXXv6Mx7LCYl8GBBtPuQr9TVm9kosud1UGxXiwR6E/7t0va30My
        4Uth/9HjeRo++oWC+qMG8NaTuA==
X-Google-Smtp-Source: APXvYqzWwC7Ch+QvQCrGlJxm5+vhrpKDnDkq6j4yMwmixQuRrGa0Erj+7tVYsmrihspM4g4t9QT+dA==
X-Received: by 2002:a37:9ac5:: with SMTP id c188mr25021421qke.342.1570480023155;
        Mon, 07 Oct 2019 13:27:03 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d133sm8465782qkg.31.2019.10.07.13.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:27:02 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:27:01 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/19] btrfs: rename DISCARD opt to DISCARD_SYNC
Message-ID: <20191007202700.ndehgrpuzz2pps54@MacBook-Pro-91.local>
References: <cover.1570479299.git.dennis@kernel.org>
 <e2c7ca7b48bc3a5a219329f7d086ab1cfd7330a3.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c7ca7b48bc3a5a219329f7d086ab1cfd7330a3.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:33PM -0400, Dennis Zhou wrote:
> This series introduces async discard which will use the flag
> DISCARD_ASYNC, so rename the original flag to DISCARD_SYNC as it is
> synchronously done in transaction commit.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
