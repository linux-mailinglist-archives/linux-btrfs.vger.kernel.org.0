Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C809294C0B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439554AbgJUL6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393832AbgJUL6a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 07:58:30 -0400
X-Greylist: delayed 65812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 21 Oct 2020 04:58:29 PDT
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05A4C0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 04:58:29 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b07e9c2.dip0.t-ipconnect.de [91.7.233.194])
        by mail.itouring.de (Postfix) with ESMTPSA id 4BF17CC304D;
        Wed, 21 Oct 2020 13:58:28 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 0F938F015C5;
        Wed, 21 Oct 2020 13:58:28 +0200 (CEST)
Subject: Re: libbtrfsutil + python = UUID confusion?
To:     Hans van Kranenburg <hans@knorrie.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <92dcded4-3281-eeda-6072-527aa685a07e@applied-asynchrony.com>
 <00c8a37b-90f4-c96f-6586-8a1b1cf60f1b@knorrie.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <d6afdc87-d4a6-dbdb-8f6e-b0c97c1ab26a@applied-asynchrony.com>
Date:   Wed, 21 Oct 2020 13:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <00c8a37b-90f4-c96f-6586-8a1b1cf60f1b@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


tl;dr: I can't read.

On 2020-10-21 13:36, Hans van Kranenburg wrote:
> Hi,
> 
> On 10/20/20 7:41 PM, Holger Hoffstätte wrote:
>>     >>> import uuid
>>     >>> uuid.UUID(bytes=i.uuid)
>>     UUID('5398a9c8-aa30-4658-b3cf-caaf03e9f853')
>>
>> Yeah no wait what? The expected fsid of /mnt/data1 is
>> "14831af0-32d2-40b7-98c9-ca5467910a8c".
> 
> A subvolume (actually, the root_item object) also has a uuid field. It's
> the uuid of the subvolume itself.

Yes, it has. I swear I had the same thought yesterday, and somehow
missed it nevertheless.

> What if you do btrfs sub show /mnt/data1 and then look at the UUID:
> field? Is it 5398a9c8-aa30-4658-b3cf-caaf03e9f853?

Yes, of course it is. Thank you.

Holger
