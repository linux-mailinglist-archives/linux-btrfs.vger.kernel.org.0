Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF4D19B736
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgDAUmT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 16:42:19 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:50830 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732345AbgDAUmS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 16:42:18 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 8B4866004A;
        Wed,  1 Apr 2020 20:42:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id bSKh3itnVIv5; Wed,  1 Apr 2020 20:42:15 +0000 (UTC)
Received: from galois.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Wed,  1 Apr 2020 20:42:15 +0000 (UTC)
Date:   Wed, 01 Apr 2020 22:42:17 +0200
In-Reply-To: <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net> <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com> <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net> <c0e5cc1b-ddfa-270e-2934-a6470584193e@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Btrfs transid corruption
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
From:   Christoph Anton Mitterer <calestyo@scientia.net>
Message-ID: <60F9B082-A802-4CCD-8003-84E9533162C4@scientia.net>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Will make a dd copy first, then try it out...then come back (with lots of further questions on the matter).

Thanks so far and till later,
Chris
