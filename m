Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4215B0E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 20:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgBLTUp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 14:20:45 -0500
Received: from mailgw-02.dd24.net ([193.46.215.43]:42036 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgBLTUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 14:20:45 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 529455FFEF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 19:20:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id 2M39mJ9iVPwe for <linux-btrfs@vger.kernel.org>;
        Wed, 12 Feb 2020 19:20:41 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-253-53.dynamic.mnet-online.de [46.244.253.53])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 19:20:41 +0000 (UTC)
Message-ID: <14deddb440625512ae490a619a37034ff1caac3b.camel@scientia.net>
Subject: Re: [PATCH v2] Btrfs: send, fix emission of invalid clone
 operations within the same file
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Wed, 12 Feb 2020 20:20:40 +0100
In-Reply-To: <CAL3q7H5ETtr_DAjTUkrzDY6-OpDJYzSsuWbZnzpR7sDh-WXqgg@mail.gmail.com>
References: <20200124115204.4086-1-fdmanana@kernel.org>
         <20200129170953.13945-1-fdmanana@kernel.org>
         <8727d06b4bef8f337dea40c83d3fc4132f721585.camel@scientia.net>
         <CAL3q7H5ETtr_DAjTUkrzDY6-OpDJYzSsuWbZnzpR7sDh-WXqgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2020-02-11 at 14:46 +0000, Filipe Manana wrote:
> It's a bug fix, so yes. In fact you can check that yourself:

Thanks... actually I did check it directly in linux-stable.git ... but
it must have been merged shortly afterwards ^^

Cheers,
Chris.

