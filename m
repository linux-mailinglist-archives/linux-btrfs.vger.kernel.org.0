Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AE2A1AF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 15:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfH2NIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 09:08:43 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:41860 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfH2NIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 09:08:42 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 677165FE6A
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 13:08:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id VGIqR6hloSBl for <linux-btrfs@vger.kernel.org>;
        Thu, 29 Aug 2019 13:08:39 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.131])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 13:08:39 +0000 (UTC)
Message-ID: <43a44ae86dc4e36dd4351cb9d9e6d0c3798bcd7f.camel@scientia.net>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs@vger.kernel.org
Date:   Thu, 29 Aug 2019 15:08:38 +0200
In-Reply-To: <3fe4a6dd-942b-56b6-c5ca-fed5e801dc0e@googlemail.com>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
         <18d24f2f-4d33-10aa-5052-c358d4f7c328@petaramesh.org>
         <a8968a812e270a0dd80c4cf431a8437d3a7daba5.camel@scientia.net>
         <5aefca34-224a-0a81-c930-4ccfcd144aef@petaramesh.org>
         <4bd70aa2-7ad0-d5c6-bc1f-22340afaac60@petaramesh.org>
         <370697f1-24c9-c8bd-01a7-c2885a7ece05@gmx.com>
         <209fcd36-6748-99c5-7b6d-319571bdd11f@petaramesh.org>
         <6525d5cf-9203-0332-cad5-2abc5d3e541c@gmx.com>
         <317a6f8f-3810-4a6c-ba64-3825317de1e7@petaramesh.org>
         <c116d672-a212-f73f-ffdf-fd97aa958135@knorrie.org>
         <3fe4a6dd-942b-56b6-c5ca-fed5e801dc0e@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2019-08-29 at 14:46 +0200, Oliver Freyermuth wrote:
> This thread made me check on my various BTRFS volumes and for almost
> all of them (in different machines), I find cases of
>  failed to load free space cache for block group XXXX, rebuilding it
> now
> at several points during the last months in my syslogs - and that's
> for machines without broken memory, for disks for which FUA should be
> working fine,
> without any unsafe shutdowns over their lifetime, and with histories
> as short as only having seen 5.x kernels. 


I'm having the very same... machines that are most likely fine in terms
of hardware and had no crashes or so,... yet they still see v1 free
space cache issues every now and then,... which sounds like a pointer
that something's wrong there.

Cheers,
Chris.

