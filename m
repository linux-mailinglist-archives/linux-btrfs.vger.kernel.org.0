Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8B662CEFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfE1S4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 14:56:05 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:58110 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1S4F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 14:56:05 -0400
Received: from [IPv6:2001:980:4a41:fb::12] (unknown [IPv6:2001:980:4a41:fb::12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id A37C24752D140;
        Tue, 28 May 2019 20:56:03 +0200 (CEST)
Subject: Re: Unable to mount, corrupt leaf
To:     Cesar Strauss <cesar.strauss@inpe.br>, linux-btrfs@vger.kernel.org
References: <23b224cf-1e0f-267f-8fbb-74eaf2b6937a@inpe.br>
From:   Hans van Kranenburg <hans@knorrie.org>
Message-ID: <a01d4f21-6ad1-1853-bc5a-618deede7872@knorrie.org>
Date:   Tue, 28 May 2019 20:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <23b224cf-1e0f-267f-8fbb-74eaf2b6937a@inpe.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

On 5/28/19 8:39 PM, Cesar Strauss wrote:
> 
> After a BTRFS partition becoming read-only under use, it cannot be 
> mounted anymore.
> 
> The output is:
> 
> # mount /dev/sdb5 /mnt/disk1
> mount: /mnt/disk1: wrong fs type, bad option, bad superblock on 
> /dev/sdb5, missing codepage or helper program, or other error.
> 
> Kernel output:
> [ 2042.106654] BTRFS info (device sdb5): disk space caching is enabled
> [ 2042.799537] BTRFS critical (device sdb5): corrupt leaf: root=2 
> block=199940210688 slot=31, unexpected item end, have 268450090 expect 14634


bin(14634) ->
               '0b11100100101010'

bin(268450090) ->
'0b10000000000000011100100101010'

So, what you're observing here is a bitflip. One of the zeros flipped
into a one, which caused the 14634 to suddenly become 268450090.

Since this is detected as corruption, and not detected using the btrfs
checksums, it means that the bitflip did not happen when the value was
stored on disk, but it happened in your memory chips inside the computer
before the information was written to disk.

> [ 2042.807879] BTRFS critical (device sdb5): corrupt leaf: root=2 
> block=199940210688 slot=31, unexpected item end, have 268450090 expect 14634
> [ 2042.807947] BTRFS error (device sdb5): failed to read block groups: -5
> [ 2042.832362] BTRFS error (device sdb5): open_ctree failed
> 
> [...]
> 
> Before making any recovery attempts, or even restoring from backup, I 
> would like to ask for the best option to proceed.

The best thing to do is to not use this phsyical computer for anything
else right now than running a proper program to analyze and check the
memory chips, in order to find out which one is causing the problems.

Hans
