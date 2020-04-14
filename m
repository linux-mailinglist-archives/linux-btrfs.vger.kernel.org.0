Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F851A7243
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 06:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405098AbgDNEGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 00:06:21 -0400
Received: from mailgw-01.dd24.net ([193.46.215.41]:43490 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405082AbgDNEGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 00:06:20 -0400
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 604A05FF62
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 04:06:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id jYJKTPCchChp for <linux-btrfs@vger.kernel.org>;
        Tue, 14 Apr 2020 04:06:15 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-42-14.dynamic.mnet-online.de [88.217.42.14])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Apr 2020 04:06:15 +0000 (UTC)
Message-ID: <732225b51548301c700868165ae644df608e7b9a.camel@scientia.net>
Subject: Re: authenticated file systems using HMAC(SHA256)
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Tue, 14 Apr 2020 06:06:14 +0200
In-Reply-To: <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <CAJCQCtSLOgj7MHKNeGOHu1DPa=xC=sR7cZzR88hN1y_mTYRFKw@mail.gmail.com>
         <SN4PR0401MB35987317CD0E2B97CD5A499E9BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
         <CAJCQCtRtxqy7eMPg+eWoz36MMNBM48-mec8h182p4HmQqX-48Q@mail.gmail.com>
         <SN4PR0401MB3598FDECC128D251AB7B73459BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2020-04-09 at 08:50 +0000, Johannes Thumshirn wrote:
> Maybe having someone in the community being interested in this work
> can 
> accelerate it's upstream acceptance.

I think it would be great having something like this in btrfs.


If this was to be merged, it would perhaps make sense to have it
audited by a number of crypto experts.


And also, to clearly specify what it can to and what not:
- like how it behaves with other features of btrfs (compression, raid,
  repair, etc.)
- limitations (e.g. fs-verity was just read-only, wasn't it?!)
- what exactly does it protect?
  - "just" the content of files (i.e. a file with invalid HMAC will be 
    detected)
  - file metadata (dates, names, permissions, owners, xattrs, etc)
  - the file hirarchy (location of the files in the tree)
  - would files removed/added (by an attacker) be detected



Cheers,
Chris.

