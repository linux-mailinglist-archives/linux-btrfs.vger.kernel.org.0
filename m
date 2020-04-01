Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8685719B71D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgDAUhJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 1 Apr 2020 16:37:09 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:50540 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAUhJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Apr 2020 16:37:09 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id E257F60083;
        Wed,  1 Apr 2020 20:37:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id 55eDwMhumpGF; Wed,  1 Apr 2020 20:37:06 +0000 (UTC)
Received: from galois.fritz.box (ppp-46-244-252-139.dynamic.mnet-online.de [46.244.252.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA;
        Wed,  1 Apr 2020 20:37:05 +0000 (UTC)
Date:   Wed, 01 Apr 2020 22:37:08 +0200
In-Reply-To: <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
References: <800B6BF0-64AA-45F5-A539-9D2868C2835C@scientia.net> <a8a1e614-d5f0-d4b6-2f0b-626a34761758@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Btrfs transid corruption
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
From:   Christoph Anton Mitterer <calestyo@scientia.net>
Message-ID: <2FA13CAC-C259-41BF-BA9E-F9032DFA185C@scientia.net>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 1. April 2020 22:31:58 MESZ schrieb Josef Bacik <josef@toxicpanda.com>:
>On 4/1/20 4:06 PM, Christoph Anton Mitterer wrote:
>Looks like the tree log got corrupted, you can use mount -o nologreplay
>to get 
>it mounted, and then you should be good to go (hopefully).  Thanks,


I can mount it then, but only with ro...without ro I got another ctree open error (see Google drive for screenshot).

But this is then only to rescue the data...I cannot repair the fs, right? 

Thanks,
Chris
