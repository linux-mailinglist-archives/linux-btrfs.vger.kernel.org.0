Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA64B0F55
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbfILM7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 08:59:02 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:58762 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfILM7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 08:59:02 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id B21DC5FD9C;
        Thu, 12 Sep 2019 12:59:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id cZZNbahsSIMO; Thu, 12 Sep 2019 12:58:58 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.131])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Thu, 12 Sep 2019 12:58:58 +0000 (UTC)
Message-ID: <ee4e5ad0e0d4563c829113a84985b48448833fb4.camel@scientia.net>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     =?ISO-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Thu, 12 Sep 2019 14:58:58 +0200
In-Reply-To: <5480ef51-6b55-4f30-fe3d-005c7883c630@petaramesh.org>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
         <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
         <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
         <5480ef51-6b55-4f30-fe3d-005c7883c630@petaramesh.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2019-09-12 at 12:53 +0200, Swâmi Petaramesh wrote:
> Yep, I assume that a big flashing red neon sign should be raised for
> a 
> confirmed bug that can trash your filesystem into ashes, and
> actually 
> did so for two of mine...

I doubt this will happen... I've asked for something like this to be
set up on the last corruption bugs but there seems to be little
interest for a warning system for users.


Cheers,
Chris.

