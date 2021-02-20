Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96124320515
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 12:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhBTL1t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 06:27:49 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41401 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTL1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 06:27:47 -0500
Received: from [192.168.3.4] (p579ad2c7.dip0.t-ipconnect.de [87.154.210.199])
        (Authenticated sender: chainofflowers@neuromante.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 53C72240004;
        Sat, 20 Feb 2021 11:27:00 +0000 (UTC)
Subject: Re: Access Beyond End of Device & Input/Output Errors
From:   chainofflowers <chainofflowers@neuromante.net>
To:     linux-btrfs@vger.kernel.org, quwenruo.btrfs@gmx.com
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
Message-ID: <36f43213-14de-4dc0-074a-fa19babfed30@neuromante.net>
Date:   Sat, 20 Feb 2021 12:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu!

Is there any chance to find some hints of the issue in the log I attached?

On 08.02.21 22:05, chainofflowers wrote:
> Hi Qu!
> 
> It happened again, and this time I've been able to dump the dmesg.
> Also this time it happened on my home drive, please see the attached dump.
> 
> What can I do to fix it?
> btrfs scrub reports no error, neither does brfs check.
> I have also remounted the partition with -oclear_cache,space_cache, I
> hoped that could fix it...
> 
> Thanks...
> 
> (c)
> 
