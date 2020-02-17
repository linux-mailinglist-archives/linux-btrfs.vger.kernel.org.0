Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE97161404
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 14:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgBQNzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 08:55:49 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:49511 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgBQNzt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 08:55:49 -0500
Received: from [10.137.0.38] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 64FBB200007;
        Mon, 17 Feb 2020 13:55:47 +0000 (UTC)
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     Menion <menion@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
 <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org>
Date:   Mon, 17 Feb 2020 14:55:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-02-17 14:50, Menion wrote:
> Is it ok to run it on a mounted filesystem with concurrent read and
> write operations?

Yes. Please check man btrfs-balance.

All such BTRFS operations are to be run on live, mounted filesystems.

Performance will suffer and it might be long though.

> Also, since the number of HDD is 5, how this "raid1" scheme is deployed?

BTRFS will manage storing 2 copies of every metadata block on 2 
different disks, and will choose how by itself.

ॐ

-- 
Swâmi Petaramesh <swami@petaramesh.org> PGP 9076E32E

