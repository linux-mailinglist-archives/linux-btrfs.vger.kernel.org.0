Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20C5F4F67
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 16:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKHPYU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 10:24:20 -0500
Received: from aurora.thatsmathematics.com ([162.209.10.89]:53650 "EHLO
        aurora.thatsmathematics.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfKHPYU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 10:24:20 -0500
Received: from moneta (unknown [67.221.64.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by aurora.thatsmathematics.com (Postfix) with ESMTPSA id 04A967E200;
        Fri,  8 Nov 2019 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=thatsmathematics.com;
        s=swordfish; t=1573226659;
        bh=npSmE0Upm3YGVeXTm7hB4KJ60icu0reBSHzlUxvhHMY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=il3PsjoVCh6Tt8XaKgA+CHeAWKDvuvDEtdT6FpHQrcWz1JKTJ2QuBuRc4qfegxj9V
         Mk4kCZJmT39MUlukkHYg9eQFrUyoB0JBnxuKAc5I5j+Zp2Go97JYxiy/UzNM2Awqcp
         ErtcqzdDysQXvDKTvbzVwHkcriO24l4MIOXTvWzs=
Date:   Fri, 8 Nov 2019 10:24:18 -0500 (EST)
From:   Nate Eldredge <nate@thatsmathematics.com>
X-X-Sender: nate@moneta
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
cc:     Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
Subject: Re: Defragmenting to recover wasted space
In-Reply-To: <c5458fb8-7df9-9e27-4208-fdbb3b4d731f@gmx.com>
Message-ID: <alpine.DEB.2.21.1911081021520.3492@moneta>
References: <alpine.DEB.2.21.1911070814430.3492@moneta> <cc5fba8b-baf3-f984-c99d-c5be9ce3a2d9@georgianit.com> <alpine.DEB.2.21.1911071419570.3492@moneta> <c5458fb8-7df9-9e27-4208-fdbb3b4d731f@gmx.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 8 Nov 2019, Qu Wenruo wrote:

> In fact, you can just go nodatacow.
> Furthermore, nodatacow attr can be applied to a directory so that any
> newer file will just inherit the nodatacow attr.
>
> In that case, any overwrite will not be COWed (as long as there is no
> snapshot for it), thus no space wasted.

Aha, I didn't know about that feature.  Thanks, that is exactly what I 
want.

-- 
Nate Eldredge
nate@thatsmathematics.com

