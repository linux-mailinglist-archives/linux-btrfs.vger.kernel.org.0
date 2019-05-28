Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A27D2C6D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfE1Mnc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 28 May 2019 08:43:32 -0400
Received: from voltaic.bi-co.net ([134.119.3.22]:59951 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfE1Mnc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:43:32 -0400
Received: from mila.uni-paderborn.de (mila.uni-paderborn.de [131.234.92.203])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id 0719F20839;
        Tue, 28 May 2019 14:43:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
From:   =?utf-8?Q?Michael_La=C3=9F?= <bevan@bi-co.net>
In-Reply-To: <6e9c176d0b9389b2ff04cf38556471360725146e.camel@scientia.net>
Date:   Tue, 28 May 2019 14:43:30 +0200
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6B22E3F5-9095-4533-92F2-0A6D9041D493@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
 <6e9c176d0b9389b2ff04cf38556471360725146e.camel@scientia.net>
To:     Christoph Anton Mitterer <calestyo@scientia.net>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Am 28.05.2019 um 14:36 schrieb Christoph Anton Mitterer <calestyo@scientia.net>:
> 
> Hey.
> 
> Just to be on the safe side...
> 
> AFAIU this issue only occured in 5.1.2 and later, right?

No. The issue was already introduced in v5.1-rc1 (commit 61697a6abd24).

> Starting with which 5.1.x and 5.2.x versions has the fix been merged?

It's fixed in v5.2-rc2 (commit 51b86f9a8d1c) and v5.1.5 (commit 871e122d55e8).

Cheers,
Michael
