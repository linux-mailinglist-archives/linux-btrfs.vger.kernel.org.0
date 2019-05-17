Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9A21BC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 18:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfEQQjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 12:39:13 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:59787 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQQjN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 12:39:13 -0400
Received: from [2001:8b0:162c:2:b132:85a2:4793:373b]
        by smtp.steev.me.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        id 1hRft2-0007pB-9b
        for linux-btrfs@vger.kernel.org; Fri, 17 May 2019 17:39:12 +0100
Subject: Re: Used disk size of a received subvolume?
References: <c79df692-cc5d-5a3a-1123-e376e8c94eb3@tty0.ch>
 <20190516171225.GH1667@carfax.org.uk>
 <27af7824-f3e9-47a5-7760-d3e30827a081@tty0.ch>
 <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
To:     linux-btrfs@vger.kernel.org
From:   Steven Davies <btrfs-list@steev.me.uk>
Message-ID: <24f44d54-a560-0b6e-5fe0-026626d1d2c5@steev.me.uk>
Date:   Fri, 17 May 2019 17:39:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <811bcd96-5a8e-cb10-7efb-22c1046e0f42@cobb.uk.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2019 16:28, Graham Cobb wrote:

> That is why I created my "extents-list" stuff. This is a horrible hack
> (one day I will rewrite it using the python library) which lets me
> answer questions like: "how much space am I wasting by keeping
> historical snapshots", "how much data is being shared between two
> subvolumes", "how much of the data in my latest snapshot is unique to
> that snapshot" and "how much space would I actually free up if I removed
> (just) these particular directories". None of which can be answered from
> the existing btrfs command line tools (unless I have missed something).

I have my own horrible hack to do something like this; if you ever get 
around to implementing it in Python could you share the code?

-- 
Steven Davies
