Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7365920251
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 11:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEPJNA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 05:13:00 -0400
Received: from mailgw-02.dd24.net ([193.46.215.43]:54546 "EHLO
        mailgw-02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPJNA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 05:13:00 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-02.dd24.net (Postfix) with ESMTP id 831BE5FCA4
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 09:12:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.36])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10236)
        with ESMTP id 5fZM82nUUZLz for <linux-btrfs@vger.kernel.org>;
        Thu, 16 May 2019 09:12:56 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.132])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 09:12:56 +0000 (UTC)
Message-ID: <8d61eae5873f028557942dbb88f4f4cbaee0b891.camel@scientia.net>
Subject: Re: delayed_refs has NO entry / btrfs_update_root:136: Aborting
 unused transaction(No space left).
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Date:   Thu, 16 May 2019 11:12:55 +0200
In-Reply-To: <b2a668d7124f1d3e410367f587926f622b3f03a4.camel@scientia.net>
References: <b2a668d7124f1d3e410367f587926f622b3f03a4.camel@scientia.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since no one seems to show any big interest in this issues, I've added
it for the records in https://bugzilla.kernel.org/show_bug.cgi?id=203621

Cheers,
Chris.

