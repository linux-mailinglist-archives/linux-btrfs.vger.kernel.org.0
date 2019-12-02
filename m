Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4423B10F224
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 22:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfLBV1x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 2 Dec 2019 16:27:53 -0500
Received: from [185.35.77.55] ([185.35.77.55]:56884 "EHLO mail.megacandy.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfLBV1w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Dec 2019 16:27:52 -0500
Received: from [192.168.10.160] (26.51-174-238.customer.lyse.net [51.174.238.26])
        (Authenticated sender: gardv@megacandy.net)
        by mail.megacandy.net (Postfix) with ESMTPSA id EB6A242BD04;
        Mon,  2 Dec 2019 21:27:50 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: Unrecoverable corruption after loss of cache
From:   Gard Vaaler <gardv@megacandy.net>
In-Reply-To: <2292c7cc-fc18-364b-7b7c-dfef014a028f@suse.com>
Date:   Mon, 2 Dec 2019 22:27:49 +0100
Cc:     linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E5ED2688-A506-4D11-8D01-27BD7C366894@megacandy.net>
References: <7D7AA867-8B53-4CD5-83EF-95EABAD2A77C@megacandy.net>
 <2292c7cc-fc18-364b-7b7c-dfef014a028f@suse.com>
To:     Nikolay Borisov <nborisov@suse.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> 1. des. 2019 kl. 19:51 skrev Nikolay Borisov <nborisov@suse.com>:
> On 1.12.19 г. 19:27 ч., Gard Vaaler wrote:
>> Trying to recover a filesystem that was corrupted by losing writes due to a failing caching device, I get the following error:
>>> ERROR: child eb corrupted: parent bytenr=2529690976256 item=0 parent level=2 child level=0
>> 
>> Trying to zero the journal or reinitialising the extent tree yields the same error. Is there any way to recover the filesystem? Relevant logs attached.
> 
> Provide more information about your storage stack.


Nothing special: SATA disks with (now-detached) SATA SSDs.

-- 
Gard

