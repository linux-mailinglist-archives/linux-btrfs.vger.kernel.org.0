Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330DC411389
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 13:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhITL35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 07:29:57 -0400
Received: from 78-32-144-114.static.aquiss.com ([78.32.144.114]:51029 "EHLO
        smtp.steev.me.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbhITL34 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 07:29:56 -0400
X-Greylist: delayed 949 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 07:29:56 EDT
Received: from [2001:4d48:ad5d:2410::25] (helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.94.2)
        id 1mSHDv-001pQX-5V; Mon, 20 Sep 2021 12:12:35 +0100
MIME-Version: 1.0
Date:   Mon, 20 Sep 2021 12:12:33 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     dsterba@suse.cz, Forza <forza@tnonline.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Select DUP metadata by default on single devices.
In-Reply-To: <20210920090914.GB9286@twin.jikos.cz>
References: <9809e10.87861547.17bfad90f99@tnonline.net>
 <20210920090914.GB9286@twin.jikos.cz>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <433faf921e92e94fa117a4e263dfddcd@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-09-20 10:09, David Sterba wrote:

> So:
> - DUP by default for metadata on single device
> - single by default for data on multiple devices (now it's raid0)
> - free-space-tree on

Is this synonymous with space_cache=v2?

> - no-holes on
> 
> I'd vote for one version doing the whole switch rather than doing the
> changes by one.

-- 
Steven Davies
