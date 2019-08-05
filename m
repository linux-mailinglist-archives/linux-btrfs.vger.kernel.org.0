Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76275816E1
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfHEKUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 06:20:17 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:42986 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEKUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Aug 2019 06:20:17 -0400
Received: from tux.wizards.de (p5DE2BA44.dip0.t-ipconnect.de [93.226.186.68])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 70157416D648;
        Mon,  5 Aug 2019 12:20:15 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 1D42FF015F9;
        Mon,  5 Aug 2019 12:20:15 +0200 (CEST)
Subject: Re: [PATCH] btrfs: add an ioctl to force chunk allocation
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20190802161031.18427-1-josef@toxicpanda.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <a90f8550-c956-310d-c56c-6be8781fb3e9@applied-asynchrony.com>
Date:   Mon, 5 Aug 2019 12:20:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802161031.18427-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/2/19 6:10 PM, Josef Bacik wrote:
> In testing block group removal it's sometimes handy to be able to create
> block groups on demand.  Add an ioctl to allow us to force allocation
> from userspace.

Gave this a try and it works as advertised, though I noticed that the
redundancy level is ignored, e.g. adding a single metadata chunk will
add a new "single" chunk even when the metadata level is dup.
Doing a balance -mconvert dup,soft fixes that right up, but it's IMHO
unexpected. Can you put a cherry on top and create the new chunk according
to its dup level?

thanks :)
Holger
