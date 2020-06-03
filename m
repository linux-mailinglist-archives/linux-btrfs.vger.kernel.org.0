Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACC1ED086
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFCNI3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 3 Jun 2020 09:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCNI3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 09:08:29 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Jun 2020 06:08:29 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0BDC08C5C0
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Jun 2020 06:08:29 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id D1609F5E3B;
        Wed,  3 Jun 2020 15:01:51 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Xuanrui Qi <me@xuanruiqi.com>, linux-btrfs@vger.kernel.org,
        =?ISO-8859-1?Q?Sw=E2mi?= Petaramesh <swami@petaramesh.org>
Subject: Re: Massive filesystem corruption, potentially related to eCryptfs-on-btrfs
Date:   Wed, 03 Jun 2020 15:01:52 +0200
Message-ID: <1673026.qcCv5XE2zU@merkaba>
In-Reply-To: <cf91b9ae-8f70-96f9-97cf-4ddd464b4ec4@petaramesh.org>
References: <DM6PR02MB44274C6B16F173291A82C4A8C98A0@DM6PR02MB4427.namprd02.prod.outlook.com> <cf91b9ae-8f70-96f9-97cf-4ddd464b4ec4@petaramesh.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi.

Swâmi Petaramesh - 02.06.20, 08:04:59 CEST:
> Le 01/06/2020 à 23:08, Xuanrui Qi a écrit :
> > I have just recovered from a massive filesystem corruption problem
> > which turned out to be a total nightmare, and I have strong reason
> > to
> > suspect that it is related to eCryptfs-encrypted folders on btrfs.
[…]
> For the record, I've been using ecryptfs on BTRFS for years on more
> than 10 different machines (including the one on which I'm presently
> writing this) and *NEVER* went into a corruption problem relating
> BTRFS and ecryptfs.

I have been using ecryptfs on BTRFS just on one machine, but also for 
years. No issues either.

So I do not believe that there is a principal issue with running 
ecryptfs on BTRFS.

Best,
-- 
Martin


