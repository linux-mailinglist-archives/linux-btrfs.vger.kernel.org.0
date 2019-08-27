Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9889E87E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfH0M6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 08:58:06 -0400
Received: from drutsystem.com ([84.10.39.251]:34193 "EHLO drutsystem.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbfH0M6G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:06 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 08:58:05 EDT
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ziu.info; s=ziu;
        t=1566910355; bh=zAQqfY8nGY1OA5TAXuGiN1nTI1U0XjYmLyoWhTIuQSc=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Hkn1GvOPUy1w5roI7MYuQYDlxLNoKCTaoOqO42ZJkpdNlehPOFQQ0S57+iqDBiY0A
         iOcVX5aCQjlgJfk5A/ZmdjrcvJVnYnduhX4s+kK7XA8xiTeNSmKHU1uUfE340yawRk
         td/i9ZhQhzA0PoKiqVUqQ0xTPz0AaBrAMa2Ny0v8=
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
From:   Michal Soltys <soltys@ziu.info>
Message-ID: <ee6ec9d0-28b3-8bd9-104d-98738ab846aa@ziu.info>
Date:   Tue, 27 Aug 2019 14:52:33 +0200
MIME-Version: 1.0
In-Reply-To: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-MailScanner-ID: 7819F814383.AF072
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: soltys@ziu.info
X-Spam-Status: No
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/19 7:44 PM, Christoph Anton Mitterer wrote:
> Hey.
> 
> Anything new about the issue described here:
> https://www.spinics.net/lists/linux-btrfs/msg91046.html
> 
> It was said that it might be a regression in 5.2 actually and not a
> hardware thing... so I just wonder whether I can safely move to 5.2?
> 
> 
> Cheers,
> Chris.
> 
> 

FWIW, my laptop is on btrfs since around late 4.x kernel times - also 
using archlinux. And it went w/o any issues through all the kernels 
since then to current one (5.2.9 as of this writing). It survived some 
peculiar hangs and sudden power offs without any bad lasting sideffects 
throughout btrfs existence as its main filesystem. It's on old samsung 
850 pro ssd (though haven't tested if the disk is cache flush liar or not).

That to say I don't have any storage stacks underneath. On some other 
machines I use btrfs (on arch) as well, often with its builtin raid1 
implementation - no issues observed so far.
