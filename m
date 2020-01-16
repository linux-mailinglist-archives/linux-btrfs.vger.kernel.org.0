Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95613D1DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 03:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgAPCGK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 21:06:10 -0500
Received: from mailgw-02.dd24.net ([193.46.215.43]:48584 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgAPCGK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 21:06:10 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 21:06:09 EST
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 94322601DE
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 01:57:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id 1pOxA2bP0nNV for <linux-btrfs@vger.kernel.org>;
        Thu, 16 Jan 2020 01:57:52 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-188-174-67-191.dynamic.mnet-online.de [188.174.67.191])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 01:57:52 +0000 (UTC)
Message-ID: <ba2dcbb0085b186c6df859a4f5db415597fe2f8e.camel@scientia.net>
Subject: Re: read time tree block corruption with kernel 5.4.11
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 16 Jan 2020 02:57:51 +0100
In-Reply-To: <f2f96d17-7473-8a24-2702-37e5217ad665@googlemail.com>
References: <f2f96d17-7473-8a24-2702-37e5217ad665@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 2020-01-15 at 23:04 +0100, Oliver Freyermuth wrote:
> I have recently upgraded to 5.4.11 from a 5.3 kernel and now also hit
> the dreaded read time tree block corruption

Is there some known corruption bug in 5.4?

Thanks,
Chris.

