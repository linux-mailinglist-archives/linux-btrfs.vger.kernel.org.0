Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040DE21ADA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 05:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJDrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 23:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgGJDrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jul 2020 23:47:36 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jul 2020 20:47:35 PDT
Received: from ulnar.ocb.by (ulnar.ocb.by [IPv6:2a01:4f8:192:2464:2:237:ffff:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC415C08C5CE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jul 2020 20:47:35 -0700 (PDT)
Received: from ulnar.ocb.by (localhost [127.0.0.1])
        by ulnar.ocb.by (Postfix) with ESMTP id 6F0D940161
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 05:39:59 +0200 (CEST)
Authentication-Results: ulnar.ocb.by;
        dkim=pass (2048-bit key; unprotected) header.d=schramm.by header.i=@schramm.by header.b="cFKf6p2k";
        dkim-atps=neutral
Received: from [IPv6:2a02:8106:f:37fc:329c:23ff:fe9a:9e57] (unknown [IPv6:2a02:8106:f:37fc:329c:23ff:fe9a:9e57])
        (Authenticated sender: lists@schramm.by)
        by ulnar.ocb.by (Postfix) with ESMTPSA id 3FF1240133
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 05:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schramm.by;
        s=20200415; t=1594352399;
        bh=4Yc1j9FpMSt0tPibRAPr2Z88eyxSDwOB1STs1awAXnE=;
        h=Subject:To:From:Message-ID:Date:From;
        b=cFKf6p2k2ayWnRavOao9HMb7XgYuwTIPOnpFcajP2leoH5ngsWvn0BksJ1xiWmF/n
         ydWbOodWveF+kZb7T2QgRWqmG3soK5CeeDtpslON3RwtcioHd2UQu0t7mxOwubwZAe
         4NBJOP4Az9+FAwaONujgITCjiwPtwzG7b9jCY511OHF6fZ78iBZvMFt/EjDpwZfTJY
         t2zF2Y/ImQUa2uN/IlxnOZinrl/7YW8cKVyfgujP/141K/9f6e00IZvbdWoYn5uoMC
         LAWVi1uSK5vg60ZzB4xcmketrzlhA+Bx9MWsDfv/xbkCi1ce1GnsTn5jl47vqrZScn
         a9RceeeuPD3Cw==
Subject: Re: btrfs and system df
To:     linux-btrfs@vger.kernel.org
References: <3ffa3a38-0e98-886f-2cfb-3aeb9f2c1c7c@schramm.by>
 <8c7db612-fffd-99b5-8de0-50435f5637b8@gmx.com>
From:   Holger Schramm <lists@schramm.by>
Message-ID: <be7475de-264a-309d-30b0-23ee9d26caa1@schramm.by>
Date:   Fri, 10 Jul 2020 05:39:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8c7db612-fffd-99b5-8de0-50435f5637b8@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamSMTP @ Ulnar
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 09.07.20 um 06:09 schrieb Qu Wenruo:
> 
> 
> On 2020/7/9 上午11:44, Hans von Stoffeln wrote:
>> Hi,
>>
>> current situation is that the linux system df thinks the drive is full:
>>
>> /dev/mapper/HyVol002-hy002_data    3,0T    655G     0  100%
>> /home/pyloor/data
> 
> This looks like a bug fixed by commit d55966c4279b ("btrfs: do not zero
> f_bavail if we have available space"), which is fixed in v5.6, and
> backported.
> 
> So what's your kernel version?

My kernel version was 5.4.0. Now I've updated to 5.7.6 and everything is 
fine. Thanks for your quick help.

Kind regards,
Holger

