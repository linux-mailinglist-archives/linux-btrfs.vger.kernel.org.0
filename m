Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2981EB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHEOKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:10:41 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:43480 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfHEOKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 10:10:41 -0400
Received: from tux.wizards.de (p5DE2BA44.dip0.t-ipconnect.de [93.226.186.68])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 19471416B329;
        Mon,  5 Aug 2019 16:10:40 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id C0748F0160B;
        Mon,  5 Aug 2019 16:10:39 +0200 (CEST)
Subject: Re: [PATCH][v2] btrfs: add an ioctl to force chunk allocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190805131942.8669-1-josef@toxicpanda.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <ca939ada-e4ef-80a2-9b8f-e64279f48ff7@applied-asynchrony.com>
Date:   Mon, 5 Aug 2019 16:10:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805131942.8669-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/5/19 3:19 PM, Josef Bacik wrote:
> In testing block group removal it's sometimes handy to be able to create
> block groups on demand.  Add an ioctl to allow us to force allocation
> from userspace.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> v1->v2:
> - I noticed last week when backporting this that btrfs_chunk_alloc doesn't
>    figure out the rest of the flags needed for the type.  Use
>    btrfs_force_chunk_alloc instead so that we get the raid settings for the alloc
>    type we're using.

Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>

Now works as intended - very nice, thanks!

-h
