Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D03CACB6A
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2019 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfIHH5n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 03:57:43 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:39460 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfIHH5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Sep 2019 03:57:43 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail02.iobjects.de (Postfix) with ESMTPSA id E8D484160441;
        Sun,  8 Sep 2019 09:57:41 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id A658EF015AB;
        Sun,  8 Sep 2019 09:57:41 +0200 (CEST)
Subject: Re: Balance conversion to metadata RAID1, data RAID1 leaves some
 metadata as DUP
To:     Pete <pete@petezilla.co.uk>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <94bca1e6-6b6a-10fb-9e44-ae9a2202187d@applied-asynchrony.com>
Date:   Sun, 8 Sep 2019 09:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eda2fb2a-c657-5e4a-8d08-1bf57b57dd3b@petezilla.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/8/19 9:09 AM, Pete wrote:
(snip)
> I presume running another balance will fix this, but surely all metadata
> should have been converted?  Is there a way to only balance the DUP
> metadata?

Adding "soft" to -mconvert should do exactly that; it will then skip
any chunks that are already in the target profile.

-h
