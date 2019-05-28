Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE462C6AB
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2019 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfE1Mgm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 May 2019 08:36:42 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:44156 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfE1Mgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 May 2019 08:36:41 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 31B485FDDB;
        Tue, 28 May 2019 12:36:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id iQLUs5k_ipco; Tue, 28 May 2019 12:36:38 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.131])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Tue, 28 May 2019 12:36:38 +0000 (UTC)
Message-ID: <6e9c176d0b9389b2ff04cf38556471360725146e.camel@scientia.net>
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux
 5.1.2
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Michael =?ISO-8859-1?Q?La=DF?= <bevan@bi-co.net>,
        linux-btrfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:36:37 +0200
In-Reply-To: <297da4cbe20235080205719805b08810@bi-co.net>
References: <297da4cbe20235080205719805b08810@bi-co.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey.

Just to be on the safe side...

AFAIU this issue only occured in 5.1.2 and later, right?

Starting with which 5.1.x and 5.2.x versions has the fix been merged?

Cheers,
Chris.

