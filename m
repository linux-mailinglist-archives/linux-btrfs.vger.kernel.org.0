Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B6D1DFD74
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 May 2020 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgEXGiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 May 2020 02:38:06 -0400
Received: from bezitopo.org ([45.55.162.231]:34870 "EHLO marozi.bezitopo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgEXGiF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 May 2020 02:38:05 -0400
Received: from bezitopo.org (unknown [IPv6:2001:5b0:212a:cab8:4e72:b9ff:fe7b:8dbf])
        by marozi.bezitopo.org (Postfix) with ESMTPSA id 041F75FB7E
        for <linux-btrfs@vger.kernel.org>; Sun, 24 May 2020 02:38:04 -0400 (EDT)
Received: from puma.localnet (localhost [127.0.0.1])
        by bezitopo.org (Postfix) with ESMTP id E4D8630EC4
        for <linux-btrfs@vger.kernel.org>; Sun, 24 May 2020 02:37:52 -0400 (EDT)
From:   Pierre Abbat <phma@bezitopo.org>
To:     linux-btrfs@vger.kernel.org
Subject: Re: Trying to mount hangs
Date:   Sun, 24 May 2020 02:37:52 -0400
Message-ID: <19884168.u0ROftlITR@puma>
In-Reply-To: <f49ceced-fcbf-5be7-442d-25bbfbc75881@gmx.com>
References: <2549429.Qys7a5ZjRC@puma> <2582603.WkyslYimHe@puma> <f49ceced-fcbf-5be7-442d-25bbfbc75881@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Friday, May 22, 2020 6:02:44 AM EDT Qu Wenruo wrote:
> For that purpose, we have btrfs-image, which will only dump the
> metadata, which is way smaller than the full disk, and can be further
> compressed using -c9 option. (And you can compress it furthermore).
> 
> That btrfs-image dump even contains log tree, which is exactly what we
> need to fix the hang.

I'm sending it. Let me know if you can reproduce the hang.

Pierre

-- 
gau do li'i co'e kei do



