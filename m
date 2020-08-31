Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8B42571EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 04:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHaCoZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 22:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHaCoZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 22:44:25 -0400
Received: from jemma.woof94.com (jemma.woof94.com [IPv6:2404:9400:3:0:216:3eff:fee0:fa86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA67C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 30 Aug 2020 19:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=moffatt.email; s=woof2014; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E9LHPxWsWoxElFikmkB2xmxcpSqzSN23a9wTr/tD88M=; b=C0HifmzOpqtWpoTWC3jzKp0Y5P
        SMpVKUDOyJtYBardbPBId1bU54nP7xJ1zvd6clNTGs2bCsTywC8SOKpPArUsRPUwcIJAOzg7IC+h5
        gnJKbAP5UmxDH73gEf9xiPuxkea+E+gzexqXUhK7RIwA7S5eKqEG+G4VmFo/qt0C2JpM=;
Received: from 2403-5800-3100-142-4dde-3dc2-100-2daa.ip6.aussiebb.net ([2403:5800:3100:142:4dde:3dc2:100:2daa])
        by jemma.woof94.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <hamish-btrfs@moffatt.email>)
        id 1kCZnh-0006M0-15; Mon, 31 Aug 2020 12:44:05 +1000
Subject: Re: new database files not compressed
To:     Eric Wong <e@80x24.org>,
        Hamish Moffatt <hamish-btrfs@moffatt.email>
Cc:     linux-btrfs@vger.kernel.org
References: <6992fae3-ce87-8ae1-8dfe-1cb65578a16a@moffatt.email>
 <20200831022019.GA27823@dcvr>
From:   Hamish Moffatt <hamish-btrfs@moffatt.email>
Message-ID: <ad646cef-dc19-9158-e904-b3a7f20060ef@moffatt.email>
Date:   Mon, 31 Aug 2020 12:44:03 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831022019.GA27823@dcvr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 31/8/20 12:20 pm, Eric Wong wrote:
> Hamish Moffatt <hamish-btrfs@moffatt.email> wrote:
>> I am trying to store Firebird database files compressed on btrfs. Although I
>> have mounted the file system with -o compress-force, new files created by
>> Firebird are not being compressed according to compsize. If I copy them, or
>> use btrfs filesystem defrag, they compress well.
>>
>> Other files seem to be compressed automatically OK. Why are the Firebird
>> files different?
> Maybe Firebird creates DB with the No_COW attribute?
> "lsattr -l /path/to/file" to check.
>
> I don't know much about Firebird; but No_COW is pretty much
> required for big database, VM images, etc which are subject to
> random writes.  Unfortunately, neither compression nor
> checksumming are available with No_COW set.
>
> Big SQLite and Xapian DBs gave me trouble even on an SSD before
> I recreated them with No_COW.  Small DBs can probably get away
> with autodefrag.

I don't see anything in the lsattr output;


$ isql-fb
Use CONNECT or CREATE DATABASE to specify a database
SQL> create database 'foo.fdb';
SQL> ^D

$ lsattr foo.fdb
------------------- foo.fdb
$ lsattr -l foo.fdb
foo.fdb                      ---
$ sudo compsize foo.fdb
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL      100%      768K         768K         768K
none       100%      768K         768K         768K


Still, if you're telling me that trying to use compression on database 
files is a bad idea, thanks for the warning and I'll let it be.


Hamish

