Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4BAB0AF8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 11:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfILJJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 05:09:10 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:51896 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfILJJK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 05:09:10 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail02.iobjects.de (Postfix) with ESMTPSA id EA7FD4162722;
        Thu, 12 Sep 2019 11:09:08 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id A8EF8EEB932;
        Thu, 12 Sep 2019 11:09:08 +0200 (CEST)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <3b972dc4-9dc6-620e-9bf8-79ec2df5cec7@applied-asynchrony.com>
Date:   Thu, 12 Sep 2019 11:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/12/19 10:24 AM, James Harvey wrote:
> On Thu, Sep 12, 2019 at 3:51 AM Filipe Manana <fdmanana@gmail.com> wrote:
>> ...
>>
>> Until the fix gets merged to 5.2 kernels (and 5.3), I don't really
>> recommend running 5.2 or 5.3.
> 
> What is your recommendation for distributions that have been shipping
> 5.2.x for quite some time, where a distro-wide downgrade to 5.1.x
> isn't really an option that will be considered, especially because
> many users aren't using BTRFS?  Can/should your patch be backported to
> 5.2.13/5.2.14?  Or, does it really need to be applied to 5.3rc or git
> master?  Or, is it possibly not the right fix for the corruption risk,
> and should a flashing neon sign be given to users to just run 5.1.x
> even though the distribution repos have 5.2.x?

It applies and works just fine in 5.2.x, I have it running in .14.
If your distribution doesn't apply patches or just ships a random
release-of-the month kernel, well.. ¯\(ツ)/¯

> What is your recommendation for users who have been running 5.2.x and
> running into a lot of hangs?  Would you say to apply your patch to a
> custom-compiled kernel, or to downgrade to 5.1.x?

5.1.x is EOL upstream and you might be missing other critical things
like security fixes. Considering how easy it is to build a custom kernel
from an existing configuration, the former.

-h
