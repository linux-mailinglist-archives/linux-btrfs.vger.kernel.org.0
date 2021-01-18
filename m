Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5E2FAC38
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jan 2021 22:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388804AbhARVIs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jan 2021 16:08:48 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35913 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394385AbhARVI0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jan 2021 16:08:26 -0500
X-Originating-IP: 87.154.218.196
Received: from [192.168.3.4] (p579adac4.dip0.t-ipconnect.de [87.154.218.196])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EB8461BF203
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Jan 2021 21:07:18 +0000 (UTC)
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     linux-btrfs@vger.kernel.org
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
From:   chainofflowers <chainofflowers@neuromante.net>
Message-ID: <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
Date:   Mon, 18 Jan 2021 22:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, I put everything in place... I am now waiting for the next
occurrence...
> The best way to debug such problem is to recompile the kernel adding
> some debug outputs.
> (Maybe it can be done with bpftrace, but not yet familiar with that)
> 
> If you're able to recompile the kenerl (using abs + makepkg for Arch
> based kernel), please try the following diff.
> 
> This will add extra debugging to show where the offending length
> happens, either extent discard or unallocated space discard.
> And from that output we can continue our investigation.
> 
> Thanks,
> Qu

