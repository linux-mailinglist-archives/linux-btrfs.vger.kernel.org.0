Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D256128D3F
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 10:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfLVJAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 04:00:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:53743 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLVJAt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 04:00:49 -0500
Received: from [192.168.1.168] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id DB632200005;
        Sun, 22 Dec 2019 09:00:46 +0000 (UTC)
Subject: Re: Kernel 5.4 - BTRFS FS shows full with about 600 GB Free ?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>
References: <8bd55f28-2176-89f7-bd53-4992ccd53f42@petaramesh.org>
 <81dec38b-ec8e-382e-7dfe-cb331f418ffa@gmx.com>
 <e743df15-4830-8d83-bc36-6ddd33c1e720@petaramesh.org>
 <dd37e99c-e087-2b6d-830a-96811b337ba2@gmx.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <bd183df9-4742-301d-251c-443d99d170c7@petaramesh.org>
Date:   Sun, 22 Dec 2019 10:00:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <dd37e99c-e087-2b6d-830a-96811b337ba2@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again,

Le 22/12/2019 à 09:12, Qu Wenruo a écrit :
> So if you have enough uncommitted metadata, that check will be triggered
> and suddenly returns 0 available space, even 1 sec early you still get
> tons of available space.

With « uncommitted metadata » do you mean that this situation is only 
temporary and should end once all transactions are commited to disk ?

Because in the one disk on which I observe this (and which passes a full 
btrfs check with bells and whistles) it still shows 0% free after 2 days 
and several unmounts / remounts...

Furthermore I've conected it to machines using 5.3 and even 4.15 
kernels, and they *ALL* state that the free disk space is zero - even 
though I can understand if « That check is from 2015 ».

That still seems to boild down to : Once I got this error it seems I 
cannot step out of it using any reasonably recent kernel.

So I may have either to patch my kernel or wait for the patch to reach 
#Arch kernels... and hope it actually fixes it.

(I have to admit that I haven't yet fully understood the technical 
aspects of this overcommit story...)

I'm also worried that on my machines that does NOT show this problem on 
their own main filesystems, this could happen anytime soon ?

Thanks anyway very much for your help.

Kind regards.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E
