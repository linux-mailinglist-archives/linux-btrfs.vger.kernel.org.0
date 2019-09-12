Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9703B1493
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfILSwK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 14:52:10 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:43907 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfILSwK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 14:52:10 -0400
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.156] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 73EFB240003;
        Thu, 12 Sep 2019 18:52:07 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Zdenek Kaspar <zkaspar82@gmail.com>,
        Christoph Anton Mitterer <calestyo@scientia.net>,
        fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <ce6a9b8274f5af89d9378aa84e934ce3f3354acd.camel@scientia.net>
 <CAL3q7H5qNE4rizN14qmgrAwtju9KRHspKxo3S-PoTcSUvXYuew@mail.gmail.com>
 <41d5dae3587efa5c19262a230e3c459f8e14159b.camel@scientia.net>
 <2cfe8d20-43f1-ae88-0712-60bb9d6d4dc0@petaramesh.org>
 <d92a1321-7e79-e3a9-7dd0-c82d9545b3a0@gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <7d7468b3-36af-8fbb-3e27-84d6c78a2862@petaramesh.org>
Date:   Thu, 12 Sep 2019 20:52:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <d92a1321-7e79-e3a9-7dd0-c82d9545b3a0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 12/09/2019 à 18:21, Zdenek Kaspar a écrit :
> On 9/12/19 4:57 PM, Swâmi Petaramesh wrote:
>
>> However having read that the bug is diagnosed, confirmed and fixed by
>> Filipe, I seriously consider downgrading my kernel back to 5.1 on the 2
>> Manjaro machines as it is rather straightforward, and maybe my Arch as
>> well... Until I'm sure that the fix made it to said distro kernels.
>
> It's included in [testing] right now...
>
> https://git.archlinux.org/linux.git/log/?h=v5.2.14-arch2
> Z.


:)


ॐ
-- 
Swâmi Petaramesh <swami@petaramesh.org> OpenPGP ID 0x1BFFD850

