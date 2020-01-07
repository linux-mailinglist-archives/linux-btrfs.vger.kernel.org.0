Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5EF132F63
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 20:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgAGT0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 14:26:52 -0500
Received: from mail.itouring.de ([188.40.134.68]:39062 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbgAGT0w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 14:26:52 -0500
Received: from tux.applied-asynchrony.com (p5B07E981.dip0.t-ipconnect.de [91.7.233.129])
        by mail.itouring.de (Postfix) with ESMTPSA id 034F84163429;
        Tue,  7 Jan 2020 20:26:50 +0100 (CET)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 5ED1FF01600;
        Tue,  7 Jan 2020 20:26:49 +0100 (CET)
Subject: Re: write amplification, was: very slow "btrfs dev delete" 3x6Tb, 7Tb
 of data
To:     Chris Murphy <lists@colorremedies.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <5e6e2ff8-89be-45db-49d3-802de42663ed@dubiel.pl>
 <CAJCQCtSr9j8AzLRfguHb8+9n_snxmpXkw0V+LiuDnqqvLVAxKQ@mail.gmail.com>
 <20200104053843.GK13306@hungrycats.org>
 <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <bc544d4a-b375-ce26-0fcc-c0dacae4a0bd@applied-asynchrony.com>
Date:   Tue, 7 Jan 2020 20:26:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTvTbr9Civ5DLhTPRsMZ2qK2=YWFLB3JMSRRzZS9v-iNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/7/20 7:44 PM, Chris Murphy wrote:
> Egads! Soo... total tangent. I'll change the subject.

Time for science!

"Analyzing IO Amplification in Linux File Systems"
https://arxiv.org/abs/1707.08514

Ironically Btrfs does better in a related paper:

"Filesystem Aging: It’s more Usage than Fullness"
https://www.usenix.org/conference/hotstorage19/presentation/conway

enjoy,
Holger
