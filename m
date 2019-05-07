Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E744116989
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfEGRpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:45:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46432 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfEGRpT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:45:19 -0400
Received: by mail-yw1-f65.google.com with SMTP id a130so8304874ywe.13
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=goxnGcgqU37PrYhrAIO8gZo8WDzvNCMOtOnEEZJWFoU=;
        b=awh0zEgBD3gliUko+TRMF1h10PZkAOE1z2zz7MKaj6a+4tnIXjVHVGsULgFt4nvsRT
         7ixGjaocOC06LI46Qwm/7iMICkZIpsKExojpu+glBgC3W7seIUkRAAr1ShM5Xc2TeJ52
         f520vhhTtlnr0PLKSdQbOaBzoriVpvjQBIJUe1esYuTf6+4cl80+D8/iGeA+ulwSVspb
         ZhBtnSP00TisH03N2NO1lLaY80276ndkHk5iw5UNgCKmxdBAnSq6V/ueKlJssXznp4F4
         CBzPt2aeKArFiD6aj/7Kgc726ARVOZ+m8BhU/PWSNnieAB23EXMbKQch9tuF1ztJ6RcW
         QTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=goxnGcgqU37PrYhrAIO8gZo8WDzvNCMOtOnEEZJWFoU=;
        b=W4OyCmbqKHOWO0oploP0grIcM25iwPkdNFZQL5ttIorSt59FzTyoBUXWlCgQlGTk6k
         gMfqTp+OxEuKRNsLJhaX/8PDk9rOpabrQCUSY5586y8mrA6SFCf/uQ2wR1YQrSNJXOYm
         ewGqt8Xyc2AvUEn1W+zdaeEfiPLAyX4fgVeTZXeYnOBwdFBlbfoWMwJ9K4reqvCt1Nm+
         7CdZm4A5kRAVTTw9knlnSuuq1YKhhREimK3UDKq1wxQg6NIcuAYw27urlI8MBQBT3z/3
         T4OxCUMfrTuWbXSsR7GXWAjwPkvGsMdnGgv2e/n8kw7wWAjLijaCCHHQtFVUz/iEwDd5
         ouAA==
X-Gm-Message-State: APjAAAVX4BS8sI8yNrkBDBfbntP3MrPW8MeW41+jAoIHH3EIqH0DtJZs
        g+s4bOip9b/nn6Ap1etYl/86UQhUtB3gXTfC
X-Google-Smtp-Source: APXvYqw1WSF+2TOoOdTS4bNa6u2sfa7hLC1//F+h7xjRIf18wW7+TnDrrBdDipw3YGD5vRPrBc6zNA==
X-Received: by 2002:a81:4985:: with SMTP id w127mr8514675ywa.144.1557251118366;
        Tue, 07 May 2019 10:45:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::5c09])
        by smtp.gmail.com with ESMTPSA id a18sm3957267ywa.17.2019.05.07.10.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:45:18 -0700 (PDT)
Date:   Tue, 7 May 2019 13:45:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] Btrfs: teach tree-checker to detect file extent
 items with overlapping ranges
Message-ID: <20190507174516.sn5vbbemkgoa5fi2@macbook-pro-91.dhcp.thefacebook.com>
References: <20190506154412.20147-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506154412.20147-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 06, 2019 at 04:44:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Having file extent items with ranges that overlap each other is a serious
> issue that leads to all sorts of corruptions and crashes (like a BUG_ON()
> during the course of __btrfs_drop_extents() when it traims file extent
> items). Therefore teach the tree checker to detect such cases. This is
> motivated by a recently fixed bug (race between ranged full fsync and
> writeback or adjacent ranges).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
