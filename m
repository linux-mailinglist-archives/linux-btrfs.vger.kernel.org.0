Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4D8159202
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbgBKOcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 09:32:05 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:33394 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbgBKOcF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 09:32:05 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id BEC8C6080E;
        Tue, 11 Feb 2020 14:32:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id vAl2kzdkJ-4f; Tue, 11 Feb 2020 14:32:01 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-46-244-253-53.dynamic.mnet-online.de [46.244.253.53])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Tue, 11 Feb 2020 14:32:01 +0000 (UTC)
Message-ID: <8727d06b4bef8f337dea40c83d3fc4132f721585.camel@scientia.net>
Subject: Re: [PATCH v2] Btrfs: send, fix emission of invalid clone
 operations within the same file
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Date:   Tue, 11 Feb 2020 15:32:01 +0100
In-Reply-To: <20200129170953.13945-1-fdmanana@kernel.org>
References: <20200124115204.4086-1-fdmanana@kernel.org>
         <20200129170953.13945-1-fdmanana@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Just wanted to ask whether this is going to be backported to 5.5?

Cheers,
Chris.

