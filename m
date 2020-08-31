Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE482571CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 04:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgHaCUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 22:20:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35752 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgHaCUU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 22:20:20 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id B9F2A1F66E;
        Mon, 31 Aug 2020 02:20:19 +0000 (UTC)
Date:   Mon, 31 Aug 2020 02:20:19 +0000
From:   Eric Wong <e@80x24.org>
To:     Hamish Moffatt <hamish-btrfs@moffatt.email>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: new database files not compressed
Message-ID: <20200831022019.GA27823@dcvr>
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hamish Moffatt <hamish-btrfs@moffatt.email> wrote:
> I am trying to store Firebird database files compressed on btrfs. Although I
> have mounted the file system with -o compress-force, new files created by
> Firebird are not being compressed according to compsize. If I copy them, or
> use btrfs filesystem defrag, they compress well.
> 
> Other files seem to be compressed automatically OK. Why are the Firebird
> files different?

Maybe Firebird creates DB with the No_COW attribute?
"lsattr -l /path/to/file" to check.

I don't know much about Firebird; but No_COW is pretty much
required for big database, VM images, etc which are subject to
random writes.  Unfortunately, neither compression nor
checksumming are available with No_COW set.

Big SQLite and Xapian DBs gave me trouble even on an SSD before
I recreated them with No_COW.  Small DBs can probably get away
with autodefrag.
