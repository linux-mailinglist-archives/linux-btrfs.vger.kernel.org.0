Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560A6B0D41
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfILKxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 06:53:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33027 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbfILKxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 06:53:06 -0400
X-Originating-IP: 88.191.131.7
Received: from [192.168.1.156] (unknown [88.191.131.7])
        (Authenticated sender: swami@petaramesh.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B0A5460003;
        Thu, 12 Sep 2019 10:53:03 +0000 (UTC)
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     James Harvey <jamespharvey20@gmail.com>, fdmanana@gmail.com
Cc:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <11e4e889f903ddad682297c4420faeb0245414cf.camel@scientia.net>
 <CAL3q7H4peDv_bQa5vGJeOM=V--yq1a1=aHat5qcsXjbnDoSkDQ@mail.gmail.com>
 <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
From:   =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Message-ID: <5480ef51-6b55-4f30-fe3d-005c7883c630@petaramesh.org>
Date:   Thu, 12 Sep 2019 12:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CA+X5Wn7GCed+bWNq7jkTHgDc5dT-OHyUkTRxfa1eHv=25_ijrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Le 12/09/2019 à 10:24, James Harvey a écrit :
> and should a flashing neon sign be given to users to just run 5.1.x
> even though the distribution repos have 5.2.x?
Yep, I assume that a big flashing red neon sign should be raised for a 
confirmed bug that can trash your filesystem into ashes, and actually 
did so for two of mine...

ॐ
-- 
Swâmi Petaramesh <swami@petaramesh.org> OpenPGP ID 0x1BFFD850

